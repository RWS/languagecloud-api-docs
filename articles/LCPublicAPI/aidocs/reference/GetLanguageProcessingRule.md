# Trados Cloud Platform API Get Language Processing Rule

Get Language Processing Rule GetLanguageProcessingRule GET /language-processing-rules/{languageProcessingRuleId}

- Friendly name: Get Language Processing Rule
- Operation ID: GetLanguageProcessingRule
- HTTP Method: GET
- Path: /language-processing-rules/{languageProcessingRuleId}

Returns a Language Processing Rule by identifier.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: language-processing-rule (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

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
* "notFound": The resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: language-processing-rule
<a id="language-processing-rule"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
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

### .NET — `ILanguageProcessingClient`

```csharp
Task<LanguageProcessingRule> GetLanguageProcessingRuleAsync(string languageProcessingRuleId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `languageProcessingRuleId` | `string` | yes |
| `fields` | `string` | no |

### Java — `LanguageProcessingApi`

```java
// GET /language-processing-rules/{languageProcessingRuleId}?fields={fields}
LanguageProcessingRule getLanguageProcessingRule(String languageProcessingRuleId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `languageProcessingRuleId` | `String` | yes |
| `fields` | `String` | no |