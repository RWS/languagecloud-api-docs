# Trados Cloud Platform API Create Project Group

Create Project Group CreateProjectGroup POST /project-groups

- Friendly name: Create Project Group
- Operation ID: CreateProjectGroup
- HTTP Method: POST
- Path: /project-groups

Creates a new project group.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: project-group-create-request (see model section below)

## Response

### 201



- Content: application/json
- Schema: project-group-create-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* "minSize": Minimum size exceeded for the value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to create the project group in the specified location.
* "benefitNotAvailable": Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": Project group with the same name already exists.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-group-create-request
<a id="project-group-create-request"></a>

```
type: object
  description: Input for project group creation.
properties:
  - name: type: string
  - description: type: string
  - location: type: string
```

## Model: project-group-create-response
<a id="project-group-create-response"></a>

```
type: object
  description: The Project Group Create response. 
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - status: type: string enum: [new, inProgress, completed, deleting]
  - location: $ref: #/components/schemas/folder-v2
  - shortId: type: string
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
Task<ProjectGroup> CreateProjectGroupAsync(ProjectGroupCreateRequest fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `ProjectGroupCreateRequest` | no |

### Java — `ProjectGroupApi`

```java
// POST /project-groups?fields={fields}
ProjectGroupCreateResponse createProjectGroup(ProjectGroupCreateRequest projectGroupCreateRequest, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupCreateRequest` | `ProjectGroupCreateRequest` | yes |
| `fields` | `String` | no |