# Trados Cloud Platform API Reschedule Project Tasks

Reschedule Project Tasks RescheduleProjectTasks PATCH /projects/{projectId}/tasks/reschedule

- Friendly name: Reschedule Project Tasks
- Operation ID: RescheduleProjectTasks
- HTTP Method: PATCH
- Path: /projects/{projectId}/tasks/reschedule

Reschedules the tasks of a specific project.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: reschedule-tasks-request (see model section below)

## Response

### 200

OK

### 400

Error codes:
* “invalid”: Invalid input mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: reschedule-tasks-request
<a id="reschedule-tasks-request"></a>

```
type: object
  description: Reschedule tasks.
properties:
  - dueBy: type: string (format: date-time)
  - taskIds: type: array
    items:
      type: string
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

### .NET — `IProjectClient`

```csharp
Task RescheduleProjectTasksAsync(RescheduleTasksRequest projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `RescheduleTasksRequest` | yes |

### Java — `ProjectApi`

```java
// PATCH /projects/{projectId}/tasks/reschedule
void rescheduleProjectTasks(String projectId, RescheduleTasksRequest rescheduleTasksRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `rescheduleTasksRequest` | `RescheduleTasksRequest` | yes |