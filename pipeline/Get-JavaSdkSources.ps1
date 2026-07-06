<#
.SYNOPSIS
    Downloads the latest lc-public-api-sdk sources JAR from Maven Central
    and extracts the *Api.java interface files needed by Update-SdkSections.ps1.

.DESCRIPTION
    Queries the Maven Central repository metadata for the latest release version,
    downloads the -sources.jar (which is a ZIP), and extracts all *Api.java files
    from com/rws/lt/lc/publicapi/sdk/api/ into the output directory (flat — no
    subdirectories). The extracted files are identical in structure to the
    SDK_JAVA/api/ directory used by the existing local-source parser.

.PARAMETER GroupId
    Maven groupId (dot-separated). Default: com.rws.lt.lc.public-api

.PARAMETER ArtifactId
    Maven artifactId. Default: lc-public-api-sdk

.PARAMETER OutputDir
    Directory to write extracted *Api.java files into.
    Default: .\tools\java-api

.PARAMETER Version
    Specific artifact version. If empty, the latest release version is
    auto-discovered from maven-metadata.xml.

.PARAMETER Force
    Re-download even when the output directory is already at the correct version.

.EXAMPLE
    .\pipeline\Get-JavaSdkSources.ps1
    .\pipeline\Get-JavaSdkSources.ps1 -OutputDir .\tools\java-api
    .\pipeline\Get-JavaSdkSources.ps1 -Version 25.0.10
#>
param(
    [string] $GroupId    = "com.rws.lt.lc.public-api",
    [string] $ArtifactId = "lc-public-api-sdk",
    [string] $OutputDir  = ".\tools\java-api",
    [string] $Version    = "",
    [switch] $Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Convert groupId dots to path separators
$groupPath = $GroupId -replace '\.', '/'

# ── Discover latest release version ───────────────────────────────────────────
if (-not $Version) {
    $metaUrl = "https://repo1.maven.org/maven2/$groupPath/$ArtifactId/maven-metadata.xml"
    Write-Host "Querying Maven Central for latest version of ${GroupId}:$ArtifactId ..." -ForegroundColor Cyan
    $metaContent = (Invoke-WebRequest -Uri $metaUrl -UseBasicParsing).Content
    [xml]$meta   = $metaContent
    $Version     = $meta.metadata.versioning.release
    if (-not $Version) { $Version = $meta.metadata.versioning.latest }
    if (-not $Version) { throw "Could not determine latest version from: $metaUrl" }
}

Write-Host "  Target version : $Version"

# ── Version cache: skip if already extracted at this version ──────────────────
$markerPath = Join-Path $OutputDir ".version"
if (-not $Force -and (Test-Path $markerPath)) {
    $cached = (Get-Content $markerPath -Raw).Trim()
    if ($cached -eq $Version) {
        Write-Host "Java SDK sources already present at version $Version -- skipping download." -ForegroundColor DarkGray
        Write-Output (Resolve-Path $OutputDir).Path
        exit 0
    }
}

# ── Download sources JAR ───────────────────────────────────────────────────────
$jarName     = "$ArtifactId-$Version-sources.jar"
$downloadUrl = "https://repo1.maven.org/maven2/$groupPath/$ArtifactId/$Version/$jarName"
Write-Host "  Downloading: $downloadUrl"

$tmpJar = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName() + ".jar")
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tmpJar -UseBasicParsing

    # ── Prepare output directory (clean slate) ─────────────────────────────────
    if (Test-Path $OutputDir) {
        # Remove only .java files so the version marker survives while we overwrite
        Get-ChildItem $OutputDir -Filter "*.java" | Remove-Item -Force
    } else {
        New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    }

    # ── Extract *Api.java files from the api/ package ─────────────────────────
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($tmpJar)
    try {
        # Match entries under the api/ directory that end in Api.java
        $apiPattern = 'com/rws/lt/lc/publicapi/sdk/api/\w+Api\.java$'
        $extracted  = 0

        foreach ($entry in $zip.Entries) {
            if ($entry.FullName -notmatch $apiPattern) { continue }

            $destPath    = Join-Path $OutputDir $entry.Name
            $entryStream = $entry.Open()
            $fileStream  = [System.IO.File]::Create($destPath)
            try {
                $entryStream.CopyTo($fileStream)
            } finally {
                $fileStream.Close()
                $entryStream.Close()
            }
            $extracted++
        }

        if ($extracted -eq 0) {
            throw "No *Api.java files matching '$apiPattern' found in sources JAR"
        }

        Write-Host "  Extracted $extracted *Api.java files → $OutputDir"
    } finally {
        $zip.Dispose()
    }
} finally {
    if (Test-Path $tmpJar) { Remove-Item $tmpJar -Force }
}

# ── Write version marker ──────────────────────────────────────────────────────
$Version | Set-Content $markerPath -NoNewline

Write-Host "Java SDK sources ready: $OutputDir  (version $Version)" -ForegroundColor Green
Write-Output (Resolve-Path $OutputDir).Path
