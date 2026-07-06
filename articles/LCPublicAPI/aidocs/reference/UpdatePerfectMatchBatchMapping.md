# Trados Cloud Platform API Update PerfectMatch Batch Mapping

Update PerfectMatch Batch Mapping UpdatePerfectMatchBatchMapping PUT /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}

- Friendly name: Update PerfectMatch Batch Mapping
- Operation ID: UpdatePerfectMatchBatchMapping
- HTTP Method: PUT
- Path: /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}

Updates a PerfectMatch batch mapping.

Pay special attention to how [updating works](../docs/Updating-data-with-PUT.html).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: perfect-match-batch-mapping-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes: 
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

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

### 409

Error codes:
* "updateNotAllowed": the resource could not be updated at this time.

- Content: application/json
- Schema: error-response (see model section below)


## Model: perfect-match-batch-mapping-update-request
<a id="perfect-match-batch-mapping-update-request"></a>

```
type: object
properties:
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/language-direction-request
  - files: type: array
    items:
      $ref: #/components/schemas/perfect-match-file-mapping-request
  - matchingProjects: type: array
    items:
      type: string
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

## Model: language-direction-request
<a id="language-direction-request"></a>

```
type: object
  description: The language directions model used for creating or updating a project.
properties:
  - sourceLanguage: $ref: #/components/schemas/source-language-request
  - targetLanguage: $ref: #/components/schemas/target-language-request
```

## Model: perfect-match-file-mapping-request
<a id="perfect-match-file-mapping-request"></a>

```
type: object
properties:
  - sourceFileId: type: string
  - fileName: type: string
  - targetLanguages: type: array
    items:
      $ref: #/components/schemas/target-language-request
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

## Model: source-language-request
<a id="source-language-request"></a>

```
type: object
properties:
  - languageCode: type: string
```

## Model: target-language-request
<a id="target-language-request"></a>

```
type: object
  description: 
properties:
  - languageCode: type: string
```

## SDK

### .NET — `IPerfectMatchMappingClient`

```csharp
Task UpdatePerfectMatchBatchMappingAsync(string mappingId, string batchMappingId);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `string` | yes |
| `batchMappingId` | `string` | yes |

### Java — `PerfectMatchMappingApi`

```java
// PUT /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}
void updatePerfectMatchBatchMapping(String mappingId, String batchMappingId, PerfectMatchBatchMappingUpdateRequest perfectMatchBatchMappingUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `String` | yes |
| `batchMappingId` | `String` | yes |
| `perfectMatchBatchMappingUpdateRequest` | `PerfectMatchBatchMappingUpdateRequest` | no |