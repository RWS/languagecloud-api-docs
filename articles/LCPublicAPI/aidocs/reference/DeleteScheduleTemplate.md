# Trados Cloud Platform API Delete Schedule Template

Delete Schedule Template DeleteScheduleTemplate DELETE /schedule-templates/{scheduleTemplateId}

- Friendly name: Delete Schedule Template
- Operation ID: DeleteScheduleTemplate
- HTTP Method: DELETE
- Path: /schedule-templates/{scheduleTemplateId}

Deletes a schedule template.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 204

No Content

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to delete the schedule template.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the schedule template could not be found by identifier.

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

### .NET — `IScheduleTemplateClient`

```csharp
Task DeleteScheduleTemplateAsync(string scheduleTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `scheduleTemplateId` | `string` | yes |

### Java — `ScheduleTemplateApi`

```java
// DELETE /schedule-templates/{scheduleTemplateId}
void deleteScheduleTemplate(String scheduleTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `scheduleTemplateId` | `String` | yes |