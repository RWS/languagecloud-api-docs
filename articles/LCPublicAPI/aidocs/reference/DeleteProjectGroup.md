# Trados Cloud Platform API Delete Project Group

Delete Project Group DeleteProjectGroup DELETE /project-groups/{projectGroupId}

- Friendly name: Delete Project Group
- Operation ID: DeleteProjectGroup
- HTTP Method: DELETE
- Path: /project-groups/{projectGroupId}

Deletes a project group.

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
* "forbidden": the authenticated user is not allowed to delete the project group.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project group could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "conflict": there might be projects that are still `attaching`.

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

### .NET — `IProjectGroupClient`

```csharp
Task DeleteProjectGroupAsync(string projectGroupId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `string` | yes |

### Java — `ProjectGroupApi`

```java
// DELETE /project-groups/{projectGroupId}
void deleteProjectGroup(String projectGroupId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectGroupId` | `String` | yes |