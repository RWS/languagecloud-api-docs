# Trados Cloud Platform API Poll Upload Zip File

Poll Upload Zip File PollUploadZipFile GET /files/{fileId}

- Friendly name: Poll Upload Zip File
- Operation ID: PollUploadZipFile
- HTTP Method: GET
- Path: /files/{fileId}

Monitors the unzipping operation for a previously uploaded archive and retrieves details about the extracted files.

Once the [Upload Zip File](#/operations/UploadZipFile) operation has finished extracting the files, they can be added to the desired project using the [Attach Source Files](#/operations/AddSourceFiles) endpoint.
 Alternatively, they can be used to [Request File Analysis](#/operations/RequestFileAnalysis) details like word counts and estimated costs.


## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: file-metadata-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to read uploaded files.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the file could not be found by id.

- Content: application/json
- Schema: error-response (see model section below)


## Model: file-metadata-response
<a id="file-metadata-response"></a>

```
type: object
properties:
  - id: type: string
  - fileName: type: string
  - unzipStatus: type: string enum: [queued, extracting, extracted, unzipError]
  - associatedFiles: type: array
    items:
      $ref: #/components/schemas/file-extracted-response
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

## Model: file-extracted-response
<a id="file-extracted-response"></a>

```
type: object
properties:
  - id: type: string
  - fileName: type: string
  - filePath: type: string
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

### .NET — `IFileClient`

```csharp
Task PollUploadZipFileAsync(string fileId);
```

| Parameter | Type | Required |
|---|---|---|
| `fileId` | `string` | yes |

### Java — `FileApi`

```java
// GET /files/{fileId}
FileMetadataResponse pollUploadZipFile(String fileId);
```

| Parameter | Type | Required |
|---|---|---|
| `fileId` | `String` | yes |