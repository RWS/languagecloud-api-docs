# Trados Cloud Platform API Download Target File Version

Download Target File Version DownloadFileVersion GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download

- Friendly name: Download Target File Version
- Operation ID: DownloadFileVersion
- HTTP Method: GET
- Path: /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download

Downloads the file version (native or BCM). 

If the `fileVersionId` path parameter represents a native file version, the native file will be downloaded. If the `fileVersionId` is an identifier of a version in [BCM format](../../BCM/BCM.NET_client_API.html), the BCM file will be downloaded.

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
* "forbidden": not allowed to download the file version.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the file version could not be found.

- Content: application/json
- Schema: error-response (see model section below)

### 409

error codes:
* "invalidType": the type of the file version cannot be downloaded.

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

### .NET — `ITargetFileClient`

```csharp
Task DownloadFileVersionAsync(string projectId, string targetFileId, string fileVersionId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |
| `fileVersionId` | `string` | yes |

### Java — `TargetFileApi`

```java
// GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download
FileResponse downloadFileVersion(String projectId, String targetFileId, String fileVersionId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `fileVersionId` | `String` | yes |