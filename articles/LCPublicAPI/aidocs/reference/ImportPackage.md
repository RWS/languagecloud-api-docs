# Trados Cloud Platform API Import Package

Import Package ImportPackage POST /packages/import

- Friendly name: Import Package
- Operation ID: ImportPackage
- HTTP Method: POST
- Path: /packages/import

Creates an operation for importing a translation package. The accepted file types are .sdlppx and .sdlrpx. The system associates the imported package with the appropriate project and task automatically based on its contents, using the information contained in the file. You can also check the related [documentation](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/returning-translation-packages-719556).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: package-import-request (see model section below)

## Response

### 200



- Content: application/json
```
type: object
properties:
  - importId: type: string
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
* "forbidden": the authenticated user is not allowed to import a package.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Package could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: package-import-request
<a id="package-import-request"></a>

```
type: object
properties:
  - file: type: string (format: binary)
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
Task ImportPackageAsync();
```

### Java — `PackageApi`

```java
// POST /packages/import
ImportPackage200Response importPackage(PackageImportRequest packageImportRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `packageImportRequest` | `PackageImportRequest` | no |