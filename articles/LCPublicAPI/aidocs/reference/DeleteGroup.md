# Trados Cloud Platform API Delete Group

Delete Group DeleteGroup DELETE /groups/{groupId}

- Friendly name: Delete Group
- Operation ID: DeleteGroup
- HTTP Method: DELETE
- Path: /groups/{groupId}

Deletes a group by identifier.

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
* “invalid”: Invalid input in the parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to delete the Group.

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

### .NET — `IGroupClient`

```csharp
Task DeleteGroupAsync(string groupId);
```

| Parameter | Type | Required |
|---|---|---|
| `groupId` | `string` | yes |

### Java — `GroupApi`

```java
// DELETE /groups/{groupId}
void deleteGroup(String groupId);
```

| Parameter | Type | Required |
|---|---|---|
| `groupId` | `String` | yes |