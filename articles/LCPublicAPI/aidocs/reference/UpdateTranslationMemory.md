# Trados Cloud Platform API Update Translation Memory

Update Translation Memory UpdateTranslationMemory PUT /translation-memory/{translationMemoryId}

- Friendly name: Update Translation Memory
- Operation ID: UpdateTranslationMemory
- HTTP Method: PUT
- Path: /translation-memory/{translationMemoryId}

Updates a Translation Memory. We recommend reading this page too [Updating data with PUT](../docs/Updating-data-with-PUT.html).

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.

## Request body

- Content: application/json

- Schema: translation-memory-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.
* "minSize": Minimum size not met for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The translation memory could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-memory-update-request
<a id="translation-memory-update-request"></a>

```
type: object
  description: 
properties:
  - name: type: string
  - description: type: string
  - copyright: type: string
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/language-direction-request
  - languageProcessingRuleId: type: string
  - fieldTemplateId: type: string
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

## Model: language-direction-request
<a id="language-direction-request"></a>

```
type: object
  description: The language directions model used for creating or updating a project.
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

### .NET — `ITranslationMemoryClient`

```csharp
Task UpdateTranslationMemoryAsync(string translationMemoryId);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `string` | yes |

### Java — `TranslationMemoryApi`

```java
// PUT /translation-memory/{translationMemoryId}
void updateTranslationMemory(String translationMemoryId, TranslationMemoryUpdateRequest translationMemoryUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `String` | yes |
| `translationMemoryUpdateRequest` | `TranslationMemoryUpdateRequest` | no |