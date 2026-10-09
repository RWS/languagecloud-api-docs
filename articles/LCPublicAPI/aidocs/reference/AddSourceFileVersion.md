# Trados Cloud Platform API Add Source File Version

Add Source File Version AddSourceFileVersion POST /tasks/{taskId}/source-files/{sourceFileId}/versions

- Friendly name: Add Source File Version
- Operation ID: AddSourceFileVersion
- HTTP Method: POST
- Path: /tasks/{taskId}/source-files/{sourceFileId}/versions

Adds a new version of the source file in [BCM](../../BCM/BCM.NET_client_API.html) or native format. More information about file formats can be found on the [File formats](../docs/File-formats.html) page.

The version is added on the task represented by `taskId`. To successfully  execute the add operation the task should already be assigned and accepted by a user. If the task is automatic, it's possible to add a source file version only when the status of task is `inProgress`.

The file versions added need to respect the output file type declared by the task type of the enclosing task. On the [Rules for sequencing tasks correctly](https://docs.rws.com/791595/885137/trados-enterprise/rules-for-sequencing-tasks-correctly) page from the official RWS Documentation Center, you can find out what output file type is supported by each task.

For adding a source file version using an extension task, the configuration of the task must declare the `scope`'s value as "file".

If the file type of the new added file is different than the supported source file type, the new `fileTypeSettingsId` must be specified in the body or an update of file type should be performed after the add operation, using the [Update Source File Properties](#/operations/UpdateSourceProperties).

The value of `fileTypeSettingsId` is one of the identifiers listed by the [List File Type Settings](#/operations/ListFileTypeSettings) endpoint.

The [List File Type Settings](#/operations/ListFileTypeSettings) endpoint must be called with the File Processing Configuration identifier of your project.

The File Processing Configuration of your project can be retrieved from [Get Project](#/operations/GetProject) endpoint.

The multipart parameters in the body should respect and strictly follow the order specified in our documentation. 

Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when adding files.


## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

For details on multipart requests please see [this article](../docs/How-to-multipart.html).
- Content: multipart/form-data

```
type: object
properties:
  - properties: $ref: #/components/schemas/source-file-version-properties-create-request
  - file: type: string (format: binary)
```

## Response

### 201

Created

- Content: application/json
- Schema: source-file-version-response (see model section below)

### 400

Error codes:
* "invalid": invalid input in the query parameter mentioned in the “name” field on the error response.
* "invalid": the provided document is not a valid BCM file.
* "invalid": invalid file format
* "multiPartOrder": the multipart order in body is not correct. `properties` must be the first, followed by `file`.

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
* "notFound": \
    \- the specified task or the source file was not found.\
    \- the request is performed in a task that doesn't have the input file type as source file and is used a target file identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "noOwner": the task has no owner.
* "differentOwner": the authenticated user is not the owner of the task.
* "differentServiceUserOwner": the authenticated service user is not the owner of the task.
* "taskCompleted": adding source file version is not allowed when the task is completed.
* "unsupported" : you cannot add a source file version for this task.
* "duplicate": a file with the same name already exists.

- Content: application/json
- Schema: error-response (see model section below)


## Model: source-file-version-properties-create-request
<a id="source-file-version-properties-create-request"></a>

```
type: object
  description: 
properties:
  - type: type: string enum: [bcm, native]
  - fileTypeSettingsId: type: string
```

## Model: source-file-version-response
<a id="source-file-version-response"></a>

```
type: object
  description: 
properties:
  - id: type: string
  - type: type: string enum: [native, bcm]
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
Task AddSourceFileVersionAsync(string sourceFileId, string taskId, string fields = null, SourceFileVersionPropertiesCreateRequest properties, FileParameter file);
```

| Parameter | Type | Required |
|---|---|---|
| `sourceFileId` | `string` | yes |
| `taskId` | `string` | yes |
| `fields` | `string` | no |
| `properties` | `SourceFileVersionPropertiesCreateRequest` | yes |
| `file` | `FileParameter` | yes |

### Java — `SourceFileApi`

```java
// POST /tasks/{taskId}/source-files/{sourceFileId}/versions?fields={fields}
SourceFileVersionResponse addSourceFileVersion(String sourceFileId, String taskId, SourceFileVersionPropertiesCreateRequest properties, File file, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `sourceFileId` | `String` | yes |
| `taskId` | `String` | yes |
| `properties` | `SourceFileVersionPropertiesCreateRequest` | yes |
| `file` | `File` | yes |
| `fields` | `String` | no |