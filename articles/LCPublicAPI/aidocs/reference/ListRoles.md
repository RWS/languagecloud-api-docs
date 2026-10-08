# Trados Cloud Platform API List Roles

List Roles ListRoles GET /roles

- Friendly name: List Roles
- Operation ID: ListRoles
- HTTP Method: GET
- Path: /roles

Retrieves a list of all roles available for the account.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-roles-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-roles-response
<a id="list-roles-response"></a>

```
type: object
  description: A response for the List Roles endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/role
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
Task<ListRolesResponse> ListRolesAsync(string fields = null, int? top = null, int? skip = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `string` | no |
| `top` | `int` | no |
| `skip` | `int` | no |

### Java — `RoleAndPermissionApi`

```java
// GET /roles?fields={fields}&top={top}&skip={skip}
ListRolesResponse listRoles(String fields, Integer top, Integer skip);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `String` | no |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |