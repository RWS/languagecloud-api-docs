# Trados Cloud Platform API List LLM Configurations

List LLM Configurations ListLlmConfigurations GET /connected-ai/llm-configurations

- Friendly name: List LLM Configurations
- Operation ID: ListLlmConfigurations
- HTTP Method: GET
- Path: /connected-ai/llm-configurations

List the account configured Large Language Models.

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: list-llm-configurations-response (see model section below)

### 400

"invalid": Invalid input in the query parameter mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-llm-configurations-response
<a id="list-llm-configurations-response"></a>

```
type: object
  description: A response for the List LLM Configurations endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/llm-configuration-response
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

## Model: llm-configuration-response
<a id="llm-configuration-response"></a>

```
type: object
  description: The LLM configuration details
properties:
  - id: type: string
  - description: type: string
  - model: type: string
  - type: type: string enum: [azureOpenAI, awsBedrock]
  - isDefault: type: boolean
  - isActive: type: boolean
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

### .NET — `IConnectedAIClient`

```csharp
Task<ListLlmConfigurationsResponse> ListLlmConfigurationsAsync(string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `string` | no |

### Java — `ConnectedAiApi`

```java
// GET /connected-ai/llm-configurations?fields={fields}
ListLlmConfigurationsResponse listLlmConfigurations(String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `String` | no |