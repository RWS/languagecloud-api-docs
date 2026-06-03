# Trados Cloud Platform API Export Project Files

Export Project Files ExportProjectFiles POST /projects/{projectId}/files/exports

- Friendly name: Export Project Files
- Operation ID: ExportProjectFiles
- HTTP Method: POST
- Path: /projects/{projectId}/files/exports

Generates an asynchronous export operation. To monitor the progress until completion, use the [Poll Project Files Export](../api/Public-API.v1-fv.html#/operations/ExportProjectFilesStatus)  endpoint. 

This operation triggers the packaging of the project files into a `zip` format.
> [!WARNING] 
> The export ID has a time-to-live (TTL) of 20 minutes, starting from when this export operation is initiated (not when the underlying async operation completes). Ensure you poll and download the export within this timeframe, or you will receive a `404 Not Found` error.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: zip-file-export-request (see model section below)

## Response

### 200

Export Operation was triggered successfully

- Content: application/json
- Schema: zip-file-export-response (see model section below)

### 400

Error responses:
* "invalid": invalid input for the value mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - the authenticated user is not allowed to trigger an export on the specified project, or does not have access to the project.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: zip-file-export-request
<a id="zip-file-export-request"></a>

```
type: object
properties:
  - referenceFiles: $ref: #/components/schemas/zip-file-export-reference-files-request
  - targetFiles: $ref: #/components/schemas/zip-file-export-target-files-request
```

## Model: zip-file-export-response
<a id="zip-file-export-response"></a>

```
type: object
properties:
  - exportId: type: string
  - state: type: string enum: [created, processing, done, error]
```

## Model: error-response
<a id="error-response"></a>

```
type: object
  description: Error response properties.
properties:
  - message: type: string
  - errorCode: type: string
  - details: type: array
    items:
      $ref: #/components/schemas/error-detail-response
```

## Model: zip-file-export-reference-files-request
<a id="zip-file-export-reference-files-request"></a>

```
type: object
  description: Reference files associated with the project.
properties:
  - include: type: boolean
```

## Model: zip-file-export-target-files-request
<a id="zip-file-export-target-files-request"></a>

```
type: object
  description: Target files associated with the project.
properties:
  - includeVersions: type: string enum: [currentVersion, none, nativeVersion]
  - targetLanguages: type: array
    items:
      type: string
  - downloadFlat: type: boolean
```

## Model: error-detail-response
<a id="error-detail-response"></a>

```
type: object
  description: Error detail response properties.
properties:
  - name: type: string
  - code: type: string
  - value: type: string
```

## SDK

### .NET — `IProjectClient`

```csharp
Task ExportProjectFilesAsync(string projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |

### Java — `ProjectApi`

```java
// POST /projects/{projectId}/files/exports
ZipFileExportResponse exportProjectFiles(String projectId, ZipFileExportRequest zipFileExportRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `zipFileExportRequest` | `ZipFileExportRequest` | no |