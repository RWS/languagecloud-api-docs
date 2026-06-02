<#
.SYNOPSIS
    Runs C2M4AI.exe to generate reference markdown from an OpenAPI spec.
    Uses SHA-256 hashing for change detection — skips execution if spec unchanged.

.PARAMETER ApiContract
    Path to the OpenAPI JSON or YAML file.
    Default: .\articles\LCPublicAPI\api\Public-API.v1.json

.PARAMETER OutputDir
    Path where reference .md files are written. Default: .\articles\LCPublicAPI\aidocs\reference

.PARAMETER C2M4AIExe
    Path to C2M4AI.exe. Default: .\tools\C2M4AI.exe
    If the file does not exist at this path, run Get-C2M4AI.ps1 first
    (or use Invoke-AiDocsPipeline.ps1 which does this automatically).

.PARAMETER NoSchema
    Pass --no-schema to C2M4AI to suppress generation of Schemas.md.
    Defaults to true — schemas are already inlined in each operation file.

.PARAMETER Force
    Run C2M4AI even if the spec hash has not changed.

.OUTPUTS
    Writes the new spec hash to <OutputDir parent>/.api-spec-hash after a
    successful run. Exits with code 0 on success, non-zero on failure.

.EXAMPLE
    .\pipeline\Invoke-C2M4AI.ps1
    .\pipeline\Invoke-C2M4AI.ps1 -ApiContract .\articles\LCPublicAPI\api\Public-API.v1.json -Force
#>
param(
    [string] $ApiContract = ".\articles\LCPublicAPI\api\Public-API.v1.json",
    [string] $OutputDir   = ".\articles\LCPublicAPI\aidocs\reference",
    [string] $C2M4AIExe   = ".\tools\C2M4AI.exe",
    [switch] $NoSchema    = $true,
    [switch] $Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Hash file lives next to the reference dir (in aidocs/)
$hashFile = Join-Path (Split-Path $OutputDir -Parent) ".api-spec-hash"

function Get-FileSHA256 ([string]$path) {
    return (Get-FileHash -Path $path -Algorithm SHA256).Hash
}

Write-Host ""
Write-Host "=== Invoke-C2M4AI ===" -ForegroundColor Cyan
Write-Host "Contract : $ApiContract"
Write-Host "Output   : $OutputDir"
Write-Host "Exe      : $C2M4AIExe"
Write-Host ""

# Validate inputs
if (-not (Test-Path $ApiContract)) {
    Write-Error "API contract not found: $ApiContract"
    exit 1
}
if (-not (Test-Path $C2M4AIExe)) {
    Write-Error "C2M4AI.exe not found: $C2M4AIExe"
    exit 1
}

$currentHash = Get-FileSHA256 $ApiContract

# Change detection
if (-not $Force -and (Test-Path $hashFile)) {
    $storedHash = (Get-Content $hashFile -Raw).Trim()
    if ($storedHash -eq $currentHash) {
        Write-Host "API spec unchanged (SHA-256 match). Skipping generation." -ForegroundColor DarkGray
        Write-Host "Use -Force to regenerate regardless."
        exit 0
    }
    Write-Host "API spec changed — running C2M4AI."
} elseif ($Force) {
    Write-Host "Force mode — running C2M4AI."
} else {
    Write-Host "No stored hash — running C2M4AI for the first time."
}

# Ensure output directory exists
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
    Write-Host "Created output dir: $OutputDir"
}

# Run C2M4AI
$noSchemaFlag = @(if ($NoSchema) { "--no-schema" })
Write-Host ""
Write-Host "Running: $C2M4AIExe $ApiContract -o $OutputDir$($NoSchema ? ' --no-schema' : '')"
Write-Host ""

& $C2M4AIExe $ApiContract -o $OutputDir @noSchemaFlag

if ($LASTEXITCODE -ne 0) {
    Write-Error "C2M4AI exited with code $LASTEXITCODE"
    exit $LASTEXITCODE
}

# Store new hash only after success
$currentHash | Set-Content -Path $hashFile -Encoding UTF8
Write-Host ""
Write-Host "Done. Reference files written to: $OutputDir" -ForegroundColor Cyan
Write-Host "Hash stored : $hashFile ($currentHash)"
