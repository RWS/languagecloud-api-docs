# Trados Cloud Platform API Export Termbase

Export Termbase ExportTermbase POST /termbases/{termbaseId}/exports

- Friendly name: Export Termbase
- Operation ID: ExportTermbase
- HTTP Method: POST
- Path: /termbases/{termbaseId}/exports

Generates an asynchronous export operation.<br>
Use the [Poll Export Termbase](#/operations/PollExportTermbase) endpoint to poll until the export status is `done`.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

```
type: object
properties:
  - format: type: string enum: [xml, tbx]
  - properties: $ref: #/components/schemas/termbase-export-properties-request
```

## Response

### 200

OK

- Content: application/json
- Schema: termbase-export-response (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

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
* "notFound": - The specified termbase was not found.


## Model: termbase-export-properties-request
<a id="termbase-export-properties-request"></a>

```
type: object
properties:
  - downloadCompressed: type: boolean
```

## Model: termbase-export-response
<a id="termbase-export-response"></a>

```
type: object
properties:
  - id: type: string
  - status: type: string enum: [queued, processing, done, cancelled, error]
  - errorMessage: type: string
  - downloadUrl: type: string
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

### .NET — `ITermbaseExportClient`

```csharp
Task ExportTermbaseAsync(string termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |

### Java — `TermbaseExportApi`

```java
// POST /termbases/{termbaseId}/exports
TermbaseExportResponse exportTermbase(String termbaseId, ExportTermbaseRequest exportTermbaseRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `exportTermbaseRequest` | `ExportTermbaseRequest` | no |