# Trados Cloud Platform API Update Project Pricing Model

Update Project Pricing Model UpdateProjectPricingModel PUT /projects/{projectId}/pricing-model

- Friendly name: Update Project Pricing Model
- Operation ID: UpdateProjectPricingModel
- HTTP Method: PUT
- Path: /projects/{projectId}/pricing-model

Update project pricing model only during Customer Quote Review task type.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: project-pricing-model-update-request (see model section below)

## Response

### 204



### 400

Error codes:
* “invalidPricingModel”: There is mismatch configuration between the project and the new pricing model.
* "differentCurrencyCode": There is a mismatch between the provided pricing model currency and the pricing model currency in the project.
* “differentFuzzyBands”: There is a mismatch between the provided pricing model fuzzy bands and the pricing model fuzzy bands in the project.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the project configuration.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: project-pricing-model-update-request
<a id="project-pricing-model-update-request"></a>

```
type: object
properties:
  - id: type: string
  - strategy: type: string enum: [copy, use]
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

### .NET — `IProjectClient`

```csharp
Task UpdateProjectPricingModelAsync(ProjectPricingModelUpdateRequest projectId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `ProjectPricingModelUpdateRequest` | yes |

### Java — `ProjectApi`

```java
// PUT /projects/{projectId}/pricing-model
void updateProjectPricingModel(String projectId, ProjectPricingModelUpdateRequest projectPricingModelUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `projectPricingModelUpdateRequest` | `ProjectPricingModelUpdateRequest` | yes |