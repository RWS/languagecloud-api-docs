# Trados Cloud Platform API Delete Application

Delete Application DeleteApplication DELETE /applications/{applicationId}

- Friendly name: Delete Application
- Operation ID: DeleteApplication
- HTTP Method: DELETE
- Path: /applications/{applicationId}

Deletes an integration application.

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

### 404

Error codes:
* "notFound": The resource could not be found by identifier.

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

### .NET — `IIntegrationClient`

```csharp
Task DeleteApplicationAsync(string applicationId);
```

| Parameter | Type | Required |
|---|---|---|
| `applicationId` | `string` | yes |

### Java — `IntegrationApi`

```java
// DELETE /applications/{applicationId}
void deleteApplication(String applicationId);
```

| Parameter | Type | Required |
|---|---|---|
| `applicationId` | `String` | yes |