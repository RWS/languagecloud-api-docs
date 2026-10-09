# Trados Cloud Platform API Convert XDT to Termbase Structure

Convert XDT to Termbase Structure ConvertTermbaseTemplate POST /termbase-templates/convert-xdt

- Friendly name: Convert XDT to Termbase Structure
- Operation ID: ConvertTermbaseTemplate
- HTTP Method: POST
- Path: /termbase-templates/convert-xdt

Converts a termbase definition (XDT file) to a termbase structure that will be returned in the response.<br>
The structure will not be stored in the Trados Cloud Platform.

## Parameters

- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

For details on multipart requests please see [this article](../docs/How-to-multipart.html).
- Content: multipart/form-data

```
type: object
properties:
  - file: type: string (format: binary)
```

## Response

### 200

OK

- Content: application/json
- Schema: termbase-structure (see model section below)

### 400

Error code “invalid” in case of:
 * Empty or missing file in request
 * Not valid multipart request
 * File parameter contains other extension than the one expected by specification.

- Content: application/json
- Schema: error-response (see model section below)

### 401

Unauthorized

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)


## Model: termbase-structure
<a id="termbase-structure"></a>

```
type: object
  description: The termbase structure.
properties:
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

## SDK

### .NET — `ITermbaseTemplateClient`

```csharp
Task ConvertTermbaseTemplateAsync(string fields = null, FileParameter file);
```

| Parameter | Type | Required |
|---|---|---|
| `fields` | `string` | no |
| `file` | `FileParameter` | yes |

### Java — `TermbaseTemplateApi`

```java
// POST /termbase-templates/convert-xdt?fields={fields}
TermbaseStructure convertTermbaseTemplate(File file, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `file` | `File` | yes |
| `fields` | `String` | no |