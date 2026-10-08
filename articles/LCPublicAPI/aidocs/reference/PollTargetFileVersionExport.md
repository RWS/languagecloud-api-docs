# Trados Cloud Platform API Poll Target File Version Export

Poll Target File Version Export PollTargetFileVersionExport GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}

- Friendly name: Poll Target File Version Export
- Operation ID: PollTargetFileVersionExport
- HTTP Method: GET
- Path: /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}

Polls a target file version via an export operation. The new version can be downloaded once the status is "completed".

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: file-version-export (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to retrieve the export.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found.

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
Task PollTargetFileVersionExportAsync(string projectId, string targetFileId, string fileVersionId, string exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |
| `fileVersionId` | `string` | yes |
| `exportId` | `string` | yes |

### Java — `TargetFileApi`

```java
// GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}
FileVersionExport pollTargetFileVersionExport(String projectId, String targetFileId, String fileVersionId, String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `fileVersionId` | `String` | yes |
| `exportId` | `String` | yes |