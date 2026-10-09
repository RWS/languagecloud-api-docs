# Trados Cloud Platform API Accept Task

Accept Task AcceptTask PUT /tasks/{taskId}/accept

- Friendly name: Accept Task
- Operation ID: AcceptTask
- HTTP Method: PUT
- Path: /tasks/{taskId}/accept

Accepts a task. The authenticated user becomes the owner of the accepted task and can start work on it. Optionally, the task can be accepted on behalf of a group by providing the `onBehalfOfGroup` query parameter. In this case, the authenticated user must be a member of the specified group, and the group must be present in the task's assignee list. The `onBehalfOfGroup` parameter is allowed only if the [task](#/operations/GetTask) has `configuration.CONCURRENT_EDITING_ENABLED = true`.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **onBehalfOfGroup** (query, string) - optional: The identifier of the group on behalf of which the task is being accepted. The authenticated user must be a member of the specified group, and the group must be present in the task's assignee list.

## Request body

No request body.

## Response

### 204

No Content

### 400

Error codes: 

  * "empty": Empty value for variable mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "alreadyOwned": the task is already owned
* "invalidStatus": the task status doesn't permit the accept operation

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

### .NET — `ITaskClient`

```csharp
Task AcceptTaskAsync(string taskId, string onBehalfOfGroup = null);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `string` | yes |
| `onBehalfOfGroup` | `string` | no |

### Java — `TaskApi`

```java
// PUT /tasks/{taskId}/accept?onBehalfOfGroup={onBehalfOfGroup}
void acceptTask(String taskId, String onBehalfOfGroup);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `String` | yes |
| `onBehalfOfGroup` | `String` | no |