# Trados Cloud Platform API Create Project

Create Project CreateProject POST /projects

- Friendly name: Create Project
- Operation ID: CreateProject
- HTTP Method: POST
- Path: /projects

Creates a new project.

When creating a project using a project template that supports multiple source languages, you must supply the `languageDirections`.

Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when creating projects.

The values from a selected project template will take precedence over the individual resources when creating a new project.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: project-create-request (see model section below)

## Response

### 201



- Content: application/json
- Schema: project (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* "empty": Empty mandatory value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.
* "missing": Missing required field for the value mentioned in the "name" field on the error response. 
* "deleted": Some of the selected values were deleted and cannot be selected for some values of the  "customFields" field.


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
"forbidden": 
- The authenticated user is not allowed to create the project in the specified location.
- Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-create-request
<a id="project-create-request"></a>

```
type: object
  description: Input for Project creation.

Before starting the project, the required configuration resources (translation engine, file processing configuration and workflow) should be set either explicitly or through a project template that contains references to these configuration resources.
properties:
  - name: type: string
  - description: type: string
  - dueBy: $ref: #/components/schemas/date-time
  - projectTemplate: $ref: #/components/schemas/object-id-request
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/language-direction-request
  - location: type: string
  - translationEngine: $ref: #/components/schemas/configuration-resource-request
  - fileProcessingConfiguration: $ref: #/components/schemas/configuration-resource-request
  - workflow: $ref: #/components/schemas/configuration-resource-request
  - pricingModel: $ref: #/components/schemas/configuration-resource-request
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field-request
  - tqaProfile: $ref: #/components/schemas/configuration-resource-request
  - forceOnline: type: boolean
  - projectManagers: type: array
    items:
      $ref: #/components/schemas/project-manager-request
  - scheduleTemplate: $ref: #/components/schemas/configuration-resource-request
  - settings: $ref: #/components/schemas/project-settings-create-request
```

## Model: project
<a id="project"></a>

```
type: object
  description: Project resource.
properties:
  - id: type: string
  - shortId: type: string
  - name: type: string
  - description: type: string
  - dueBy: type: string (format: date-time)
  - deliveredBy: type: string (format: date-time)
  - createdAt: type: string (format: date-time)
  - status: type: string enum: [created, inProgress, completed, archived]
  - statusHistory: type: array
    items:
      $ref: #/components/schemas/project-status-history
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/language-direction
  - customer: $ref: #/components/schemas/customer
  - createdBy: $ref: #/components/schemas/user
  - location: $ref: #/components/schemas/folder-v2
  - projectTemplate: $ref: #/components/schemas/project-template-response
  - translationEngine: $ref: #/components/schemas/translation-engine
  - fileProcessingConfiguration: $ref: #/components/schemas/file-processing-configuration
  - pricingModel: $ref: #/components/schemas/pricing-model
  - workflow: $ref: #/components/schemas/workflow
  - projectPlan: $ref: #/components/schemas/project-plan
  - analytics: $ref: #/components/schemas/analytics
  - analysisStatistics: $ref: #/components/schemas/analysis-statistics
  - quote: $ref: #/components/schemas/quote
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field
  - tqaProfile: $ref: #/components/schemas/tqa-profile
  - forceOnline: type: boolean
  - quoteTemplate: $ref: #/components/schemas/project-quote-template
  - projectGroup: $ref: #/components/schemas/project-group
  - projectManagers: type: array
    items:
      $ref: #/components/schemas/project-manager-response
  - scheduleTemplate: $ref: #/components/schemas/schedule-template
  - perfectMatchMapping: $ref: #/components/schemas/perfect-match-mapping-simple-response
  - settings: $ref: #/components/schemas/project-settings-response
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

## Model: object-id-request
<a id="object-id-request"></a>

```
type: object
  description: An object with identifier.
properties:
  - id: type: string
```

## Model: language-direction-request
<a id="language-direction-request"></a>

```
type: object
  description: The language directions model used for creating or updating a project.
properties:
  - sourceLanguage: $ref: #/components/schemas/source-language-request
  - targetLanguage: $ref: #/components/schemas/target-language-request
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

## Model: project-settings-create-request
<a id="project-settings-create-request"></a>

```
type: object
properties:
  - general: $ref: #/components/schemas/project-settings-general-request
```

## Model: project-status-history
<a id="project-status-history"></a>

```
type: object
  description: An Item which describes a change in the status of the project.
properties:
  - from: type: string enum: [none, created, inProgress, completed]
  - to: type: string enum: [created, inProgress, completed]
  - by: $ref: #/components/schemas/user
  - timestamp: $ref: #/components/schemas/date-time
```

## Model: language-direction
<a id="language-direction"></a>

```
type: object
  description: A Language Direction.
properties:
  - id: type: string
  - sourceLanguage: $ref: #/components/schemas/language
  - targetLanguage: $ref: #/components/schemas/language
  - analysisStatistics: $ref: #/components/schemas/analysis-statistics
```

## Model: customer
<a id="customer"></a>

```
type: object
  description: Customer resource.
properties:
  - id: type: string
  - name: type: string
  - keyContact: $ref: #/components/schemas/user
  - location: $ref: #/components/schemas/folder-v2
  - ragStatus: type: string enum: [green, amber, red]
  - customFieldDefinitions: type: array
    items:
      $ref: #/components/schemas/custom-field-resource
```

## Model: user
<a id="user"></a>

```
type: object
  description: User in the account.
properties:
  - id: type: string
  - description: type: string
  - email: type: string
  - name: type: string
  - firstName: type: string
  - lastName: type: string
  - anonymized: type: boolean
  - anonymizedUserName: type: string
  - account: $ref: #/components/schemas/account
  - location: $ref: #/components/schemas/folder-v2
  - groups: type: array
    items:
      $ref: #/components/schemas/group
  - userType: $ref: #/components/schemas/user-type
  - status: $ref: #/components/schemas/user-status
  - invitationLink: type: string
  - membership: $ref: #/components/schemas/account-membership-type
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
```

## Model: folder-v2
<a id="folder-v2"></a>

```
type: object
  description: Folder used for resource storage.
properties:
  - id: type: string
  - name: type: string
  - hasParent: type: boolean
  - path: type: array
    items:
      $ref: #/components/schemas/folder-path
```

## Model: project-template-response
<a id="project-template-response"></a>

```
type: object
  description: Project Template resource.  (Not available for List Projects endpoint)
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/language-direction-no-statistics
  - location: $ref: #/components/schemas/folder-v2
  - translationEngine: $ref: #/components/schemas/translation-engine
  - fileProcessingConfiguration: $ref: #/components/schemas/file-processing-configuration
  - pricingModel: $ref: #/components/schemas/pricing-model
  - workflow: $ref: #/components/schemas/workflow
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field
  - forceOnline: type: boolean
  - projectManagers: type: array
    items:
      $ref: #/components/schemas/project-manager-response
  - quoteTemplate: $ref: #/components/schemas/project-quote-template-deprecated
  - scheduleTemplate: $ref: #/components/schemas/schedule-template
  - settings: $ref: #/components/schemas/project-template-settings-response
  - lastModifiedAt: type: string (format: date-time)
```

## Model: translation-engine
<a id="translation-engine"></a>

```
type: object
  description: Translation Engine resource. (Not available for List Projects endpoint)
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - definition: $ref: #/components/schemas/translation-engine-definition
```

## Model: file-processing-configuration
<a id="file-processing-configuration"></a>

```
type: object
  description: File Processing Configuration resource. (Not available for List Projects endpoint)
properties:
  - id: type: string
  - name: type: string
  - location: $ref: #/components/schemas/folder-v2
```

## Model: pricing-model
<a id="pricing-model"></a>

```
type: object
  description: Pricing Model resource.  (Not available for List Projects endpoint)
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - currencyCode: type: string
  - location: $ref: #/components/schemas/folder-v2
  - languageDirectionPricing: type: array
    items:
      $ref: #/components/schemas/language-direction-cost
  - additionalCosts: type: array
    items:
      $ref: #/components/schemas/project-cost
```

## Model: workflow
<a id="workflow"></a>

```
type: object
  description: The steps a project goes through. (Not available for List Projects endpoint)
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder
  - workflowTemplate: $ref: #/components/schemas/workflow-template
  - taskConfigurations: type: array
    items:
      $ref: #/components/schemas/workflow-task-configuration
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/language-direction-no-statistics
```

## Model: project-plan
<a id="project-plan"></a>

```
type: object
  description: The configurations of the tasks that will be created in the future.

Available now directly after project creation, project does not need to be started to be populated. 

(Not available for List Projects endpoint)
properties:
  - taskConfigurations: type: array
    items:
      $ref: #/components/schemas/project-plan-task-configuration
```

## Model: analytics
<a id="analytics"></a>

```
type: object
  description: Project analytics.
properties:
  - progress: $ref: #/components/schemas/analytics-progress
  - overdueStatistics: $ref: #/components/schemas/analytics-overdue-statistics
  - sourceFileStatistics: type: array
    items:
      $ref: #/components/schemas/analytics-source-file-statistics
  - workloadStatistics: $ref: #/components/schemas/analytics-workload-statistics
  - taskTypeStatistics: type: array
    items:
      $ref: #/components/schemas/analytics-task-type-statistics
  - phaseStatistics: type: array
    items:
      $ref: #/components/schemas/analytics-phase-statistics
```

## Model: analysis-statistics
<a id="analysis-statistics"></a>

```
type: object
properties:
  - exactMatch: $ref: #/components/schemas/count
  - inContextExactMatch: $ref: #/components/schemas/count
  - perfectMatch: $ref: #/components/schemas/count
  - new: $ref: #/components/schemas/count
  - repetitions: $ref: #/components/schemas/count
  - crossDocumentRepetitions: $ref: #/components/schemas/count
  - machineTranslation: $ref: #/components/schemas/count
  - locked: $ref: #/components/schemas/count
  - fuzzyMatch: type: array
    items:
      $ref: #/components/schemas/fuzzy-count
  - total: $ref: #/components/schemas/count
```

## Model: quote
<a id="quote"></a>

```
type: object
  description: Project quote.
properties:
  - totalAmount: type: number
  - currencyCode: type: string
  - translationCosts: type: array
    items:
      $ref: #/components/schemas/quote-translation-cost
  - languageCosts: type: array
    items:
      $ref: #/components/schemas/quote-language-cost
  - additionalCosts: type: array
    items:
      $ref: #/components/schemas/quote-additional-cost
  - notes: type: string
```

## Model: custom-field
<a id="custom-field"></a>

```
type: object
  description: A Custom Field model.
properties:
  - id: type: string
  - name: type: string
  - key: type: string
  - value: type: object
      description: The value of the custom property. A date will be serialized as an ISO_8601 string.
```

## Model: tqa-profile
<a id="tqa-profile"></a>

```
type: object
  description: As a project manager, you choose a TQA configuration and use it to automatically assess the quality of a translation document.

The TQA configuration specifies:
 - Categories and subcategories that reviewers will use to classify the translation issues in a document.
 - Severities to define custom metrics you want to use to assess translation quality.
 - Score to measure the importance of each category or subcategory of an issue.
 - Pass/Fail Threshold to define the maximum number of penalty points admitted before failing the translation document.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - passFailThreshold: $ref: #/components/schemas/tqa-profile-passFailThreshold
  - categories: type: array
    items:
      $ref: #/components/schemas/tqa-profile-category
  - severities: type: array
    items:
      $ref: #/components/schemas/tqa-profile-severity
  - scores: type: array
    items:
      $ref: #/components/schemas/tqa-profile-score
  - path: type: array
    items:
      $ref: #/components/schemas/folder
```

## Model: project-quote-template
<a id="project-quote-template"></a>

```
type: object
  description: Project Quote Template resource.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
```

## Model: project-group
<a id="project-group"></a>

```
type: object
  description: Project Group resource. (Not available for List Projects endpoint)
properties:
  - id: type: string
  - shortId: type: string
  - name: type: string
  - description: type: string
  - status: type: string enum: [new, inProgress, completed, deleting]
  - projects: type: array
    items:
      $ref: #/components/schemas/project-group-project
  - location: $ref: #/components/schemas/folder-v2
  - createdAt: type: string (format: date-time)
  - lastModifiedAt: type: string (format: date-time)
```

## Model: project-manager-response
<a id="project-manager-response"></a>

```
type: object
  description: 
properties:
  - type: type: string enum: [group, user]
  - user: $ref: #/components/schemas/user
  - group: $ref: #/components/schemas/group
```

## Model: schedule-template
<a id="schedule-template"></a>

```
type: object
  description: Schedule Template resource
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - configurations: type: array
    items:
      $ref: #/components/schemas/schedule-template-configuration
  - projectScheduleConfiguration: $ref: #/components/schemas/schedule-template-project-configuration
```

## Model: perfect-match-mapping-simple-response
<a id="perfect-match-mapping-simple-response"></a>

```
type: object
  description: PerfectMatch Mapping (Not available for List Projects endpoint)
properties:
  - id: type: string
  - createdBy: $ref: #/components/schemas/user
  - batchMappings: type: array
    items:
      $ref: #/components/schemas/perfect-match-batch-mapping
```

## Model: project-settings-response
<a id="project-settings-response"></a>

```
type: object
properties:
  - general: $ref: #/components/schemas/project-settings-general-response
  - translationMemorySettings: $ref: #/components/schemas/project-translation-memory-settings-response
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

## Model: project-settings-general-request
<a id="project-settings-general-request"></a>

```
type: object
properties:
  - completionConfiguration: $ref: #/components/schemas/completion-config-request
```

## Model: language
<a id="language"></a>

```
type: object
  description: The language object.
properties:
  - languageCode: type: string
  - englishName: type: string
  - direction: type: string
  - parentLanguageCode: type: string
  - defaultSpecificLanguageCode: type: string
  - isNeutral: type: boolean
```

## Model: custom-field-resource
<a id="custom-field-resource"></a>

```
type: object
  description: A Custom Field resource model.
properties:
  - key: type: string
  - value: type: object
      description: The value of the custom property. A date will be serialized as an ISO_8601 string.
```

## Model: account
<a id="account"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
```

## Model: group
<a id="group"></a>

```
type: object
  description: Group of Users.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - users: type: array
    items:
      $ref: #/components/schemas/user
  - roles: type: array
    items:
      $ref: #/components/schemas/role
  - additionalRoles: type: array
    items:
      $ref: #/components/schemas/group-additional-roles
  - groupType: type: string enum: [default, custom, vendor, customer]
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
```

## Model: user-type
<a id="user-type"></a>

```
type: string enum: [user, serviceUser]
```

## Model: user-status
<a id="user-status"></a>

```
type: string enum: [inactive, active, deleted, provisioned]
```

## Model: account-membership-type
<a id="account-membership-type"></a>

```
type: string enum: [member, collaborator]
```

## Model: folder-path
<a id="folder-path"></a>

```
type: object
  description: Path of a folder.
properties:
  - id: type: string
  - name: type: string
  - location: type: string
  - hasParent: type: boolean
```

## Model: language-direction-no-statistics
<a id="language-direction-no-statistics"></a>

```
type: object
  description: A Language Direction.
properties:
  - id: type: string
  - sourceLanguage: $ref: #/components/schemas/language
  - targetLanguage: $ref: #/components/schemas/language
```

## Model: project-quote-template-deprecated
<a id="project-quote-template-deprecated"></a>

```
type: object
  description: (Deprecated) moved under settings.general.quoteTemplate
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
```

## Model: project-template-settings-response
<a id="project-template-settings-response"></a>

```
type: object
  description: Project Template settings. See detailed description of options on the <a href="https://docs.rws.com/791595/1054430/trados-enterprise---accelerate/creating-project-templates/procedure">Official Documentation</a> page. 

 (Not available for List Project Templates endpoint)
properties:
  - general: $ref: #/components/schemas/project-template-general-settings-response
  - batchTasks: $ref: #/components/schemas/project-template-batch-tasks-settings
  - verification: $ref: #/components/schemas/project-template-verification-settings
  - qualityManagement: $ref: #/components/schemas/project-template-quality-management-settings-response
  - termbaseSettings: $ref: #/components/schemas/project-template-termbase-settings-response
  - translationMemorySettings: $ref: #/components/schemas/project-template-translation-memory-settings-response
```

## Model: translation-engine-definition
<a id="translation-engine-definition"></a>

```
type: object
  description: The definition of a translation engine.
properties:
  - languageProcessingRuleId: type: string
  - languagePairDefinitions: type: array
    items:
      $ref: #/components/schemas/translation-engine-definition-language-pair
  - sequence: $ref: #/components/schemas/remote-translation-engine-sequence
  - adjacentLanguagePenalty: type: integer
```

## Model: language-direction-cost
<a id="language-direction-cost"></a>

```
type: object
properties:
  - sourceLanguage: type: string
  - targetLanguage: type: string
  - contextMatch: type: number
  - exactMatch: type: number
  - new: type: number
  - perfectMatch: type: number
  - repetition: type: number
  - machineTranslation: type: number
  - pricingUnit: $ref: #/components/schemas/pricing-unit-type
  - fuzzyMatches: type: array
    items:
      $ref: #/components/schemas/fuzzy-match
  - additionalCosts: type: array
    items:
      $ref: #/components/schemas/language-cost
```

## Model: project-cost
<a id="project-cost"></a>

```
type: object
properties:
  - name: type: string
  - type: $ref: #/components/schemas/project-cost-type
  - index: type: number
  - costPerUnit: type: number
  - unitCount: type: number
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - costOperator: $ref: #/components/schemas/conditional-cost-operator
  - costVariable: $ref: #/components/schemas/conditional-cost-variable
  - operand: type: number
  - serviceTypes: type: array
    items:
      type: string
  - customUnitName: type: string
```

## Model: folder
<a id="folder"></a>

```
type: object
  description: Folder used for resource storage.
properties:
  - id: type: string
  - name: type: string
  - hasParent: type: boolean
  - path: type: array
    items:
      $ref: #/components/schemas/folder-path
```

## Model: workflow-template
<a id="workflow-template"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - taskTemplates: type: array
    items:
      $ref: #/components/schemas/workflow-task-template
  - phases: type: array
    items:
      $ref: #/components/schemas/workflow-phase
  - transitions: type: array
    items:
      $ref: #/components/schemas/workflow-template-transition
  - configurationValues: type: array
    items:
      $ref: #/components/schemas/workflow-task-type-config-value
```

## Model: workflow-task-configuration
<a id="workflow-task-configuration"></a>

```
type: object
  description: Properties of a workflow task.
properties:
  - scope: $ref: #/components/schemas/task-configuration-scope
  - assignees: $ref: #/components/schemas/workflow-task-assignee
  - isSkipped: type: boolean
  - taskTemplate: $ref: #/components/schemas/workflow-task-template
  - configurationValues: type: array
    items:
      $ref: #/components/schemas/workflow-task-type-config-value
```

## Model: project-plan-task-configuration
<a id="project-plan-task-configuration"></a>

```
type: object
  description: The configuration of a task that will be created in the future.
properties:
  - taskTemplate: $ref: #/components/schemas/workflow-task-template
  - scope: $ref: #/components/schemas/task-configuration-scope
  - assignees: type: array
    items:
      $ref: #/components/schemas/workflow-task-assignee
  - isSkipped: type: boolean
  - dueBy: type: string (format: date-time)
  - configurationValues: type: array
    items:
      $ref: #/components/schemas/workflow-task-type-config-value
```

## Model: analytics-progress
<a id="analytics-progress"></a>

```
type: object
  description: Overall progress.
properties:
  - overall: type: integer
```

## Model: analytics-overdue-statistics
<a id="analytics-overdue-statistics"></a>

```
type: object
  description: Statistics on overdue work.
properties:
  - overdueTasks: type: integer
  - dueDateCloseTasks: type: integer
```

## Model: analytics-source-file-statistics
<a id="analytics-source-file-statistics"></a>

```
type: object
  description: Source file statistics grouped by role.
properties:
  - role: $ref: #/components/schemas/file-role
  - count: type: integer
```

## Model: analytics-workload-statistics
<a id="analytics-workload-statistics"></a>

```
type: object
  description: Statistics on workload progress.
properties:
  - completed: type: integer
  - total: type: integer
```

## Model: analytics-task-type-statistics
<a id="analytics-task-type-statistics"></a>

```
type: object
  description: Task Type statistics grouped.
properties:
  - id: type: string
  - key: type: string
  - total: type: integer
  - current: type: integer
  - completed: type: integer
  - error: type: integer
```

## Model: analytics-phase-statistics
<a id="analytics-phase-statistics"></a>

```
type: object
  description: Statistics for phases grouped.
properties:
  - name: type: string
  - total: type: integer
  - completed: type: integer
```

## Model: count
<a id="count"></a>

```
type: object
  description: Statistics count.
properties:
  - words: type: integer
  - segments: type: integer
  - characters: type: integer
  - placeables: type: integer
  - tags: type: integer
```

## Model: fuzzy-count
<a id="fuzzy-count"></a>

```
type: object
  description: Statistics count for fuzzy matches.
properties:
  - count: $ref: #/components/schemas/count
  - category: $ref: #/components/schemas/fuzzy-category
```

## Model: quote-translation-cost
<a id="quote-translation-cost"></a>

```
type: object
  description: Fees calculated based on segment status (new, translated, signed off) and previous leverage (100% match and identical context, 100% match, <100%match, cross-file repetitions).
properties:
  - total: type: number
  - targetLanguage: $ref: #/components/schemas/language
  - exactMatch: $ref: #/components/schemas/translation-cost-item
  - inContextExactMatch: $ref: #/components/schemas/translation-cost-item
  - new: $ref: #/components/schemas/translation-cost-item
  - perfectMatch: $ref: #/components/schemas/translation-cost-item
  - repetitions: $ref: #/components/schemas/translation-cost-item
  - machineTranslation: $ref: #/components/schemas/translation-cost-item
  - fuzzyMatch: type: array
    items:
      $ref: #/components/schemas/translation-cost-fuzzy-item
  - runningTotal: type: number
```

## Model: quote-language-cost
<a id="quote-language-cost"></a>

```
type: object
  description: Fees relevant for a specific target language.
properties:
  - name: type: string
  - count: type: number
  - total: type: number
  - cost: type: number
  - costType: $ref: #/components/schemas/language-cost-type
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - targetLanguage: $ref: #/components/schemas/language
  - costOrder: type: integer
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - conditionalCostOperator: $ref: #/components/schemas/conditional-cost-operator
  - conditionalCostVariable: $ref: #/components/schemas/conditional-cost-variable
  - conditionalCostThreshold: type: number
  - runningTotal: type: number
  - customUnitName: type: string
```

## Model: quote-additional-cost
<a id="quote-additional-cost"></a>

```
type: object
  description: Other extra fees not captured by translationCosts and languageCosts.
properties:
  - name: type: string
  - count: type: number
  - total: type: number
  - cost: type: number
  - costType: $ref: #/components/schemas/project-cost-type
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - costOrder: type: integer
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - conditionalCostOperator: $ref: #/components/schemas/conditional-cost-operator
  - conditionalCostVariable: $ref: #/components/schemas/conditional-cost-variable
  - conditionalCostThreshold: type: number
  - runningTotal: type: number
  - customUnitName: type: string
```

## Model: tqa-profile-passFailThreshold
<a id="tqa-profile-passFailThreshold"></a>

```
type: object
  description: Pass/Fail Threshold is used to define the maximum number of penalty points admitted before failing the translation document.
properties:
  - points: type: integer
  - quantity: type: integer
  - scope: type: string
```

## Model: tqa-profile-category
<a id="tqa-profile-category"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - abbreviation: type: string
```

## Model: tqa-profile-severity
<a id="tqa-profile-severity"></a>

```
type: object
  description: Severities are custom metrics that reviewers can use to measure the importance of any translation-related issues that they find in a file.
properties:
  - id: type: string
  - name: type: string
  - type: type: string
```

## Model: tqa-profile-score
<a id="tqa-profile-score"></a>

```
type: object
  description: The TQA scoring indicates whether translations pass or fail the acceptance threshold.
properties:
  - category: $ref: #/components/schemas/tqa-profile-category
  - severity: $ref: #/components/schemas/tqa-profile-severity
  - penalty: type: integer
```

## Model: project-group-project
<a id="project-group-project"></a>

```
type: object
  description: Project resource for project group.
properties:
  - id: type: string
  - status: type: string enum: [attaching, attached, detaching, updating, failed]
```

## Model: schedule-template-configuration
<a id="schedule-template-configuration"></a>

```
type: object
  description: Schedule Template Configuration resource
properties:
  - taskTypeId: type: string
  - taskTypeName: type: string
  - schedules: type: array
    items:
      $ref: #/components/schemas/schedule-template-configuration-schedules
```

## Model: schedule-template-project-configuration
<a id="schedule-template-project-configuration"></a>

```
type: object
  description: Schedule Template Project Configuration resource
properties:
  - duration: type: integer
  - reminder: <schema>
      description: <div style="display:inline; float:right; color:#008080; margin-top:-23px; font-size:11px">default</div><div style="display: inline;">Expressed in minutes.</div>
```

## Model: perfect-match-batch-mapping
<a id="perfect-match-batch-mapping"></a>

```
type: object
properties:
  - id: type: string
  - batch: type: integer
  - status: type: string enum: [generating, generated, pending]
  - matchingProjects: type: array
    items:
      $ref: #/components/schemas/project
  - matchingFiles: type: array
    items:
      $ref: #/components/schemas/perfect-match-file-mapping
```

## Model: project-settings-general-response
<a id="project-settings-general-response"></a>

```
type: object
properties:
  - completionConfiguration: $ref: #/components/schemas/completion-config-response
```

## Model: project-translation-memory-settings-response
<a id="project-translation-memory-settings-response"></a>

```
type: object
  description: Translation Memory settings
properties:
  - filters: $ref: #/components/schemas/translation-memory-settings-filters-response
  - updateTranslationMemoryFields: type: array
    items:
      $ref: #/components/schemas/translation-memory-settings-update-field-response
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

## Model: role
<a id="role"></a>

```
type: object
  description: Role in the account.
properties:
  - id: type: string
  - type: type: string enum: [provisioned, custom]
  - name: type: string
  - description: type: string
  - permissions: type: array
    items:
      $ref: #/components/schemas/permission
```

## Model: group-additional-roles
<a id="group-additional-roles"></a>

```
type: object
  description: Roles granted to the group in addition to the group location.
properties:
  - location: $ref: #/components/schemas/folder-v2
  - roles: type: array
    items:
      $ref: #/components/schemas/role
```

## Model: project-template-general-settings-response
<a id="project-template-general-settings-response"></a>

```
type: object
  description: General settings, are detailed in section 10.a
properties:
  - forceOnline: type: boolean
  - allowSourceEdit: type: boolean
  - quoteTemplate: $ref: #/components/schemas/project-quote-template
  - customerPortalVisibility: type: boolean
  - completionConfiguration: $ref: #/components/schemas/completion-config-request
```

## Model: project-template-batch-tasks-settings
<a id="project-template-batch-tasks-settings"></a>

```
type: object
  description: Project Template Batch Tasks Settings
properties:
  - preProcessing: $ref: #/components/schemas/project-template-batch-tasks-preprocessing-settings
  - updateTranslationMemory: $ref: #/components/schemas/update-translation-memory-settings
```

## Model: project-template-verification-settings
<a id="project-template-verification-settings"></a>

```
type: object
  description: 
properties:
  - tagVerifier: $ref: #/components/schemas/project-template-verification-tag-verifier-settings
  - qaChecker: $ref: #/components/schemas/project-template-verification-qa-checker-settings
```

## Model: project-template-quality-management-settings-response
<a id="project-template-quality-management-settings-response"></a>

```
type: object
properties:
  - tqaProfile: $ref: #/components/schemas/tqa-profile
```

## Model: project-template-termbase-settings-response
<a id="project-template-termbase-settings-response"></a>

```
type: object
properties:
  - general: $ref: #/components/schemas/project-template-termbase-general-settings
```

## Model: project-template-translation-memory-settings-response
<a id="project-template-translation-memory-settings-response"></a>

```
type: object
  description: Translation Memory settings
properties:
  - penalties: $ref: #/components/schemas/project-template-TM-penalties
  - filters: $ref: #/components/schemas/translation-memory-settings-filters-response
  - updateTranslationMemoryFields: type: array
    items:
      $ref: #/components/schemas/translation-memory-settings-update-field-response
```

## Model: translation-engine-definition-language-pair
<a id="translation-engine-definition-language-pair"></a>

```
type: object
properties:
  - languagePair: $ref: #/components/schemas/language-pair
  - resources: type: array
    items:
      $ref: #/components/schemas/language-pair-resource
  - adjacentLanguagePairs: type: array
    items:
      $ref: #/components/schemas/language-pair
```

## Model: remote-translation-engine-sequence
<a id="remote-translation-engine-sequence"></a>

```
<schema>
  title: Translation Engine Sequence
  description: Lists of IDs for Translation Memories, Termbases, Machine Translations and Large Language Models, in order of their use
```

## Model: pricing-unit-type
<a id="pricing-unit-type"></a>

```
type: string enum: [words, characters]
```

## Model: fuzzy-match
<a id="fuzzy-match"></a>

```
type: object
  description: Fuzzy match model.
properties:
  - price: type: number
  - category: $ref: #/components/schemas/fuzzy-match-category
```

## Model: language-cost
<a id="language-cost"></a>

```
type: object
properties:
  - name: type: string
  - type: $ref: #/components/schemas/language-cost-type
  - index: type: number
  - costPerUnit: type: number
  - unitCount: type: number
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - costOperator: $ref: #/components/schemas/conditional-cost-operator
  - costVariable: $ref: #/components/schemas/conditional-cost-variable
  - operand: type: number
  - serviceTypes: type: array
    items:
      type: string
  - customUnitName: type: string
```

## Model: project-cost-type
<a id="project-cost-type"></a>

```
type: string enum: [volume, perTargetLanguage, perFile, hourly, percentage, perPage, conditional, adhoc, adhocVolume]
```

## Model: volume-unit-type
<a id="volume-unit-type"></a>

```
type: string enum: [words, characters, custom]
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

## Model: workflow-task-template
<a id="workflow-task-template"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - apiInternalId: type: string
  - description: type: string
  - canSkip: type: boolean
  - requiresAssignment: type: boolean
  - taskType: $ref: #/components/schemas/task-type
  - phase: $ref: #/components/schemas/workflow-phase
```

## Model: workflow-phase
<a id="workflow-phase"></a>

```
type: object
  description: A set of workflow steps which work together towards a localization outcome.
properties:
  - id: type: string
  - name: type: string
```

## Model: workflow-template-transition
<a id="workflow-template-transition"></a>

```
type: object
properties:
  - from: $ref: #/components/schemas/workflow-template-transition-node
  - to: $ref: #/components/schemas/workflow-template-transition-node
  - condition: $ref: #/components/schemas/workflow-template-transition-condition
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

## Model: task-configuration-scope
<a id="task-configuration-scope"></a>

```
type: object
properties:
  - type: type: string enum: [global, sourceLanguage, targetLanguage, languageDirection]
  - sourceLanguage: $ref: #/components/schemas/language
  - targetLanguage: $ref: #/components/schemas/language
  - languageDirection: $ref: #/components/schemas/language-direction-item
```

## Model: workflow-task-assignee
<a id="workflow-task-assignee"></a>

```
type: object
  description: Task assignee. Based on the "type", further details can be retrieved. <br> For ex. for "type"="user", "user" property is available. <br> For "projectCreator" and "projectManager" no other property is available.
properties:
  - type: type: string enum: [user, group, vendorOrderTemplate, projectCreator, projectManager]
  - user: $ref: #/components/schemas/user
  - group: $ref: #/components/schemas/group
  - vendorOrderTemplate: $ref: #/components/schemas/vendor-order-template
```

## Model: file-role
<a id="file-role"></a>

```
type: string enum: [translatable, reference, localizable, unknown]
```

## Model: fuzzy-category
<a id="fuzzy-category"></a>

```
type: object
  description: Fuzzy category range. Example of Fuzzy bands: 100-100%, 95-99%, 85-94%, 75-84%, 50-74%.
properties:
  - minimum: type: integer
  - maximum: type: integer
```

## Model: translation-cost-item
<a id="translation-cost-item"></a>

```
type: object
properties:
  - count: type: number
  - rate: type: number
  - total: type: number
  - runningTotal: type: number
```

## Model: translation-cost-fuzzy-item
<a id="translation-cost-fuzzy-item"></a>

```
type: object
properties:
  - count: type: number
  - rate: type: number
  - total: type: number
  - runningTotal: type: number
  - fuzzyCategory: $ref: #/components/schemas/fuzzy-category
```

## Model: language-cost-type
<a id="language-cost-type"></a>

```
type: string enum: [volume, hourly, percentage, perPage, conditional, adhoc, adhocVolume]
```

## Model: schedule-template-configuration-schedules
<a id="schedule-template-configuration-schedules"></a>

```
type: object
  description: The Configuration Schedules resource.
properties:
  - scope: type: string enum: [global, sourceLanguage, languageDirection]
  - duration: type: integer
  - reminder: <schema>
      description: Expressed in minutes.
  - sourceLanguage: type: string
  - targetLanguage: type: string
```

## Model: perfect-match-file-mapping
<a id="perfect-match-file-mapping"></a>

```
type: object
properties:
  - fileMappingId: type: string
  - fileId: type: string
  - fileName: type: string
  - targetLanguages: type: array
    items:
      $ref: #/components/schemas/language
  - matches: type: array
    items:
      $ref: #/components/schemas/perfect-match-file-match
```

## Model: completion-config-response
<a id="completion-config-response"></a>

```
type: object
  description: Completion configuration properties.
properties:
  - completeDate: $ref: #/components/schemas/date-time
  - completeDays: type: number
  - archiveDate: $ref: #/components/schemas/date-time
  - archiveDays: type: number
  - archiveReminderDays: type: number
```

## Model: translation-memory-settings-filters-response
<a id="translation-memory-settings-filters-response"></a>

```
type: object
  description: Translation Memory filter settings.
properties:
  - hardFilter: $ref: #/components/schemas/translation-memory-settings-hard-filter-response
```

## Model: translation-memory-settings-update-field-response
<a id="translation-memory-settings-update-field-response"></a>

```
type: object
  description: Translation Memory Field definition with values for field updates
```

## Model: permission
<a id="permission"></a>

```
type: object
  description: A single permission which governs access to resources.
properties:
  - name: type: string
  - description: type: string
  - category: type: string
  - entityType: $ref: #/components/schemas/permission-entity-type
  - dependsOn: type: array
    items:
      type: string
```

## Model: project-template-batch-tasks-preprocessing-settings
<a id="project-template-batch-tasks-preprocessing-settings"></a>

```
type: object
  description: Pre-Processing Settings, configure how TMs are applied, are detailed in section 10.b
properties:
  - minimumMatchValue: type: integer
  - translationOverwriteMode: type: string enum: [keepExisting, overwriteIfBetter, overwriteAlways, overwriteExceptPerfectMatch]
  - afterApplyingTranslations: type: array
    items:
      type: string enum: [confirmExactMatches, confirmContextMatches, lockExactMatches, lockContextMatches, lockGreenSegments, lockAmberSegments, lockRedSegments]
  - noMatchFoundAction: type: string enum: [leaveTargetSegmentsEmpty, copySourceToTarget]
  - reportCrossFileRepetition: type: boolean
  - excludeLockedSegments: type: boolean
```

## Model: update-translation-memory-settings
<a id="update-translation-memory-settings"></a>

```
type: object
properties:
  - segmentsConfirmationLevels: type: array
    items:
      type: string enum: [approvedTranslation, approvedSignOff, draft, notTranslated, translated, rejectedTranslation, rejectedSignOff]
  - targetSegmentsDifferOption: type: string enum: [addNew, overwrite, keepMostRecent, leaveUnchanged, merge]
```

## Model: project-template-verification-tag-verifier-settings
<a id="project-template-verification-tag-verifier-settings"></a>

```
type: object
  description: Tag Verifier Settings, are detailed in section 10.d
properties:
  - enabled: type: boolean
  - checkAddedTags: type: boolean
  - addedTagsSeverity: type: string enum: [error, warning, note]
  - checkDeletedTags: type: boolean
  - deletedTagsSeverity: type: string enum: [error, warning, note]
  - checkTagOrderChanged: type: boolean
  - tagOrderChangedSeverity: type: string enum: [error, warning, note]
  - checkSpacingAroundTags: type: boolean
  - spaceAroundTagsSeverity: type: string enum: [error, warning, note]
  - ignoreFormattingTags: type: boolean
  - ignoreLockedSegments: type: boolean
  - ignoreDifferenceBetweenNormalAndNonBreakingSpace: type: boolean
```

## Model: project-template-verification-qa-checker-settings
<a id="project-template-verification-qa-checker-settings"></a>

```
type: object
  description: QA Checker Settings, are detailed in section 10.e
properties:
  - enabled: type: boolean
  - allLanguages: $ref: #/components/schemas/project-template-verification-qa-checker-all-languages
  - perTargetLanguage: type: array
    items:
      $ref: #/components/schemas/project-template-verification-qa-checker-per-target-language
```

## Model: project-template-termbase-general-settings
<a id="project-template-termbase-general-settings"></a>

```
type: object
properties:
  - showRecognizedTermsWithNoTranslation: type: boolean
  - enableRecognitionOfTwoLetterTerms: type: boolean
  - allowOverlappingTerms: type: boolean
  - minimumScore: type: number
  - termLength: type: number
```

## Model: project-template-TM-penalties
<a id="project-template-TM-penalties"></a>

```
type: object
  description: Translation Memory Penalties
properties:
  - standardPenalties: $ref: #/components/schemas/project-template-TM-standard-penalties
  - translationUnitStatusPenalties: $ref: #/components/schemas/project-template-TM-translation-unit-status-penalties
```

## Model: language-pair
<a id="language-pair"></a>

```
type: object
  description: 
properties:
  - source: type: string
  - target: type: string
```

## Model: language-pair-resource
<a id="language-pair-resource"></a>

```
type: object
  description: Resource describing a Translation Memory, Termbase or Machine Translation used in a Translation Engine.
properties:
  - id: type: string
  - systemId: type: string
  - type: type: string enum: [TM, MT, TB, LLM]
  - penalty: type: integer
  - lookup: type: boolean
  - concordance: type: boolean
  - update: type: boolean
  - generativeTranslation: type: boolean
  - smartReview: type: boolean
```

## Model: fuzzy-match-category
<a id="fuzzy-match-category"></a>

```
type: object
  description: Fuzzy match category range.
properties:
  - minimumMatchValue: type: integer
  - maximumMatchValue: type: integer
```

## Model: task-type
<a id="task-type"></a>

```
type: object
  description: Task type.
properties:
  - id: type: string
  - key: type: string
  - name: type: string
  - apiInternalId: type: string
  - description: type: string
  - automatic: type: boolean
  - scope: type: string enum: [file, targetLanguage, batch, vendorOrder, task]
  - outcomes: type: array
    items:
      $ref: #/components/schemas/task-type-outcome
  - configurationDefinitions: type: array
    items:
      $ref: #/components/schemas/task-type-configuration-definition
  - location: $ref: #/components/schemas/folder-v2
```

## Model: workflow-template-transition-node
<a id="workflow-template-transition-node"></a>

```
type: object
properties:
  - type: type: string enum: [taskTemplate, start, end]
  - taskTemplate: $ref: #/components/schemas/workflow-task-template
```

## Model: workflow-template-transition-condition
<a id="workflow-template-transition-condition"></a>

```
type: object
properties:
  - type: type: string enum: [outcome, expression]
  - value: type: string
```

## Model: language-direction-item
<a id="language-direction-item"></a>

```
type: object
  description: 
properties:
  - id: type: string
```

## Model: vendor-order-template
<a id="vendor-order-template"></a>

```
type: object
  description: The vendor order template.
properties:
  - id: type: string
```

## Model: perfect-match-file-match
<a id="perfect-match-file-match"></a>

```
type: object
properties:
  - fileName: type: string
  - targetLanguage: $ref: #/components/schemas/language
  - origin: $ref: #/components/schemas/perfect-match-file-origin
```

## Model: translation-memory-settings-hard-filter-response
<a id="translation-memory-settings-hard-filter-response"></a>

```
type: object
  description: Hard filter configuration for Translation Memory matching.
properties:
  - expression: type: string
  - fields: type: array
    items:
      $ref: #/components/schemas/translation-memory-settings-filter-field-response
```

## Model: translation-memory-settings-filter-field-response
<a id="translation-memory-settings-filter-field-response"></a>

```
type: object
  description: Translation Memory Filter Field definition
properties:
  - fieldId: type: string
  - fieldTemplateId: type: string
  - fieldTemplateName: type: string
  - name: type: string
  - type: type: string enum: [singleString, multipleString, singlePicklist, multiplePicklist, dateTime, integer]
  - allowedValues: type: array
    items:
      type: object
      properties:
        - id: type: string
        - name: type: string
```

## Model: permission-entity-type
<a id="permission-entity-type"></a>

```
type: object
  description: The entity type a permission applies to.
properties:
  - name: type: string
  - description: type: string
```

## Model: project-template-verification-qa-checker-all-languages
<a id="project-template-verification-qa-checker-all-languages"></a>

```
type: object
properties:
  - segmentsVerification: $ref: #/components/schemas/project-template-verification-qa-checker-segments-verification
  - segmentsToExclude: $ref: #/components/schemas/project-template-verification-qa-checker-segments-to-exclude
  - inconsistencies: $ref: #/components/schemas/project-template-verification-qa-checker-inconsistencies
  - punctuation: $ref: #/components/schemas/project-template-verification-qa-checker-punctuation
  - numbers: $ref: #/components/schemas/project-template-verification-qa-checker-numbers
  - wordList: $ref: #/components/schemas/project-template-verification-qa-checker-word-list
  - regularExpressions: $ref: #/components/schemas/project-template-verification-qa-checker-regular-expressions
  - trademarkCheck: $ref: #/components/schemas/project-template-verification-qa-checker-trademark-check
  - lengthVerification: $ref: #/components/schemas/project-template-verification-qa-checker-length-verification
```

## Model: project-template-verification-qa-checker-per-target-language
<a id="project-template-verification-qa-checker-per-target-language"></a>

```
type: object
properties:
  - targetLanguage: $ref: #/components/schemas/language
  - punctuation: $ref: #/components/schemas/project-template-verification-qa-checker-punctuation
  - numbers: $ref: #/components/schemas/project-template-verification-qa-checker-numbers
  - wordList: $ref: #/components/schemas/project-template-verification-qa-checker-word-list
  - regularExpressions: $ref: #/components/schemas/project-template-verification-qa-checker-regular-expressions
```

## Model: project-template-TM-standard-penalties
<a id="project-template-TM-standard-penalties"></a>

```
type: object
  description: Translation Memory Standard Penalties
properties:
  - missingFormatting: type: integer
  - differentFormatting: type: integer
  - multipleTranslations: type: integer
  - autoLocalization: type: integer
  - textReplacement: type: integer
  - alignment: type: integer
  - characterWidthDifference: type: integer
```

## Model: project-template-TM-translation-unit-status-penalties
<a id="project-template-TM-translation-unit-status-penalties"></a>

```
type: object
  description: Translation Memory Translation Unit Status Penalties
properties:
  - translated: type: integer
  - rejectedTranslation: type: integer
  - approvedTranslation: type: integer
  - rejectedSignOff: type: integer
  - approvedSignOff: type: integer
  - notTranslated: type: integer
  - draft: type: integer
```

## Model: task-type-outcome
<a id="task-type-outcome"></a>

```
type: object
  description: The task type outcome.
properties:
  - name: type: string
  - description: type: string
  - default: type: boolean
```

## Model: task-type-configuration-definition
<a id="task-type-configuration-definition"></a>

```
type: object
  description: Describes a single configurable option for a task type.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - dataType: type: string enum: [integer, boolean, string]
  - optional: type: boolean
  - defaultValue: type: object
      description: The default value applied when no value is explicitly set. The type matches `dataType`. May be `null` when no default is defined.
  - options: type: array
    items:
      type: string
  - constraints: type: array
    items:
      $ref: #/components/schemas/task-type-configuration-constraint
```

## Model: perfect-match-file-origin
<a id="perfect-match-file-origin"></a>

```
type: object
properties:
  - fileId: type: string
  - matchSource: type: string enum: [userUpload, perfectMatch, candidateConfirm, userSelection]
  - projectId: type: string
  - type: type: string enum: [bcm, sdlXliff]
```

## Model: project-template-verification-qa-checker-segments-verification
<a id="project-template-verification-qa-checker-segments-verification"></a>

```
type: object
properties:
  - checkForgottenTranslation: type: boolean
  - forgottenTranslationSeverity: type: string enum: [error, warning, note]
  - checkSourceTargetIdentical: type: boolean
  - sourceTargetIdenticalSeverity: type: string enum: [error, warning, note]
  - identicalSegmentsIgnoreTags: type: boolean
  - identicalSegmentsIgnoreCase: type: boolean
  - checkTargetLonger: type: boolean
  - longerByValue: type: number
  - checkTargetShorter: type: boolean
  - shorterByValue: type: number
  - ignoreSegmentsFewerThanCount: type: number
  - ignoreSegmentsFewerThanBase: type: string enum: [words, characters]
  - checkForbiddenChars: type: boolean
  - forbiddenChars: type: string
  - forbiddenCharsSeverity: type: string enum: [error, warning, note]
```

## Model: project-template-verification-qa-checker-segments-to-exclude
<a id="project-template-verification-qa-checker-segments-to-exclude"></a>

```
type: object
properties:
  - excludePerfectMatchSegments: type: boolean
  - excludeExactMatches: type: boolean
  - excludeFuzzyMatches: type: boolean
  - excludeFuzzyMatchesValue: type: number
  - excludeNewTranslation: type: boolean
  - excludeConfirmedTranslations: type: boolean
  - excludeLockedSegments: type: boolean
  - excludeIdentical: type: boolean
  - elementContextExclusion: type: boolean
  - exclusionContextList: type: array
    items:
      type: string
  - reportAllNonExcluded: type: boolean
  - reportAllNonExcludedSeverity: type: string enum: [error, warning, note]
```

## Model: project-template-verification-qa-checker-inconsistencies
<a id="project-template-verification-qa-checker-inconsistencies"></a>

```
type: object
properties:
  - checkInconsistentTranslations: type: boolean
  - checkInconsistentTranslationsSeverity: type: string enum: [error, warning, note]
  - checkInconsistentTranslationsIgnoreTags: type: boolean
  - checkInconsistentTranslationsIgnoreCase: type: boolean
  - checkRepeatedWords: type: boolean
  - checkRepeatedWordsSeverity: type: string enum: [error, warning,  Note]
  - checkRepeatedWordsIgnoreNumbers: type: boolean
  - checkRepeatedWordsIgnoreCase: type: boolean
  - checkUneditedSegmentsFuzzy: type: boolean
  - checkUneditedSegmentsFuzzySeverity: type: string enum: [error, warning, note]
  - checkOnlyConfirmedSegments: type: boolean
  - checkIfMatchScoresBelow: type: boolean
  - checkIfMatchScoresBelowValue: type: number
```

## Model: project-template-verification-qa-checker-punctuation
<a id="project-template-verification-qa-checker-punctuation"></a>

```
type: object
properties:
  - checkIdenticalPunctuation: type: boolean
  - checkIdenticalPunctuationSeverity: type: string enum: [error, warning, note]
  - checkSpanishPunctuation: type: boolean
  - checkSpanishPunctuationSeverity: type: string enum: [error, warning, note]
  - checkUnintentionalSpacesBeforePunctuation: type: boolean
  - checkUnintentionalSpacesBeforePunctuationSeverity: type: string enum: [error, warning, note]
  - checkUnintentionalSpacesBeforePunctuationValues: type: string
  - punctuationSpacesFrench: type: boolean
  - checkMultipleSpaces: type: boolean
  - checkMultipleSpacesSeverity: type: string enum: [error, warning, note]
  - checkMultipleDots: type: boolean
  - checkMultipleDotsSeverity: type: string enum: [error, warning, note]
  - ignoreThreeDots: type: boolean
  - checkExtraSpace: type: boolean
  - checkExtraSpaceSeverity: type: string enum: [error, warning, note]
  - checkCapitalizationOfInitials: type: boolean
  - checkCapitalizationOfInitialsSeverity: type: string enum: [error, warning, note]
  - checkConsistencyOfGlobalCapitalization: type: boolean
  - checkConsistencyOfGlobalCapitalizationSeverity: type: string enum: [error, warning, note]
  - checkBrackets: type: boolean
  - checkBracketsSeverity: type: string enum: [error, warning, note]
```

## Model: project-template-verification-qa-checker-numbers
<a id="project-template-verification-qa-checker-numbers"></a>

```
type: object
properties:
  - checkNumbers: type: boolean
  - checkNumbersSeverity: type: string enum: [error, warning, note]
  - checkTimes: type: boolean
  - checkTimesSeverity: type: string enum: [error, warning, note]
  - checkDates: type: boolean
  - checkDatesSeverity: type: string enum: [error, warning, note]
  - checkMeasurements: type: boolean
  - checkMeasurementsSeverity: type: string enum: [error, warning, note]
```

## Model: project-template-verification-qa-checker-word-list
<a id="project-template-verification-qa-checker-word-list"></a>

```
type: object
properties:
  - enabled: type: boolean
  - searchWholeWords: type: boolean
  - ignoreCase: type: boolean
  - checkWordListSeverity: type: string enum: [error, warning, note]
  - wordList: type: array
    items:
      type: object
      properties:
        - wrongForm: type: string
        - correctForm: type: string
```

## Model: project-template-verification-qa-checker-regular-expressions
<a id="project-template-verification-qa-checker-regular-expressions"></a>

```
type: object
properties:
  - checkRegularExpressions: type: boolean
  - regularExpressionSeverity: type: string enum: [error, warning, note]
  - regularExpressions: type: array
    items:
      $ref: #/components/schemas/project-template-verification-qa-checker-regular-expressions-model
```

## Model: project-template-verification-qa-checker-trademark-check
<a id="project-template-verification-qa-checker-trademark-check"></a>

```
type: object
properties:
  - enabled: type: boolean
  - trademarkSeverity: type: string enum: [error, warning, note]
  - trademarkSymbols: type: array
    items:
      type: string
```

## Model: project-template-verification-qa-checker-length-verification
<a id="project-template-verification-qa-checker-length-verification"></a>

```
type: object
properties:
  - checkLengthLimitation: type: boolean
  - checkLengthLimitationSeverity: type: string enum: [error, warning, note]
  - targetSegmentsVerificationType: type: string enum: [fileSpecificLimit, absoluteCharacterCount]
  - absoluteCharCountValue: type: number
```

## Model: task-type-configuration-constraint
<a id="task-type-configuration-constraint"></a>

```
type: object
  description: A validation constraint applied to a task type configuration value.
properties:
  - type: type: string enum: [minValue, maxValue]
  - value: type: object
      description: The constraint threshold. Type matches the parent configuration option's `dataType`.
```

## Model: project-template-verification-qa-checker-regular-expressions-model
<a id="project-template-verification-qa-checker-regular-expressions-model"></a>

```
type: object
properties:
  - description: type: string
  - regexSource: type: string
  - regexTarget: type: string
  - ignoreCase: type: boolean
  - condition: type: string enum: [targetAndSource, targetNotSource, sourceNotTarget, sourceOnly, targetOnly, differentCount, groupedTargetAndSource]
```

## SDK

### .NET — `IProjectClient`

```csharp
Task<Project> CreateProjectAsync(ProjectCreateRequest fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `ProjectCreateRequest` | no |

### Java — `ProjectApi`

```java
// POST /projects?fields={fields}
Project createProject(ProjectCreateRequest projectCreateRequest, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectCreateRequest` | `ProjectCreateRequest` | yes |
| `fields` | `String` | no |