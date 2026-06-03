# Trados Cloud Platform API List Custom Field Definitions

List Custom Field Definitions ListCustomFields GET /custom-field-definitions

- Friendly name: List Custom Field Definitions
- Operation ID: ListCustomFields
- HTTP Method: GET
- Path: /custom-field-definitions

Retrieves a list of all the custom field definitions.

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
- Schema: list-custom-field-definitions-response (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the "name" field on the error response.

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


## Model: list-custom-field-definitions-response
<a id="list-custom-field-definitions-response"></a>

```
type: object
  description: A response for the List Custom Field Definitions endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/custom-field-definition
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
Task<ListCustomFieldsResponse> ListCustomFieldsAsync(int? top = null, int? skip = null, IEnumerable<string> location, LocationStrategy? locationStrategy = null, string sort = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `int` | no |
| `skip` | `int` | no |
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |
| `sort` | `string` | no |
| `fields` | `string` | no |

### Java — `CustomFieldApi`

```java
// GET /custom-field-definitions?top={top}&skip={skip}&location={location}&locationStrategy={locationStrategy}&sort={sort}&fields={fields}
ListCustomFieldDefinitionsResponse listCustomFields(Integer top, Integer skip, List<String> location, String locationStrategy, String sort, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |
| `sort` | `String` | no |
| `fields` | `String` | no |