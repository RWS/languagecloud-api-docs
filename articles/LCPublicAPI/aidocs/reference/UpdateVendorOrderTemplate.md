# Trados Cloud Platform API Update Vendor Order Template

Update Vendor Order Template UpdateVendorOrderTemplate PUT /vendors/{vendorId}/order-templates/{orderTemplateId}

- Friendly name: Update Vendor Order Template
- Operation ID: UpdateVendorOrderTemplate
- HTTP Method: PUT
- Path: /vendors/{vendorId}/order-templates/{orderTemplateId}

Updates a vendor order template by identifier. Only fields included in the request body are updated. We recommend reading [Updating data with PUT](../docs/Updating-data-with-PUT.html) before using this endpoint.

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.

## Request body

- Content: application/json

- Schema: vendor-order-template-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* "invalid": Invalid input in the field mentioned in the "name" field on the error response.
* "empty": Empty input in the body parameter mentioned in the "name" field on the error response.
* "minSize": Minimum size exceeded for the value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response. 


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the vendor order template.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the vendor order template could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: vendor-order-template-update-request
<a id="vendor-order-template-update-request"></a>

```
type: object
  description: Request body for updating an existing vendor order template.
properties:
  - name: type: string
  - description: type: string
  - serviceTypes: type: array
    items:
      type: string
  - pricingModelId: type: string
  - quoteConfiguration: $ref: #/components/schemas/vendor-order-template-quote-configuration
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field-request
  - languagePairs: type: array
    items:
      $ref: #/components/schemas/language-pair
  - assignments: type: array
    items:
      $ref: #/components/schemas/vot-configuration
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

## Model: vendor-order-template-quote-configuration
<a id="vendor-order-template-quote-configuration"></a>

```
type: object
  description: Controls when and how the vendor quote is generated.
properties:
  - behaviour: $ref: #/components/schemas/vot-quote-behaviour
  - holdingDelay: type: integer
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

## Model: language-pair
<a id="language-pair"></a>

```
type: object
  description: 
properties:
  - source: type: string
  - target: type: string
```

## Model: vot-configuration
<a id="vot-configuration"></a>

```
type: object
  description: Assignee and manager assignment for a specific language pair. Every language pair listed in `languagePairs` must have exactly one corresponding entry in `assignments`.
properties:
  - languagePair: $ref: #/components/schemas/language-pair
  - managers: type: array
    items:
      $ref: #/components/schemas/vot-person-request
  - assignees: type: array
    items:
      $ref: #/components/schemas/vot-person-request
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

## Model: vot-quote-behaviour
<a id="vot-quote-behaviour"></a>

```
type: string enum: [waitForAllFiles, perFileQuote, finalQuoteAfterBatchCompleted, quoteBeforeCustomerQuoteGeneration]
```

## Model: vot-person-request
<a id="vot-person-request"></a>

```
type: object
  description: A user or group assigned as a manager or assignee on a vendor order template. When `type` is `user`, `id` is the identifier of a user present in the vendor's `members` list. When `type` is `group`, `id` is the identifier of a group present in the vendor's `groups` list.
properties:
  - type: type: string enum: [user, group]
  - id: type: string
```

## SDK

### .NET — `IVendorClient`

```csharp
Task UpdateVendorOrderTemplateAsync(VendorOrderTemplateUpdateRequest vendorId, string orderTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `VendorOrderTemplateUpdateRequest` | yes |
| `orderTemplateId` | `string` | yes |

### Java — `VendorApi`

```java
// PUT /vendors/{vendorId}/order-templates/{orderTemplateId}
void updateVendorOrderTemplate(String vendorId, String orderTemplateId, VendorOrderTemplateUpdateRequest vendorOrderTemplateUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `String` | yes |
| `orderTemplateId` | `String` | yes |
| `vendorOrderTemplateUpdateRequest` | `VendorOrderTemplateUpdateRequest` | yes |