# Trados Cloud Platform API Poll Project Files Export

Poll Project Files Export ExportProjectFilesStatus GET /projects/{projectId}/files/exports/{exportId}

- Friendly name: Poll Project Files Export
- Operation ID: ExportProjectFilesStatus
- HTTP Method: GET
- Path: /projects/{projectId}/files/exports/{exportId}

Retrieves the state of the export operation. 

 Once the state is marked as `done`, you can download the generated `zip` file using the following endpoint: [Download Exported Project Files](../api/Public-API.v1-fv.html#/operations/DownloadFile).

> [!WARNING] 
> The export ID has a time-to-live (TTL) of 20 minutes, starting from when the export operation was initiated (not when the underlying async operation completes). If the TTL expires, this endpoint will return a `404 Not Found` error. Ensure you poll and download the export within this timeframe.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **exportId** (path, string) - required: The export identifier.

## Request body

No request body.

## Response

### 200

OK

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
* "forbidden": - the authenticated user is not allowed to retrieve the details of the export.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the export operation could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


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
Task ExportProjectFilesStatusAsync(string exportId, string projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `exportId` | `string` | yes |
| `projectId` | `string` | yes |

### Java — `ProjectApi`

```java
// GET /projects/{projectId}/files/exports/{exportId}
ZipFileExportResponse exportProjectFilesStatus(String projectId, String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `exportId` | `String` | yes |