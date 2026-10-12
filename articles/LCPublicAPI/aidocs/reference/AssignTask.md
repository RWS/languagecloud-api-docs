# Trados Cloud Platform API Assign Task

Assign Task AssignTask PUT /tasks/{taskId}/assign

- Friendly name: Assign Task
- Operation ID: AssignTask
- HTTP Method: PUT
- Path: /tasks/{taskId}/assign

Assigns a task. The task assignees will be updated.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: task-assign-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input mentioned in the “name” field on the error response.
* "limit.exceeded": a maximum number of users per task was assigned


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to assign the task.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the task could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidStatus": the current task's status doesn't permit the operation.

- Content: application/json
- Schema: error-response (see model section below)


## Model: task-assign-request
<a id="task-assign-request"></a>

```
type: object
  description: Properties of task assignment.
 <br> Total assignee count is limited. See more at [Maximum number of task assignees](https://docs.rws.com/791595/1137562/trados-enterprise---accelerate/maximum-number-of-task-assignees).
properties:
  - assignees: type: array
    items:
      $ref: #/components/schemas/task-assignee-request
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

## Model: task-assignee-request
<a id="task-assignee-request"></a>

```
type: object
properties:
  - id: type: string
  - type: type: string enum: [user, group, vendorOrderTemplate, projectManager, projectCreator]
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
Task AssignTaskAsync(TaskAssignRequest taskId);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `TaskAssignRequest` | yes |

### Java — `TaskApi`

```java
// PUT /tasks/{taskId}/assign
void assignTask(String taskId, TaskAssignRequest taskAssignRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `String` | yes |
| `taskAssignRequest` | `TaskAssignRequest` | yes |