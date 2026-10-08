# Trados Cloud Platform API Update File Mapping With Project File

Update File Mapping With Project File UpdatePerfectMatchFileMappingWithProjectFile PUT /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/project-file

- Friendly name: Update File Mapping With Project File
- Operation ID: UpdatePerfectMatchFileMappingWithProjectFile
- HTTP Method: PUT
- Path: /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/project-file

Updates a PerfectMatch file mapping with an existing target file from a PerfectMatch candidate. Only valid candidates can be used to request an update.

Use the [Candidates](#/operations/GetPerfectMatchCandidates) endpoint to retrieve a list of valid `fileId` and `projectId` to provide as matching data. 

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: perfect-match-project-file-mapping-request (see model section below)

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


## Model: perfect-match-project-file-mapping-request
<a id="perfect-match-project-file-mapping-request"></a>

```
type: object
  description: Provide a matching file from an existing project.
properties:
  - fileId: type: string
  - projectId: type: string
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
Task UpdatePerfectMatchFileMappingWithProjectFileAsync(string mappingId, string batchMappingId, string fileMappingId);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `string` | yes |
| `batchMappingId` | `string` | yes |
| `fileMappingId` | `string` | yes |

### Java — `PerfectMatchMappingApi`

```java
// PUT /perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/project-file
void updatePerfectMatchFileMappingWithProjectFile(String mappingId, String batchMappingId, String fileMappingId, PerfectMatchProjectFileMappingRequest perfectMatchProjectFileMappingRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `mappingId` | `String` | yes |
| `batchMappingId` | `String` | yes |
| `fileMappingId` | `String` | yes |
| `perfectMatchProjectFileMappingRequest` | `PerfectMatchProjectFileMappingRequest` | no |