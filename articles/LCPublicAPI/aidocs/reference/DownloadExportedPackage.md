# Trados Cloud Platform API Download Exported Package

Download Exported Package DownloadExportedPackage GET /packages/export/download/{exportId}

- Friendly name: Download Exported Package
- Operation ID: DownloadExportedPackage
- HTTP Method: GET
- Path: /packages/export/download/{exportId}

Downloads an exported package with the .sdlppx extension.

## Parameters

- **exportId** (path, string) - required: The export operation identifier.

## Request body

No request body.

## Response

### 200

OK

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
* "forbidden": the authenticated user is not allowed to view task.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Package could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "conflict": Cannot download package export if status is not done.

- Content: application/json
- Schema: error-response (see model section below)


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

### .NET — `IPackageClient`

```csharp
Task DownloadExportedPackageAsync(string exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `exportId` | `string` | yes |

### Java — `PackageApi`

```java
// GET /packages/export/download/{exportId}
void downloadExportedPackage(String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `exportId` | `String` | yes |