# Trados Cloud Platform API Attach Source Files

Attach Source Files AddSourceFiles POST /projects/{projectId}/source-files/attach-files

- Friendly name: Attach Source Files
- Operation ID: AddSourceFiles
- HTTP Method: POST
- Path: /projects/{projectId}/source-files/attach-files

This endpoint can only be used after files have been uploaded via the [Upload Zip File](#/operations/UploadZipFile) endpoint. It allows you to add multiple source files to a project. 

 Each file must be individually attached by setting the `fileUrl` to the `associatedFiles.id` returned by the [Poll Upload Zip File](#/operations/PollUploadZipFile) endpoint, once the `unzipStatus` is `extracted`. 

If a file is attached after the project has already been started, a new start project request must be made.

> Note: The maximum character size of the sum between the `name` and the `path` fields must not exceed 255. Otherwise the request cannot be validated.


## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body


- Content: application/json

- Schema: source-file-attachment-request (see model section below)

## Response

### 201



- Content: application/json
- Schema: source-file-attachment-response (see model section below)

### 400

Error codes:
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
* "forbidden": the authenticated user is not allowed to attach a source file on the project.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": duplicate source file name inside a project is not allowed.
* "duplicate": duplicate fileUrl inside a project is not allowed.

- Content: application/json
- Schema: error-response (see model section below)


## Model: source-file-attachment-request
<a id="source-file-attachment-request"></a>

```
type: object
  description: 
properties:
  - sourceFilesAttachment: type: array
    items:
      $ref: #/components/schemas/source-file-attachment-request-item
```

## Model: source-file-attachment-response
<a id="source-file-attachment-response"></a>

```
type: object
  description: 
properties:
  - sourceFiles: type: array
    items:
      $ref: #/components/schemas/source-file
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

## Model: source-file-attachment-request-item
<a id="source-file-attachment-request-item"></a>

```
type: object
  description: Attached Source File properties referencing previously uploaded file
properties:
  - name: type: string
  - role: type: string enum: [translatable, reference, unknown]
  - fileUrl: type: string
  - type: type: string enum: [native, bcm, sdlxliff]
  - language: $ref: #/components/schemas/source-language-request
  - targetLanguages: type: array
    items:
      $ref: #/components/schemas/target-language-request
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

## Model: source-language-request
<a id="source-language-request"></a>

```
type: object
properties:
  - languageCode: type: string
```

## Model: target-language-request
<a id="target-language-request"></a>

```
type: object
  description: 
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

## SDK

### .NET — `ISourceFileClient`

```csharp
Task AddSourceFilesAsync(SourceFileAttachmentRequest projectId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `SourceFileAttachmentRequest` | yes |
| `fields` | `string` | no |

### Java — `SourceFileApi`

```java
// POST /projects/{projectId}/source-files/attach-files?fields={fields}
SourceFileAttachmentResponse addSourceFiles(String projectId, SourceFileAttachmentRequest sourceFileAttachmentRequest, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `sourceFileAttachmentRequest` | `SourceFileAttachmentRequest` | yes |
| `fields` | `String` | no |