# Trados Cloud Platform API Get Vendor

Get Vendor GetVendor GET /vendors/{vendorId}

- Friendly name: Get Vendor
- Operation ID: GetVendor
- HTTP Method: GET
- Path: /vendors/{vendorId}

Retrieves a vendor by identifier.

Use the `fields` query parameter to include optional nested resources such as `members`. The `members` field returns the users in the vendor's `VendorProjectManager` group. To manage vendor members, use the [Create User](#/operations/CreateUser), [Update User](#/operations/UpdateUser), or [Update Group](#/operations/UpdateGroup) endpoints.

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: vendor (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to read the vendor.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the vendor could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: vendor
<a id="vendor"></a>

```
type: object
  description: Represents an external LSP (Language Service Provider) organization that can be assigned translation tasks through vendor order templates.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - keyContact: $ref: #/components/schemas/user
  - vendorFolder: $ref: #/components/schemas/folder-v2
  - groups: type: array
    items:
      $ref: #/components/schemas/group
  - selfManaged: type: boolean
  - quoteTemplate: $ref: #/components/schemas/project-quote-template
  - members: type: array
    items:
      $ref: #/components/schemas/user
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field
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

## Model: user
<a id="user"></a>

```
type: object
  description: User in the account.
properties:
  - id: type: string
  - description: type: string
  - email: type: string
  - name: type: string
  - firstName: type: string
  - lastName: type: string
  - anonymized: type: boolean
  - anonymizedUserName: type: string
  - account: $ref: #/components/schemas/account
  - location: $ref: #/components/schemas/folder-v2
  - groups: type: array
    items:
      $ref: #/components/schemas/group
  - userType: $ref: #/components/schemas/user-type
  - status: $ref: #/components/schemas/user-status
  - invitationLink: type: string
  - membership: $ref: #/components/schemas/account-membership-type
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
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

## Model: group
<a id="group"></a>

```
type: object
  description: Group of Users.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - users: type: array
    items:
      $ref: #/components/schemas/user
  - roles: type: array
    items:
      $ref: #/components/schemas/role
  - additionalRoles: type: array
    items:
      $ref: #/components/schemas/group-additional-roles
  - groupType: type: string enum: [default, custom, vendor, customer]
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
```

## Model: project-quote-template
<a id="project-quote-template"></a>

```
type: object
  description: Project Quote Template resource.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
```

## Model: custom-field
<a id="custom-field"></a>

```
type: object
  description: A Custom Field model.
properties:
  - id: type: string
  - name: type: string
  - key: type: string
  - value: type: object
      description: The value of the custom property. A date will be serialized as an ISO_8601 string.
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

## Model: account
<a id="account"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
```

## Model: user-type
<a id="user-type"></a>

```
type: string enum: [user, serviceUser]
```

## Model: user-status
<a id="user-status"></a>

```
type: string enum: [inactive, active, deleted, provisioned]
```

## Model: account-membership-type
<a id="account-membership-type"></a>

```
type: string enum: [member, collaborator]
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

## Model: group-additional-roles
<a id="group-additional-roles"></a>

```
type: object
  description: Roles granted to the group in addition to the group location.
properties:
  - location: $ref: #/components/schemas/folder-v2
  - roles: type: array
    items:
      $ref: #/components/schemas/role
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

### .NET — `IVendorClient`

```csharp
Task<Vendor> GetVendorAsync(string vendorId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `string` | yes |
| `fields` | `string` | no |

### Java — `VendorApi`

```java
// GET /vendors/{vendorId}?fields={fields}
Vendor getVendor(String vendorId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `String` | yes |
| `fields` | `String` | no |