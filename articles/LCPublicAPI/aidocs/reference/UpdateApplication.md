# Trados Cloud Platform API Update Application

Update Application UpdateApplication PUT /applications/{applicationId}

- Friendly name: Update Application
- Operation ID: UpdateApplication
- HTTP Method: PUT
- Path: /applications/{applicationId}

Updates an integration application.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: application-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: application-update-request
<a id="application-update-request"></a>

```
type: object
properties:
  - name: type: string
  - description: type: string
  - enableApiAccess: type: boolean
  - serviceUserId: type: string
  - regenerateSecret: type: boolean
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

### .NET — `IIntegrationClient`

```csharp
Task UpdateApplicationAsync(string applicationId);
```

| Parameter | Type | Required |
|---|---|---|
| `applicationId` | `string` | yes |

### Java — `IntegrationApi`

```java
// PUT /applications/{applicationId}
void updateApplication(String applicationId, ApplicationUpdateRequest applicationUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `applicationId` | `String` | yes |
| `applicationUpdateRequest` | `ApplicationUpdateRequest` | no |