<#
.SYNOPSIS
    Convert ../reference/*.json links in markdown files to ../api/*-fv.html links.

.DESCRIPTION
    Scans all markdown files under articles/LCPublicAPI/docs and finds links that
    reference JSON files under ../reference/. It converts two types of references:

    - paths -> operations: ../reference/<file>.json/paths/~1path~1sub/get
      becomes ../api/<file>-fv.html#/operations/#<operationId>

    - components/schemas -> schemas: ../reference/<file>.json/components/schemas/<SchemaName>
      becomes ../api/<file>-fv.html#/schemas/#<SchemaName>

    By default the script runs in preview mode and only prints proposed replacements.
    Use -Force to apply changes to files.

.PARAMETER Root
    Root path of the repository. Defaults to the current working directory.

.PARAMETER Force
    Apply changes. If not specified the script only shows a preview.

.EXAMPLE
    # preview
    .\convert-reference-links.ps1

    # apply changes
    .\convert-reference-links.ps1 -Force
#>

param(
    [string]$Root = (Get-Location).Path,
    [switch]$Force
)

Write-Host "Root: $Root"

$docsDir = Join-Path $Root 'articles\LCPublicAPI\docs'
if (-not (Test-Path $docsDir)) {
    Write-Error "Docs directory not found: $docsDir"
    exit 1
}

$mdFiles = Get-ChildItem -Path $docsDir -Recurse -Include *.md -File
if ($mdFiles.Count -eq 0) {
    Write-Host "No markdown files found under $docsDir"
    exit 0
}

$linkPattern = '\.\./reference/(?<file>[^/\\)]+)\.json/(?<rest>[^)\s]+)'
$regex = [regex]$linkPattern

$summary = [System.Collections.Generic.List[psobject]]::new()

foreach ($md in $mdFiles) {
    $content = Get-Content -Raw -Path $md.FullName -ErrorAction Stop
    $mMatches = $regex.Matches($content)
    if ($mMatches.Count -eq 0) { continue }

    $newContent = $content
    $fileChanges = [System.Collections.Generic.List[string]]::new()

    foreach ($m in $mMatches) {
        $orig = $m.Value
        $fileName = $m.Groups['file'].Value
        $rest = $m.Groups['rest'].Value

        $newUrl = $null

        if ($rest -like 'paths/*') {
            # expected format: paths/<encoded-json-pointer>/<method>
            $parts = $rest -split '/' | Where-Object { $_ -ne '' }
            # remove the leading 'paths'
            if ($parts.Count -lt 3) { continue }
            $parts = $parts[1..($parts.Count - 1)]
            $method = $parts[-1].ToLower()
            $encPathParts = $parts[0..($parts.Count - 2)]
            $encodedPointer = ($encPathParts -join '/')
            # decode JSON Pointer escaping ~1 -> / and ~0 -> ~
            $decodedPath = $encodedPointer -replace '~1','/' -replace '~0','~'

            $refJsonPath = Join-Path $Root "articles\LCPublicAPI\reference\$fileName.json"
            if (-not (Test-Path $refJsonPath)) {
                # try the api folder as some sources place the json files under articles/LCPublicAPI/api
                $apiJsonPath = Join-Path $Root "articles\LCPublicAPI\api\$fileName.json"
                if (Test-Path $apiJsonPath) {
                    Write-Host "Info: using API JSON fallback: $apiJsonPath (for $fileName.json in $($md.FullName))"
                    $refJsonPath = $apiJsonPath
                }
                else {
                    Write-Warning "Referenced JSON not found: $refJsonPath (in $($md.FullName))"
                    continue
                }
            }

            try {
                $json = Get-Content -Raw -Path $refJsonPath | ConvertFrom-Json -ErrorAction Stop
            }
            catch {
                Write-Warning "Failed to parse JSON: $refJsonPath"
                continue
            }

            $pathObj = $null
            if ($json.paths -and $json.paths.PSObject.Properties.Name -contains $decodedPath) {
                $pathObj = $json.paths.PSObject.Properties[$decodedPath].Value
            }
            else {
                # no exact match; try a best-effort find using replacement of '{' '}' to parameter name
                $alt = $json.paths.PSObject.Properties.Name | Where-Object { $_ -replace '[{}]','' -eq ($decodedPath -replace '[{}]','') }
                if ($alt) { $pathObj = $json.paths.PSObject.Properties[$alt].Value }
            }

            $operationId = $null
            if ($null -ne $pathObj) {
                if ($pathObj.PSObject.Properties.Name -contains $method) {
                    $op = $pathObj.PSObject.Properties[$method].Value
                    if ($op -and $op.operationId) { $operationId = $op.operationId }
                }
            }

            if (-not $operationId) {
                # fallback: create a slug-like id from method + path
                $slug = ($method + '-' + ($decodedPath -replace '[^0-9A-Za-z]','-')).Trim('-')
                $operationId = $slug
                Write-Host "Warning: operationId not found for $fileName.json $decodedPath $method. Falling back to $operationId"
            }

            # build new URL using fragment format '#/operations/<operationId>'
            $newUrl = "../api/$fileName-fv.html#/operations/$operationId"
        }
        elseif ($rest -like 'components/schemas/*') {
            # schema name is the last segment
            $parts = $rest -split '/'
            $schema = $parts[-1]
            $newUrl = "../api/$fileName-fv.html#/schemas/$schema"
        }
        else {
            continue
        }

        if ($newUrl) {
            # literal replace the matched path portion to avoid regex escape issues
            $newContent = $newContent.Replace($orig, $newUrl)
            $fileChanges.Add("$orig -> $newUrl")
        }
    }

    if ($fileChanges.Count -gt 0) {
        $summary.Add([pscustomobject]@{ File = $md.FullName; Changes = $fileChanges })
        if ($Force) {
            Set-Content -Path $md.FullName -Value $newContent -Encoding UTF8
            Write-Host "Updated: $($md.FullName)"
        }
        else {
            Write-Host "Preview (no write): $($md.FullName)"
            foreach ($c in $fileChanges) { Write-Host "  $c" }
        }
    }
}

# Summary
if ($summary.Count -eq 0) {
    Write-Host "No links matched the pattern."
}
else {
    Write-Host "Processed $($summary.Count) files. Use -Force to apply changes."
}
