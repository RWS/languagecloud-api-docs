# Trados Cloud Platform API Update Source File

Update Source File UpdateSourceFile PUT /projects/{projectId}/source-files/{sourceFileId}

- Friendly name: Update Source File
- Operation ID: UpdateSourceFile
- HTTP Method: PUT
- Path: /projects/{projectId}/source-files/{sourceFileId}

Updates a source file.

## Parameters

No parameters.

## Request body

- Content: application/json

- Schema: source-file-rename-request (see model section below)

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
* "notFound": the project or the source file could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": a file with the same name already exists.


## Model: source-file-rename-request
<a id="source-file-rename-request"></a>

```
type: object
properties:
  - name: type: string
  - updateTargetFilesName: type: boolean
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

### .NET — `ISourceFileClient`

```csharp
Task UpdateSourceFileAsync(string projectId, string sourceFileId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `sourceFileId` | `string` | yes |

### Java — `SourceFileApi`

```java
// PUT /projects/{projectId}/source-files/{sourceFileId}
void updateSourceFile(String projectId, String sourceFileId, SourceFileRenameRequest sourceFileRenameRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `sourceFileId` | `String` | yes |
| `sourceFileRenameRequest` | `SourceFileRenameRequest` | no |