# Trados Cloud Platform API Get Source File Properties

Get Source File Properties GetSourceFileProperties GET /tasks/{taskId}/source-files/{sourceFileId}

- Friendly name: Get Source File Properties
- Operation ID: GetSourceFileProperties
- HTTP Method: GET
- Path: /tasks/{taskId}/source-files/{sourceFileId}

Retrieves the properties for a source file.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: source-file-properties-response (see model section below)

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
* "notFound": the task or source file could not be found by id.


- Content: application/json
- Schema: error-response (see model section below)


## Model: source-file-properties-response
<a id="source-file-properties-response"></a>

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
Task<SourceFileProperties> GetSourceFilePropertiesAsync(string taskId, string sourceFileId);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `string` | yes |
| `sourceFileId` | `string` | yes |

### Java — `SourceFileApi`

```java
// GET /tasks/{taskId}/source-files/{sourceFileId}
SourceFilePropertiesResponse getSourceFileProperties(String taskId, String sourceFileId);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `String` | yes |
| `sourceFileId` | `String` | yes |