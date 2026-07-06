# Trados Cloud Platform API Get Schedule Template

Get Schedule Template GetScheduleTemplate GET /schedule-templates/{scheduleTemplateId}

- Friendly name: Get Schedule Template
- Operation ID: GetScheduleTemplate
- HTTP Method: GET
- Path: /schedule-templates/{scheduleTemplateId}

Retrieves a schedule template by identifier.

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
- Schema: schedule-template (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* “empty”: Empty input for the “scheduleTemplateId” path parameter variable.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to read the schedule template.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the schedule template could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


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

## SDK

### .NET — `IScheduleTemplateClient`

```csharp
Task<ScheduleTemplate> GetScheduleTemplateAsync(string scheduleTemplateId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `scheduleTemplateId` | `string` | yes |
| `fields` | `string` | no |

### Java — `ScheduleTemplateApi`

```java
// GET /schedule-templates/{scheduleTemplateId}?fields={fields}
ScheduleTemplate getScheduleTemplate(String scheduleTemplateId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `scheduleTemplateId` | `String` | yes |
| `fields` | `String` | no |