# Trados Cloud Platform API Update Project Group

Update Project Group UpdateProjectGroup PUT /project-groups/{projectGroupId}

- Friendly name: Update Project Group
- Operation ID: UpdateProjectGroup
- HTTP Method: PUT
- Path: /project-groups/{projectGroupId}

Updates the project group.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body


- Content: application/json

- Schema: project-group-update-request (see model section below)

## Response

### 204

No Content

### 400

Error responses:

* “invalid”: Invalid input on update project group model.
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
* "forbidden": the authenticated user is not allowed to update the project group.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project group could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": Project group with the same name already exists.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-group-update-request
<a id="project-group-update-request"></a>

```
type: object
properties:
  - name: type: string
  - description: type: string
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

### .NET — `IProjectGroupClient`

```csharp
Task UpdateProjectGroupAsync(ProjectGroupUpdateRequest projectGroupId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `ProjectGroupUpdateRequest` | yes |

### Java — `ProjectGroupApi`

```java
// PUT /project-groups/{projectGroupId}
void updateProjectGroup(String projectGroupId, ProjectGroupUpdateRequest projectGroupUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `String` | yes |
| `projectGroupUpdateRequest` | `ProjectGroupUpdateRequest` | yes |