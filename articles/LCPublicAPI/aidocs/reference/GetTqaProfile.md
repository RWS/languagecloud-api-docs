# Trados Cloud Platform API Get TQA Profile

Get TQA Profile GetTqaProfile GET /tqa-profiles/{profileId}

- Friendly name: Get TQA Profile
- Operation ID: GetTqaProfile
- HTTP Method: GET
- Path: /tqa-profiles/{profileId}

Get a TQA Profile By identifier.

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

OK

- Content: application/json
- Schema: tqa-profile (see model section below)

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
* "forbidden": the authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the User could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


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

### .NET — `ITQAProfileClient`

```csharp
Task<TqaProfile> GetTqaProfileAsync(string profileId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `profileId` | `string` | yes |
| `fields` | `string` | no |

### Java — `TqaProfileApi`

```java
// GET /tqa-profiles/{profileId}?fields={fields}
TqaProfile getTqaProfile(String profileId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `profileId` | `String` | yes |
| `fields` | `String` | no |