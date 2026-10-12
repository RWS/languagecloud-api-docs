# Trados Cloud Platform API Get Target File

Get Target File GetTargetFile GET /projects/{projectId}/target-files/{targetFileId}

- Friendly name: Get Target File
- Operation ID: GetTargetFile
- HTTP Method: GET
- Path: /projects/{projectId}/target-files/{targetFileId}

Retrieves a target file from a project.

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
- Schema: target-file (see model section below)

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
* "notFound": the project or the target file could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: target-file
<a id="target-file"></a>

```
type: object
  description: Target File.
properties:
  - id: type: string
  - name: type: string
  - languageDirection: $ref: #/components/schemas/language-direction
  - sourceFile: $ref: #/components/schemas/source-file
  - latestVersion: $ref: #/components/schemas/target-file-latest-version
  - analysisStatistics: $ref: #/components/schemas/analysis-statistics
  - status: type: string enum: [inProgress, finished, canceled]
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

## Model: language-direction
<a id="language-direction"></a>

```
type: object
  description: A Language Direction.
properties:
  - id: type: string
  - sourceLanguage: $ref: #/components/schemas/language
  - targetLanguage: $ref: #/components/schemas/language
  - analysisStatistics: $ref: #/components/schemas/analysis-statistics
```

## Model: source-file
<a id="source-file"></a>

```
type: object
  description: Source File.
properties:
  - id: type: string
  - name: type: string
  - role: $ref: #/components/schemas/file-role
  - language: $ref: #/components/schemas/language
  - versions: type: array
    items:
      $ref: #/components/schemas/source-file-version
  - targetLanguages: type: array
    items:
      $ref: #/components/schemas/language
  - path: type: array
    items:
      type: string
  - totalWords: type: integer
```

## Model: target-file-latest-version
<a id="target-file-latest-version"></a>

```
type: object
  description: Target File Latest Version.
properties:
  - id: type: string
  - type: type: string enum: [native, bcm]
  - version: type: integer
```

## Model: analysis-statistics
<a id="analysis-statistics"></a>

```
type: object
properties:
  - exactMatch: $ref: #/components/schemas/count
  - inContextExactMatch: $ref: #/components/schemas/count
  - perfectMatch: $ref: #/components/schemas/count
  - new: $ref: #/components/schemas/count
  - repetitions: $ref: #/components/schemas/count
  - crossDocumentRepetitions: $ref: #/components/schemas/count
  - machineTranslation: $ref: #/components/schemas/count
  - locked: $ref: #/components/schemas/count
  - fuzzyMatch: type: array
    items:
      $ref: #/components/schemas/fuzzy-count
  - total: $ref: #/components/schemas/count
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

## Model: file-role
<a id="file-role"></a>

```
type: string enum: [translatable, reference, localizable, unknown]
```

## Model: source-file-version
<a id="source-file-version"></a>

```
type: object
  description: Source File Version.
properties:
  - id: type: string
  - type: type: string enum: [native, bcm]
  - name: type: string
  - version: type: integer
  - originatingTaskId: type: string
```

## Model: count
<a id="count"></a>

```
type: object
  description: Statistics count.
properties:
  - words: type: integer
  - segments: type: integer
  - characters: type: integer
  - placeables: type: integer
  - tags: type: integer
```

## Model: fuzzy-count
<a id="fuzzy-count"></a>

```
type: object
  description: Statistics count for fuzzy matches.
properties:
  - count: $ref: #/components/schemas/count
  - category: $ref: #/components/schemas/fuzzy-category
```

## Model: fuzzy-category
<a id="fuzzy-category"></a>

```
type: object
  description: Fuzzy category range. Example of Fuzzy bands: 100-100%, 95-99%, 85-94%, 75-84%, 50-74%.
properties:
  - minimum: type: integer
  - maximum: type: integer
```

## SDK

### .NET — `ITargetFileClient`

```csharp
Task<TargetFile> GetTargetFileAsync(string projectId, string targetFileId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |
| `fields` | `string` | no |

### Java — `TargetFileApi`

```java
// GET /projects/{projectId}/target-files/{targetFileId}?fields={fields}
TargetFile getTargetFile(String projectId, String targetFileId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `fields` | `String` | no |