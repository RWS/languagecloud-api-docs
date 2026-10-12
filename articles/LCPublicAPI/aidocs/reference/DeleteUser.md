# Trados Cloud Platform API Delete User

Delete User DeleteUser DELETE /users/{userId}

- Friendly name: Delete User
- Operation ID: DeleteUser
- HTTP Method: DELETE
- Path: /users/{userId}

Deletes a user.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 204

No Content

### 400

Invalid input in userId field.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

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

### .NET — `IUserClient`

```csharp
Task DeleteUserAsync(string userId);
```

| Parameter | Type | Required |
|---|---|---|
| `userId` | `string` | yes |

### Java — `UserApi`

```java
// DELETE /users/{userId}
void deleteUser(String userId);
```

| Parameter | Type | Required |
|---|---|---|
| `userId` | `String` | yes |