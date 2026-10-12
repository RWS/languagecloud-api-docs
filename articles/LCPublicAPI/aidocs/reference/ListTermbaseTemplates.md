# Trados Cloud Platform API List Termbase Templates

List Termbase Templates ListTermbaseTemplates GET /termbase-templates

- Friendly name: List Termbase Templates
- Operation ID: ListTermbaseTemplates
- HTTP Method: GET
- Path: /termbase-templates

List termbase templates.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **location** (query, array) - optional: The identifiers of the resource folders. 
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.
- **type** (query, string) - optional: The type of the termbase template to retrieve. If not specified, both types will be returned
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: list-termbase-templates-response (see model section below)

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
* "forbidden": - The authenticated user is not allowed to read the resources.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 416

Error codes:
* "requestedRangeNotSatisfiable":  The requested entity or one of it's dependencies attempted to retrieve data outside the allowed range. Skip+Top might be outside the supported range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-termbase-templates-response
<a id="list-termbase-templates-response"></a>

```
type: object
  description: The termbase templates response.
properties:
  - items: type: array
    items:
      $ref: #/components/schemas/termbase-template
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

## Model: termbase-template
<a id="termbase-template"></a>

```
type: object
  description: The termbase template.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - copyright: type: string
  - location: $ref: #/components/schemas/folder-v2
  - createdAt: type: string (format: date-time)
  - lastModifiedAt: type: string (format: date-time)
  - type: type: string enum: [system, userDefined]
  - languages: type: array
    items:
      $ref: #/components/schemas/language
  - fields: type: array
    items:
      $ref: #/components/schemas/termbase-field
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

## Model: termbase-field
<a id="termbase-field"></a>

```
type: object
  description: The termbase field.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - type: type: string enum: [system, userDefined]
  - level: type: string enum: [entry, language, term]
  - dataType: type: string enum: [text, double, date, picklist, boolean]
  - pickListValues: type: array
    items:
      type: string
  - allowCustomValues: type: boolean
  - allowMultiple: type: boolean
  - isMandatory: type: boolean
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

## SDK

### .NET — `ITermbaseTemplateClient`

```csharp
Task<ListTermbaseTemplatesResponse> ListTermbaseTemplatesAsync(IEnumerable<string> location, string fields = null, Type2? type = null, int? top = null, int? skip = null);
```

| Parameter | Type | Required |
|---|---|---|
| `location` | `IEnumerable<string>` | yes |
| `fields` | `string` | no |
| `type` | `Type2` | no |
| `top` | `int` | no |
| `skip` | `int` | no |

### Java — `TermbaseTemplateApi`

```java
// GET /termbase-templates?location={location}&fields={fields}&type={type}&top={top}&skip={skip}
ListTermbaseTemplatesResponse listTermbaseTemplates(List<String> location, String fields, String type, Integer top, Integer skip);
```

| Parameter | Type | Required |
|---|---|---|
| `location` | `List<String>` | no |
| `fields` | `String` | no |
| `type` | `String` | no |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |