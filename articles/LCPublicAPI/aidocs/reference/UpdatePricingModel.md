# Trados Cloud Platform API Update Pricing Model

Update Pricing Model UpdatePricingModel PUT /pricing-models/{pricingModelId}

- Friendly name: Update Pricing Model
- Operation ID: UpdatePricingModel
- HTTP Method: PUT
- Path: /pricing-models/{pricingModelId}

Updates a pricing model.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: pricing-model-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* "empty": Empty mandatory value mentioned in the "name" field on the error response.
* "minSize": Minimum size exceeded for the value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.
* "missing": Missing required field for the value mentioned in the "name" field on the error response. 

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the pricing model.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the pricing model could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: pricing-model-update-request
<a id="pricing-model-update-request"></a>

```
type: object
properties:
  - name: type: string
  - description: type: string
  - currencyCode: type: string
  - languageDirectionPricing: type: array
    items:
      $ref: #/components/schemas/language-direction-cost-request
  - additionalCosts: type: array
    items:
      $ref: #/components/schemas/project-cost-request
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

## Model: language-direction-cost-request
<a id="language-direction-cost-request"></a>

```
type: object
properties:
  - sourceLanguage: type: string
  - targetLanguage: type: string
  - contextMatch: type: number
  - exactMatch: type: number
  - new: type: number
  - perfectMatch: type: number
  - repetition: type: number
  - machineTranslation: type: number
  - pricingUnit: $ref: #/components/schemas/pricing-unit-type
  - fuzzyMatches: type: array
    items:
      $ref: #/components/schemas/fuzzy-match
  - additionalCosts: type: array
    items:
      $ref: #/components/schemas/language-cost-request
```

## Model: project-cost-request
<a id="project-cost-request"></a>

```
type: object
properties:
  - name: type: string
  - type: $ref: #/components/schemas/project-cost-type
  - index: type: number
  - costPerUnit: type: number
  - unitCount: type: number
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - costOperator: $ref: #/components/schemas/conditional-cost-operator
  - costVariable: $ref: #/components/schemas/conditional-cost-variable
  - operand: type: number
  - serviceTypes: type: array
    items:
      type: string
  - customUnitName: type: string
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

## Model: pricing-unit-type
<a id="pricing-unit-type"></a>

```
type: string enum: [words, characters]
```

## Model: fuzzy-match
<a id="fuzzy-match"></a>

```
type: object
  description: Fuzzy match model.
properties:
  - price: type: number
  - category: $ref: #/components/schemas/fuzzy-match-category
```

## Model: language-cost-request
<a id="language-cost-request"></a>

```
type: object
properties:
  - name: type: string
  - type: $ref: #/components/schemas/language-cost-type
  - index: type: number
  - costPerUnit: type: number
  - unitCount: type: number
  - volumeUnitType: $ref: #/components/schemas/volume-unit-type
  - conditionalCostType: $ref: #/components/schemas/conditional-cost-type
  - conditionalCostOperator: $ref: #/components/schemas/conditional-cost-operator
  - conditionalCostVariable: $ref: #/components/schemas/conditional-cost-variable
  - operand: type: number
  - serviceTypes: type: array
    items:
      type: string
  - customUnitName: type: string
```

## Model: project-cost-type
<a id="project-cost-type"></a>

```
type: string enum: [volume, perTargetLanguage, perFile, hourly, percentage, perPage, conditional, adhoc, adhocVolume]
```

## Model: volume-unit-type
<a id="volume-unit-type"></a>

```
type: string enum: [words, characters, custom]
```

## Model: conditional-cost-type
<a id="conditional-cost-type"></a>

```
type: string enum: [absolute, relative, percentage]
```

## Model: conditional-cost-operator
<a id="conditional-cost-operator"></a>

```
type: string enum: [less, lessOrEqual, greater, greaterOrEqual]
```

## Model: conditional-cost-variable
<a id="conditional-cost-variable"></a>

```
type: string enum: [wordCount, runningTotal]
```

## Model: fuzzy-match-category
<a id="fuzzy-match-category"></a>

```
type: object
  description: Fuzzy match category range.
properties:
  - minimumMatchValue: type: integer
  - maximumMatchValue: type: integer
```

## Model: language-cost-type
<a id="language-cost-type"></a>

```
type: string enum: [volume, hourly, percentage, perPage, conditional, adhoc, adhocVolume]
```

## SDK

### .NET — `IPricingModelClient`

```csharp
Task UpdatePricingModelAsync(string pricingModelId);
```

| Parameter | Type | Required |
|---|---|---|
| `pricingModelId` | `string` | yes |

### Java — `PricingModelApi`

```java
// PUT /pricing-models/{pricingModelId}
void updatePricingModel(String pricingModelId, PricingModelUpdateRequest pricingModelUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `pricingModelId` | `String` | yes |
| `pricingModelUpdateRequest` | `PricingModelUpdateRequest` | no |