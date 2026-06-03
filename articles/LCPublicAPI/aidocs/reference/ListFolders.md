# Trados Cloud Platform API List Folders

List Folders ListFolders GET /folders

- Friendly name: List Folders
- Operation ID: ListFolders
- HTTP Method: GET
- Path: /folders

Retrieves a list of all the folders in an account.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.
- **location** (query, array) - optional: The identifiers of the resource folders. You can control the behavior by using the 'locationStrategy'. 
- **locationStrategy** (query, string) - optional: Options: <br> - `location`: all the resources located strictly in the folders from the 'location' parameter (default); <br> - `lineage`: all the resources located in the folders specified in the 'location' parameter, as well as the subfolders; <br> - `bloodline`: all the resources located in the folders specified in the 'location' parameter, as well as the ancestor folders; <br> - `genealogy`: the resources located in the folders specified in the 'location' parameter together with subfolders and ancestors.
- **name** (query, string) - optional: Filter folders by name.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-folders-response (see model section below)

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
* "requestedRangeNotSatisfiable":  The requested entity or one of it's dependencies attempted to retrieve data outside the allowed range. Skip+Top might be outside the supported range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-folders-response
<a id="list-folders-response"></a>

```
type: object
  description: A response for the List Folders endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/folder
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

## Model: folder
<a id="folder"></a>

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

### .NET — `IFolderClient`

```csharp
Task<ListFoldersResponse> ListFoldersAsync(int? top = null, int? skip = null, IEnumerable<string> location, LocationStrategy? locationStrategy = null, string name = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `int` | no |
| `skip` | `int` | no |
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |
| `name` | `string` | no |
| `fields` | `string` | no |

### Java — `FolderApi`

```java
// GET /folders?top={top}&skip={skip}&location={location}&locationStrategy={locationStrategy}&name={name}&fields={fields}
ListFoldersResponse listFolders(Integer top, Integer skip, List<String> location, String locationStrategy, String name, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |
| `name` | `String` | no |
| `fields` | `String` | no |