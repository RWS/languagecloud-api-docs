# Trados Cloud Platform API Upload Zip File

Upload Zip File UploadZipFile POST /files

- Friendly name: Upload Zip File
- Operation ID: UploadZipFile
- HTTP Method: POST
- Path: /files

Uploads an archive containing source files in `.zip` format, which will be extracted and used during project creation.

Status of the upload operation can be tracked using the [Poll Upload Zip File](#/operations/PollUploadZipFile) endpoint.

Once this Upload Zip File operation has finished extracting the files, they can be added to the desired project using the [Attach Source Files](#/operations/AddSourceFiles) endpoint. Alternatively, they can be used to [Request File Analysis](#/operations/RequestFileAnalysis) details like word counts and estimated costs.


Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

For details on multipart requests please see [this article](../docs/How-to-multipart.html).
- Content: multipart/form-data

```
type: object
properties:
  - file: type: string (format: binary)
```

## Response

### 200



- Content: application/json
- Schema: file-upload-response (see model section below)

### 400

Error code “invalid” in case of:
 * Empty or missing file in request
 * Not valid multipart request
 * File parameter contains other extension than the one expected by specification.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: file-upload-response
<a id="file-upload-response"></a>

```
type: object
properties:
  - id: type: string
  - fileName: type: string
  - unzipStatus: type: string enum: [queued, extracting, extracted, unzipError]
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

### .NET — `IFileClient`

```csharp
Task UploadZipFileAsync(FileParameter file);
```

| Parameter | Type | Required |
|---|---|---|
| `file` | `FileParameter` | yes |

### Java — `FileApi`

```java
// POST /files
FileUploadResponse uploadZipFile(File file);
```

| Parameter | Type | Required |
|---|---|---|
| `file` | `File` | yes |