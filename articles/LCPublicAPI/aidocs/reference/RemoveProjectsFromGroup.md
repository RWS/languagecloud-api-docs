# Trados Cloud Platform API Remove Projects From Group

Remove Projects From Group RemoveProjectsFromGroup DELETE /project-groups/{projectGroupId}/projects

- Friendly name: Remove Projects From Group
- Operation ID: RemoveProjectsFromGroup
- HTTP Method: DELETE
- Path: /project-groups/{projectGroupId}/projects

Removes projects from the project group.

The projects are not removed instantly. To check the status use the [Get Project Group](#/operations/GetProjectGroup) endpoint.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: remove-projects-from-group-request (see model section below)

## Response

### 202

Accepted

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
* "forbidden": The authenticated user is not allowed to remove the projects from the project group.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The project group could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* “conflict”: A project with status "attaching" cannot be removed.

- Content: application/json
- Schema: error-response (see model section below)


## Model: remove-projects-from-group-request
<a id="remove-projects-from-group-request"></a>

```
type: object
  description: Input for removing projects from group.
properties:
  - projects: type: array
    items:
      $ref: #/components/schemas/project-group-project-request
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

### .NET — `IProjectGroupClient`

```csharp
Task RemoveProjectsFromGroupAsync(string projectGroupId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `string` | yes |

### Java — `ProjectGroupApi`

```java
// DELETE /project-groups/{projectGroupId}/projects
void removeProjectsFromGroup(String projectGroupId, RemoveProjectsFromGroupRequest removeProjectsFromGroupRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `String` | yes |
| `removeProjectsFromGroupRequest` | `RemoveProjectsFromGroupRequest` | no |