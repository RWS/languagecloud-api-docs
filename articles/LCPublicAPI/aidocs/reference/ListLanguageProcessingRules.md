# Trados Cloud Platform API List Language Processing Rules

List Language Processing Rules ListLanguageProcessingRules GET /language-processing-rules

- Friendly name: List Language Processing Rules
- Operation ID: ListLanguageProcessingRules
- HTTP Method: GET
- Path: /language-processing-rules

Returns a list of Language Processing Rules.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.
- **sort** (query, string) - optional: A comma separated list of fields used to sort the resources in the response. Each field can have a unary negative to imply descending sort order.
- **location** (query, array) - optional: The identifiers of the resource folders. You can control the behavior by using the 'locationStrategy'. 
- **locationStrategy** (query, string) - optional: Options: <br> - `location`: all the resources located strictly in the folders from the 'location' parameter (default); <br> - `lineage`: all the resources located in the folders specified in the 'location' parameter, as well as the subfolders; <br> - `bloodline`: all the resources located in the folders specified in the 'location' parameter, as well as the ancestor folders; <br> - `genealogy`: the resources located in the folders specified in the 'location' parameter together with subfolders and ancestors.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-language-processing-rules (see model section below)

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
* "requestedRangeNotSatisfiable":  The requested entity or one of it's dependencies attempted to retrieve data outside the allowed range. Skip+Top might be outside the supported range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-language-processing-rules
<a id="list-language-processing-rules"></a>

```
type: object
properties:
  - items: type: array
    items:
      $ref: #/components/schemas/language-processing-rule
  - itemCount: type: string
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

## Model: language-processing-rule
<a id="language-processing-rule"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
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

### .NET — `ILanguageProcessingClient`

```csharp
Task<ListLanguageProcessingRulesResponse> ListLanguageProcessingRulesAsync(int? top = null, int? skip = null, string sort = null, IEnumerable<string> location, LocationStrategy? locationStrategy = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `int` | no |
| `skip` | `int` | no |
| `sort` | `string` | no |
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |
| `fields` | `string` | no |

### Java — `LanguageProcessingApi`

```java
// GET /language-processing-rules?top={top}&skip={skip}&sort={sort}&location={location}&locationStrategy={locationStrategy}&fields={fields}
ListLanguageProcessingRules listLanguageProcessingRules(Integer top, Integer skip, String sort, List<String> location, String locationStrategy, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `sort` | `String` | no |
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |
| `fields` | `String` | no |