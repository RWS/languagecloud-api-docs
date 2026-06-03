# Trados Cloud Platform API Delete Project Template

Delete Project Template DeleteProjectTemplate DELETE /project-templates/{projectTemplateId}

- Friendly name: Delete Project Template
- Operation ID: DeleteProjectTemplate
- HTTP Method: DELETE
- Path: /project-templates/{projectTemplateId}

Deletes a project template by id.

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
* "forbidden": the authenticated user is not allowed to read the project template.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project template could not be found by identifier.

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

### .NET — `IProjectTemplateClient`

```csharp
Task DeleteProjectTemplateAsync(string projectTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectTemplateId` | `string` | yes |

### Java — `ProjectTemplateApi`

```java
// DELETE /project-templates/{projectTemplateId}
void deleteProjectTemplate(String projectTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectTemplateId` | `String` | yes |