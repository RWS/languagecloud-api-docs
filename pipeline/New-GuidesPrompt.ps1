<#
.SYNOPSIS
    Generates a VS Code Copilot agent-mode prompt for creating or updating aidocs/guides/*.md.

.DESCRIPTION
    Detects whether this is an initial generation (no guides exist yet), a full refresh
    (-All), or an incremental update (-ChangedSources). Writes a ready-to-use .prompt.md
    file that the human opens in VS Code and runs via Copilot agent mode.

    The generated prompt references workspace file paths so Copilot reads source docs
    and existing guides directly — no content embedding required.

    Run from the repository root.

.PARAMETER ChangedSources
    List of repo-relative paths of source docs that changed (from git diff --name-only).
    Example: @("articles/LCPublicAPI/docs/API-rate-limits.md")
    When omitted with no -All, defaults to -All behaviour.

.PARAMETER All
    Generate a full-refresh prompt covering all source docs.

.PARAMETER OutputFile
    Where to write the generated prompt.
    Default: _update-prompt.md in the repository root.

.EXAMPLE
    # Initial generation or full refresh
    .\pipeline\New-GuidesPrompt.ps1 -All

    # Incremental: only source docs that changed
    $changed = git diff --name-only HEAD~1 HEAD
    .\pipeline\New-GuidesPrompt.ps1 -ChangedSources $changed

    # Custom output path
    .\pipeline\New-GuidesPrompt.ps1 -All -OutputFile .\my-prompt.md
#>
param(
    [string[]] $ChangedSources = @(),
    [switch]   $All,
    [string]   $OutputFile   = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Resolve output file path ───────────────────────────────────────────────────
if (-not $OutputFile) {
    $OutputFile = Join-Path $PWD "_update-prompt.md"
}

# ── Resolve key paths ──────────────────────────────────────────────────────────
$repoRoot         = $PWD.Path
$sourceDocsDir    = Join-Path $repoRoot "articles\LCPublicAPI\docs"
$guidesDir        = Join-Path $repoRoot "aidocs\guides"
$relSourceDocsDir = 'articles/LCPublicAPI/docs'
$relGuidesDir     = 'aidocs/guides'

if (-not (Test-Path $sourceDocsDir)) {
    Write-Error "Source docs directory not found: $sourceDocsDir"
    exit 1
}

# ── Determine mode ─────────────────────────────────────────────────────────────
$existingGuides = @()
if (Test-Path $guidesDir) {
    $existingGuides = @(Get-ChildItem $guidesDir -Filter "*.md" |
                        Where-Object { $_.Name -ne "index.md" -and $_.Name -notlike "_*" } |
                        Sort-Object Name)
}

$isInitial = ($existingGuides.Count -eq 0)

# Normalise changed-sources to repo-relative, forward-slash paths
$normChanged = @($ChangedSources |
    ForEach-Object { ($_ -replace '\\', '/').TrimStart('.').TrimStart('/') } |
    Where-Object   { $_ -match '(?i)articles/LCPublicAPI/docs/' })

# Auto-detect changed sources from git when no -ChangedSources and no -All
if (-not $isInitial -and $normChanged.Count -eq 0 -and -not $All) {
    Write-Host "No -ChangedSources supplied — auto-detecting via git diff HEAD~1 HEAD..." -ForegroundColor DarkGray
    $gitOut = @(git diff --name-only HEAD~1 HEAD 2>$null | Where-Object { $_ })
    $normChanged = @($gitOut |
        ForEach-Object { ($_ -replace '\\', '/').TrimStart('.').TrimStart('/') } |
        Where-Object   { $_ -match '(?i)articles/LCPublicAPI/docs/' })
    if ($normChanged.Count -eq 0) {
        Write-Warning "No guide source changes detected — use -All for a full refresh."
        exit 0
    }
}

$mode = if ($isInitial)     { "Initial generation" }
        elseif ($All)        { "Full refresh" }
        else                 { "Incremental update" }

Write-Host ""
Write-Host "=== New-GuidesPrompt ===" -ForegroundColor Cyan
Write-Host "Mode           : $mode"
Write-Host "Source docs    : $sourceDocsDir"
Write-Host "Guides dir     : $guidesDir"
Write-Host "Existing guides: $($existingGuides.Count)"
Write-Host "Output file    : $OutputFile"
Write-Host ""

# ── Build source-docs section ──────────────────────────────────────────────────
$fence = '```'
$sourceDocsSection = if ($isInitial -or $All) {
    "Read **all** ```.md``` files recursively under this path:`n`n$fence`n$relSourceDocsDir`n$fence"
} else {
    $bullets = $normChanged | ForEach-Object {
        $rel = "$relSourceDocsDir/" + ($_ -replace '(?i).*articles/LCPublicAPI/docs/', '')
        "- ``$rel``"
    }
    "Read the following changed source files:`n`n$($bullets -join "`n")"
}

# ── Build existing-guides section ──────────────────────────────────────────────
$guidesSection = if ($existingGuides.Count -eq 0) {
    "None — this is the initial generation run."
} else {
    $bullets = $existingGuides | ForEach-Object {
        $rel = "$relGuidesDir/$($_.Name)"
        "- ``$rel``"
    }
    "The following guide files already exist in ``$relGuidesDir``:`n`n$($bullets -join "`n")"
}

# ── Build mode-specific instructions ──────────────────────────────────────────
$modeInstructions = switch ($mode) {
    "Initial generation" {
@"
This is the **first time** guides are being generated. No guide files exist yet.

1. Read all source files listed above.
2. Design a guide structure: determine which cross-cutting topics deserve their own file.
3. Create one `.md` file per topic in the output directory.
4. Create `index.md` in the output directory listing all guides.
5. The suggested initial topics are listed at the bottom of this prompt as a reference — you may deviate if you see a better structure based on the source material.
"@
    }
    "Full refresh" {
@"
This is a **full refresh** — regenerate all guides from scratch.

1. Read all source files listed above.
2. For each existing guide, rewrite it with up-to-date content.
3. If you find topics in the source material that have no corresponding guide, create new guide files.
4. Remove any guide that no longer has relevant source material.
5. Regenerate `index.md` to reflect the final set of guides.
"@
    }
    "Incremental update" {
@"
This is an **incremental update** — only the listed source files changed.

1. Read each changed source file listed above.
2. Determine which existing guide(s) are affected by the changes.
3. Update only the affected guides. Do not touch unaffected guides.
4. If a change introduces a concept that has no home in any existing guide, create a new guide file.
5. If a new guide was created, add it to `index.md`.
"@
    }
}

# ── Build suggested initial topics (reference) ─────────────────────────────────
$suggestedTopics = @"
> **Suggested initial guide structure** (agent may deviate based on source material):
>
> | Output file | Primary source file(s) |
> |---|---|
> | ``auth.md`` | ``Authentication.md``, ``Service-credentials.md``, ``Service-users-and-custom-applications.md``, ``Headers-considerations.md``, ``Multi-region.md`` |
> | ``pagination.md`` | ``Use-paging-and-sorting-for-lists.md`` |
> | ``sparse-fieldsets.md`` | ``Use-fields-in-your-requests.md`` |
> | ``errors.md`` | ``How-to-report-an-issue.md`` |
> | ``rate-limits.md`` | ``API-rate-limits.md`` |
> | ``async-polling.md`` | ``Track-projects.md``, ``Interact-with-tasks.md``, ``File-formats.md`` |
> | ``file-upload.md`` | ``How-to-multipart.md``, ``File-formats.md`` |
> | ``webhooks.md`` | ``webhooks/`` subfolder |
> | ``locations-folders.md`` | ``How-to-use-location-and-folders.md`` |
> | ``put-semantics.md`` | ``Updating-data-with-PUT.md`` |
> | ``custom-fields.md`` | ``Custom-Fields.md`` |
> | ``changelog.md`` | ``Whats-New.md``, ``Whats-deprecated.md`` |
> | ``api-clients.md`` | ``api-clients/java/``, ``api-clients/net/`` |
"@

# ── Assemble the full prompt ───────────────────────────────────────────────────
$prompt = @"
---
mode: agent
description: "Generate or update Trados Language Cloud API guides in aidocs/guides/"
---

**Execute this task now. Do not ask for clarification — follow the instructions below exactly.**

# Guide generation — $mode

## Instructions

$modeInstructions

## Source docs

$sourceDocsSection

## Existing guides

$guidesSection

## Output directory

Write all guide files to:

``````
$relGuidesDir
``````

## Guide authoring rules

- Each guide is a single `.md` file focused on one cross-cutting concern.
- Content must be AI-consumable: **dense, factual, no marketing language, no redundant prose**.
- Include concrete values wherever the source provides them: exact header names, enum values, status codes, numeric limits, algorithm steps.
- Use **tables** for reference data (error codes, rate limits, event types, status values, etc.).
- Use **fenced code blocks** for HTTP examples and SDK snippets.
- All links between files must be **relative** and correct for static serving.
- Do **not** add YAML front matter to guide files.
- Do **not** add "last updated" timestamps.

## index.md format

`index.md` must use a flat Markdown table — no prose, no extra headers:

``````markdown
# Trados Language Cloud API — Guides

| Guide | Description |
|---|---|
| [Guide Title](./guide-file.md) | One-sentence description. |
``````

$suggestedTopics
"@

# ── Write output ──────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllText($OutputFile, $prompt, [System.Text.Encoding]::UTF8)

Write-Host "Prompt written to: $OutputFile" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Open VS Code"
Write-Host "  2. Open Copilot Chat in agent mode"
Write-Host "  3. Type:  #_update-prompt.md"
Write-Host "     (or drag the file into the chat input)"
Write-Host "  4. Send — Copilot will read source docs and write/update guides"
Write-Host "  5. Review the changes in .\aidocs\guides\"
Write-Host "  6. Commit when satisfied"
Write-Host ""
