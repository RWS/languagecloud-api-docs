# Trados Cloud Platform API Update Translation Unit

Update Translation Unit TranslationsUpdate PUT /translations/translation-unit

- Friendly name: Update Translation Unit
- Operation ID: TranslationsUpdate
- HTTP Method: PUT
- Path: /translations/translation-unit

Updates a translation unit. The system identifies matching translation units in the TM based on the provided BCM [fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html). 

 For detailed concepts and examples see the [Translation API](../docs/translations/Translations.html) page.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: translation-update-request (see model section below)

## Response

### 200

Ok

- Content: application/json
- Schema: translation-unit-add-update-response (see model section below)

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


## Model: translation-update-request
<a id="translation-update-request"></a>

```
type: object
properties:
  - input: $ref: #/components/schemas/translation-tu-update-input-request
  - definition: $ref: #/components/schemas/translation-update-definition
  - settings: $ref: #/components/schemas/translation-update-settings
```

## Model: translation-unit-add-update-response
<a id="translation-unit-add-update-response"></a>

```
type: object
properties:
  - success: type: boolean
  - insights: type: array
    items:
      $ref: #/components/schemas/translation-unit-insight-model
  - errorInsights: type: array
    items:
      $ref: #/components/schemas/translation-error-detail-response
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

## Model: translation-tu-update-input-request
<a id="translation-tu-update-input-request"></a>

```
type: object
properties:
  - content: type: string
```

## Model: translation-update-definition
<a id="translation-update-definition"></a>

```
type: object
properties:
  - translationEngineId: type: string
```

## Model: translation-update-settings
<a id="translation-update-settings"></a>

```
type: object
properties:
  - fields: type: array
    items:
      $ref: #/components/schemas/translation-update-field
```

## Model: translation-unit-insight-model
<a id="translation-unit-insight-model"></a>

```
type: object
  description: Detailed insight information about the processed translation unit.
properties:
  - resourceId: type: string
  - translationHash: type: string
  - action: type: string enum: [discard, add, merge, overwrite, error, delete]
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

## Model: translation-update-field
<a id="translation-update-field"></a>

```
type: object
  description: 
properties:
  - name: type: string
  - values: type: array
    items:
      type: string
```

## SDK

### .NET — `ITranslationClient`

```csharp
Task TranslationsUpdateAsync(string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `string` | no |

### Java — `TranslationApi`

```java
// PUT /translations/translation-unit?fields={fields}
TranslationUnitAddUpdateResponse translationsUpdate(String fields, TranslationUpdateRequest translationUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `String` | no |
| `translationUpdateRequest` | `TranslationUpdateRequest` | no |