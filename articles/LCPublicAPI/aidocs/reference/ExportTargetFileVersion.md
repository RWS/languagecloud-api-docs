# Trados Cloud Platform API Export Target File Version

Export Target File Version ExportTargetFileVersion POST /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports

- Friendly name: Export Target File Version
- Operation ID: ExportTargetFileVersion
- HTTP Method: POST
- Path: /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports

Generates an asynchronous export operation. Use the [Get Target File Version Export](#/operations/PollTargetFileVersionExport) endpoint to poll until the export is completed. Used only for [BCM](../../BCM/BCM.NET_client_API.html) file versions.

This operation triggers a conversion of the BCM target file version in a native or SDLXLIFF format, based on the value of the `format` query parameter used.

Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **format** (query, string) - optional: The file format.

## Request body

No request body.

## Response

### 202



- Content: application/json
- Schema: file-version-export (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to export the target file version.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project, the target file or the version could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidType": The type of the target file doesn't allow the export operation.
* "conflict": A target file version export is already in progress.

- Content: application/json
- Schema: error-response (see model section below)


## Model: file-version-export
<a id="file-version-export"></a>

```
allOf:
  - part0:
    $ref: #/components/schemas/asynchronous-result
  - part1:
    type: object
    properties:
      - downloadUrl: type: string
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

## Model: asynchronous-result
<a id="asynchronous-result"></a>

```
type: object
  description: Represents the result of an asynchronous operation, including status and potential error information.
properties:
  - id: type: string
  - status: type: string enum: [created, inProgress, completed, failed]
  - errorMessage: type: string
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
Task ExportTargetFileVersionAsync(string projectId, string targetFileId, string fileVersionId, Format? format = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |
| `fileVersionId` | `string` | yes |
| `format` | `Format` | no |

### Java — `TargetFileApi`

```java
// POST /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports?format={format}
FileVersionExport exportTargetFileVersion(String projectId, String targetFileId, String fileVersionId, String format);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `fileVersionId` | `String` | yes |
| `format` | `String` | no |