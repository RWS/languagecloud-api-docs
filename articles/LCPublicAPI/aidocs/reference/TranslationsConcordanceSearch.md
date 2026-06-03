# Trados Cloud Platform API Concordance

Concordance TranslationsConcordanceSearch POST /translations/concordance

- Friendly name: Concordance
- Operation ID: TranslationsConcordanceSearch
- HTTP Method: POST
- Path: /translations/concordance

Performs a concordance search for a given text within the TM linked to the specified translation engine. The translated content will be returned as a BCM [fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html) or [term](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Skeleton.Term.html). 

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

- Schema: translation-concordance-search-request (see model section below)

## Response

### 200

OK.

- Content: application/json
- Schema: translation-concordance-search-response (see model section below)

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


## Model: translation-concordance-search-request
<a id="translation-concordance-search-request"></a>

```
type: object
properties:
  - input: $ref: #/components/schemas/translation-concordance-input-request
  - languageDirection: $ref: #/components/schemas/language-direction-general-request
  - definition: $ref: #/components/schemas/translation-concordance-search-definition
  - targetOnly: type: boolean
  - settings: $ref: #/components/schemas/concordance-search-settings
```

## Model: translation-concordance-search-response
<a id="translation-concordance-search-response"></a>

```
type: object
properties:
  - translations: type: array
    items:
      $ref: #/components/schemas/translation-concordance
  - appliedResourcesStatus: type: array
    items:
      $ref: #/components/schemas/translation-concordance-search-applied-resource-status
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

## Model: translation-concordance-input-request
<a id="translation-concordance-input-request"></a>

```
type: object
properties:
  - content: type: string
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

## Model: translation-concordance-search-definition
<a id="translation-concordance-search-definition"></a>

```
type: object
properties:
  - translationEngineId: type: string
```

## Model: concordance-search-settings
<a id="concordance-search-settings"></a>

```
type: object
properties:
  - translationMemory: $ref: #/components/schemas/concordance-search-settings-tm
```

## Model: translation-concordance
<a id="translation-concordance"></a>

```
type: object
properties:
  - translationProposal: type: string
  - resourceType: $ref: #/components/schemas/translation-concordance-resource-type
```

## Model: translation-concordance-search-applied-resource-status
<a id="translation-concordance-search-applied-resource-status"></a>

```
type: object
properties:
  - resourceId: type: string
  - resourceType: type: string enum: [TM]
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

## Model: concordance-search-settings-tm
<a id="concordance-search-settings-tm"></a>

```
type: object
properties:
  - minimumMatchValue: type: integer
  - penalties: $ref: #/components/schemas/concordance-search-TM-penalties
```

## Model: translation-concordance-resource-type
<a id="translation-concordance-resource-type"></a>

```
type: string enum: [TM]
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

## Model: concordance-search-TM-penalties
<a id="concordance-search-TM-penalties"></a>

```
type: object
properties:
  - standardPenalties: $ref: #/components/schemas/translation-concordance-search-standard-penalties
  - translationUnitStatusPenalties: $ref: #/components/schemas/translation-concordance-search-unit-status-penalties
```

## Model: translation-concordance-search-standard-penalties
<a id="translation-concordance-search-standard-penalties"></a>

```
type: object
  description: 
properties:
  - alignment: type: integer
  - characterWidthDifference: type: integer
```

## Model: translation-concordance-search-unit-status-penalties
<a id="translation-concordance-search-unit-status-penalties"></a>

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
Task TranslationsConcordanceSearchAsync(TranslationConcordanceSearchRequest body, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `body` | `TranslationConcordanceSearchRequest` | yes |
| `fields` | `string` | no |

### Java — `TranslationApi`

```java
// POST /translations/concordance?fields={fields}
TranslationConcordanceSearchResponse translationsConcordanceSearch(String fields, TranslationConcordanceSearchRequest translationConcordanceSearchRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `String` | no |
| `translationConcordanceSearchRequest` | `TranslationConcordanceSearchRequest` | no |