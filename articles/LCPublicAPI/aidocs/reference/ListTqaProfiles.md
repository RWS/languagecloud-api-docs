# Trados Cloud Platform API List TQA Profiles

List TQA Profiles ListTqaProfiles GET /tqa-profiles

- Friendly name: List TQA Profiles
- Operation ID: ListTqaProfiles
- HTTP Method: GET
- Path: /tqa-profiles

List TQA Profiles.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **location** (query, array) - optional: The identifiers of the resource folders. You can control the behavior by using the 'locationStrategy'. 
- **locationStrategy** (query, string) - optional: Options: <br> - `location`: all the resources located strictly in the folders from the 'location' parameter (default); <br> - `lineage`: all the resources located in the folders specified in the 'location' parameter, as well as the subfolders; <br> - `bloodline`: all the resources located in the folders specified in the 'location' parameter, as well as the ancestor folders; <br> - `genealogy`: the resources located in the folders specified in the 'location' parameter together with subfolders and ancestors.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.
- **sort** (query, string) - optional: A comma separated list of fields used to sort the resources in the response. Each field can have a unary negative to imply descending sort order.
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
- Schema: list-tqa-profiles-response (see model section below)

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


## Model: list-tqa-profiles-response
<a id="list-tqa-profiles-response"></a>

```
type: object
  description: 
properties:
  - items: type: array
    items:
      $ref: #/components/schemas/tqa-profile
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

## Model: tqa-profile
<a id="tqa-profile"></a>

```
type: object
  description: As a project manager, you choose a TQA configuration and use it to automatically assess the quality of a translation document.

The TQA configuration specifies:
 - Categories and subcategories that reviewers will use to classify the translation issues in a document.
 - Severities to define custom metrics you want to use to assess translation quality.
 - Score to measure the importance of each category or subcategory of an issue.
 - Pass/Fail Threshold to define the maximum number of penalty points admitted before failing the translation document.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - passFailThreshold: $ref: #/components/schemas/tqa-profile-passFailThreshold
  - categories: type: array
    items:
      $ref: #/components/schemas/tqa-profile-category
  - severities: type: array
    items:
      $ref: #/components/schemas/tqa-profile-severity
  - scores: type: array
    items:
      $ref: #/components/schemas/tqa-profile-score
  - path: type: array
    items:
      $ref: #/components/schemas/folder
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

## Model: tqa-profile-passFailThreshold
<a id="tqa-profile-passFailThreshold"></a>

```
type: object
  description: Pass/Fail Threshold is used to define the maximum number of penalty points admitted before failing the translation document.
properties:
  - points: type: integer
  - quantity: type: integer
  - scope: type: string
```

## Model: tqa-profile-category
<a id="tqa-profile-category"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - abbreviation: type: string
```

## Model: tqa-profile-severity
<a id="tqa-profile-severity"></a>

```
type: object
  description: Severities are custom metrics that reviewers can use to measure the importance of any translation-related issues that they find in a file.
properties:
  - id: type: string
  - name: type: string
  - type: type: string
```

## Model: tqa-profile-score
<a id="tqa-profile-score"></a>

```
type: object
  description: The TQA scoring indicates whether translations pass or fail the acceptance threshold.
properties:
  - category: $ref: #/components/schemas/tqa-profile-category
  - severity: $ref: #/components/schemas/tqa-profile-severity
  - penalty: type: integer
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

### .NET — `ITQAProfileClient`

```csharp
Task<ListTqaProfilesResponse> ListTqaProfilesAsync(IEnumerable<string> location, LocationStrategy? locationStrategy = null, int? top = null, int? skip = null, string sort = null, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `location` | `IEnumerable<string>` | yes |
| `locationStrategy` | `LocationStrategy` | no |
| `top` | `int` | no |
| `skip` | `int` | no |
| `sort` | `string` | no |
| `fields` | `string` | no |

### Java — `TqaProfileApi`

```java
// GET /tqa-profiles?location={location}&locationStrategy={locationStrategy}&top={top}&skip={skip}&sort={sort}&fields={fields}
ListTqaProfilesResponse listTqaProfiles(List<String> location, String locationStrategy, Integer top, Integer skip, String sort, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `location` | `List<String>` | no |
| `locationStrategy` | `String` | no |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `sort` | `String` | no |
| `fields` | `String` | no |