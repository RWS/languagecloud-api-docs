# Trados Cloud Platform API Update Schedule Template

Update Schedule Template UpdateScheduleTemplate PUT /schedule-templates/{scheduleTemplateId}

- Friendly name: Update Schedule Template
- Operation ID: UpdateScheduleTemplate
- HTTP Method: PUT
- Path: /schedule-templates/{scheduleTemplateId}

Updates the schedule template identified by `scheduleTemplateId`.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: schedule-template-update-request (see model section below)

## Response

### 204

No content

### 400

Error responses:

* “invalid”: invalid input on update schedule template model.
* "empty": Empty mandatory value mentioned in the "name" field on the error response or in “scheduleTemplateId” path variable.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" or in the "description" fields. 
* "invalidType": The value provided for the "taskTypeId" field is invalid.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the schedule template.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the schedule template could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": A schedule template with the same name already exists in the same location.

- Content: application/json
- Schema: error-response (see model section below)


## Model: schedule-template-update-request
<a id="schedule-template-update-request"></a>

```
type: object
  description: Schedule Template update request model
properties:
  - name: type: string
  - description: type: string
  - configurations: type: array
    items:
      $ref: #/components/schemas/schedule-template-configuration-request
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

## Model: schedule-template-configuration-request
<a id="schedule-template-configuration-request"></a>

```
type: object
  description: Schedule Template Configuration resource
properties:
  - taskTypeId: type: string
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
Task UpdateScheduleTemplateAsync(string scheduleTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `scheduleTemplateId` | `string` | yes |

### Java — `ScheduleTemplateApi`

```java
// PUT /schedule-templates/{scheduleTemplateId}
void updateScheduleTemplate(String scheduleTemplateId, ScheduleTemplateUpdateRequest scheduleTemplateUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `scheduleTemplateId` | `String` | yes |
| `scheduleTemplateUpdateRequest` | `ScheduleTemplateUpdateRequest` | no |