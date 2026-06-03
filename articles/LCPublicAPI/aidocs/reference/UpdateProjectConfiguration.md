# Trados Cloud Platform API Update Project Configuration

Update Project Configuration UpdateProjectConfiguration PUT /projects/{projectId}/configuration

- Friendly name: Update Project Configuration
- Operation ID: UpdateProjectConfiguration
- HTTP Method: PUT
- Path: /projects/{projectId}/configuration

Updates the configuration settings for an existing project.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: project-configuration-request (see model section below)

## Response

### 200



### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the project configuration.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-configuration-request
<a id="project-configuration-request"></a>

```
type: object
  description: A request used to update the configuration settings for a project.
properties:
  - translationMemoryFieldsSettings: $ref: #/components/schemas/translation-memory-fields-update-request
  - updateTranslationMemory: $ref: #/components/schemas/update-translation-memory
  - perfectMatchMappingId: type: string
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

## Model: translation-memory-fields-update-request
<a id="translation-memory-fields-update-request"></a>

```
type: object
properties:
  - settings: type: array
    items:
      $ref: #/components/schemas/translation-memory-fields-settings-request
```

## Model: update-translation-memory
<a id="update-translation-memory"></a>

```
type: object
properties:
  - settings: $ref: #/components/schemas/update-translation-memory-settings
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

## Model: translation-memory-fields-settings-request
<a id="translation-memory-fields-settings-request"></a>

```
type: object
  description: 
properties:
  - name: type: string
  - values: type: array
    items:
      type: string
  - type: $ref: #/components/schemas/translation-memory-field-update-type
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

## Model: translation-memory-field-update-type
<a id="translation-memory-field-update-type"></a>

```
type: string enum: [dateTime, singlePicklist, multiplePicklist, integer, singleString, multipleString]
```

## SDK

### .NET — `IProjectClient`

```csharp
Task UpdateProjectConfigurationAsync(string projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |

### Java — `ProjectApi`

```java
// PUT /projects/{projectId}/configuration
void updateProjectConfiguration(String projectId, ProjectConfigurationRequest projectConfigurationRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `projectConfigurationRequest` | `ProjectConfigurationRequest` | no |