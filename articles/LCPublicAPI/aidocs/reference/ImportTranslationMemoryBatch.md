<!--LLM_GENERATED_START-->
# Trados Cloud Platform API Import Translation Memory Batch

Import Translation Memory Batch ImportTranslationMemoryBatch POST /translation-memory/{translationMemoryId}/imports/batch

- Friendly name: Import Translation Memory Batch
- Operation ID: ImportTranslationMemoryBatch
- HTTP Method: POST
- Path: /translation-memory/{translationMemoryId}/imports/batch

Generates asynchronous import operations for multiple language directions using one uploaded file. The optional import settings apply to all requested language directions.

Send the multipart form parts in this order: `properties` first, `file` second. The `properties` part contains JSON text with a non-empty `languageDirections` array and optional settings at the top level, not inside an `importSettings` object.

The response is an array of import IDs and initial statuses. Each initial status is set to `queued`; this is not a live progress check. Use [Poll Translation Memory Import](./PollTMImport.md) with each returned `id` to retrieve its current status.

See the [TM import/export guide](../../docs/translation-memory/Translation-memory-import-export.md#importing-multiple-language-directions) for Postman setup.

## Parameters

- **translationMemoryId** (path, string) - required: The identifier of the Translation Memory.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Required: yes
- Content: multipart/form-data
- Part order: `properties`, then `file`

```yaml
type: object
required: [properties, file]
properties:
  properties:
    $ref: '#/components/schemas/translation-memory-batch-import-request'
  file:
    type: string
    format: binary
```

Send `properties` as JSON inside a text part and `file` as a file part. Accepted file types: `tmx`, `sdltm`, `zip`, `tmx.gz`, `sdlxliff`.

Example value for `properties`:

```json
{
  "languageDirections": [
    {
      "sourceLanguageCode": "en-US",
      "targetLanguageCode": "de-DE"
    },
    {
      "sourceLanguageCode": "en-GB",
      "targetLanguageCode": "fr-FR"
    }
  ],
  "targetSegmentsDifferOption": "addNew",
  "unknownFieldsOption": "addToTranslationMemory",
  "onlyImportSegmentsWithConfirmationLevels": [
    "translated",
    "approvedTranslation"
  ]
}
```

Use the public API property names and case-sensitive enum values, not downstream names such as `confirmationLevels`, `existingTUsUpdateMode` or `newFieldsBehaviour`. `existingFieldsUpdateMode` is not supported.

## Response

### 200

OK - returned when no import has status `queued` or `inProgress`.

- Content: application/json
- Schema: array of `translation-memory-import-response` (see model below)

### 202

Accepted - the imports have been queued for processing.

- Content: application/json
- Schema: array of `translation-memory-import-response` (see model below)

```json
[
  { "id": "test-import-id-1", "status": "queued" },
  { "id": "test-import-id-2", "status": "queued" }
]
```

### 400

Error codes:
- `invalid`: Invalid input in the query/form parameter mentioned in the `name` field on the error response. `languageDirections` must not be empty and each entry must include `sourceLanguageCode` and `targetLanguageCode`.
- `empty`: Empty mandatory value mentioned in the `name` field on the error response.
- `multiPartOrder`: The `properties` part must be first, followed by the `file` part.

- Content: application/json
- Schema: `error-response` (see model below)

### 401

The user could not be identified.

- Content: application/json
- Schema: `error-response` (see model below)

### 403

Error codes:
- `forbidden`: Not authorized to import translation memories.

- Content: application/json
- Schema: `error-response` (see model below)

### 404

Error codes:
- `notFound`: The translation memory or named filter could not be found.

- Content: application/json
- Schema: `error-response` (see model below)

All documented responses include the `X-LC-TraceId` header.

## Model: translation-memory-batch-import-request
<a id="translation-memory-batch-import-request"></a>

```yaml
type: object
required: [languageDirections]
properties:
  languageDirections:
    type: array
    minItems: 1
    items:
      type: object
      required: [sourceLanguageCode, targetLanguageCode]
      properties:
        sourceLanguageCode:
          type: string
        targetLanguageCode:
          type: string
  exportInvalidTranslationUnits:
    type: boolean
    default: true
  targetSegmentsDifferOption:
    type: string
    enum: [addNew, overwrite, leaveUnchanged, keepMostRecent]
    default: addNew
  unknownFieldsOption:
    type: string
    enum: [skipTranslationUnit, ignore, addToTranslationMemory, failTranslationUnitImport]
    default: addToTranslationMemory
  onlyImportSegmentsWithConfirmationLevels:
    type: array
    items:
      type: string
      enum: [translated, approvedTranslation, approvedSignOff, draft, rejectedTranslation, rejectedSignOff, notTranslated]
    default: [translated, approvedSignOff, approvedTranslation]
  filterName:
    type: string
```

An empty `onlyImportSegmentsWithConfirmationLevels` array imposes no confirmation-level restriction. `filterName` selects a saved filter expression to apply to all language directions; available filters are returned by [Get Translation Memory](./GetTranslationMemory.md).

## Model: translation-memory-import-response
<a id="translation-memory-import-response"></a>

```yaml
type: object
required: [id, status]
properties:
  id:
    type: string
  status:
    type: string
    deprecated: true
    enum: [queued, inProgress, failed, done, cancelled]
```

For this POST response, `status` is initially `queued`. Poll each `id` using `GET /translation-memory/imports/{importId}`; the import completes successfully when its polled status is `done`. Other terminal statuses are `failed` and `cancelled`.

## Model: error-response
<a id="error-response"></a>

```yaml
type: object
properties:
  message:
    type: string
  errorCode:
    type: string
  details:
    type: array
    items:
      $ref: '#/components/schemas/error-detail-response'
```

## Model: error-detail-response
<a id="error-detail-response"></a>

```yaml
type: object
properties:
  name:
    type: string
  code:
    type: string
  value:
    type: string
```
<!--LLM_GENERATED_END-->
