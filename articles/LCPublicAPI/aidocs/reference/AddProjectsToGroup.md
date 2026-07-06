# Trados Cloud Platform API Add Projects To Group

Add Projects To Group AddProjectsToGroup POST /project-groups/{projectGroupId}/projects

- Friendly name: Add Projects To Group
- Operation ID: AddProjectsToGroup
- HTTP Method: POST
- Path: /project-groups/{projectGroupId}/projects

Adds projects to the project group.

The projects are not added instantly. To check the status use the [Get Project Group](#/operations/GetProjectGroup) endpoint.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: add-projects-to-group-request (see model section below)

## Response

### 202

Accepted

- Content: application/json
- Schema: add-projects-to-group-response (see model section below)

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
* "forbidden": The authenticated user is not allowed to add the projects to group.
* "forbidden": The projects are not found or the authenticated user does not have acces to them.
* "benefitNotAvailable": Your subscription does not include access to the requested type of benefit.
* "quotaReached": The maximum number of projects allowed for your project group has already been reached.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The project group could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* “conflict”: A project with status "detaching" cannot be added.

- Content: application/json
- Schema: error-response (see model section below)


## Model: add-projects-to-group-request
<a id="add-projects-to-group-request"></a>

```
type: object
  description: Input for adding projects to group.
properties:
  - projects: type: array
    items:
      $ref: #/components/schemas/project-group-project-request
```

## Model: add-projects-to-group-response
<a id="add-projects-to-group-response"></a>

```
type: object
  description: Add Projects To Group response.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - status: type: string enum: [new, inProgress, completed, deleting]
  - projects: type: array
    items:
      $ref: #/components/schemas/project-group-project
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

## Model: project-group-project-request
<a id="project-group-project-request"></a>

```
type: object
properties:
  - id: type: string
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
Task AddProjectsToGroupAsync(AddProjectsToGroupRequest projectGroupId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `AddProjectsToGroupRequest` | yes |
| `fields` | `string` | no |

### Java — `ProjectGroupApi`

```java
// POST /project-groups/{projectGroupId}/projects?fields={fields}
AddProjectsToGroupResponse addProjectsToGroup(String projectGroupId, AddProjectsToGroupRequest addProjectsToGroupRequest, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `String` | yes |
| `addProjectsToGroupRequest` | `AddProjectsToGroupRequest` | yes |
| `fields` | `String` | no |