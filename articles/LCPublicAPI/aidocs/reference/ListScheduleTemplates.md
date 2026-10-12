# Trados Cloud Platform API List Schedule Templates

List Schedule Templates ListScheduleTemplates GET /schedule-templates

- Friendly name: List Schedule Templates
- Operation ID: ListScheduleTemplates
- HTTP Method: GET
- Path: /schedule-templates

Retrieves a list of all the schedule templates in an account.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.
- **name** (query, string) - optional: Filter by name.
- **location** (query, array) - optional: The identifiers of the resource folders. You can control the behavior by using the 'locationStrategy'. 
- **locationStrategy** (query, string) - optional: Options: <br> - `location`: all the resources located strictly in the folders from the 'location' parameter (default); <br> - `lineage`: all the resources located in the folders specified in the 'location' parameter, as well as the subfolders; <br> - `bloodline`: all the resources located in the folders specified in the 'location' parameter, as well as the ancestor folders; <br> - `genealogy`: the resources located in the folders specified in the 'location' parameter together with subfolders and ancestors.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-schedule-templates-response (see model section below)

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


## Model: list-schedule-templates-response
<a id="list-schedule-templates-response"></a>

```
type: object
  description: A response for the List Schedule Templates endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/schedule-template
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

## Model: schedule-template
<a id="schedule-template"></a>

```
type: object
  description: Schedule Template resource
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - configurations: type: array
    items:
      $ref: #/components/schemas/schedule-template-configuration
  - projectScheduleConfiguration: $ref: #/components/schemas/schedule-template-project-configuration
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

## Model: schedule-template-configuration
<a id="schedule-template-configuration"></a>

```
type: object
  description: Schedule Template Configuration resource
properties:
  - taskTypeId: type: string
  - taskTypeName: type: string
  - schedules: type: array
    items:
      $ref: #/components/schemas/schedule-template-configuration-schedules
```

## Model: schedule-template-project-configuration
<a id="schedule-template-project-configuration"></a>

```
type: object
  description: Schedule Template Project Configuration resource
properties:
  - duration: type: integer
  - reminder: <schema>
      description: <div style="display:inline; float:right; color:#008080; margin-top:-23px; font-size:11px">default</div><div style="display: inline;">Expressed in minutes.</div>
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

## Model: schedule-template-configuration-schedules
<a id="schedule-template-configuration-schedules"></a>

```
type: object
  description: The Configuration Schedules resource.
properties:
  - scope: type: string enum: [global, sourceLanguage, languageDirection]
  - duration: type: integer
  - reminder: <schema>
      description: Expressed in minutes.
  - sourceLanguage: type: string
  - targetLanguage: type: string
```

## SDK

### .NET — `IScheduleTemplateClient`

```csharp
Task<ListScheduleTemplatesResponse> ListScheduleTemplatesAsync(int? top = null, int? skip = null, string fields = null, string name = null, IEnumerable<string> location, LocationStrategy? locationStrategy = null);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `int` | no |
| `skip` | `int` | no |
| `fields` | `string` | no |
| `name` | `string` | no |
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |

### Java — `ScheduleTemplateApi`

```java
// GET /schedule-templates?top={top}&skip={skip}&fields={fields}&name={name}&location={location}&locationStrategy={locationStrategy}
ListScheduleTemplatesResponse listScheduleTemplates(Integer top, Integer skip, String fields, String name, List<String> location, String locationStrategy);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `fields` | `String` | no |
| `name` | `String` | no |
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |