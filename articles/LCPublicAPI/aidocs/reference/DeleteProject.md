# Trados Cloud Platform API Delete Project

Delete Project DeleteProject DELETE /projects/{projectId}

- Friendly name: Delete Project
- Operation ID: DeleteProject
- HTTP Method: DELETE
- Path: /projects/{projectId}

Deletes a project.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 204

No Content

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to delete the project.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


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

### .NET — `IProjectClient`

```csharp
Task DeleteProjectAsync(string projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |

### Java — `ProjectApi`

```java
// DELETE /projects/{projectId}
void deleteProject(String projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |