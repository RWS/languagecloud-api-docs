# Trados Cloud Platform API Create Termbase Template

Create Termbase Template CreateTermbaseTemplate POST /termbase-templates

- Friendly name: Create Termbase Template
- Operation ID: CreateTermbaseTemplate
- HTTP Method: POST
- Path: /termbase-templates

Creates a new termbase template.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: termbase-template-create-request (see model section below)

## Response

### 201

Created

- Content: application/json
- Schema: termbase-template (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the “name” field on the error response.
* "empty": Empty mandatory value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.
* "duplicate": The field name must be unique within the list.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to create a termbase template in the specified location.
* "benefitNotAvailable": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": - The specified location was not found.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": There is already a termbase template with the same name.

- Content: application/json
- Schema: error-response (see model section below)


## Model: termbase-template-create-request
<a id="termbase-template-create-request"></a>

```
type: object
  description: The termbase template create request.
properties:
  - name: type: string
  - description: type: string
  - copyright: type: string
  - location: type: string
  - languages: type: array
    items:
      $ref: #/components/schemas/language-request
  - fields: type: array
    items:
      $ref: #/components/schemas/termbase-field-create-request
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

## Model: language-request
<a id="language-request"></a>

```
type: object
properties:
  - languageCode: type: string
```

## Model: termbase-field-create-request
<a id="termbase-field-create-request"></a>

```
type: object
  description: The termbase field request.

If dataType is `picklist` and pickListValues array is empty `allowCustomValues` must be true.
properties:
  - name: type: string
  - description: type: string
  - level: type: string enum: [entry, language, term]
  - dataType: type: string enum: [text, double, date, picklist, boolean]
  - pickListValues: type: array
    items:
      type: string
  - allowCustomValues: type: boolean
  - allowMultiple: type: boolean
  - isMandatory: type: boolean
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

## SDK

### .NET — `ITermbaseTemplateClient`

```csharp
Task<TermbaseTemplate> CreateTermbaseTemplateAsync(string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `string` | no |

### Java — `TermbaseTemplateApi`

```java
// POST /termbase-templates?fields={fields}
TermbaseTemplate createTermbaseTemplate(String fields, TermbaseTemplateCreateRequest termbaseTemplateCreateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `String` | no |
| `termbaseTemplateCreateRequest` | `TermbaseTemplateCreateRequest` | no |