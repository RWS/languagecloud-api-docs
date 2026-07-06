# Trados Cloud Platform API Delete Role

Delete Role DeleteRole DELETE /roles/{roleId}

- Friendly name: Delete Role
- Operation ID: DeleteRole
- HTTP Method: DELETE
- Path: /roles/{roleId}

Deletes a role by identifier.

> Note: Only custom roles can be deleted. Provisioned roles cannot be removed.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 204

No Content

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the "name" field on the error response, or provisioned roles cannot be deleted.
* "empty": Empty input for the "roleId" path parameter variable.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to delete the role.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the role could not be found by identifier.

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

### .NET — `IRoleandPermissionClient`

```csharp
Task DeleteRoleAsync(string roleId);
```

| Parameter | Type | Required |
|---|---|---|
| `roleId` | `string` | yes |

### Java — `RoleAndPermissionApi`

```java
// DELETE /roles/{roleId}
void deleteRole(String roleId);
```

| Parameter | Type | Required |
|---|---|---|
| `roleId` | `String` | yes |