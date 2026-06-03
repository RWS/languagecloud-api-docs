# Trados Cloud Platform API Update Translation Engine

Update Translation Engine UpdateTranslationEngine PUT /translation-engines/{translationEngineId}

- Friendly name: Update Translation Engine
- Operation ID: UpdateTranslationEngine
- HTTP Method: PUT
- Path: /translation-engines/{translationEngineId}

Updates a translation engine. 

It can be used to update a stand-alone translation engine or a project's translation engine. 
The identifier of a project's translation engine can be retrieved only by calling [Get Project](#/operations/GetProject) endpoint.

Pay special attention that some properties can not be changed for a project's translation engine. These include: name, description, definition.languageProcessingId, and language pairs can not be added/removed from definition.languagePairDefinitions. 

Pay special attention to how [updating](../docs/Updating-data-with-PUT.html) works.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body


- Content: application/json

- Schema: translation-engine-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* "empty": Empty input in the update translation engine model. Check error details.
* "invalidLanguage": Invalid language code used in language-pair

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to update the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The translation memory could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:

  * "updateNotAllowed": Property specified in error response can not be updated because the translation engine provided is a copy assigned to a project.
* "duplicate": Duplicate resources found for the language pair specified in the error details.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-engine-update-request
<a id="translation-engine-update-request"></a>

```
type: object
  description: Translation Engine resource update request
properties:
  - name: type: string
  - description: type: string
  - definition: $ref: #/components/schemas/translation-engine-definition
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

## Model: translation-engine-definition
<a id="translation-engine-definition"></a>

```
type: object
  description: The definition of a translation engine.
properties:
  - languageProcessingRuleId: type: string
  - languagePairDefinitions: type: array
    items:
      $ref: #/components/schemas/translation-engine-definition-language-pair
  - sequence: $ref: #/components/schemas/remote-translation-engine-sequence
  - adjacentLanguagePenalty: type: integer
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

## Model: translation-engine-definition-language-pair
<a id="translation-engine-definition-language-pair"></a>

```
type: object
properties:
  - languagePair: $ref: #/components/schemas/language-pair
  - resources: type: array
    items:
      $ref: #/components/schemas/language-pair-resource
  - adjacentLanguagePairs: type: array
    items:
      $ref: #/components/schemas/language-pair
```

## Model: remote-translation-engine-sequence
<a id="remote-translation-engine-sequence"></a>

```
<schema>
  title: Translation Engine Sequence
  description: Lists of IDs for Translation Memories, Termbases, Machine Translations and Large Language Models, in order of their use
```

## Model: language-pair
<a id="language-pair"></a>

```
type: object
  description: 
properties:
  - source: type: string
  - target: type: string
```

## Model: language-pair-resource
<a id="language-pair-resource"></a>

```
type: object
  description: Resource describing a Translation Memory, Termbase or Machine Translation used in a Translation Engine.
properties:
  - id: type: string
  - systemId: type: string
  - type: type: string enum: [TM, MT, TB, LLM]
  - penalty: type: integer
  - lookup: type: boolean
  - concordance: type: boolean
  - update: type: boolean
  - generativeTranslation: type: boolean
  - smartReview: type: boolean
```

## SDK

### .NET — `ITranslationEngineClient`

```csharp
Task UpdateTranslationEngineAsync(string translationEngineId);
```

| Parameter | Type | Required |
|---|---|---|
| `translationEngineId` | `string` | yes |

### Java — `TranslationEngineApi`

```java
// PUT /translation-engines/{translationEngineId}
void updateTranslationEngine(String translationEngineId, TranslationEngineUpdateRequest translationEngineUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `translationEngineId` | `String` | yes |
| `translationEngineUpdateRequest` | `TranslationEngineUpdateRequest` | no |