# Trados Cloud Platform API List Workflows

List Workflows ListWorkflows GET /workflows

- Friendly name: List Workflows
- Operation ID: ListWorkflows
- HTTP Method: GET
- Path: /workflows

Retrieves all the workflows in an account.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.
- **location** (query, array) - optional: The identifiers of the resource folders. You can control the behavior by using the 'locationStrategy'. 
- **locationStrategy** (query, string) - optional: Options: <br> - `location`: all the resources located strictly in the folders from the 'location' parameter (default); <br> - `lineage`: all the resources located in the folders specified in the 'location' parameter, as well as the subfolders; <br> - `bloodline`: all the resources located in the folders specified in the 'location' parameter, as well as the ancestor folders; <br> - `genealogy`: the resources located in the folders specified in the 'location' parameter together with subfolders and ancestors.
- **sort** (query, string) - optional: A comma separated list of fields used to sort the resources in the response. Each field can have a unary negative to imply descending sort order.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-workflows-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 416

Error codes:
* "requestedRangeNotSatisfiable": The requested entity or one of its dependencies attempted to retrieve data outside the allowed range. Skip+Top might be outside the supported range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-workflows-response
<a id="list-workflows-response"></a>

```
type: object
  description: A response for the List Workflows endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/workflow
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

## Model: vendor-order-template
<a id="vendor-order-template"></a>

```
type: object
  description: The vendor order template.
properties:
  - id: type: string
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

## Model: account
<a id="account"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
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

## Model: permission-entity-type
<a id="permission-entity-type"></a>

```
type: object
  description: The entity type a permission applies to.
properties:
  - name: type: string
  - description: type: string
```

## SDK

### .NET — `IWorkflowClient`

```csharp
Task<ListWorkflowsResponse> ListWorkflowsAsync(int? top = null, int? skip = null, IEnumerable<string> location, LocationStrategy? locationStrategy = null, string sort = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `int` | no |
| `skip` | `int` | no |
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |
| `sort` | `string` | no |
| `fields` | `string` | no |

### Java — `WorkflowApi`

```java
// GET /workflows?top={top}&skip={skip}&location={location}&locationStrategy={locationStrategy}&sort={sort}&fields={fields}
ListWorkflowsResponse listWorkflows(Integer top, Integer skip, List<String> location, String locationStrategy, String sort, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |
| `sort` | `String` | no |
| `fields` | `String` | no |