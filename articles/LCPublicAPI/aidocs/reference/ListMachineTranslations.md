# Trados Cloud Platform API List Machine Translations

List Machine Translations ListMachineTranslations GET /machine-translation

- Friendly name: List Machine Translations
- Operation ID: ListMachineTranslations
- HTTP Method: GET
- Path: /machine-translation

Retrieves a list of machine translations that can be used in a translation engine.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **sourceLanguage** (query, string) - required: Language code expressed as generic language (example: "en") or specific language (example: "en-US")
- **targetLanguage** (query, array) - required: List of language codes separated by comma, values can be generic language code or specific language code.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-machine-translations-response (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-machine-translations-response
<a id="list-machine-translations-response"></a>

```
type: object
  description: A response for the List Machine Translations endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/machine-translation
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

## Model: machine-translation
<a id="machine-translation"></a>

```
type: object
  description: Machine translation resource.
properties:
  - id: type: string
  - provider: type: string
  - type: type: string
  - systemId: type: string
  - modelSourceLanguage: type: string
  - modelTargetLanguage: type: string
  - matchingSourceLanguage: type: string
  - matchingTargetLanguages: type: array
    items:
      type: string
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

### .NET — `IMachineTranslationClient`

```csharp
Task<ListMachineTranslationsResponse> ListMachineTranslationsAsync(string sourceLanguage, IEnumerable<string> targetLanguage);
```

| Parameter | Type | Required |
|---|---|---|
| `sourceLanguage` | `string` | yes |
| `targetLanguage` | `IEnumerable<string>` | yes |

### Java — `MachineTranslationApi`

```java
// GET /machine-translation?sourceLanguage={sourceLanguage}&targetLanguage={targetLanguage}
ListMachineTranslationsResponse listMachineTranslations(String sourceLanguage, List<String> targetLanguage);
```

| Parameter | Type | Required |
|---|---|---|
| `sourceLanguage` | `String` | yes |
| `targetLanguage` | `List<String>` | yes |