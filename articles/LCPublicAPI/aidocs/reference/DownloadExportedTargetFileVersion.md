# Trados Cloud Platform API Download Exported Target File Version

Download Exported Target File Version DownloadExportedTargetFileVersion GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}/download

- Friendly name: Download Exported Target File Version
- Operation ID: DownloadExportedTargetFileVersion
- HTTP Method: GET
- Path: /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}/download

Downloads a completed target file version via an export operation.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200



- Content: application/octet-stream
```
type: string (format: binary)
```

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": not allowed to download the exported target file

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidStatus": the export is not completed
* "conflict": the export is not in a downloadable state due to another export, or the workflow has progressed since this export was requested

- Content: application/json
- Schema: error-response (see model section below)


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

### .NET — `ITargetFileClient`

```csharp
Task DownloadExportedTargetFileVersionAsync(string projectId, string targetFileId, string fileVersionId, string exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |
| `fileVersionId` | `string` | yes |
| `exportId` | `string` | yes |

### Java — `TargetFileApi`

```java
// GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}/download
FileResponse downloadExportedTargetFileVersion(String projectId, String targetFileId, String fileVersionId, String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `fileVersionId` | `String` | yes |
| `exportId` | `String` | yes |