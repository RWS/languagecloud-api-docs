<#
Convert markdown links inside contract JSON files.

Behavior:
- If a markdown link points to a .md file, replace the url to .html (literal change).
- If a markdown link points to a reference or api JSON path like
  ../reference/Public-API.v1.json/paths/~1files~1{fileId}/get or ../api/Public-API.v1.json/components/schemas/foo
  then replace the URL with either a local fragment (#/operations/... or #/schemas/...) when the referenced contract is the same file,
  or with a full relative path to the referenced contract HTML (e.g. ../../LCPublicAPI/api/Public-API.v1-fv.html#/operations/OpId)

Usage:
.\scripts\convert-contract-links.ps1 -Contract <path-to-contract.json> [-Root <repo-root>] [-Force]
If -Contract is omitted the script will process all *.json files under
articles/Extensibility/api and articles/LCPublicAPI/api.

Preview runs by default; add -Force to write changes.
#>

param(
    [string]$Contract,
    [string]$Root = (Get-Location).Path,
    [switch]$Force
)

Write-Host "Root: $Root"

# ensure $Root is a single string (some callers may pass arrays)
if ($Root -is [array]) { $Root = $Root[0] }

function Resolve-ReferencedJsonFile {
    param(
        [string]$referencedFileName,
        [string]$currentDir,
        [string]$root
    )

    # Candidate locations relative to current file and repo
    $candidates = @()
    $candidates += Join-Path $currentDir "..\reference\$referencedFileName"
    $candidates += Join-Path $currentDir "..\api\$referencedFileName"
    $candidates += Join-Path $root "articles\LCPublicAPI\api\$referencedFileName"
    $candidates += Join-Path $root "articles\Extensibility\api\$referencedFileName"

    foreach ($c in $candidates) {
        try {
            $p = Resolve-Path -Path $c -ErrorAction Stop
            if ($p) { return $p.Path }
        } catch { }
    }

    return $null
}

function Get-JsonPointerPath {
    param([string]$pointer)
    # pointer segments are separated by /; ~1 -> /, ~0 -> ~
    $seg = $pointer -split '/'
    $decoded = ($seg | ForEach-Object { $_ -replace '~1', '/' -replace '~0','~' }) -join '/'
    return $decoded
}

function Get-OperationIdFromJson {
    param(
        [object]$jsonObj,
        [string]$jsonPointer,
        [string]$method
    )
    # $jsonPointer is like 'paths/~1files~1{fileId}~1versions~1{fileVersionId}~1download'
    $pathKey = $jsonPointer -replace '^paths/',''
    # decode ~1 and ~0
    $pathKeyDecoded = ($pathKey -split '/').ForEach({ $_ -replace '~1','/' -replace '~0','~' }) -join '/'
    if ($jsonObj.paths -and $jsonObj.paths.PSObject.Properties.Name -contains $pathKeyDecoded) {
        $pathObj = $jsonObj.paths.$($pathKeyDecoded)
        if ($null -ne $pathObj) {
            $methodLower = $method.ToLower()
            if ($pathObj.PSObject.Properties.Name -contains $methodLower) {
                $op = $pathObj.$methodLower.operationId
                if ($op) { return $op }
            }
        }
    }
    return $null
}

function Get-SchemaNameFromJsonPointer {
    param([string]$pointer)
    # pointer like components/schemas/MySchema
    if ($pointer -match '^components/schemas/(.+)$') { return $Matches[1] }
    return $null
}

if ($Contract) {
    $contractFiles = @((Resolve-Path -Path $Contract).Path)
} else {
    $dirs = @(
        "$Root\articles\Extensibility\api",
        "$Root\articles\LCPublicAPI\api"
    )
    $contractFiles = @()
    foreach ($d in $dirs) {
        if (Test-Path $d) {
            $contractFiles += Get-ChildItem -Path $d -Filter '*.json' -File -Recurse | Select-Object -ExpandProperty FullName
        }
    }
}

if (-not $contractFiles -or $contractFiles.Count -eq 0) {
    Write-Error "No contract files found to process. Provide -Contract or ensure API folders exist under articles/."
    exit 1
}

$report = @()

foreach ($cf in $contractFiles) {
    Write-Host "Processing: $cf"
    $origContent = Get-Content -Raw -Path $cf -Encoding UTF8
    $newContent = $origContent
    $currentDir = Split-Path -Path $cf -Parent
    $jsonObj = $null
    try { $jsonObj = $origContent | ConvertFrom-Json -ErrorAction Stop } catch { }

    # find markdown links [text](url)
    $linkPattern = '\[([^\]]+)\]\(([^)]+)\)'
    $linkMatches = [regex]::Matches($origContent, $linkPattern)
    foreach ($m in $linkMatches) {
        $fullMatch = $m.Value
        $text = $m.Groups[1].Value
        $url = $m.Groups[2].Value

        # Skip absolute URLs (http, https, mailto)
        if ($url -match '^(https?:|mailto:|#)') { continue }

        $newUrl = $null

        # Case 1: .md -> .html
        if ($url -match '\.md(\#.*)?$') {
            $newUrl = $url -replace '\.md(\#.*)?$','.html$1'
            $report += [pscustomobject]@{ File = $cf; Old = $url; New = $newUrl; Reason = '.md -> .html' }
        }

        # Case 2: reference or api JSON paths
        elseif ($url -match '^(?:\.\./)?(?:reference|api)/(?<file>[^/]+\.json)/(?<rest>.+)$') {
            $refFile = $Matches['file']
            $rest = $Matches['rest']

            # locate referenced json file on disk
            $resolved = Resolve-ReferencedJsonFile -referencedFileName $refFile -currentDir $currentDir -root $Root
            if (-not $resolved) {
                Write-Warning "Referenced JSON not found: $refFile (in $cf)"
                continue
            }

            # load referenced json object
            try {
                $refJsonText = Get-Content -Raw -Path $resolved -Encoding UTF8
                $refObj = $refJsonText | ConvertFrom-Json -ErrorAction Stop
            } catch {
                Write-Warning "Failed to parse referenced JSON: $resolved"
                continue
            }

            # determine if referenced file is the same as current contract
            $isLocalContract = ($resolved -eq (Resolve-Path -Path $cf).Path)

            if ($rest -like 'paths/*') {
                # rest format: paths/~1something~1foo/post
                $parts = $rest -split '/'
                # last segment is method
                $method = $parts[-1]
                $pointer = ($parts[0..($parts.Length-2)] -join '/')

                # try to get operationId
                $opId = Get-OperationIdFromJson -jsonObj $refObj -jsonPointer $pointer -method $method
                if (-not $opId) {
                    Write-Warning "OperationId not found for $url in $resolved"
                    continue
                }

                if ($isLocalContract) {
                    $newUrl = "#/operations/$opId"
                } else {
                    # compute relative path from current file to referenced file's folder
                    $refDir = Split-Path -Path $resolved -Parent
                    $refHtmlFile = [System.IO.Path]::Combine($refDir, ([System.IO.Path]::GetFileNameWithoutExtension($refFile) + '-fv.html'))
                    # create a relative path using URI trick
                    $fromUri = (Get-Item $currentDir).FullName.TrimEnd('\') + '\'
                    $toUri = (Get-Item $refHtmlFile).FullName
                    $uriFrom = New-Object System.Uri($fromUri)
                    $uriTo = New-Object System.Uri($toUri)
                    $rel = $uriFrom.MakeRelativeUri($uriTo).ToString() -replace '/','\'
                    # convert Windows backslashes to forward slashes for markdown
                    $rel = $rel -replace '\\','/'
                    $newUrl = "$rel#\/operations\/$opId"
                    # remove escapes inserted above
                    $newUrl = $newUrl -replace '\\/', '/'
                }

                $report += [pscustomobject]@{ File = $cf; Old = $url; New = $newUrl; Reason = 'paths -> operationId' }
            }

            elseif ($rest -like 'components/schemas/*') {
                $schema = $rest -replace '^components/schemas/',''
                if ($isLocalContract) {
                    $newUrl = "#/schemas/$schema"
                } else {
                    $refDir = Split-Path -Path $resolved -Parent
                    $refHtmlFile = [System.IO.Path]::Combine($refDir, ([System.IO.Path]::GetFileNameWithoutExtension($refFile) + '-fv.html'))
                    $fromUri = (Get-Item $currentDir).FullName.TrimEnd('\') + '\'
                    $toUri = (Get-Item $refHtmlFile).FullName
                    $uriFrom = New-Object System.Uri($fromUri)
                    $uriTo = New-Object System.Uri($toUri)
                    $rel = $uriFrom.MakeRelativeUri($uriTo).ToString() -replace '/','\\'
                    $rel = $rel -replace '\\','/'
                    $newUrl = "$rel#\/schemas\/$schema"
                    $newUrl = $newUrl -replace '\\/', '/'
                }
                $report += [pscustomobject]@{ File = $cf; Old = $url; New = $newUrl; Reason = 'components/schemas -> schema' }
            }

            else {
                # Not handled pointer type
                continue
            }
        }

        if ($newUrl) {
            # literal replace the url inside the JSON content
            $escapedOld = [Regex]::Escape($url)
            # Replace only the exact markdown link target inside parentheses to avoid accidental replacements elsewhere
            $patternFull = "(\[" + [Regex]::Escape($text) + "\]\()" + $escapedOld + "\)"
            $replacement = "`$1" + $newUrl + ")"
            # fallback simple replace if above fails
            if ($newContent -match [regex]::Escape($fullMatch)) {
                $newContent = $newContent -replace [regex]::Escape($fullMatch), "[$text]($newUrl)"
            } else {
                $newContent = $newContent -replace $patternFull, $replacement
            }
        }
    }

    if ($newContent -ne $origContent) {
        Write-Host "Preview (no write): $cf"
        # print replacements for this file
        $report | Where-Object { $_.File -eq $cf } | ForEach-Object { Write-Host "  $($_.Old) -> $($_.New)" }

        if ($Force) {
            Set-Content -Path $cf -Value $newContent -Encoding UTF8
            Write-Host "Wrote changes to $cf"
        }
    }
}

# summary
$grouped = $report | Group-Object -Property File
foreach ($g in $grouped) {
    Write-Host "File: $($g.Name) - Changes: $($g.Count)"
}

if (-not $Force) { Write-Host "Processed $($contractFiles.Count) files. Use -Force to apply changes." }
