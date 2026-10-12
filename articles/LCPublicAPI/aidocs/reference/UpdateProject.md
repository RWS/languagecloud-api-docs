# Trados Cloud Platform API Update Project

Update Project UpdateProject PUT /projects/{projectId}

- Friendly name: Update Project
- Operation ID: UpdateProject
- HTTP Method: PUT
- Path: /projects/{projectId}

Updates the project in terms of: name, description, due date, quote, and project resources. Observe the rules of [JSON Merge Patch Semantics](https://tools.ietf.org/html/rfc7386). 

Project rescheduling (updating dueBy) is permitted only if: 
* there is no Customer Quote Approval task in the associated flow 
* at least one Customer Quote Approval was closed(in case multiple project batches) 

Update `projectPlan.taskConfigurations` are now permitted before project is started. Elements are now pre-populated at project creation time.

For detailed information about Translation Memory advanced configuration including filters and field updates, see [Translation Memory Advanced Configuration](../docs/translation-memory/Translation-memory-advanced-configuration.html).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: project-update-request (see model section below)

## Response

### 204

No Content

### 400

Error responses:

* “invalid”: invalid input on update quote model
* “invalidStatus”: the quote cannot be edited, the project is in a phase which doesn't allow the quote to be edited
* "conflict": the project does not have a quote to be updated
* "limit.exceeded": a maximum number of users per task was assigned
 
* "deleted": Some of the selected values were deleted and cannot be selected for some values of the  "customFields" field.


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the Project.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Project could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error responses:

* “invalidStatus”: a field cannot be edited, because the project is in a status which doesn't allow the field to be edited. `details.name` will provide the field name which is not allowed to be edited.

* updateNotAllowed: a field of the project cannot be edited before the completion of customer approval.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-update-request
<a id="project-update-request"></a>

```
type: object
properties:
  - name: type: string
  - description: type: string
  - dueBy: $ref: #/components/schemas/date-time
  - deliveredBy: $ref: #/components/schemas/date-time
  - translationEngine: $ref: #/components/schemas/configuration-resource-request
  - fileProcessingConfiguration: $ref: #/components/schemas/configuration-resource-request
  - pricingModel: $ref: #/components/schemas/configuration-resource-request
  - workflow: $ref: #/components/schemas/configuration-resource-request
  - projectPlan: $ref: #/components/schemas/project-plan-update-request
  - tqaProfile: $ref: #/components/schemas/configuration-resource-request
  - quote: $ref: #/components/schemas/quote-update-request
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field-request
  - projectManagers: type: array
    items:
      $ref: #/components/schemas/project-manager-request
  - settings: $ref: #/components/schemas/project-settings-update-request
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

## Model: date-time
<a id="date-time"></a>

```
type: string (format: date-time)
```

## Model: configuration-resource-request
<a id="configuration-resource-request"></a>

```
type: object
  description: Resource configuration properties.
properties:
  - id: type: string
  - strategy: type: string enum: [copy, use]
```

## Model: project-plan-update-request
<a id="project-plan-update-request"></a>

```
type: object
  description: Updates the configurations of the tasks that will be created in the future. 
For example, you can change the assignee of the "translation" task while the project is in the "preprocessing" phase.
properties:
  - taskConfigurations: type: array
    items:
      $ref: #/components/schemas/project-plan-task-configuration-request
```

## Model: quote-update-request
<a id="quote-update-request"></a>

```
type: object
properties:
  - languageCosts: type: array
    items:
      $ref: #/components/schemas/quote-language-cost-request
  - additionalCosts: type: array
    items:
      $ref: #/components/schemas/quote-additional-cost-request
  - notes: type: string
```

## Model: custom-field-request
<a id="custom-field-request"></a>

```
type: object
  description: A Custom Field model used at project creation or project update.
properties:
  - key: type: string
  - value: type: object
      description: The value of the custom field. A date will be serialized as a ISO_8601 string. For read only custom fields (`isReadOnly`), it must be set exactly as the `defaultValue` from custom field definition.
```

## Model: project-manager-request
<a id="project-manager-request"></a>

```
type: object
properties:
  - id: type: string
  - type: type: string enum: [group, user]
```

## Model: project-settings-update-request
<a id="project-settings-update-request"></a>

```
type: object
properties:
  - general: $ref: #/components/schemas/project-settings-general-request
  - translationMemorySettings: $ref: #/components/schemas/translation-memory-settings-request
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

## Model: project-plan-task-configuration-request
<a id="project-plan-task-configuration-request"></a>

```
type: object
  description: A project plan task configuration request. Used to update a task that will be created in the future.
properties:
  - taskTemplate: $ref: #/components/schemas/object-id-request
  - isSkipped: type: boolean
  - assignees: type: array
    items:
      $ref: #/components/schemas/project-plan-task-assignee-request
  - scope: $ref: #/components/schemas/task-configuration-scope-request
  - dueBy: $ref: #/components/schemas/date-time
  - configurationValues: type: array
    items:
      $ref: #/components/schemas/workflow-task-type-config-value
```

## Model: quote-language-cost-request
<a id="quote-language-cost-request"></a>

```
type: object
properties:
  - name: type: string
  - count: type: number
  - cost: type: number
  - costType: $ref: #/components/schemas/language-cost-type
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - targetLanguage: $ref: #/components/schemas/target-language-request
  - costOrder: type: integer
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - conditionalCostOperator: $ref: #/components/schemas/conditional-cost-operator
  - conditionalCostVariable: $ref: #/components/schemas/conditional-cost-variable
  - conditionalCostThreshold: type: number
```

## Model: quote-additional-cost-request
<a id="quote-additional-cost-request"></a>

```
type: object
properties:
  - name: type: string
  - count: type: number
  - cost: type: number
  - costType: $ref: #/components/schemas/project-cost-type
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - costOrder: type: integer
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - conditionalCostOperator: $ref: #/components/schemas/conditional-cost-operator
  - conditionalCostVariable: $ref: #/components/schemas/conditional-cost-variable
  - conditionalCostThreshold: type: number
```

## Model: project-settings-general-request
<a id="project-settings-general-request"></a>

```
type: object
properties:
  - completionConfiguration: $ref: #/components/schemas/completion-config-request
```

## Model: translation-memory-settings-request
<a id="translation-memory-settings-request"></a>

```
type: object
  description: Translation Memory settings Request
properties:
  - filters: $ref: #/components/schemas/translation-memory-filters-request
  - updateTranslationMemoryFields: type: array
    items:
      $ref: #/components/schemas/translation-memory-update-TM-fields-request
```

## Model: object-id-request
<a id="object-id-request"></a>

```
type: object
  description: An object with identifier.
properties:
  - id: type: string
```

## Model: project-plan-task-assignee-request
<a id="project-plan-task-assignee-request"></a>

```
type: object
properties:
  - type: type: string enum: [user, group, vendorOrderTemplate, projectCreator]
  - id: type: string
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

## Model: language-cost-type
<a id="language-cost-type"></a>

```
type: string enum: [volume, hourly, percentage, perPage, conditional, adhoc, adhocVolume]
```

## Model: volume-unit-type
<a id="volume-unit-type"></a>

```
type: string enum: [words, characters, custom]
```

## Model: target-language-request
<a id="target-language-request"></a>

```
type: object
  description: 
properties:
  - languageCode: type: string
```

## Model: conditional-cost-type
<a id="conditional-cost-type"></a>

```
type: string enum: [absolute, relative, percentage]
```

## Model: conditional-cost-operator
<a id="conditional-cost-operator"></a>

```
type: string enum: [less, lessOrEqual, greater, greaterOrEqual]
```

## Model: conditional-cost-variable
<a id="conditional-cost-variable"></a>

```
type: string enum: [wordCount, runningTotal]
```

## Model: project-cost-type
<a id="project-cost-type"></a>

```
type: string enum: [volume, perTargetLanguage, perFile, hourly, percentage, perPage, conditional, adhoc, adhocVolume]
```

## Model: completion-config-request
<a id="completion-config-request"></a>

```
type: object
  description: Completion configuration properties.
properties:
  - completeDays: type: number
  - archiveDays: type: number
  - archiveReminderDays: type: number
```

## Model: translation-memory-filters-request
<a id="translation-memory-filters-request"></a>

```
type: object
  description: Translation Memory filter settings request
properties:
  - hardFilter: $ref: #/components/schemas/translation-memory-hard-filter-request
```

## Model: translation-memory-update-TM-fields-request
<a id="translation-memory-update-TM-fields-request"></a>

```
type: object
properties:
  - fieldId: type: string
  - values: type: array
    items:
      type: string
```

## Model: source-language-request
<a id="source-language-request"></a>

```
type: object
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

## Model: translation-memory-hard-filter-request
<a id="translation-memory-hard-filter-request"></a>

```
type: object
  description: Hard filter configuration for Translation Memory matching request
properties:
  - expression: type: string
```

## SDK

### .NET — `IProjectClient`

```csharp
Task UpdateProjectAsync(ProjectUpdateRequest projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `ProjectUpdateRequest` | yes |

### Java — `ProjectApi`

```java
// PUT /projects/{projectId}
void updateProject(String projectId, ProjectUpdateRequest projectUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `projectUpdateRequest` | `ProjectUpdateRequest` | yes |