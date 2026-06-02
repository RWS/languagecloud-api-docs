<#
.SYNOPSIS
    Downloads and extracts the Contract2Markdown4AI (C2M4AI) executable
    from a GitHub release ZIP.

.PARAMETER OutputPath
    Destination path for the extracted executable.
    Default: .\tools\C2M4AI.exe

.PARAMETER DownloadUrl
    Full URL of the release ZIP.
    Default: v0.3.0 win-x64 release from github.com/haiduc32/Contract2Markdown4AI

.PARAMETER Force
    Re-download and overwrite even when the executable already exists.

.EXAMPLE
    .\pipeline\Get-C2M4AI.ps1
    .\pipeline\Get-C2M4AI.ps1 -OutputPath .\tools\C2M4AI.exe
    .\pipeline\Get-C2M4AI.ps1 -DownloadUrl https://github.com/.../v0.4.0/...zip -Force
#>
param(
    [string] $OutputPath  = ".\tools\C2M4AI.exe",
    [string] $DownloadUrl = "https://github.com/haiduc32/Contract2Markdown4AI/releases/download/v0.3.0/Contract2Markdown4AI-win-x64-0.3.0.zip",
    [switch] $Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Skip if already present and not forced
if (-not $Force -and (Test-Path $OutputPath)) {
    Write-Host "C2M4AI.exe already present at: $OutputPath" -ForegroundColor DarkGray
    Write-Output (Resolve-Path $OutputPath).Path
    exit 0
}

# Ensure output directory exists
$outDir = Split-Path $OutputPath -Parent
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

Write-Host "Downloading C2M4AI from:" -ForegroundColor Cyan
Write-Host "  $DownloadUrl"

$tmpZip = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName() + ".zip")
try {
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $tmpZip -UseBasicParsing

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($tmpZip)
    try {
        # Find the first .exe in the archive
        $exeEntry = $zip.Entries | Where-Object { $_.Name -match '\.exe$' } | Select-Object -First 1
        if (-not $exeEntry) {
            throw "No .exe found inside the downloaded archive: $DownloadUrl"
        }

        Write-Host "  Extracting: $($exeEntry.FullName) → $OutputPath"
        $entryStream = $exeEntry.Open()
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
    if (Test-Path $tmpZip) { Remove-Item $tmpZip -Force }
}

Write-Host "C2M4AI.exe extracted to: $OutputPath" -ForegroundColor Green
Write-Output (Resolve-Path $OutputPath).Path
