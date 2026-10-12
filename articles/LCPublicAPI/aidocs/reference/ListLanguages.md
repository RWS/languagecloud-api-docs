# Trados Cloud Platform API List Languages

List Languages ListLanguages GET /languages

- Friendly name: List Languages
- Operation ID: ListLanguages
- HTTP Method: GET
- Path: /languages

Retrieves a list of all the languages.

The supported values for language `type` filter are: "all", "specific" or "neutral".\
The "neutral" languages are the generic languages, e.g.: en -> English.\
The "specific" languages are the sub-languages, e.g.: en-150 -> English (Europe), en-us -> English (United States).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **languageCodes** (query, array) - optional: Filter by language codes.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **type** (query, string) - optional: Filter by type.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-languages-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-languages-response
<a id="list-languages-response"></a>

```
type: object
  description: A response for the List Languages endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/language
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

## Model: language
<a id="language"></a>

```
type: object
  description: The language object.
properties:
  - languageCode: type: string
  - englishName: type: string
  - direction: type: string
  - parentLanguageCode: type: string
  - defaultSpecificLanguageCode: type: string
  - isNeutral: type: boolean
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

### .NET — `ILanguageClient`

```csharp
Task<ListLanguagesResponse> ListLanguagesAsync(IEnumerable<string> languageCodes, Type? type = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `languageCodes` | `IEnumerable<string>` | yes |
| `type` | `Type` | no |
| `fields` | `string` | no |

### Java — `LanguageApi`

```java
// GET /languages?languageCodes={languageCodes}&type={type}&fields={fields}
ListLanguagesResponse listLanguages(List<String> languageCodes, String type, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `languageCodes` | `List<String>` | no |
| `type` | `String` | no |
| `fields` | `String` | no |