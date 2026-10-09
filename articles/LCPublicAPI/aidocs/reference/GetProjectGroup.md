# Trados Cloud Platform API Get Project Group

Get Project Group GetProjectGroup GET /project-groups/{projectGroupId}

- Friendly name: Get Project Group
- Operation ID: GetProjectGroup
- HTTP Method: GET
- Path: /project-groups/{projectGroupId}

Retrieves a project group by identifier.

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
- Schema: project-group (see model section below)

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
* "forbidden": The authenticated user is not allowed to read the project group.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The project group could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-group
<a id="project-group"></a>

```
type: object
  description: Project Group resource. (Not available for List Projects endpoint)
properties:
  - id: type: string
  - shortId: type: string
  - name: type: string
  - description: type: string
  - status: type: string enum: [new, inProgress, completed, deleting]
  - projects: type: array
    items:
      $ref: #/components/schemas/project-group-project
  - location: $ref: #/components/schemas/folder-v2
  - createdAt: type: string (format: date-time)
  - lastModifiedAt: type: string (format: date-time)
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

## Model: project-group-project
<a id="project-group-project"></a>

```
type: object
  description: Project resource for project group.
properties:
  - id: type: string
  - status: type: string enum: [attaching, attached, detaching, updating, failed]
```

## Model: folder-v2
<a id="folder-v2"></a>

```
type: object
  description: Folder used for resource storage.
properties:
  - id: type: string
  - name: type: string
  - hasParent: type: boolean
  - path: type: array
    items:
      $ref: #/components/schemas/folder-path
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

## Model: folder-path
<a id="folder-path"></a>

```
type: object
  description: Path of a folder.
properties:
  - id: type: string
  - name: type: string
  - location: type: string
  - hasParent: type: boolean
```

## SDK

### .NET — `IProjectGroupClient`

```csharp
Task<ProjectGroup> GetProjectGroupAsync(string projectGroupId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `string` | yes |
| `fields` | `string` | no |

### Java — `ProjectGroupApi`

```java
// GET /project-groups/{projectGroupId}?fields={fields}
ProjectGroup getProjectGroup(String projectGroupId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `String` | yes |
| `fields` | `String` | no |