# Trados Cloud Platform API Import Target File Version

Import Target File Version ImportTargetFileVersion POST /projects/{projectId}/target-files/{targetFileId}/versions/imports

- Friendly name: Import Target File Version
- Operation ID: ImportTargetFileVersion
- HTTP Method: POST
- Path: /projects/{projectId}/target-files/{targetFileId}/versions/imports

Generates an asynchronous import operation. Use [Poll Target File Version Import endpoint](#/operations/PollTargetFileVersionImport) to poll until the import is completed. Only `sdlxliff` files can be imported.

Import should be used when a file is downloaded as an `sdlxliff`, processed and then, replaced. 
The import operation triggers internally the update of the [BCM](../../BCM/BCM.NET_client_API.html) file associated with the imported file. It should mostly be used for offline work.

Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

For details on multipart requests please see [this article](../docs/How-to-multipart.html).
- Content: multipart/form-data

```
type: object
properties:
  - file: type: string (format: binary)
```

## Response

### 200



- Content: application/json
- Schema: file-version-import (see model section below)

### 400

Error code “invalid” in case of:
 * Empty or missing file in request
 * Not valid multipart request
 * File parameter contains other extension than the one expected by specification.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to execute operation.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": - the specified project or target file was not found.

- Content: application/json
- Schema: error-response (see model section below)


## Model: file-version-import
<a id="file-version-import"></a>

```
allOf:
  - part0:
    $ref: #/components/schemas/asynchronous-result
  - part1:
    type: object
    properties:
      - fileVersionId: type: string
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

## Model: asynchronous-result
<a id="asynchronous-result"></a>

```
type: object
  description: Represents the result of an asynchronous operation, including status and potential error information.
properties:
  - id: type: string
  - status: type: string enum: [created, inProgress, completed, failed]
  - errorMessage: type: string
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

### .NET — `ITargetFileClient`

```csharp
Task ImportTargetFileVersionAsync(string projectId, string targetFileId, FileParameter file);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `targetFileId` | `string` | yes |
| `file` | `FileParameter` | yes |

### Java — `TargetFileApi`

```java
// POST /projects/{projectId}/target-files/{targetFileId}/versions/imports
FileVersionImport importTargetFileVersion(String projectId, String targetFileId, File file);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `targetFileId` | `String` | yes |
| `file` | `File` | yes |