# Trados Cloud Platform API Export Package

Export Package ExportPackage POST /packages/export

- Friendly name: Export Package
- Operation ID: ExportPackage
- HTTP Method: POST
- Path: /packages/export

Creates a task for exporting the selected tasks in a given number of packages, for more information check the [documentation](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/downloading-packages-for-translation-719552) on downloading packages for translation

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: package-export-request (see model section below)

## Response

### 200



- Content: application/json
```
type: object
properties:
  - exportIds: type: array
    items:
      type: string
```

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
* "forbidden": the authenticated user is not allowed to export the package.

- Content: application/json
- Schema: error-response (see model section below)


## Model: package-export-request
<a id="package-export-request"></a>

```
type: object
properties:
  - projectId: type: string
  - taskIds: type: array
    items:
      type: string
  - onlinePackage: type: boolean
  - includeTM: type: boolean
  - includeReferenceFiles: type: boolean
  - splitByLanguage: type: boolean
  - filesPerPackage: type: integer
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
Task ExportPackageAsync();
```

### Java — `PackageApi`

```java
// POST /packages/export
ExportPackage200Response exportPackage(PackageExportRequest packageExportRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `packageExportRequest` | `PackageExportRequest` | no |