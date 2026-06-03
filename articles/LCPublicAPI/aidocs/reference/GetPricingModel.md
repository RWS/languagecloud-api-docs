# Trados Cloud Platform API Get Pricing Model

Get Pricing Model GetPricingModel GET /pricing-models/{pricingModelId}

- Friendly name: Get Pricing Model
- Operation ID: GetPricingModel
- HTTP Method: GET
- Path: /pricing-models/{pricingModelId}

Retrieves a pricing model by identifier.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: pricing-model (see model section below)

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
* "forbidden": the authenticated user is not allowed to read the pricing model.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: pricing-model
<a id="pricing-model"></a>

```
type: object
  description: Pricing Model resource.  (Not available for List Projects endpoint)
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - currencyCode: type: string
  - location: $ref: #/components/schemas/folder-v2
  - languageDirectionPricing: type: array
    items:
      $ref: #/components/schemas/language-direction-cost
  - additionalCosts: type: array
    items:
      $ref: #/components/schemas/project-cost
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

## Model: folder-v2
<a id="folder-v2"></a>

```
type: object
  description: Folder used for resource storage.
properties:
  - id: type: string
  - name: type: string
  - hasParent: type: boolean
  - path: type: array
    items:
      $ref: #/components/schemas/folder-path
```

## Model: language-direction-cost
<a id="language-direction-cost"></a>

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
      $ref: #/components/schemas/language-cost
```

## Model: project-cost
<a id="project-cost"></a>

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

## Model: folder-path
<a id="folder-path"></a>

```
type: object
  description: Path of a folder.
properties:
  - id: type: string
  - name: type: string
  - location: type: string
  - hasParent: type: boolean
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

## Model: language-cost
<a id="language-cost"></a>

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
  - costOperator: $ref: #/components/schemas/conditional-cost-operator
  - costVariable: $ref: #/components/schemas/conditional-cost-variable
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
Task<PricingModel> GetPricingModelAsync(string pricingModelId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `pricingModelId` | `string` | yes |
| `fields` | `string` | no |

### Java — `PricingModelApi`

```java
// GET /pricing-models/{pricingModelId}?fields={fields}
PricingModel getPricingModel(String pricingModelId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `pricingModelId` | `String` | yes |
| `fields` | `String` | no |