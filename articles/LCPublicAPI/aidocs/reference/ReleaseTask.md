# Trados Cloud Platform API Release Task

Release Task ReleaseTask PUT /tasks/{taskId}/release

- Friendly name: Release Task
- Operation ID: ReleaseTask
- HTTP Method: PUT
- Path: /tasks/{taskId}/release

Releases the task from its owner so that other task assignees will be able to accept it.

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

  * "empty": Empty value for variable mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to release the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the task could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "noOwner": the task currently has no owner.
* "differentOwner": the authenticated user is not the owner of the task.
* "invalidStatus": the task's status does not permit this operation.

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
Task ReleaseTaskAsync(string taskId);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `string` | yes |

### Java — `TaskApi`

```java
// PUT /tasks/{taskId}/release
void releaseTask(String taskId);
```

| Parameter | Type | Required |
|---|---|---|
| `taskId` | `String` | yes |