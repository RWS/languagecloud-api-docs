<#
.SYNOPSIS
    Downloads the latest Rws.LanguageCloud.Sdk NuGet package and extracts
    the XML documentation file needed by Update-SdkSections.ps1.

.DESCRIPTION
    Queries the NuGet flat-container API to discover the latest stable version,
    downloads the .nupkg (which is a ZIP), and extracts the XML doc file from
    lib/netstandard2.0/ (with fallback to lib/net*/). No reflection required.

.PARAMETER PackageId
    NuGet package identifier (lowercase). Default: rws.languagecloud.sdk

.PARAMETER OutputPath
    Destination path for the extracted XML documentation file.
    Default: .\tools\Rws.LanguageCloud.Sdk.xml

.PARAMETER Version
    Specific package version to download. If empty, the latest stable version
    is auto-discovered from the NuGet flat-container index.

.PARAMETER Force
    Re-download even when the XML file is already present at the correct version.

.EXAMPLE
    .\pipeline\Get-DotNetSdkXml.ps1
    .\pipeline\Get-DotNetSdkXml.ps1 -OutputPath .\tools\sdk.xml
    .\pipeline\Get-DotNetSdkXml.ps1 -Version 2.5.0
#>
param(
    [string] $PackageId  = "rws.languagecloud.sdk",
    [string] $OutputPath = ".\tools\Rws.LanguageCloud.Sdk.xml",
    [string] $Version    = "",
    [switch] $Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Discover latest stable version ────────────────────────────────────────────
if (-not $Version) {
    $indexUrl = "https://api.nuget.org/v3-flatcontainer/$PackageId/index.json"
    Write-Host "Querying NuGet for latest version of $PackageId ..." -ForegroundColor Cyan
    $index   = Invoke-RestMethod -Uri $indexUrl -UseBasicParsing
    # Filter out pre-release versions (those containing a hyphen)
    $stable  = $index.versions | Where-Object { $_ -notmatch '-' }
    $Version = $stable | Select-Object -Last 1
    if (-not $Version) { throw "No stable version found for package: $PackageId" }
}

Write-Host "  Target version : $Version"

# ── Version cache: skip if already extracted at this version ──────────────────
$markerPath = $OutputPath + ".version"
if (-not $Force -and (Test-Path $OutputPath) -and (Test-Path $markerPath)) {
    $cached = (Get-Content $markerPath -Raw).Trim()
    if ($cached -eq $Version) {
        Write-Host "NuGet XML already present at version $Version — skipping download." -ForegroundColor DarkGray
        Write-Output (Resolve-Path $OutputPath).Path
        exit 0
    }
}

# ── Ensure output directory exists ────────────────────────────────────────────
$outDir = Split-Path $OutputPath -Parent
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

# ── Download .nupkg ───────────────────────────────────────────────────────────
$downloadUrl = "https://api.nuget.org/v3-flatcontainer/$PackageId/$Version/$PackageId.$Version.nupkg"
Write-Host "  Downloading: $downloadUrl"

$tmpPkg = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName() + ".nupkg")
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tmpPkg -UseBasicParsing

    # ── Extract XML documentation file ────────────────────────────────────────
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($tmpPkg)
    try {
        # Prefer netstandard2.0, then any net* TFM
        $xmlEntry = $zip.Entries |
                    Where-Object { $_.FullName -match 'lib/netstandard2\.0/.*\.xml$' } |
                    Select-Object -First 1
        if (-not $xmlEntry) {
            $xmlEntry = $zip.Entries |
                        Where-Object { $_.FullName -match '^lib/net[^/]+/.*\.xml$' } |
                        Select-Object -First 1
        }
        if (-not $xmlEntry) {
            throw "No XML documentation file found inside NuGet package $PackageId $Version"
        }

        Write-Host "  Extracting  : $($xmlEntry.FullName) → $OutputPath"
        $entryStream = $xmlEntry.Open()
        $fileStream  = [System.IO.File]::Create($OutputPath)
        try {
            $entryStream.CopyTo($fileStream)
        } finally {
            $fileStream.Close()
            $entryStream.Close()
        }
    } finally {
        $zip.Dispose()
    }
} finally {
    if (Test-Path $tmpPkg) { Remove-Item $tmpPkg -Force }
}

# ── Write version marker ──────────────────────────────────────────────────────
$Version | Set-Content $markerPath -NoNewline

Write-Host "NuGet XML extracted: $OutputPath  (version $Version)" -ForegroundColor Green
Write-Output (Resolve-Path $OutputPath).Path
