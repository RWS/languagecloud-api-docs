# Trados Cloud Platform API Download Exported Project Files

Download Exported Project Files DownloadFile GET /projects/{projectId}/files/exports/{exportId}/download

- Friendly name: Download Exported Project Files
- Operation ID: DownloadFile
- HTTP Method: GET
- Path: /projects/{projectId}/files/exports/{exportId}/download

Downloads the generated `zip` file containing the files according to initial export operation parameters. 

The final ZIP file will be named using the project name. 

 When the export operation is performed with `downloadFlat=true` and one target language specified, the resulting ZIP file name will be a combination of the project name and the target language code, as defined by the [Export Project Files](#/operations/ExportProjectFiles) endpoint.

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
* "forbidden": the authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the file could not be found by identifier.


- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "conflict": the export operation is not done yet.


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

### .NET — `IProjectClient`

```csharp
Task DownloadFileAsync(string projectId, string exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `exportId` | `string` | yes |

### Java — `ProjectApi`

```java
// GET /projects/{projectId}/files/exports/{exportId}/download
FileResponse downloadFile(String projectId, String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `exportId` | `String` | yes |