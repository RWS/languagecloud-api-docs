<#
.SYNOPSIS
    Orchestrates the deterministic AI docs generation pipeline.

.DESCRIPTION
    Accepts a list of changed files (e.g. from a git diff on a PR) and
    routes each change to the appropriate deterministic script. Only the
    parts of the documentation that are affected by the changes are
    regenerated — making the pipeline fast and idempotent.

    DETERMINISTIC STAGES (all run via scripts, no AI required):
      1. Reference generation  — C2M4AI.exe from api.json
      2. SDK section injection — Update-SdkSections.ps1 from SDK source
      3. Guide index rebuild   — Update-GuidesIndex.ps1 from guide files
      4. Removed operation cleanup — delete .md files for removed operations

    AI-REQUIRED STAGES (flagged but not executed by this script):
      A. Guide content update  — when docs/guides source files change

    CHANGE ROUTING:
      Changed file                                      → Stage(s) triggered
      ─────────────────────────────────────────────────────────────────
      articles/LCPublicAPI/api/Public-API.v1.json       → 1 (C2M4AI) + 2 (SDK)
      aidocs/guides/*.md                                → 3 (guide index rebuild)
      docs/guides/*.md                                  → 3 + [A] flag AI update

    If no ChangedFiles are provided (or -All is set), all stages run.

.PARAMETER RootDir
    Workspace root. Default: current directory.

.PARAMETER ChangedFiles
    List of relative file paths that changed (from git diff --name-only).
    Example: @("articles/LCPublicAPI/api/Public-API.v1.json")

.PARAMETER All
    Ignore ChangedFiles and regenerate everything.

.PARAMETER Force
    Pass -Force to all sub-scripts (rewrite even when content is unchanged).

.PARAMETER DryRun
    Print what would run without executing any scripts.

.PARAMETER DotNetXmlFile
    Path to the NuGet XML documentation file for the .NET SDK
    (e.g. tools\Rws.LanguageCloud.Sdk.xml downloaded by Get-DotNetSdkXml.ps1).
    When provided, Update-SdkSections.ps1 uses the XML parser instead of
    the C# source parser.  Overrides the default SDK_NET path.

.PARAMETER JavaApiDirPath
    Override path to the directory containing *Api.java source files.
    Default: {RootDir}\SDK_JAVA\api
    In CI: set to the directory produced by Get-JavaSdkSources.ps1.

.PARAMETER C2M4AIExePath
    Override path to the C2M4AI.exe binary.
    Default: {RootDir}\C2M4AI.exe
    In CI: set to the path produced by Get-C2M4AI.ps1.

.PARAMETER OldApiSpec
    Path to the previous version of api.json, used by Get-ApiSpecDiff.ps1
    to produce a targeted list of changed operations. If omitted, all
    reference files are processed when the spec changes.

.EXAMPLE
    # Full regeneration
    .\pipeline\Invoke-AiDocsPipeline.ps1 -All

    # Incremental update
    $changed = git diff --name-only HEAD~1 HEAD
    .\pipeline\Invoke-AiDocsPipeline.ps1 -ChangedFiles $changed

    # Dry run to preview
    .\pipeline\Invoke-AiDocsPipeline.ps1 -All -DryRun
#>
param(
    [string]   $RootDir      = ".",
    [string[]] $ChangedFiles = @(),
    [switch]   $All,
    [switch]   $Force,
    [switch]   $DryRun,
    [string]   $OldApiSpec   = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Ensure ChangedFiles is always a true array (git output can be a scalar string)
$ChangedFiles = @($ChangedFiles | Where-Object { $_ })

$ScriptDir = $PSScriptRoot

# ── Resolve absolute paths ─────────────────────────────────────────────────────
$ApiContract  = Join-Path $RootDir "articles\LCPublicAPI\api\Public-API.v1.json"
$ReferenceDir = Join-Path $RootDir "aidocs\reference"
$GuidesDir    = Join-Path $RootDir "aidocs\guides"
$ToolsDir     = Join-Path $RootDir "tools"
$C2M4AIExe    = Join-Path $ToolsDir "C2M4AI.exe"
$DotNetXmlFile = Join-Path $ToolsDir "Rws.LanguageCloud.Sdk.xml"
$JavaApiDir   = Join-Path $ToolsDir "java-api"

# ── Helper: run or simulate a script ──────────────────────────────────────────
function Invoke-Stage ([string]$label, [string]$script, [hashtable]$params) {
    Write-Host ""
    Write-Host "─── $label ───" -ForegroundColor Yellow

    if ($DryRun) {
        Write-Host "[DRY RUN] Would call: $script" -ForegroundColor DarkGray
        foreach ($kv in $params.GetEnumerator()) {
            Write-Host "  -$($kv.Key) $($kv.Value)" -ForegroundColor DarkGray
        }
        return
    }

    & $script @params
    if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        Write-Error "$label failed with exit code $LASTEXITCODE"
        exit $LASTEXITCODE
    }
}

# ── Auto-detect changed files when none supplied and -All not set ──────────────
if (-not $All -and $ChangedFiles.Count -eq 0) {
    Write-Host "No -ChangedFiles supplied — detecting changes via git diff HEAD~1 HEAD ..." -ForegroundColor DarkGray
    Push-Location $RootDir
    try   { $ChangedFiles = @(git diff --name-only HEAD~1 HEAD | Where-Object { $_ }) }
    finally { Pop-Location }
    if ($ChangedFiles.Count -eq 0) {
        Write-Host "  No changes detected. Nothing to do." -ForegroundColor DarkGray
    } else {
        Write-Host "  Detected $($ChangedFiles.Count) changed file(s)." -ForegroundColor DarkGray
    }
}

# ── Determine what changed ─────────────────────────────────────────────────────
$normalised  = $ChangedFiles | ForEach-Object { $_ -replace '\\', '/' }

$apiChanged  = $All -or ($normalised | Where-Object { $_ -match '(?i)articles/LCPublicAPI/api/Public-API\.v1\.json$' })
$guideSrcChg = @($normalised | Where-Object { $_ -match '(?i)articles/LCPublicAPI/docs/.*\.md$' })
$guideDocChg = @($normalised | Where-Object { $_ -match '(?i)aidocs/guides/.*\.md$' })

# ── Banner ─────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   AI Docs Pipeline — Deterministic   ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Root          : $RootDir"
Write-Host "Changed files : $($ChangedFiles.Count)  (use -All to ignore)"
if ($DryRun) { Write-Host "Mode          : DRY RUN" -ForegroundColor Magenta }
if ($Force)  { Write-Host "Mode          : FORCE"   -ForegroundColor Yellow }
Write-Host ""
Write-Host "Triggers:"
Write-Host "  API spec changed       : $([bool]$apiChanged)"
Write-Host "  Guide source changed   : $($guideSrcChg.Count) file(s)"
Write-Host "  Guide doc changed      : $($guideDocChg.Count) file(s)"

# ── Guard: nothing to do? ──────────────────────────────────────────────────────
if (-not $All -and -not $apiChanged -and
    -not $guideSrcChg -and -not $guideDocChg -and $ChangedFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "No relevant changes detected. Nothing to do." -ForegroundColor DarkGray
    exit 0
}

# ─────────────────────────────────────────────────────────────────────────────
#  STAGE 0 — Fetch tools and SDK packages from public registries
#  Runs unconditionally. The individual scripts cache by version, so
#  subsequent runs complete in <1 s when the version hasn’t changed.
# ─────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "─── Stage 0 — Fetch tools and SDK packages ───" -ForegroundColor Yellow

if (-not $DryRun) {
    & "$ScriptDir\Get-C2M4AI.ps1"        -OutputPath  $C2M4AIExe
    & "$ScriptDir\Get-DotNetSdkXml.ps1"  -OutputPath  $DotNetXmlFile
    & "$ScriptDir\Get-JavaSdkSources.ps1" -OutputDir  $JavaApiDir
} else {
    Write-Host "[DRY RUN] Would run: Get-C2M4AI.ps1 / Get-DotNetSdkXml.ps1 / Get-JavaSdkSources.ps1" -ForegroundColor DarkGray
}

# ─────────────────────────────────────────────────────────────────────────────
#  STAGE 1 — Reference generation (C2M4AI)
# ─────────────────────────────────────────────────────────────────────────────
if ($apiChanged) {
    $c2mParams = @{
        ApiContract = $ApiContract
        OutputDir   = $ReferenceDir
        C2M4AIExe   = $C2M4AIExe
    }
    if ($Force) { $c2mParams['Force'] = $true }

    Invoke-Stage "Stage 1 — Reference generation (C2M4AI)" `
                 "$ScriptDir\Invoke-C2M4AI.ps1" `
                 $c2mParams

    # If we have an old spec, diff it to find targeted operations for Stage 2
    if ($OldApiSpec -and (Test-Path $OldApiSpec) -and -not $All) {
        Write-Host ""
        Write-Host "  Diffing specs for targeted SDK update..." -ForegroundColor DarkGray
        $diffJson   = & "$ScriptDir\Get-ApiSpecDiff.ps1" -OldSpec $OldApiSpec -NewSpec $ApiContract
        $diff       = $diffJson | ConvertFrom-Json
        $targetOps  = @($diff.Added) + @($diff.Changed)
        Write-Host "  Targeted operations: $($targetOps.Count)"
    } else {
        $targetOps  = @()   # empty = process all in Stage 2
    }
}

# ─────────────────────────────────────────────────────────────────────────────
#  STAGE 2 — SDK section injection
# ─────────────────────────────────────────────────────────────────────────────
if ($apiChanged -or $All) {
    $sdkParams = @{
        ReferenceDir  = $ReferenceDir
        DotNetXmlFile = $DotNetXmlFile
        JavaApiDir    = $JavaApiDir
    }
    if ($Force)                                  { $sdkParams['Force']      = $true }
    if ($targetOps -and $targetOps.Count -gt 0)  { $sdkParams['Operations'] = $targetOps }

    Invoke-Stage "Stage 2 — SDK section injection" `
                 "$ScriptDir\Update-SdkSections.ps1" `
                 $sdkParams
}

# ─────────────────────────────────────────────────────────────────────────────
#  STAGE 3 — Guide index rebuild
# ─────────────────────────────────────────────────────────────────────────────
if (($guideSrcChg -or $guideDocChg -or $All) -and (Test-Path $GuidesDir)) {
    Invoke-Stage "Stage 3 — Guide index rebuild" `
                 "$ScriptDir\Update-GuidesIndex.ps1" `
                 @{ GuidesDir = $GuidesDir }
} elseif ($guideSrcChg -or $guideDocChg -or $All) {
    Write-Host ""
    Write-Host "─── Stage 3 — Guide index rebuild ───" -ForegroundColor Yellow
    Write-Host "  Skipped: guides directory does not exist yet ($GuidesDir)" -ForegroundColor DarkGray
}

# ─────────────────────────────────────────────────────────────────────────────
#  STAGE 4 — Removed operation cleanup
#  (only when we have a spec diff available)
# ─────────────────────────────────────────────────────────────────────────────
if ($apiChanged -and $OldApiSpec -and (Test-Path $OldApiSpec) -and -not $All) {
    if ($diff -and $diff.Removed -and $diff.Removed.Count -gt 0) {
        Write-Host ""
        Write-Host "─── Stage 4 — Remove deleted operations ───" -ForegroundColor Yellow
        foreach ($opId in $diff.Removed) {
            $target = Join-Path $ReferenceDir "$opId.md"
            if (Test-Path $target) {
                if ($DryRun) {
                    Write-Host "  [DRY RUN] Would delete: $target" -ForegroundColor DarkGray
                } else {
                    Remove-Item $target
                    Write-Host "  [deleted] $opId.md" -ForegroundColor Red
                }
            }
        }
    }
}

# ─────────────────────────────────────────────────────────────────────────────
#  STAGE A — Guide content update (AI-assisted, human-driven)
#  Source docs changed → emit advisory with command to generate the prompt
# ─────────────────────────────────────────────────────────────────────────────
if ($guideSrcChg.Count -gt 0 -or ($All -and -not $DryRun)) {
    Write-Host ""
    Write-Host "─── Stage A — Guide content update [AI REQUIRED] ───" -ForegroundColor Magenta
    Write-Host ""
    if ($guideSrcChg.Count -gt 0) {
        Write-Host "  Source docs changed:" -ForegroundColor Magenta
        foreach ($f in $guideSrcChg) {
            Write-Host "    · $f" -ForegroundColor Magenta
        }
        Write-Host ""
        $changedArgs = ($guideSrcChg | ForEach-Object { "`"$_`"" }) -join ', '
        Write-Host "  Run to generate an incremental Copilot prompt:" -ForegroundColor Yellow
        Write-Host "    .\pipeline\New-GuidesPrompt.ps1 -ChangedSources @($changedArgs)" -ForegroundColor White
    } else {
        Write-Host "  Run to generate a full-refresh Copilot prompt:" -ForegroundColor Yellow
        Write-Host "    .\pipeline\New-GuidesPrompt.ps1 -All" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "  Then open _update-prompt.md in VS Code and run it in Copilot agent mode." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Pipeline complete." -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
