# Trados Cloud Platform API Export Termbase Template

Export Termbase Template DownloadTermbaseDefinition GET /termbases/{termbaseId}/export-template

- Friendly name: Export Termbase Template
- Operation ID: DownloadTermbaseDefinition
- HTTP Method: GET
- Path: /termbases/{termbaseId}/export-template

Downloads the termbase definition.

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

### .NET — `ITermbaseExportClient`

```csharp
Task DownloadTermbaseDefinitionAsync(string termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |

### Java — `TermbaseExportApi`

```java
// GET /termbases/{termbaseId}/export-template
File downloadTermbaseDefinition(String termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |