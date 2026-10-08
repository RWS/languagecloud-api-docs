# Trados Cloud Platform API Import Termbase

Import Termbase ImportTermbase POST /termbases/{termbaseId}/imports

- Friendly name: Import Termbase
- Operation ID: ImportTermbase
- HTTP Method: POST
- Path: /termbases/{termbaseId}/imports

Generates an asynchronous import operation.<br>
Use the Poll Import Termbase endpoint to poll until the import status is `done`.<br>

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **strictImport** (query, boolean) - optional: Specifies if the entries are only imported into the exact language that matches your imported file.<br> `true` - The import will only occur if the language in your import file matches exactly with a language in your termbase.<br> `false` - The import will occur even there are non-matching languages, by trying to match them to a relevant main language or language variant, if available.
- **duplicateEntriesStrategy** (query, string) - optional: The strategy for duplicate entries. Determines how the duplicate entries will be handled.<br> `ignore` - The content of the current entry with the same identifier will be kept, and the new entry will be ignored<br> `merge` - The content of the current entry with the same identifier will be merged with the imported entry. If the identifier is not provided the content will be merged by text.<br> `overwrite` - The content of the current entry with the same identifier will be replaced by the imported entry.

## Request body

For details on multipart requests please see [this article](../docs/How-to-multipart.html).
- Content: multipart/form-data

```
type: object
properties:
  - properties: $ref: #/components/schemas/termbase-import-request
  - file: type: string (format: binary)
```

## Response

### 200

OK

- Content: application/json
- Schema: termbase-import-response (see model section below)

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

### 409

Error codes:
* "invalidStatus": Cannot import as the termbase is currently being processed.

- Content: application/json
- Schema: error-response (see model section below)


## Model: termbase-import-request
<a id="termbase-import-request"></a>

```
type: object
  description: Properties required for system status mapping
properties:
  - statusMapping: type: array
    items:
      $ref: #/components/schemas/termbase-system-status-mapping
```

## Model: termbase-import-response
<a id="termbase-import-response"></a>

```
type: object
properties:
  - id: type: string
  - status: type: string enum: [queued, processing, done, cancelled, failed, error]
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

## Model: termbase-system-status-mapping
<a id="termbase-system-status-mapping"></a>

```
type: object
  description: A mapping between a termbase term system status and termbase statuses.
properties:
  - systemStatusValue: $ref: #/components/schemas/termbase-entry-term-system-status-request
  - statuses: type: array
    items:
      type: string
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

## Model: termbase-entry-term-system-status-request
<a id="termbase-entry-term-system-status-request"></a>

```
type: string enum: [preferred, draft, inReview, deprecated, recommended, admitted, forbidden, rejected, superseded]
```

## SDK

### .NET — `ITermbaseImportClient`

```csharp
Task ImportTermbaseAsync(string termbaseId, bool? strictImport = null, DuplicateEntriesStrategy? duplicateEntriesStrategy = null, TermbaseImportRequest file);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `strictImport` | `bool` | no |
| `duplicateEntriesStrategy` | `DuplicateEntriesStrategy` | no |
| `file` | `TermbaseImportRequest` | yes |

### Java — `TermbaseImportApi`

```java
// POST /termbases/{termbaseId}/imports?strictImport={strictImport}&duplicateEntriesStrategy={duplicateEntriesStrategy}
TermbaseImportResponse importTermbase(String termbaseId, File file, Boolean strictImport, String duplicateEntriesStrategy, TermbaseImportRequest properties);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `file` | `File` | yes |
| `strictImport` | `Boolean` | no |
| `duplicateEntriesStrategy` | `String` | no |
| `properties` | `TermbaseImportRequest` | no |