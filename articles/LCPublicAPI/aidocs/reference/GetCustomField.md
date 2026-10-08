# Trados Cloud Platform API Get Custom Field Definition

Get Custom Field Definition GetCustomField GET /custom-field-definitions/{customFieldDefinitionId}

- Friendly name: Get Custom Field Definition
- Operation ID: GetCustomField
- HTTP Method: GET
- Path: /custom-field-definitions/{customFieldDefinitionId}

Retrieves a Custom Field by identifier.

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
- Schema: custom-field-definition (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to get the custom field definition.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: custom-field-definition
<a id="custom-field-definition"></a>

```
type: object
  description: The Custom Field definition.
properties:
  - id: type: string
  - name: type: string
  - key: type: string
  - description: type: string
  - type: type: string enum: [long, double, boolean, date, string, checkbox, longtext, picklist, multiSelectPicklist]
  - pickListOptions: type: array
    items:
      type: string
  - resourceType: type: string enum: [project, customer, vendor, vendorOrderTemplate]
  - isReadOnly: type: boolean
  - defaultValue: type: string
  - isMandatory: type: boolean
  - location: $ref: #/components/schemas/folder-v2
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

### .NET — `ICustomFieldClient`

```csharp
Task<CustomField> GetCustomFieldAsync(string customFieldDefinitionId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `customFieldDefinitionId` | `string` | yes |
| `fields` | `string` | no |

### Java — `CustomFieldApi`

```java
// GET /custom-field-definitions/{customFieldDefinitionId}?fields={fields}
CustomFieldDefinition getCustomField(String customFieldDefinitionId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `customFieldDefinitionId` | `String` | yes |
| `fields` | `String` | no |