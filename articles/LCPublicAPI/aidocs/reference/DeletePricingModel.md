# Trados Cloud Platform API Delete Pricing Model

Delete Pricing Model DeletePricingModel DELETE /pricing-models/{pricingModelId}

- Friendly name: Delete Pricing Model
- Operation ID: DeletePricingModel
- HTTP Method: DELETE
- Path: /pricing-models/{pricingModelId}

Deletes a pricing model.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 204

No Content

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
* "forbidden": the authenticated user is not allowed to delete the pricing model.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the pricing model could not be found by identifier.

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

### .NET — `IPricingModelClient`

```csharp
Task DeletePricingModelAsync(string pricingModelId);
```

| Parameter | Type | Required |
|---|---|---|
| `pricingModelId` | `string` | yes |

### Java — `PricingModelApi`

```java
// DELETE /pricing-models/{pricingModelId}
void deletePricingModel(String pricingModelId);
```

| Parameter | Type | Required |
|---|---|---|
| `pricingModelId` | `String` | yes |