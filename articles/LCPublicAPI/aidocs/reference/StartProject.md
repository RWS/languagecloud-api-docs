# Trados Cloud Platform API Start Project

Start Project StartProject PUT /projects/{projectId}/start

- Friendly name: Start Project
- Operation ID: StartProject
- HTTP Method: PUT
- Path: /projects/{projectId}/start

Starts a project. Translatable files should be uploaded before starting the project. If the action is executed on an already started project, the new translatable files should be uploaded first.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 202

Accepted

### 400

Error codes:
* “invalid”: Invalid input in the query parameter  mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to start the project.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidStatus": the project's status doesn't permit the start operation.
* "missingTranslatableFile": there was no translatable file attached to the project.
* "missingWorkflow": there was no workflow associated with the project.
* "invalidWorkflow" : the workflow associated with the project is invalid or has errors.
* "missingConfigurations": not all manual task templates have configurations.

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

### .NET — `IProjectClient`

```csharp
Task StartProjectAsync(string projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |

### Java — `ProjectApi`

```java
// PUT /projects/{projectId}/start
void startProject(String projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |