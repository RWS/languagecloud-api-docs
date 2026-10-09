# Trados Cloud Platform API Create Role

Create Role CreateRole POST /roles

- Friendly name: Create Role
- Operation ID: CreateRole
- HTTP Method: POST
- Path: /roles

Creates a custom role.

See [List Permissions](#/operations/ListPermissions) for available permission names.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: role-create-request (see model section below)

## Response

### 200



- Content: application/json
- Schema: role (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the request mentioned in the “name” field on the error response.
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
* "forbidden": the authenticated user is not allowed to create the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* “duplicate”: Role with the same name already exists.

- Content: application/json
- Schema: error-response (see model section below)


## Model: role-create-request
<a id="role-create-request"></a>

```
type: object
  description: Role create request.
```

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
Task<Role> CreateRoleAsync(string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `string` | no |

### Java — `RoleAndPermissionApi`

```java
// POST /roles?fields={fields}
Role createRole(String fields, RoleCreateRequest roleCreateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `String` | no |
| `roleCreateRequest` | `RoleCreateRequest` | no |