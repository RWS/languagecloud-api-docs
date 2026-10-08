# Trados Cloud Platform API List Task Types

List Task Types ListTaskTypes GET /task-types

- Friendly name: List Task Types
- Operation ID: ListTaskTypes
- HTTP Method: GET
- Path: /task-types

Retrieves all the task types in an account.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **key** (query, array) - optional: Filter by keys.
- **automatic** (query, boolean) - optional: Filter by automatic or human tasks.
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
- Schema: list-task-types-response (see model section below)

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
* "requestedRangeNotSatisfiable":  The requested entity or one of its dependencies attempted to retrieve data outside the allowed range. Skip+Top might be outside the supported range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-task-types-response
<a id="list-task-types-response"></a>

```
type: object
  description: A response for the List Task types endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/task-type
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

## Model: task-type
<a id="task-type"></a>

```
type: object
  description: Task type.
properties:
  - id: type: string
  - key: type: string
  - name: type: string
  - apiInternalId: type: string
  - description: type: string
  - automatic: type: boolean
  - scope: type: string enum: [file, targetLanguage, batch, vendorOrder, task]
  - outcomes: type: array
    items:
      $ref: #/components/schemas/task-type-outcome
  - configurationDefinitions: type: array
    items:
      $ref: #/components/schemas/task-type-configuration-definition
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

## Model: task-type-outcome
<a id="task-type-outcome"></a>

```
type: object
  description: The task type outcome.
properties:
  - name: type: string
  - description: type: string
  - default: type: boolean
```

## Model: task-type-configuration-definition
<a id="task-type-configuration-definition"></a>

```
type: object
  description: Describes a single configurable option for a task type.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - dataType: type: string enum: [integer, boolean, string]
  - optional: type: boolean
  - defaultValue: type: object
      description: The default value applied when no value is explicitly set. The type matches `dataType`. May be `null` when no default is defined.
  - options: type: array
    items:
      type: string
  - constraints: type: array
    items:
      $ref: #/components/schemas/task-type-configuration-constraint
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

## Model: task-type-configuration-constraint
<a id="task-type-configuration-constraint"></a>

```
type: object
  description: A validation constraint applied to a task type configuration value.
properties:
  - type: type: string enum: [minValue, maxValue]
  - value: type: object
      description: The constraint threshold. Type matches the parent configuration option's `dataType`.
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

### .NET — `ITaskTypeClient`

```csharp
Task<ListTaskTypesResponse> ListTaskTypesAsync(IEnumerable<string> key, bool? automatic = null, int? top = null, int? skip = null, IEnumerable<string> location, LocationStrategy? locationStrategy = null, string sort = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `key` | `IEnumerable<string>` | yes |
| `automatic` | `bool` | no |
| `top` | `int` | no |
| `skip` | `int` | no |
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |
| `sort` | `string` | no |
| `fields` | `string` | no |

### Java — `TaskTypeApi`

```java
// GET /task-types?key={key}&automatic={automatic}&top={top}&skip={skip}&location={location}&locationStrategy={locationStrategy}&sort={sort}&fields={fields}
ListTaskTypesResponse listTaskTypes(List<String> key, Boolean automatic, Integer top, Integer skip, List<String> location, String locationStrategy, String sort, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `key` | `List<String>` | no |
| `automatic` | `Boolean` | no |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |
| `sort` | `String` | no |
| `fields` | `String` | no |