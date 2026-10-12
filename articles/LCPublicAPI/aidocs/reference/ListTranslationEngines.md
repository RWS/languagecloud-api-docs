# Trados Cloud Platform API List Translation Engines

List Translation Engines ListTranslationEngines GET /translation-engines

- Friendly name: List Translation Engines
- Operation ID: ListTranslationEngines
- HTTP Method: GET
- Path: /translation-engines

Retrieves all the translation engines in an account.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.
- **location** (query, array) - optional: The identifiers of the resource folders. You can control the behavior by using the 'locationStrategy'. 
- **locationStrategy** (query, string) - optional: Options: <br> - `location`: all the resources located strictly in the folders from the 'location' parameter (default); <br> - `lineage`: all the resources located in the folders specified in the 'location' parameter, as well as the subfolders; <br> - `bloodline`: all the resources located in the folders specified in the 'location' parameter, as well as the ancestor folders; <br> - `genealogy`: the resources located in the folders specified in the 'location' parameter together with subfolders and ancestors.
- **sort** (query, string) - optional: A comma separated list of fields used to sort the resources in the response. Each field can have a unary negative to imply descending sort order.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-translation-engines-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 416

Error codes:
* "requestedRangeNotSatisfiable":  The requested entity or one of its dependencies attempted to retrieve data outside the allowed range. Skip+Top might be outside the supported range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-translation-engines-response
<a id="list-translation-engines-response"></a>

```
type: object
  description: A response for the List Translation Engines endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/translation-engine
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

## Model: translation-engine
<a id="translation-engine"></a>

```
type: object
  description: Translation Engine resource. (Not available for List Projects endpoint)
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - definition: $ref: #/components/schemas/translation-engine-definition
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

## Model: folder-v2
<a id="folder-v2"></a>

```
type: object
  description: Folder used for resource storage.
properties:
  - id: type: string
  - name: type: string
  - hasParent: type: boolean
  - path: type: array
    items:
      $ref: #/components/schemas/folder-path
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

## Model: folder-path
<a id="folder-path"></a>

```
type: object
  description: Path of a folder.
properties:
  - id: type: string
  - name: type: string
  - location: type: string
  - hasParent: type: boolean
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
Task<ListTranslationEnginesResponse> ListTranslationEnginesAsync(int? top = null, int? skip = null, IEnumerable<string> location, LocationStrategy? locationStrategy = null, string sort = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `int` | no |
| `skip` | `int` | no |
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |
| `sort` | `string` | no |
| `fields` | `string` | no |

### Java — `TranslationEngineApi`

```java
// GET /translation-engines?top={top}&skip={skip}&location={location}&locationStrategy={locationStrategy}&sort={sort}&fields={fields}
ListTranslationEnginesResponse listTranslationEngines(Integer top, Integer skip, List<String> location, String locationStrategy, String sort, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |
| `sort` | `String` | no |
| `fields` | `String` | no |