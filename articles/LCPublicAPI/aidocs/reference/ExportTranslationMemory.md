# Trados Cloud Platform API Export Translation Memory

Export Translation Memory ExportTranslationMemory POST /translation-memory/{translationMemoryId}/exports

- Friendly name: Export Translation Memory
- Operation ID: ExportTranslationMemory
- HTTP Method: POST
- Path: /translation-memory/{translationMemoryId}/exports

Generates an asynchronous export operation.
Use the [Poll Translation Memory Export](#/operations/PollTranslationMemoryExport) endpoint to poll until the export status is `done`.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: translation-memory-export-request (see model section below)

## Response

### 200

OK - returned when the `status` field has one of the following values: `failed`, `done`, `cancelled`

- Content: application/json
- Schema: translation-memory-export-response (see model section below)

### 202

Accepted - returned when the `status` field has one of the following values: `queued`, `inProgress`

- Content: application/json
- Schema: translation-memory-export-response (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the request parameters. Either the `translationMemoryId` or the `sourceLanguageCode`/`targetLanguageCode` are invalid.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to export the translation memory.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-memory-export-request
<a id="translation-memory-export-request"></a>

```
type: object
  description: 
properties:
  - languageDirection: $ref: #/components/schemas/translation-memory-export-language-direction
```

## Model: translation-memory-export-response
<a id="translation-memory-export-response"></a>

```
type: object
properties:
  - id: type: string
  - status: type: string enum: [queued, inProgress, failed, done, cancelled]
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

## Model: translation-memory-export-language-direction
<a id="translation-memory-export-language-direction"></a>

```
type: object
  description: 
properties:
  - sourceLanguage: $ref: #/components/schemas/source-language-request
  - targetLanguage: $ref: #/components/schemas/target-language-request
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

## Model: source-language-request
<a id="source-language-request"></a>

```
type: object
properties:
  - languageCode: type: string
```

## Model: target-language-request
<a id="target-language-request"></a>

```
type: object
  description: 
properties:
  - languageCode: type: string
```

## SDK

### .NET — `ITranslationMemoryExportClient`

```csharp
Task ExportTranslationMemoryAsync(string translationMemoryId);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `string` | yes |

### Java — `TranslationMemoryExportApi`

```java
// POST /translation-memory/{translationMemoryId}/exports
TranslationMemoryExportResponse exportTranslationMemory(String translationMemoryId, TranslationMemoryExportRequest translationMemoryExportRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `String` | yes |
| `translationMemoryExportRequest` | `TranslationMemoryExportRequest` | no |