# Trados Cloud Platform API Poll Export Package

Poll Export Package PollExportPackage GET /packages/export/{exportId}

- Friendly name: Poll Export Package
- Operation ID: PollExportPackage
- HTTP Method: GET
- Path: /packages/export/{exportId}

Polls the status of the export operation created by the [Export Package operation](../api/Public-API.v1-fv.html#/operations/ExportPackage).

## Parameters

- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.
- **exportId** (path, string) - required: The export operation identifier.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: package-export-status-response (see model section below)

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


## Model: package-export-status-response
<a id="package-export-status-response"></a>

```
type: object
properties:
  - id: type: string
  - status: type: string
  - projectId: type: string
  - taskIds: type: array
    items:
      type: string
  - expiresAt: type: string
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
Task PollExportPackageAsync(string exportId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `exportId` | `string` | yes |
| `fields` | `string` | no |

### Java — `PackageApi`

```java
// GET /packages/export/{exportId}?fields={fields}
PackageExportStatusResponse pollExportPackage(String exportId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `exportId` | `String` | yes |
| `fields` | `String` | no |