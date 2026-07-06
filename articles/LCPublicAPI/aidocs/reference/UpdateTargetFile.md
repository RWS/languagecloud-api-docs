# Trados Cloud Platform API Update Target File

Update Target File UpdateTargetFile PUT /projects/{projectId}/target-files/{targetFileId}

- Friendly name: Update Target File
- Operation ID: UpdateTargetFile
- HTTP Method: PUT
- Path: /projects/{projectId}/target-files/{targetFileId}

Updates a target file.

## Parameters

No parameters.

## Request body

- Content: application/json

- Schema: target-file-rename-request (see model section below)

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
* "forbidden": - the authenticated user is not allowed to update the target file.

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


## Model: target-file-rename-request
<a id="target-file-rename-request"></a>

```
type: object
properties:
  - name: type: string
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

### .NET — `ITargetFileClient`

```csharp
Task UpdateTargetFileAsync(string projectId, string targetFileId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |

### Java — `TargetFileApi`

```java
// PUT /projects/{projectId}/target-files/{targetFileId}
void updateTargetFile(String projectId, String targetFileId, TargetFileRenameRequest targetFileRenameRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `targetFileRenameRequest` | `TargetFileRenameRequest` | no |