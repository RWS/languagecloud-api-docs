# Trados Cloud Platform API Complete Task

Complete Task CompleteTask PUT /tasks/{taskId}/complete

- Friendly name: Complete Task
- Operation ID: CompleteTask
- HTTP Method: PUT
- Path: /tasks/{taskId}/complete

Completes a task. The task is required to be in "inProgress" state and will be marked as "completed".

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: task-complete-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “maxSize“: Maximum size exceeded for the value mentioned in the “name“ field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to complete the task.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the task could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidStatus": The current task status doesn't permit this operation.
* "noOwner": The current task was not accepted in advance.
* "differentOwner": The current task is accepted by another user.

- Content: application/json
- Schema: error-response (see model section below)


## Model: task-complete-request
<a id="task-complete-request"></a>

```
type: object
  description: Properties of task completion.
properties:
  - outcome: type: string
  - comment: type: string
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
Task CompleteTaskAsync(TaskCompleteRequest taskId);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `TaskCompleteRequest` | yes |

### Java — `TaskApi`

```java
// PUT /tasks/{taskId}/complete
void completeTask(String taskId, TaskCompleteRequest taskCompleteRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `String` | yes |
| `taskCompleteRequest` | `TaskCompleteRequest` | yes |