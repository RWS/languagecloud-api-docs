# Trados Cloud Platform API List Termbase Entry Templates

List Termbase Entry Templates ListTermbaseEntryTemplates GET /termbases/{termbaseId}/entry-templates

- Friendly name: List Termbase Entry Templates
- Operation ID: ListTermbaseEntryTemplates
- HTTP Method: GET
- Path: /termbases/{termbaseId}/entry-templates

Retrieves the entry templates that are linked to the termbase.

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

OK

- Content: application/json
- Schema: list-termbase-entry-templates-response (see model section below)

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
* "forbidden": - The authenticated user is not allowed to read the resource.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-termbase-entry-templates-response
<a id="list-termbase-entry-templates-response"></a>

```
type: object
  description: The termbase entry templates response.
properties:
  - items: type: array
    items:
      $ref: #/components/schemas/termbase-entry-template
  - itemCount: type: integer
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

## Model: termbase-entry-template
<a id="termbase-entry-template"></a>

```
type: object
  description: The termbase entry template.
properties:
  - id: type: string
  - name: type: string
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

### .NET — `ITermbaseEntryTemplatesClient`

```csharp
Task<ListTermbaseEntryTemplatesResponse> ListTermbaseEntryTemplatesAsync(string termbaseId, string fields = null, int? top = null, int? skip = null);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `fields` | `string` | no |
| `top` | `int` | no |
| `skip` | `int` | no |

### Java — `TermbaseEntryTemplatesApi`

```java
// GET /termbases/{termbaseId}/entry-templates?top={top}&skip={skip}&fields={fields}
ListTermbaseEntryTemplatesResponse listTermbaseEntryTemplates(String termbaseId, Integer top, Integer skip, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `fields` | `String` | no |