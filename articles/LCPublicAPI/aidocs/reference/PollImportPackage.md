# Trados Cloud Platform API Poll Import Package

Poll Import Package PollImportPackage GET /packages/import/{importId}

- Friendly name: Poll Import Package
- Operation ID: PollImportPackage
- HTTP Method: GET
- Path: /packages/import/{importId}

Polls the status of the import operation created by the [Import Package operation](../api/Public-API.v1-fv.html#/operations/ImportPackage).

## Parameters

- **importId** (path, string) - required: The import operation identifier.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: package-import-status-response (see model section below)

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
* "forbidden": the authenticated user is not allowed to view the task.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Task could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: package-import-status-response
<a id="package-import-status-response"></a>

```
type: object
properties:
  - id: type: string
  - status: type: string
  - error: $ref: #/components/schemas/error-response
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

### .NET — `IPackageClient`

```csharp
Task PollImportPackageAsync(string importId);
```

| Parameter | Type | Required |
|---|---|---|
| `importId` | `string` | yes |

### Java — `PackageApi`

```java
// GET /packages/import/{importId}
PackageImportStatusResponse pollImportPackage(String importId);
```

| Parameter | Type | Required |
|---|---|---|
| `importId` | `String` | yes |