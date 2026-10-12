# Trados Cloud Platform API Get Field Template

Get Field Template GetFieldTemplate GET /translation-memory/field-templates/{fieldTemplateId}

- Friendly name: Get Field Template
- Operation ID: GetFieldTemplate
- HTTP Method: GET
- Path: /translation-memory/field-templates/{fieldTemplateId}

Get a single Field Template by identifier.

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
- Schema: translation-memory-field-template (see model section below)

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


## Model: translation-memory-field-template
<a id="translation-memory-field-template"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - fieldDefinitions: type: array
    items:
      $ref: #/components/schemas/translation-memory-field
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

## Model: translation-memory-field
<a id="translation-memory-field"></a>

```
type: object
  description: The unique identifier of the field.
properties:
  - id: type: string
  - name: type: string
  - type: type: string enum: [unknown, singleString, multipleString, dateTime, singlePicklist, multiplePicklist, integer]
  - values: type: array
    items:
      $ref: #/components/schemas/translation-memory-field-value
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

## Model: translation-memory-field-value
<a id="translation-memory-field-value"></a>

```
type: object
properties:
  - id: type: string
  - value: type: string
```

## SDK

### .NET — `ITranslationMemoryClient`

```csharp
Task<FieldTemplate> GetFieldTemplateAsync(string fieldTemplateId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fieldTemplateId` | `string` | yes |
| `fields` | `string` | no |

### Java — `TranslationMemoryApi`

```java
// GET /translation-memory/field-templates/{fieldTemplateId}?fields={fields}
TranslationMemoryFieldTemplate getFieldTemplate(String fieldTemplateId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `fieldTemplateId` | `String` | yes |
| `fields` | `String` | no |