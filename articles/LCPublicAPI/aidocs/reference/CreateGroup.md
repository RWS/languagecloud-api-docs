# Trados Cloud Platform API Create Group

Create Group CreateGroup POST /groups

- Friendly name: Create Group
- Operation ID: CreateGroup
- HTTP Method: POST
- Path: /groups

Creates a group. Group roles will take effect based on the location, where the group is being created. Read more at [How to use location and folders](../docs/How-to-use-location-and-folders.html).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: group-create-request (see model section below)

## Response

### 201

Created.

- Content: application/json
- Schema: group (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the parameter mentioned in the “name” field on the error response.
* “maxSize”: Character number or List size exceeds the maximum allowed value for the “name” field on the error response.
* “minSize”: Character number or List size insufficient for the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed create a group.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Location/Roles could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "conflict": the request is conflicting with existing data.

- Content: application/json
- Schema: error-response (see model section below)


## Model: group-create-request
<a id="group-create-request"></a>

```
type: object
  description: Group of users.
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

## Model: group-update-request
<a id="group-update-request"></a>

```
type: object
  description: Group of users.
properties:
  - name: type: string
  - description: type: string
  - roles: type: array
    items:
      type: string
  - additionalRoles: type: array
    items:
      $ref: #/components/schemas/group-additional-roles-request
  - users: type: array
    items:
      type: string
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

## Model: group-additional-roles-request
<a id="group-additional-roles-request"></a>

```
type: object
  description: Roles granted to the group in addition to the group location.
properties:
  - location: type: string
  - roles: type: array
    items:
      type: string
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

### .NET — `IGroupClient`

```csharp
Task<Group> CreateGroupAsync(GroupCreateRequest fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `GroupCreateRequest` | no |

### Java — `GroupApi`

```java
// POST /groups?fields={fields}
Group createGroup(GroupCreateRequest groupCreateRequest, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `groupCreateRequest` | `GroupCreateRequest` | yes |
| `fields` | `String` | no |