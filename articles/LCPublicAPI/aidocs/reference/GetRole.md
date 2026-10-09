# Trados Cloud Platform API Get Role

Get Role GetRole GET /roles/{roleId}

- Friendly name: Get Role
- Operation ID: GetRole
- HTTP Method: GET
- Path: /roles/{roleId}

Retrieves a role by identifier.

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

OK

- Content: application/json
- Schema: role (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* “empty”: Empty input for the “roleId” path parameter variable.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to read the role.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the role could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: role
<a id="role"></a>

```
type: object
  description: Role in the account.
properties:
  - id: type: string
  - type: type: string enum: [provisioned, custom]
  - name: type: string
  - description: type: string
  - permissions: type: array
    items:
      $ref: #/components/schemas/permission
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

## Model: permission
<a id="permission"></a>

```
type: object
  description: A single permission which governs access to resources.
properties:
  - name: type: string
  - description: type: string
  - category: type: string
  - entityType: $ref: #/components/schemas/permission-entity-type
  - dependsOn: type: array
    items:
      type: string
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

## Model: permission-entity-type
<a id="permission-entity-type"></a>

```
type: object
  description: The entity type a permission applies to.
properties:
  - name: type: string
  - description: type: string
```

## SDK

### .NET — `IRoleandPermissionClient`

```csharp
Task<Role> GetRoleAsync(string roleId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `roleId` | `string` | yes |
| `fields` | `string` | no |

### Java — `RoleAndPermissionApi`

```java
// GET /roles/{roleId}?fields={fields}
Role getRole(String roleId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `roleId` | `String` | yes |
| `fields` | `String` | no |