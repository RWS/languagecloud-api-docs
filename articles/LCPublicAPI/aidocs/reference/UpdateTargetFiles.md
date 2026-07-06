# Trados Cloud Platform API Update Target Files

Update Target Files UpdateTargetFiles PUT /projects/{projectId}/target-files

- Friendly name: Update Target Files
- Operation ID: UpdateTargetFiles
- HTTP Method: PUT
- Path: /projects/{projectId}/target-files

Updates multiple target files. If any of the files fails to be updated, an error will be returned for each file. 

## Parameters

No parameters.

## Request body

- Content: application/json

- Schema: target-files-update-request (see model section below)

## Response

### 204

No Content

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
* "forbidden": - the authenticated user is not allowed to update the file.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the target file could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": a file with the same name already exists.


## Model: target-files-update-request
<a id="target-files-update-request"></a>

```
type: object
properties:
  - files: type: array
    items:
      $ref: #/components/schemas/target-file-update-request
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

## Model: target-file-update-request
<a id="target-file-update-request"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
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
Task UpdateTargetFilesAsync(string projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |

### Java — `TargetFileApi`

```java
// PUT /projects/{projectId}/target-files
void updateTargetFiles(String projectId, TargetFilesUpdateRequest targetFilesUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFilesUpdateRequest` | `TargetFilesUpdateRequest` | no |