# Trados Cloud Platform API Update Vendor

Update Vendor UpdateVendor PUT /vendors/{vendorId}

- Friendly name: Update Vendor
- Operation ID: UpdateVendor
- HTTP Method: PUT
- Path: /vendors/{vendorId}

Updates a vendor by identifier. Only fields included in the request body are updated. We recommend reading [Updating data with PUT](../docs/Updating-data-with-PUT.html) before using this endpoint.

**Member management is not part of this endpoint.** To add a user to a vendor, invite them via the [Create User](#/operations/CreateUser) endpoint specifying the vendor's `VendorProjectManager` group. To remove a user from the vendor, remove them from that group using the [Update Group](#/operations/UpdateGroup) or [Update User](#/operations/UpdateUser) endpoints.

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.

## Request body

- Content: application/json

- Schema: vendor-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* "invalid": Invalid input in the field mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the vendor.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the vendor could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": duplicate value for the field mentioned in the error details.

- Content: application/json
- Schema: error-response (see model section below)


## Model: vendor-update-request
<a id="vendor-update-request"></a>

```
type: object
  description: Request body for updating an existing vendor. Only fields included in the request body are updated. Member management is not part of this endpoint — use the [Create User](#/operations/CreateUser), [Update User](#/operations/UpdateUser), or [Update Group](#/operations/UpdateGroup) endpoints to add or remove users from the vendor's `VendorProjectManager` group.
properties:
  - name: type: string
  - description: type: string
  - keyContactId: type: string
  - selfManaged: type: boolean
  - quoteTemplateId: type: string
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field-request
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

## Model: custom-field-request
<a id="custom-field-request"></a>

```
type: object
  description: A Custom Field model used at project creation or project update.
properties:
  - key: type: string
  - value: type: object
      description: The value of the custom field. A date will be serialized as a ISO_8601 string. For read only custom fields (`isReadOnly`), it must be set exactly as the `defaultValue` from custom field definition.
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
Task UpdateVendorAsync(VendorUpdateRequest vendorId);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `VendorUpdateRequest` | yes |

### Java — `VendorApi`

```java
// PUT /vendors/{vendorId}
void updateVendor(String vendorId, VendorUpdateRequest vendorUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `String` | yes |
| `vendorUpdateRequest` | `VendorUpdateRequest` | yes |