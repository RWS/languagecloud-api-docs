# Trados Cloud Platform API Delete Vendor

Delete Vendor DeleteVendor DELETE /vendors/{vendorId}

- Friendly name: Delete Vendor
- Operation ID: DeleteVendor
- HTTP Method: DELETE
- Path: /vendors/{vendorId}

Deletes a vendor by identifier.

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.

## Request body

No request body.

## Response

### 204

No Content

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to delete the vendor.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the vendor could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "conflict": the vendor cannot be deleted because its folder contains resources that must be removed first. The error details describe which resources are blocking deletion.

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

### .NET — `IVendorClient`

```csharp
Task DeleteVendorAsync(string vendorId);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `string` | yes |

### Java — `VendorApi`

```java
// DELETE /vendors/{vendorId}
void deleteVendor(String vendorId);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `String` | yes |