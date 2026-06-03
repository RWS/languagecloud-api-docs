# Trados Cloud Platform API Update Source Files

Update Source Files UpdateSourceFiles PUT /projects/{projectId}/source-files

- Friendly name: Update Source Files
- Operation ID: UpdateSourceFiles
- HTTP Method: PUT
- Path: /projects/{projectId}/source-files

Updates multiple source files. If any of the files fails to be updated, an error will be returned for each file. 

## Parameters

No parameters.

## Request body

- Content: application/json

- Schema: source-files-update-request (see model section below)

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
* "forbidden": - the authenticated user is not allowed to update the source file.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": a file with the same name already exists.


## Model: source-files-update-request
<a id="source-files-update-request"></a>

```
type: object
properties:
  - files: type: array
    items:
      $ref: #/components/schemas/source-file-update-request
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

## Model: source-file-update-request
<a id="source-file-update-request"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - updateTargetFilesName: type: boolean
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
Task UpdateSourceFilesAsync(string projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |

### Java — `SourceFileApi`

```java
// PUT /projects/{projectId}/source-files
void updateSourceFiles(String projectId, SourceFilesUpdateRequest sourceFilesUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `sourceFilesUpdateRequest` | `SourceFilesUpdateRequest` | no |