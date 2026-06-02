<#
.SYNOPSIS
    Regenerates aidocs/guides/index.md from the current set of guide files.

.DESCRIPTION
    Scans GuidesDir for all *.md files (excluding index.md itself), reads
    the first H1 heading as the title, and the first non-heading paragraph
    as the short description. Writes a flat Markdown table to index.md.

    Idempotent: only writes the file when content has actually changed.

.PARAMETER GuidesDir
    Path to the aidocs/guides directory. Default: .\aidocs\guides

.EXAMPLE
    .\pipeline\Update-GuidesIndex.ps1
    .\pipeline\Update-GuidesIndex.ps1 -GuidesDir .\aidocs\guides
#>
param(
    [string] $GuidesDir = ".\aidocs\guides"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=== Update-GuidesIndex ===" -ForegroundColor Cyan
Write-Host "Guides dir : $GuidesDir"
Write-Host ""

if (-not (Test-Path $GuidesDir)) {
    Write-Error "Guides directory not found: $GuidesDir"
    exit 1
}

$guideFiles = Get-ChildItem $GuidesDir -Filter "*.md" |
              Where-Object { $_.Name -ne "index.md" -and $_.Name -notlike "_*" } |
              Sort-Object Name

if ($guideFiles.Count -eq 0) {
    Write-Warning "No guide files found in $GuidesDir"
    exit 0
}

function Get-GuideInfo ([string]$filePath) {
    $lines   = [System.IO.File]::ReadAllLines($filePath)
    $title   = ""
    $desc    = ""
    $pastH1  = $false

    foreach ($line in $lines) {
        $trimmed = $line.Trim()

        # First H1 is the title
        if (-not $title -and $trimmed -match '^#\s+(.+)$') {
            $title  = $matches[1].Trim()
            $pastH1 = $true
            continue
        }

        # First substantive non-heading, non-empty, non-table, non-code line after H1
        if ($pastH1 -and -not $desc -and $trimmed -and
            $trimmed -notmatch '^#+\s' -and
            $trimmed -notmatch '^\|' -and
            $trimmed -notmatch '^```' -and
            $trimmed -notmatch '^---') {

            # Strip inline markdown links → plain text for the description
            $d = $trimmed -replace '\[([^\]]+)\]\([^)]+\)', '$1'
            # Strip bold/italic markers
            $d = $d -replace '\*\*?([^*]+)\*\*?', '$1'
            # Truncate at 120 chars
            if ($d.Length -gt 120) { $d = $d.Substring(0, 117) + "..." }
            $desc = $d
        }

        if ($title -and $desc) { break }
    }

    # Fallback: use filename without extension as title
    if (-not $title) { $title = [System.IO.Path]::GetFileNameWithoutExtension($filePath) }

    return [PSCustomObject]@{ Title = $title; Description = $desc }
}

# Build table rows
$rows = foreach ($file in $guideFiles) {
    $info = Get-GuideInfo $file.FullName
    "| [$($file.Name)](./$($file.Name)) | $($info.Description) |"
    Write-Host "  $($file.Name)  →  $($info.Title)"
}

$indexContent = @"
# Guides Index

| Guide | Description |
|---|---|
$($rows -join "`n")
"@.TrimStart()

$outputPath = Join-Path $GuidesDir "index.md"
$current    = if (Test-Path $outputPath) { [System.IO.File]::ReadAllText($outputPath) } else { "" }

if ($current.Trim() -eq $indexContent.Trim()) {
    Write-Host ""
    Write-Host "Unchanged: $outputPath" -ForegroundColor DarkGray
} else {
    [System.IO.File]::WriteAllText($outputPath, $indexContent, [System.Text.Encoding]::UTF8)
    Write-Host ""
    Write-Host "Updated  : $outputPath" -ForegroundColor Green
}
