# Trados Cloud Platform API Update Project Template

Update Project Template UpdateProjectTemplate PUT /project-templates/{projectTemplateId}

- Friendly name: Update Project Template
- Operation ID: UpdateProjectTemplate
- HTTP Method: PUT
- Path: /project-templates/{projectTemplateId}

Updates a project template by id.

For detailed information about Translation Memory advanced configuration including filters and field updates, see [Translation Memory Advanced Configuration](../docs/translation-memory/Translation-memory-advanced-configuration.html).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: project-template-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input mentioned in the “name” field on the error response. 
* "deleted": Some of the selected values were deleted and cannot be selected for some values of the  "customFields" field.


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the project template.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project template could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-template-update-request
<a id="project-template-update-request"></a>

```
type: object
  description: Input for Project Template creation.
properties:
  - name: type: string
  - description: type: string
  - fileProcessingConfiguration: $ref: #/components/schemas/configuration-resource-request
  - projectManagers: type: array
    items:
      $ref: #/components/schemas/project-manager-request
  - scheduleTemplate: $ref: #/components/schemas/configuration-resource-request
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/language-direction-request
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field-request
  - translationEngine: $ref: #/components/schemas/configuration-resource-request
  - pricingModel: $ref: #/components/schemas/configuration-resource-request
  - workflow: $ref: #/components/schemas/configuration-resource-request
  - settings: $ref: #/components/schemas/project-template-settings-update-request
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

## Model: configuration-resource-request
<a id="configuration-resource-request"></a>

```
type: object
  description: Resource configuration properties.
properties:
  - id: type: string
  - strategy: type: string enum: [copy, use]
```

## Model: project-manager-request
<a id="project-manager-request"></a>

```
type: object
properties:
  - id: type: string
  - type: type: string enum: [group, user]
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

## Model: project-template-settings-update-request
<a id="project-template-settings-update-request"></a>

```
type: object
  description: Input for Project Template settings.
properties:
  - general: $ref: #/components/schemas/project-template-general-settings-update
  - qualityManagement: $ref: #/components/schemas/project-template-quality-management-settings
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

## Model: project-template-general-settings-update
<a id="project-template-general-settings-update"></a>

```
type: object
  description: General settings
properties:
  - forceOnline: type: boolean
  - quoteTemplate: $ref: #/components/schemas/configuration-resource-request
  - customerPortalVisibility: type: boolean
  - completionConfiguration: $ref: #/components/schemas/completion-config-request
```

## Model: project-template-quality-management-settings
<a id="project-template-quality-management-settings"></a>

```
type: object
properties:
  - tqaProfile: $ref: #/components/schemas/configuration-resource-request
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

## Model: translation-memory-hard-filter-request
<a id="translation-memory-hard-filter-request"></a>

```
type: object
  description: Hard filter configuration for Translation Memory matching request
properties:
  - expression: type: string
```

## SDK

### .NET — `IProjectTemplateClient`

```csharp
Task UpdateProjectTemplateAsync(ProjectTemplateUpdateRequest projectTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectTemplateId` | `ProjectTemplateUpdateRequest` | yes |

### Java — `ProjectTemplateApi`

```java
// PUT /project-templates/{projectTemplateId}
void updateProjectTemplate(String projectTemplateId, ProjectTemplateUpdateRequest projectTemplateUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectTemplateId` | `String` | yes |
| `projectTemplateUpdateRequest` | `ProjectTemplateUpdateRequest` | yes |