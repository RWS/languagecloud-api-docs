# Trados Cloud Platform API Import Translation Memory

Import Translation Memory ImportTranslationMemory POST /translation-memory/{translationMemoryId}/imports

- Friendly name: Import Translation Memory
- Operation ID: ImportTranslationMemory
- HTTP Method: POST
- Path: /translation-memory/{translationMemoryId}/imports

Generates an asynchronous import operation. 
<br>
<br> Read more about prerequisites and limitations on the [official documentation center](https://docs.rws.com/791595/741139/trados-enterprise/importing-tm-content).
<br>
Note: The order of the multipart form parameter must be implemented as such: properties first, file second.
<br>
Use the Poll Translation Memory Import endpoint to poll until the import status is `done`.<br>
To track the progress of the import please refer to [Poll Translation Memory Import](#/operations/PollTMImport).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

For details on multipart requests please see [this article](../docs/How-to-multipart.html).
- Content: multipart/form-data

```
type: object
properties:
  - properties: $ref: #/components/schemas/translation-memory-import-request
  - file: type: string (format: binary)
```

## Response

### 200

OK - returned when the `status` field has one of the following values: `failed`, `done`, `cancelled`

- Content: application/json
- Schema: translation-memory-import-response (see model section below)

### 202

Accepted - returned when the `status` field has one of the following values: `queued`, `inProgress`

- Content: application/json
- Schema: translation-memory-import-response (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query/form parameter mentioned in the “name” field on the error response.
* "empty": Empty mandatory value mentioned in the "name" field on the error response.
* "multiPartOrder": The multipart order in the body is not correct. The `properties` must be first and then, file.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": Not authorized to import translation memories.

- Content: application/json
- Schema: error-response (see model section below)
- Content: application/xml
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-memory-import-request
<a id="translation-memory-import-request"></a>

```
type: object
  description: Translation Memory Import properties sent as a JSON inside a text part.
properties:
  - sourceLanguageCode: type: string
  - targetLanguageCode: type: string
  - importAsPlainText: type: boolean
  - exportInvalidTranslationUnits: type: boolean
  - triggerRecomputeStatistics: type: boolean
  - targetSegmentsDifferOption: type: string enum: [addNew, overwrite, leaveUnchanged, keepMostRecent]
  - unknownFieldsOption: type: string enum: [skipTranslationUnit, ignore, addToTranslationMemory, failTranslationUnitImport]
  - onlyImportSegmentsWithConfirmationLevels: type: array
    items:
      type: string enum: [translated, approvedTranslation, approvedSignOff, draft, rejectedTranslation, rejectedSignOff]
```

## Model: translation-memory-import-response
<a id="translation-memory-import-response"></a>

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

### .NET — `ITranslationMemoryImportClient`

```csharp
Task ImportTranslationMemoryAsync(string translationMemoryId, TranslationMemoryImportRequest file);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `string` | yes |
| `file` | `TranslationMemoryImportRequest` | yes |

### Java — `TranslationMemoryImportApi`

```java
// POST /translation-memory/{translationMemoryId}/imports
TranslationMemoryImportResponse importTranslationMemory(String translationMemoryId, TranslationMemoryImportRequest properties, File file);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `String` | yes |
| `properties` | `TranslationMemoryImportRequest` | yes |
| `file` | `File` | yes |