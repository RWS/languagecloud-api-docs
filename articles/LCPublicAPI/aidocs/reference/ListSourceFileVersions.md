# Trados Cloud Platform API List Source File Versions

List Source File Versions ListSourceFileVersions GET /projects/{projectId}/source-files/{sourceFileId}/versions

- Friendly name: List Source File Versions
- Operation ID: ListSourceFileVersions
- HTTP Method: GET
- Path: /projects/{projectId}/source-files/{sourceFileId}/versions

Retrieves all the versions of a source file.

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
- Schema: list-source-file-versions-response (see model section below)

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
* "forbidden": the authenticated user is not allowed to retrieve the source file versions.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project or the source file could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-source-file-versions-response
<a id="list-source-file-versions-response"></a>

```
type: object
  description: A response for the List Source File Versions endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/source-file-version
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

## Model: source-file-version
<a id="source-file-version"></a>

```
type: object
  description: Source File Version.
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

### .NET — `ISourceFileClient`

```csharp
Task<ListSourceFileVersionsResponse> ListSourceFileVersionsAsync(string projectId, string sourceFileId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `sourceFileId` | `string` | yes |
| `fields` | `string` | no |

### Java — `SourceFileApi`

```java
// GET /projects/{projectId}/source-files/{sourceFileId}/versions?fields={fields}
ListSourceFileVersionsResponse listSourceFileVersions(String projectId, String sourceFileId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `sourceFileId` | `String` | yes |
| `fields` | `String` | no |