# Trados Cloud Platform API Lookup

Lookup TranslationsLookup POST /translations/lookup

- Friendly name: Lookup
- Operation ID: TranslationsLookup
- HTTP Method: POST
- Path: /translations/lookup

Translates a phrase in plain text or a BCM fragment containing a single segment. The translated content will be returned as a BCM [fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html) or [term](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Skeleton.Term.html). 

 For detailed concepts and examples see the [Translation API](../docs/translations/Translations.html) page.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

Learn more about Translation Memory standard penalties [here](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/trados-tm-penalties-1159224).
<br>
Learn more about Translation Unit status penalties [here](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/editing-project-tm-and-verification-settings-800732).
- Content: application/json

- Schema: translation-search-request (see model section below)

## Response

### 200

OK

- Content: application/json
- Schema: translation-search-response (see model section below)

### 400

Error codes: 

  * "empty": Empty value for variable mentioned in the "name" field on the error response. 

  * "invalid": Invalid input mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Unauthorized to use translation engine.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": - translation engine not found.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-search-request
<a id="translation-search-request"></a>

```
type: object
properties:
  - input: $ref: #/components/schemas/translation-lookup-input-request
  - languageDirection: $ref: #/components/schemas/language-direction-general-request
  - definition: $ref: #/components/schemas/translation-definition
  - settings: $ref: #/components/schemas/translation-search-settings
```

## Model: translation-search-response
<a id="translation-search-response"></a>

```
type: object
properties:
  - translations: type: array
    items:
      $ref: #/components/schemas/translation
  - appliedResourcesStatus: type: array
    items:
      $ref: #/components/schemas/translation-applied-resource-status
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

## Model: translation-lookup-input-request
<a id="translation-lookup-input-request"></a>

```
type: object
  description: The translation input.
properties:
  - content: type: string
  - contentType: type: string enum: [text, bcmFragment]
```

## Model: language-direction-general-request
<a id="language-direction-general-request"></a>

```
type: object
  description: The language directions model used for creating or updating a resource.
properties:
  - sourceLanguage: $ref: #/components/schemas/source-language-request
  - targetLanguage: $ref: #/components/schemas/target-language-request
```

## Model: translation-definition
<a id="translation-definition"></a>

```
type: object
properties:
  - translationEngineId: type: string
```

## Model: translation-search-settings
<a id="translation-search-settings"></a>

```
type: object
properties:
  - translationMemory: $ref: #/components/schemas/translation-search-settings-tm
```

## Model: translation
<a id="translation"></a>

```
type: object
properties:
  - translationProposal: type: string
  - resourceType: $ref: #/components/schemas/translation-resource-type
  - sourceLocation: $ref: #/components/schemas/translation-source-locations
```

## Model: translation-applied-resource-status
<a id="translation-applied-resource-status"></a>

```
type: object
properties:
  - resourceId: type: string
  - resourceType: $ref: #/components/schemas/translation-resource-type
  - status: type: string enum: [successful, unsuccessful]
  - message: type: string
  - translationErrors: type: array
    items:
      $ref: #/components/schemas/translation-error-detail-response
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

## Model: translation-search-settings-tm
<a id="translation-search-settings-tm"></a>

```
type: object
properties:
  - minimumMatchValue: type: integer
  - penalties: $ref: #/components/schemas/translation-search-TM-penalties
```

## Model: translation-resource-type
<a id="translation-resource-type"></a>

```
type: string enum: [TM, MT, TB]
```

## Model: translation-source-locations
<a id="translation-source-locations"></a>

```
type: array
items:
  $ref: #/components/schemas/translation-source-location
```

## Model: translation-error-detail-response
<a id="translation-error-detail-response"></a>

```
type: object
  description: Translation error details response properties.
properties:
  - name: type: string
  - code: type: string
  - value: type: string
```

## Model: translation-search-TM-penalties
<a id="translation-search-TM-penalties"></a>

```
type: object
properties:
  - standardPenalties: $ref: #/components/schemas/translation-search-standard-penalties
  - translationUnitStatusPenalties: $ref: #/components/schemas/translation-search-unit-status-penalties
```

## Model: translation-source-location
<a id="translation-source-location"></a>

```
type: object
properties:
  - start: type: integer
  - length: type: integer
```

## Model: translation-search-standard-penalties
<a id="translation-search-standard-penalties"></a>

```
type: object
  description: 
properties:
  - missingFormatting: type: integer
  - differentFormatting: type: integer
  - multipleTranslations: type: integer
  - autoLocalization: type: integer
  - textReplacement: type: integer
  - alignment: type: integer
  - characterWidthDifference: type: integer
```

## Model: translation-search-unit-status-penalties
<a id="translation-search-unit-status-penalties"></a>

```
type: object
  description: The penalties to apply depending on the status of the translation unit.
properties:
  - translated: type: integer
  - translationRejected: type: integer
  - translationApproved: type: integer
  - signOffRejected: type: integer
  - signOff: type: integer
  - notTranslated: type: integer
  - draft: type: integer
```

## SDK

### .NET — `ITranslationClient`

```csharp
Task TranslationsLookupAsync(TranslationSearchRequest body, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `body` | `TranslationSearchRequest` | yes |
| `fields` | `string` | no |

### Java — `TranslationApi`

```java
// POST /translations/lookup?fields={fields}
TranslationSearchResponse translationsLookup(String fields, TranslationSearchRequest translationSearchRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `String` | no |
| `translationSearchRequest` | `TranslationSearchRequest` | no |