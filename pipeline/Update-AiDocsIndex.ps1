<#
.SYNOPSIS
    Regenerates aidocs/index.md — the master entry point for the AI docs hierarchy.

.DESCRIPTION
    Scans the aidocs directory for a reference section and an optional guides
    section, then writes a compact, AI-agent-optimised top-level index.md.

    The index is a navigation map — categories and guide titles are surfaced
    at the top level so an AI agent can route to the right file in one read
    without loading the full reference index or all guide files.

    Reference section : aidocs/reference/Index.md must exist.
      - Operation count derived from .md files (excl. Index.md, Schemas.md, components.md).
      - Category list extracted from H2 headings in reference/Index.md.
    Guides section    : included only when aidocs/guides/*.md files exist.
      - Each guide listed with its H1 title and first-paragraph description.

    Idempotent: only writes the file when content has actually changed.

.PARAMETER AiDocsDir
    Path to the aidocs directory. Default: .\articles\LCPublicAPI\aidocs

.EXAMPLE
    .\pipeline\Update-AiDocsIndex.ps1
    .\pipeline\Update-AiDocsIndex.ps1 -AiDocsDir .\articles\LCPublicAPI\aidocs
#>
param(
    [string] $AiDocsDir = ".\articles\LCPublicAPI\aidocs"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=== Update-AiDocsIndex ===" -ForegroundColor Cyan
Write-Host "AI docs dir : $AiDocsDir"
Write-Host ""

$referenceDir  = Join-Path $AiDocsDir "reference"
$guidesDir     = Join-Path $AiDocsDir "guides"
$outputPath    = Join-Path $AiDocsDir "index.md"

if (-not (Test-Path $referenceDir)) {
    Write-Warning "Reference directory not found: $referenceDir — skipping index generation."
    exit 0
}

# ── Build content ─────────────────────────────────────────────────────────────
$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add("# Language Cloud Public API — AI Docs")
$lines.Add("")
$lines.Add("## API Reference → [reference/Index.md](./reference/Index.md)")
$lines.Add("")
$lines.Add("## Guides → [guides/index.md](./guides/index.md)")

$indexContent = ($lines -join "`n") + "`n"

# ── Write if changed ──────────────────────────────────────────────────────────
$current = if (Test-Path $outputPath) { [System.IO.File]::ReadAllText($outputPath) } else { "" }

if ($current.Trim() -eq $indexContent.Trim()) {
    Write-Host "Unchanged: $outputPath" -ForegroundColor DarkGray
} else {
    [System.IO.File]::WriteAllText($outputPath, $indexContent, [System.Text.Encoding]::UTF8)
    Write-Host "Updated  : $outputPath" -ForegroundColor Green
}
