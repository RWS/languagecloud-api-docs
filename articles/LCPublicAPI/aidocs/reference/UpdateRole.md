# Trados Cloud Platform API Update Role

Update Role UpdateRole PUT /roles/{roleId}

- Friendly name: Update Role
- Operation ID: UpdateRole
- HTTP Method: PUT
- Path: /roles/{roleId}

Updates a role by identifier. Pay special attention to how [updating](../docs/Updating-data-with-PUT.html) works.

See [List Permissions](#/operations/ListPermissions) for available permission names.

> Note: Only custom roles can be updated. Provisioned roles cannot be modified.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: role-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the "name" field on the error response, or provisioned roles cannot be updated.
* "empty": Empty input for the "roleId" path parameter variable.
* "minSize": Minimum size exceeded for the value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.
* "missing": Missing required field for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the role.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the role could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate" Role with the same name already exists.

- Content: application/json
- Schema: error-response (see model section below)


## Model: role-update-request
<a id="role-update-request"></a>

```
type: object
  description: Role update request.
properties:
  - name: type: string
  - description: type: string
  - permissions: type: array
    items:
      type: string
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

### .NET — `IRoleandPermissionClient`

```csharp
Task UpdateRoleAsync(string roleId);
```

| Parameter | Type | Required |
|---|---|---|
| `roleId` | `string` | yes |

### Java — `RoleAndPermissionApi`

```java
// PUT /roles/{roleId}
void updateRole(String roleId, RoleUpdateRequest roleUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `roleId` | `String` | yes |
| `roleUpdateRequest` | `RoleUpdateRequest` | no |