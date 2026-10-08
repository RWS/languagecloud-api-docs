# Trados Cloud Platform API Delete PerfectMatch File Mapping For a File

Delete PerfectMatch File Mapping For a File DeletePerfectMatchFileMappingForFile DELETE /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/target-languages/{targetLanguage}

- Friendly name: Delete PerfectMatch File Mapping For a File
- Operation ID: DeletePerfectMatchFileMappingForFile
- HTTP Method: DELETE
- Path: /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/target-languages/{targetLanguage}

Deletes a PerfectMatch file mapping for a specific file and target language.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 204

No Content

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
Task DeletePerfectMatchFileMappingForFileAsync(string mappingId, string batchMappingId, string fileMappingId, string targetLanguage);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `string` | yes |
| `batchMappingId` | `string` | yes |
| `fileMappingId` | `string` | yes |
| `targetLanguage` | `string` | yes |

### Java — `PerfectMatchMappingApi`

```java
// DELETE /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/target-languages/{targetLanguage}
void deletePerfectMatchFileMappingForFile(String mappingId, String batchMappingId, String fileMappingId, String targetLanguage);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `String` | yes |
| `batchMappingId` | `String` | yes |
| `fileMappingId` | `String` | yes |
| `targetLanguage` | `String` | yes |