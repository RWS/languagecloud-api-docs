# Trados Cloud Platform API Create Customer

Create Customer CreateCustomer POST /customers

- Friendly name: Create Customer
- Operation ID: CreateCustomer
- HTTP Method: POST
- Path: /customers

Create customer in a tenant.

For adding a customer to a tenant the authenticated user must have 'Create Customer' permission.

To also create an account for the key contact, you need to have the specific entitlements.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: customer-create-request (see model section below)

## Response

### 201

The customer was successfully created.

- Content: application/json
- Schema: customer (see model section below)

### 400

Error responses:

* “invalid”: invalid input specified in the error details.
* "empty": empty input for required field specified in the error details.
* "maxSize": The maximum size was exceeded for the value mentioned in the "name" field. 
* "deleted": Some of the selected values were deleted and cannot be selected for some values of the  "customFields" field.


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
"forbidden": 
- The authenticated user is not allowed to create a customer or if you intend to create the key contact account, you might not have sufficient permissions.

- Content: application/json
- Schema: error-response (see model section below)

### 408

Error responses:

  * "timeout": The request took longer than expected. The system might be overloaded. You might try again.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error responses:

* “duplicate”: duplicate value for the field mentioned in the error details.

- Content: application/json
- Schema: error-response (see model section below)
- Content: application/xml
- Schema: error-response (see model section below)


## Model: customer-create-request
<a id="customer-create-request"></a>

```
type: object
  description: Input for Customer creation.

 It will create an invitation for an account user account.
properties:
  - name: type: string
  - location: type: string
  - firstName: type: string
  - lastName: type: string
  - email: type: string
```

## Model: customer
<a id="customer"></a>

```
type: object
  description: Customer resource.
properties:
  - id: type: string
  - name: type: string
  - keyContact: $ref: #/components/schemas/user
  - location: $ref: #/components/schemas/folder-v2
  - ragStatus: type: string enum: [green, amber, red]
  - customFieldDefinitions: type: array
    items:
      $ref: #/components/schemas/custom-field-resource
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

## Model: custom-field-resource
<a id="custom-field-resource"></a>

```
type: object
  description: A Custom Field resource model.
properties:
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

### .NET — `ICustomerClient`

```csharp
Task<Customer> CreateCustomerAsync(CustomerCreateRequest fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `CustomerCreateRequest` | no |

### Java — `CustomerApi`

```java
// POST /customers?fields={fields}
Customer createCustomer(CustomerCreateRequest customerCreateRequest, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `customerCreateRequest` | `CustomerCreateRequest` | yes |
| `fields` | `String` | no |