# Trados Cloud Platform API Update Workflow

Update Workflow UpdateWorkflow PUT /workflows/{workflowId}

- Friendly name: Update Workflow
- Operation ID: UpdateWorkflow
- HTTP Method: PUT
- Path: /workflows/{workflowId}

Updates the workflow in terms of: name, description, task configuration (and its details), and task type configuration values (`configurationValues`). Observe the rules of [JSON Merge Patch Semantics](https://tools.ietf.org/html/rfc7386).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: workflow-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input in the body parameter mentioned in the “name” field on the error response.
* "empty": Empty input in the body parameter mentioned in the "name" field on the error response.
* "limit.exceeded": a maximum number of users per task was assigned


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the Workflow.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Workflow could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "projectPlanChanged": The associated project has already been changed at the level of `projectPlan.taskConfigurations`. Updating the workflow is no longer possible; the project should be updated to set the relevant `projectPlan.taskConfigurations` fields. 


- Content: application/json
- Schema: error-response (see model section below)


## Model: workflow-update-request
<a id="workflow-update-request"></a>

```
type: object
  description: A model to update a workflow.
properties:
  - name: type: string
  - description: type: string
  - taskConfigurations: type: array
    items:
      $ref: #/components/schemas/workflow-task-configuration-request
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

## Model: workflow-task-configuration-request
<a id="workflow-task-configuration-request"></a>

```
type: object
  description: A task configuration request.
properties:
  - taskTemplate: $ref: #/components/schemas/object-id
  - isSkipped: type: boolean
  - assignees: type: array
    items:
      $ref: #/components/schemas/workflow-task-assignee-request
  - scope: $ref: #/components/schemas/task-configuration-scope-request
  - configurationValues: type: array
    items:
      $ref: #/components/schemas/workflow-task-type-config-value
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

## Model: object-id
<a id="object-id"></a>

```
type: object
  description: An object with identifier.
properties:
  - id: type: string
```

## Model: workflow-task-assignee-request
<a id="workflow-task-assignee-request"></a>

```
type: object
properties:
  - type: type: string enum: [user, group, vendorOrderTemplate, projectCreator, projectManager]
  - user: $ref: #/components/schemas/object-id-request
  - group: $ref: #/components/schemas/object-id-request
  - vendorOrderTemplate: $ref: #/components/schemas/object-id-request
```

## Model: task-configuration-scope-request
<a id="task-configuration-scope-request"></a>

```
type: object
  description: 
properties:
  - type: type: string enum: [global, sourceLanguage, targetLanguage, languageDirection]
  - sourceLanguage: $ref: #/components/schemas/source-language-request
  - targetLanguage: $ref: #/components/schemas/target-language-request
  - languageDirection: $ref: #/components/schemas/language-direction-item
```

## Model: workflow-task-type-config-value
<a id="workflow-task-type-config-value"></a>

```
type: object
  description: A key-value pair representing a task type configuration setting.

Valid configuration keys (`id`), data types, options (for string types), and constraints (e.g., min/max for integer types) are defined in the sibling field `taskTemplate.taskType.configurationDefinitions` within the same task configuration.
properties:
  - id: type: string
  - value: type: object
      description: The configuration value.
```

## Model: object-id-request
<a id="object-id-request"></a>

```
type: object
  description: An object with identifier.
properties:
  - id: type: string
```

## Model: source-language-request
<a id="source-language-request"></a>

```
type: object
properties:
  - languageCode: type: string
```

## Model: target-language-request
<a id="target-language-request"></a>

```
type: object
  description: 
properties:
  - languageCode: type: string
```

## Model: language-direction-item
<a id="language-direction-item"></a>

```
type: object
  description: 
properties:
  - id: type: string
```

## SDK

### .NET — `IWorkflowClient`

```csharp
Task UpdateWorkflowAsync(WorkflowUpdateRequest workflowId);
```

| Parameter | Type | Required |
|---|---|---|
| `workflowId` | `WorkflowUpdateRequest` | yes |

### Java — `WorkflowApi`

```java
// PUT /workflows/{workflowId}
void updateWorkflow(String workflowId, WorkflowUpdateRequest workflowUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `workflowId` | `String` | yes |
| `workflowUpdateRequest` | `WorkflowUpdateRequest` | yes |