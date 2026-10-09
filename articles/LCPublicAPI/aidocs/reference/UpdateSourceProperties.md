# Trados Cloud Platform API Update Source File Properties

Update Source File Properties UpdateSourceProperties PUT /tasks/{taskId}/source-files/{sourceFileId}

- Friendly name: Update Source File Properties
- Operation ID: UpdateSourceProperties
- HTTP Method: PUT
- Path: /tasks/{taskId}/source-files/{sourceFileId}

Updates the properties of the source file.


The value of `fileTypeSettingsId` should be one of the identifiers listed by the [List File Type Settings](#/operations/ListFileTypeSettings)  endpoint called with an identifier of a File Processing Configuration that exists on the project. The list of File Processing Configurations from a project can be retrieved by using the [List File Processing Configurations](#/operations/ListFileProcessingConfigurations) endpoint.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: source-file-properties-update-request (see model section below)

## Response

### 204

No Content

### 400

Error responses:
* “invalid”: invalid input on update source file properties.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": - the specified task or the source file was not found.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "noOwner": the task has no owner.
* "differentOwner": the authenticated user is not the owner of the task.
* "taskCompleted": updating the source file properties is not allowed when the task is completed.

- Content: application/json
- Schema: error-response (see model section below)


## Model: source-file-properties-update-request
<a id="source-file-properties-update-request"></a>

```
type: object
  description: 
properties:
  - fileRole: type: string enum: [translatable, reference]
  - fileTypeSettingsId: type: string
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
Task UpdateSourcePropertiesAsync(string taskId, string sourceFileId);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `string` | yes |
| `sourceFileId` | `string` | yes |

### Java — `SourceFileApi`

```java
// PUT /tasks/{taskId}/source-files/{sourceFileId}
void updateSourceProperties(String taskId, String sourceFileId, SourceFilePropertiesUpdateRequest sourceFilePropertiesUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `String` | yes |
| `sourceFileId` | `String` | yes |
| `sourceFilePropertiesUpdateRequest` | `SourceFilePropertiesUpdateRequest` | no |