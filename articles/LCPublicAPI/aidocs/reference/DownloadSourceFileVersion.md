# Trados Cloud Platform API Download Source File Version

Download Source File Version DownloadSourceFileVersion GET /projects/{projectId}/source-files/{sourceFileId}/versions/{fileVersionId}/download

- Friendly name: Download Source File Version
- Operation ID: DownloadSourceFileVersion
- HTTP Method: GET
- Path: /projects/{projectId}/source-files/{sourceFileId}/versions/{fileVersionId}/download

Downloads a source file version.

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
* "forbidden": the authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project, the source file or the file version could not be found by identifier.


- Content: application/json
- Schema: error-response (see model section below)

### 422

error codes:
* "maliciousContent": the file contains malicious content. The infected file cannot be downloaded.

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

### .NET — `ISourceFileClient`

```csharp
Task DownloadSourceFileVersionAsync(string projectId, string sourceFileId, string fileVersionId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `sourceFileId` | `string` | yes |
| `fileVersionId` | `string` | yes |

### Java — `SourceFileApi`

```java
// GET /projects/{projectId}/source-files/{sourceFileId}/versions/{fileVersionId}/download
FileResponse downloadSourceFileVersion(String projectId, String sourceFileId, String fileVersionId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `sourceFileId` | `String` | yes |
| `fileVersionId` | `String` | yes |