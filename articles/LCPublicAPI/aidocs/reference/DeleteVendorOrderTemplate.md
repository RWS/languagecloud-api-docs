# Trados Cloud Platform API Delete Vendor Order Template

Delete Vendor Order Template DeleteVendorOrderTemplate DELETE /vendors/{vendorId}/order-templates/{orderTemplateId}

- Friendly name: Delete Vendor Order Template
- Operation ID: DeleteVendorOrderTemplate
- HTTP Method: DELETE
- Path: /vendors/{vendorId}/order-templates/{orderTemplateId}

Deletes a vendor order template by identifier.

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.

## Request body

No request body.

## Response

### 204

No Content

### 400

Error codes:
* "invalid": Invalid input in the field mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to delete the vendor order template.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the vendor order template could not be found by identifier.

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
Task DeleteVendorOrderTemplateAsync(string vendorId, string orderTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `string` | yes |
| `orderTemplateId` | `string` | yes |

### Java — `VendorApi`

```java
// DELETE /vendors/{vendorId}/order-templates/{orderTemplateId}
void deleteVendorOrderTemplate(String vendorId, String orderTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `String` | yes |
| `orderTemplateId` | `String` | yes |