# Trados Cloud Platform API Get Termbase Import History

Get Termbase Import History GetImportHistory GET /termbases/{termbaseId}/imports

- Friendly name: Get Termbase Import History
- Operation ID: GetImportHistory
- HTTP Method: GET
- Path: /termbases/{termbaseId}/imports

Gets the import history for a termbase.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: list-termbase-import-history (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the “name” field on the error response.
* "minSize": Minimum size exceeded for the value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to read entry.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-termbase-import-history
<a id="list-termbase-import-history"></a>

```
type: object
properties:
  - items: type: array
    items:
      $ref: #/components/schemas/termbase-import-history-response
  - itemCount: type: integer
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

## Model: termbase-import-history-response
<a id="termbase-import-history-response"></a>

```
type: object
properties:
  - id: type: string
  - fileName: type: string
  - fileSize: type: integer (format: int64)
  - status: type: string enum: [pending, queued, processing, done, cancelled, failed, error]
  - createdAt: $ref: #/components/schemas/date-time
  - elapsedTime: type: integer
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

## Model: date-time
<a id="date-time"></a>

```
type: string (format: date-time)
```

## SDK

### .NET — `ITermbaseImportClient`

```csharp
Task<ImportHistory> GetImportHistoryAsync(string termbaseId, string fields = null, int? top = null, int? skip = null);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `fields` | `string` | no |
| `top` | `int` | no |
| `skip` | `int` | no |

### Java — `TermbaseImportApi`

```java
// GET /termbases/{termbaseId}/imports?fields={fields}&top={top}&skip={skip}
ListTermbaseImportHistory getImportHistory(String termbaseId, String fields, Integer top, Integer skip);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `fields` | `String` | no |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |