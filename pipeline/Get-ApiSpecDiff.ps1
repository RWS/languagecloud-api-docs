<#
.SYNOPSIS
    Diffs two OpenAPI spec files and returns which operations were added,
    removed, or changed (by content hash).

.DESCRIPTION
    Used by the pipeline orchestrator to decide which reference .md files
    need to be regenerated or have their SDK sections re-injected.

    Each operation is keyed by its operationId. The "changed" set contains
    operations present in both specs whose full operation object differs.

    Output is a JSON object with three arrays:
        { "Added": [...], "Removed": [...], "Changed": [...] }

.PARAMETER OldSpec
    Path to the previous version of the OpenAPI JSON file.

.PARAMETER NewSpec
    Path to the current version of the OpenAPI JSON file.

.PARAMETER OutputJson
    Optional path to write the JSON diff result. If omitted, result is
    written to stdout only.

.EXAMPLE
    .\pipeline\Get-ApiSpecDiff.ps1 -OldSpec .\prev\api.json -NewSpec .\LCPublicAPI\api.json
    .\pipeline\Get-ApiSpecDiff.ps1 -OldSpec old.json -NewSpec new.json -OutputJson diff.json
#>
param(
    [Parameter(Mandatory)][string] $OldSpec,
    [Parameter(Mandatory)][string] $NewSpec,
    [string] $OutputJson
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-OperationMap ([string]$specPath) {
    $spec = Get-Content $specPath -Raw | ConvertFrom-Json
    $ops  = @{}

    foreach ($pathProp in $spec.paths.PSObject.Properties) {
        $pathStr = $pathProp.Name
        foreach ($methodProp in $pathProp.Value.PSObject.Properties) {
            # Skip non-HTTP fields (e.g. "parameters" at path level)
            $httpMethods = 'get','post','put','patch','delete','head','options','trace'
            if ($methodProp.Name -notin $httpMethods) { continue }

            $operation   = $methodProp.Value
            $operationId = $operation.operationId
            if (-not $operationId) { continue }

            # Hash the full operation object for change detection
            $json = $operation | ConvertTo-Json -Depth 20 -Compress
            $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
            $hash  = [System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes)
            $hashStr = [System.BitConverter]::ToString($hash) -replace '-', ''

            $ops[$operationId] = [PSCustomObject]@{
                Path   = $pathStr
                Method = $methodProp.Name.ToUpper()
                Hash   = $hashStr
            }
        }
    }
    return $ops
}

Write-Host "=== Get-ApiSpecDiff ===" -ForegroundColor Cyan
Write-Host "Old : $OldSpec"
Write-Host "New : $NewSpec"
Write-Host ""

$old = Get-OperationMap $OldSpec
$new = Get-OperationMap $NewSpec

$added   = @($new.Keys | Where-Object { -not $old.ContainsKey($_) } | Sort-Object)
$removed = @($old.Keys | Where-Object { -not $new.ContainsKey($_) } | Sort-Object)
$changed = @($new.Keys | Where-Object {
    $old.ContainsKey($_) -and $old[$_].Hash -ne $new[$_].Hash
} | Sort-Object)

$result = [PSCustomObject]@{
    Added   = $added
    Removed = $removed
    Changed = $changed
}

# Report
Write-Host "Added   ($($added.Count))  : $($added   -join ', ')"
Write-Host "Removed ($($removed.Count)) : $($removed -join ', ')"
Write-Host "Changed ($($changed.Count)) : $($changed -join ', ')"

$json = $result | ConvertTo-Json -Depth 3

if ($OutputJson) {
    $json | Set-Content -Path $OutputJson -Encoding UTF8
    Write-Host ""
    Write-Host "Diff written to: $OutputJson" -ForegroundColor Cyan
}

# Always write to stdout so callers can capture via pipe or $( )
Write-Output $json
