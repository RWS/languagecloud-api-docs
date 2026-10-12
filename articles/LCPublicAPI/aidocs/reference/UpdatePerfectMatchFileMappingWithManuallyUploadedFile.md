# Trados Cloud Platform API Update File Mapping With Manually Uploaded File

Update File Mapping With Manually Uploaded File UpdatePerfectMatchFileMappingWithManuallyUploadedFile POST /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/file

- Friendly name: Update File Mapping With Manually Uploaded File
- Operation ID: UpdatePerfectMatchFileMappingWithManuallyUploadedFile
- HTTP Method: POST
- Path: /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/file

Updates a PerfectMatch file mapping with a manually uploaded file.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: multipart/form-data

```
type: object
properties:
  - properties: $ref: #/components/schemas/perfect-match-custom-file-mapping-request
  - file: type: string (format: binary)
```

## Response

### 204



### 400

Error codes: 
* "missing": Missing required field for the value mentioned in the "name" field on the error response.


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
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: perfect-match-custom-file-mapping-request
<a id="perfect-match-custom-file-mapping-request"></a>

```
type: object
  description: Provide you own matching file.
properties:
  - name: type: string
  - targetLanguage: type: string
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

### .NET — `IPerfectMatchMappingClient`

```csharp
Task UpdatePerfectMatchFileMappingWithManuallyUploadedFileAsync(string mappingId, string batchMappingId, string fileMappingId, PerfectMatchCustomFileMappingRequest file);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `string` | yes |
| `batchMappingId` | `string` | yes |
| `fileMappingId` | `string` | yes |
| `file` | `PerfectMatchCustomFileMappingRequest` | yes |

### Java — `PerfectMatchMappingApi`

```java
// POST /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/file
void updatePerfectMatchFileMappingWithManuallyUploadedFile(String mappingId, String batchMappingId, String fileMappingId, PerfectMatchCustomFileMappingRequest properties, File file);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `String` | yes |
| `batchMappingId` | `String` | yes |
| `fileMappingId` | `String` | yes |
| `properties` | `PerfectMatchCustomFileMappingRequest` | yes |
| `file` | `File` | yes |