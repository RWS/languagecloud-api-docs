# Trados Cloud Platform API Add Source File

Add Source File AddSourceFile POST /projects/{projectId}/source-files

- Friendly name: Add Source File
- Operation ID: AddSourceFile
- HTTP Method: POST
- Path: /projects/{projectId}/source-files

Adds a source file to the project. Files can be uploaded before starting a project or after the project has started. When adding a `translatable` file after the project started, a new start project request should be performed.

Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files.

> Note: The maximum character size of the sum between the `name` and the `path` fields must not exceed 255. Otherwise the request cannot be validated.

> Note: Zip files will be added as reference files. If you want to upload zip files, please use the [Upload Zip File](#/operations/UploadZipFile) endpoint.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

For details on how to send multipart/form-data with `properties` see this [article](../docs/How-to-multipart.html).
- Content: multipart/form-data

```
type: object
properties:
  - properties: $ref: #/components/schemas/source-file-request
  - file: type: string (format: binary)
```

## Response

### 201



- Content: application/json
- Schema: source-file (see model section below)

### 400

Error responses:
* "invalid": invalid input on for the value mentioned in the “name” field on the error response.
* "empty": missing input for the value mentioned in the "name" field on the error response.
* "maxSize": maximum size exceeded for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to add a source file to the project.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": duplicate source file name inside a project is not allowed.
* "projectAlreadyCompleted": resource can not be added because the project it is in completed state.

- Content: application/json
- Schema: error-response (see model section below)


## Model: source-file-request
<a id="source-file-request"></a>

```
type: object
  description: Source file properties sent as a JSON inside a text part.
properties:
  - name: type: string
  - role: type: string enum: [translatable, reference, unknown]
  - type: type: string enum: [native, bcm, sdlxliff]
  - language: $ref: #/components/schemas/language-request
  - targetLanguages: type: array
    items:
      $ref: #/components/schemas/language-request
  - path: type: array
    items:
      type: string
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

## Model: file-role
<a id="file-role"></a>

```
type: string enum: [translatable, reference, localizable, unknown]
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

### .NET — `ISourceFileClient`

```csharp
Task AddSourceFileAsync(string projectId, SourceFileRequest file);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `file` | `SourceFileRequest` | yes |

### Java — `SourceFileApi`

```java
// POST /projects/{projectId}/source-files
SourceFile addSourceFile(String projectId, SourceFileRequest properties, File file);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `properties` | `SourceFileRequest` | yes |
| `file` | `File` | yes |