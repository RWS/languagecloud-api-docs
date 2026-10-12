# Trados Cloud Platform API Download Termbase Import Logs

Download Termbase Import Logs DownloadTermbaseImportLog GET /termbases/{termbaseId}/imports/{importId}/logs

- Friendly name: Download Termbase Import Logs
- Operation ID: DownloadTermbaseImportLog
- HTTP Method: GET
- Path: /termbases/{termbaseId}/imports/{importId}/logs

Downloads the termbase import logs.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200

OK

- Content: application/octet-stream
```
type: string (format: binary)
```

### 400

Error code: 
  * "invalid": the value specified in the field "name" of the errorDetails is not an accepted value.

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to read entry.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

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

### .NET — `ITermbaseImportClient`

```csharp
Task DownloadTermbaseImportLogAsync(string termbaseId, string importId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `importId` | `string` | yes |

### Java — `TermbaseImportApi`

```java
// GET /termbases/{termbaseId}/imports/{importId}/logs
File downloadTermbaseImportLog(String termbaseId, String importId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `importId` | `String` | yes |