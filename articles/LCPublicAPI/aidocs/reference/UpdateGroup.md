# Trados Cloud Platform API Update Group

Update Group UpdateGroup PUT /groups/{groupId}

- Friendly name: Update Group
- Operation ID: UpdateGroup
- HTTP Method: PUT
- Path: /groups/{groupId}

Updates a group. We recommend reading this page too [Updating data with PUT](../docs/Updating-data-with-PUT.html).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: group-update-request (see model section below)

## Response

### 204

No Content


### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
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
* "forbidden": the authenticated user is not allowed to read the Group.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Group could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "conflict": the request is conflicting with existing data.

- Content: application/json
- Schema: error-response (see model section below)


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

### .NET — `IGroupClient`

```csharp
Task UpdateGroupAsync(GroupUpdateRequest groupId);
```

| Parameter | Type | Required |
|---|---|---|
| `groupId` | `GroupUpdateRequest` | yes |

### Java — `GroupApi`

```java
// PUT /groups/{groupId}
void updateGroup(String groupId, GroupUpdateRequest groupUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `groupId` | `String` | yes |
| `groupUpdateRequest` | `GroupUpdateRequest` | yes |