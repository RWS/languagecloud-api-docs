# Trados Cloud Platform API List Target File Versions

List Target File Versions ListTargetFileVersions GET /projects/{projectId}/target-files/{targetFileId}/versions

- Friendly name: List Target File Versions
- Operation ID: ListTargetFileVersions
- HTTP Method: GET
- Path: /projects/{projectId}/target-files/{targetFileId}/versions

Retrieves the versions of a target file.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-target-file-versions-response (see model section below)

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
* "forbidden": the authenticated user is not allowed to retrieve versions on the target file.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project or the target file could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-target-file-versions-response
<a id="list-target-file-versions-response"></a>

```
type: object
  description: A response for the List Target Files Versions endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/target-file-version
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

## Model: target-file-version
<a id="target-file-version"></a>

```
type: object
  description: Target File Version.
properties:
  - id: type: string
  - type: type: string enum: [native, bcm]
  - name: type: string
  - version: type: integer
  - originatingTaskId: type: string
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
Task<ListTargetFileVersionsResponse> ListTargetFileVersionsAsync(string projectId, string targetFileId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |
| `fields` | `string` | no |

### Java — `TargetFileApi`

```java
// GET /projects/{projectId}/target-files/{targetFileId}/versions?fields={fields}
ListTargetFileVersionsResponse listTargetFileVersions(String projectId, String targetFileId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `fields` | `String` | no |