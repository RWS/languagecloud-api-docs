# Trados Cloud Platform API Download Exported Termbase

Download Exported Termbase DownloadExportedTermbase GET /termbases/{termbaseId}/exports/{exportId}/download

- Friendly name: Download Exported Termbase
- Operation ID: DownloadExportedTermbase
- HTTP Method: GET
- Path: /termbases/{termbaseId}/exports/{exportId}/download

Downloads the exported termbase when the poll operation status is `done`.

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
- Content: application/xml
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": - The specified termbase or export was not found.


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

### .NET — `ITermbaseExportClient`

```csharp
Task DownloadExportedTermbaseAsync(string termbaseId, string exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `exportId` | `string` | yes |

### Java — `TermbaseExportApi`

```java
// GET /termbases/{termbaseId}/exports/{exportId}/download
File downloadExportedTermbase(String termbaseId, String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `exportId` | `String` | yes |