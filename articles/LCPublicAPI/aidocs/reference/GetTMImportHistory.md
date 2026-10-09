# Trados Cloud Platform API Get Translation Memory Import History

Get Translation Memory Import History GetTMImportHistory GET /translation-memory/{translationMemoryId}/imports

- Friendly name: Get Translation Memory Import History
- Operation ID: GetTMImportHistory
- HTTP Method: GET
- Path: /translation-memory/{translationMemoryId}/imports

Gets the import history for a translation memory. It returns the history of last 7 days.

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
- Schema: list-translation-memory-import-history (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to read the entry.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-translation-memory-import-history
<a id="list-translation-memory-import-history"></a>

```
type: object
properties:
  - items: type: array
    items:
      $ref: #/components/schemas/translation-memory-import-history-response
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

## Model: translation-memory-import-history-response
<a id="translation-memory-import-history-response"></a>

```
type: object
properties:
  - id: type: string
  - status: type: string enum: [queued, inProgress, failed, done, cancelled]
  - displayName: type: string
  - settings: $ref: #/components/schemas/translation-memory-import-settings
  - createdAt: type: string (format: date-time)
  - updatedAt: type: string (format: date-time)
  - ownerId: type: string
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

## Model: translation-memory-import-settings
<a id="translation-memory-import-settings"></a>

```
type: object
  description: The properties provided by the client, when the Import Operation was triggered.
properties:
  - onlyImportSegmentsWithConfirmationLevels: type: array
    items:
      type: string enum: [translated, approvedTranslation, approvedSignOff, draft, rejectedTranslation, rejectedSignOff]
  - unknownFieldsOption: type: string enum: [skipTranslationUnit, ignore, addToTranslationMemory, failTranslationUnitImport]
  - targetSegmentsDifferOption: type: string enum: [addNew, overwrite, leaveUnchanged, keepMostRecent]
  - importAsPlainText: type: boolean
  - exportInvalidTranslationUnits: type: boolean
  - triggerRecomputeStatistics: type: boolean
  - fileName: type: string
  - sourceLanguageCode: type: string
  - targetLanguageCode: type: string
  - traceId: type: string
```

## SDK

### .NET — `ITranslationMemoryImportClient`

```csharp
Task<TMImportHistory> GetTMImportHistoryAsync(string translationMemoryId, string fields = null, int? top = null, int? skip = null);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `string` | yes |
| `fields` | `string` | no |
| `top` | `int` | no |
| `skip` | `int` | no |

### Java — `TranslationMemoryImportApi`

```java
// GET /translation-memory/{translationMemoryId}/imports?fields={fields}&top={top}&skip={skip}
ListTranslationMemoryImportHistory getTMImportHistory(String translationMemoryId, String fields, Integer top, Integer skip);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `String` | yes |
| `fields` | `String` | no |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |