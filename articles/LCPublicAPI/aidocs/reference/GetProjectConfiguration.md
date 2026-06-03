# Trados Cloud Platform API Get Project Configuration

Get Project Configuration GetProjectConfiguration GET /projects/{projectId}/configuration

- Friendly name: Get Project Configuration
- Operation ID: GetProjectConfiguration
- HTTP Method: GET
- Path: /projects/{projectId}/configuration

Get the configuration settings of an existing project.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: project-configuration (see model section below)

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
* "forbidden": the authenticated user is not allowed to get the project configuration.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-configuration
<a id="project-configuration"></a>

```
type: object
  description: The configuration settings for a project.
properties:
  - translationMemoryFields: $ref: #/components/schemas/translation-memory-fields
  - updateTranslationMemory: $ref: #/components/schemas/update-translation-memory
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

## Model: translation-memory-fields
<a id="translation-memory-fields"></a>

```
type: object
properties:
  - settings: type: array
    items:
      $ref: #/components/schemas/translation-memory-fields-settings
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

## Model: translation-memory-fields-settings
<a id="translation-memory-fields-settings"></a>

```
type: object
  description: The configuration settings for Translation Memory Fields.
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
Task<ProjectConfiguration> GetProjectConfigurationAsync(string projectId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `fields` | `string` | no |

### Java — `ProjectApi`

```java
// GET /projects/{projectId}/configuration?fields={fields}
ProjectConfiguration getProjectConfiguration(String projectId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `fields` | `String` | no |