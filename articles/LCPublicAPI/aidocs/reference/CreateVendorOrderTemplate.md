# Trados Cloud Platform API Create Vendor Order Template

Create Vendor Order Template CreateVendorOrderTemplate POST /vendors/{vendorId}/order-templates

- Friendly name: Create Vendor Order Template
- Operation ID: CreateVendorOrderTemplate
- HTTP Method: POST
- Path: /vendors/{vendorId}/order-templates

Creates a new vendor order template for the specified vendor.

For more information on creating vendor order templates, see [Creating order templates for vendors](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/creating-order-templates-for-vendors-708439).

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: vendor-order-template-create-request (see model section below)

## Response

### 201

Vendor Order Template created successfully.

- Content: application/json
- Schema: vendor-order-template-response (see model section below)

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
* "forbidden": the authenticated user is not allowed to create vendor order templates.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the vendor could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: vendor-order-template-create-request
<a id="vendor-order-template-create-request"></a>

```
type: object
  description: Request body for creating a new vendor order template.
properties:
  - name: type: string
  - description: type: string
  - allowQuoteEditing: type: boolean
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

## Model: vendor-order-template-response
<a id="vendor-order-template-response"></a>

```
type: object
  description: A vendor order template resource.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - allowQuoteEditing: type: boolean
  - serviceTypes: type: array
    items:
      $ref: #/components/schemas/translation-service-type
  - pricingModel: $ref: #/components/schemas/pricing-model
  - quoteConfiguration: $ref: #/components/schemas/vendor-order-template-quote-configuration
  - customFields: type: array
    items:
      $ref: #/components/schemas/custom-field
  - languagePairs: type: array
    items:
      $ref: #/components/schemas/language-pair
  - assignments: type: array
    items:
      $ref: #/components/schemas/vot-configuration-response
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

## Model: translation-service-type
<a id="translation-service-type"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
```

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

## Model: custom-field
<a id="custom-field"></a>

```
type: object
  description: A Custom Field model.
properties:
  - id: type: string
  - name: type: string
  - key: type: string
  - value: type: object
      description: The value of the custom property. A date will be serialized as an ISO_8601 string.
```

## Model: vot-configuration-response
<a id="vot-configuration-response"></a>

```
type: object
  description: Assignee and manager assignment for a specific language pair. Every language pair listed in `languagePairs` must have exactly one corresponding entry in `assignments`.
properties:
  - languagePair: $ref: #/components/schemas/language-pair
  - managers: type: array
    items:
      $ref: #/components/schemas/vot-person-response
  - assignees: type: array
    items:
      $ref: #/components/schemas/vot-person-response
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

## Model: vot-person-response
<a id="vot-person-response"></a>

```
type: object
  description: A user or group assigned as a manager or assignee on a vendor order template. When `type` is `user`, the `user` object is populated. When `type` is `group`, the `group` object is populated.
properties:
  - type: type: string enum: [user, group]
  - user: $ref: #/components/schemas/user
  - group: $ref: #/components/schemas/group
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

## Model: user
<a id="user"></a>

```
type: object
  description: User in the account.
properties:
  - id: type: string
  - description: type: string
  - email: type: string
  - name: type: string
  - firstName: type: string
  - lastName: type: string
  - anonymized: type: boolean
  - anonymizedUserName: type: string
  - account: $ref: #/components/schemas/account
  - location: $ref: #/components/schemas/folder-v2
  - groups: type: array
    items:
      $ref: #/components/schemas/group
  - userType: $ref: #/components/schemas/user-type
  - status: $ref: #/components/schemas/user-status
  - invitationLink: type: string
  - membership: $ref: #/components/schemas/account-membership-type
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
```

## Model: group
<a id="group"></a>

```
type: object
  description: Group of Users.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - users: type: array
    items:
      $ref: #/components/schemas/user
  - roles: type: array
    items:
      $ref: #/components/schemas/role
  - additionalRoles: type: array
    items:
      $ref: #/components/schemas/group-additional-roles
  - groupType: type: string enum: [default, custom, vendor, customer]
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
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

## Model: account
<a id="account"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
```

## Model: user-type
<a id="user-type"></a>

```
type: string enum: [user, serviceUser]
```

## Model: user-status
<a id="user-status"></a>

```
type: string enum: [inactive, active, deleted, provisioned]
```

## Model: account-membership-type
<a id="account-membership-type"></a>

```
type: string enum: [member, collaborator]
```

## Model: role
<a id="role"></a>

```
type: object
  description: Role in the account.
properties:
  - id: type: string
  - type: type: string enum: [provisioned, custom]
  - name: type: string
  - description: type: string
  - permissions: type: array
    items:
      $ref: #/components/schemas/permission
```

## Model: group-additional-roles
<a id="group-additional-roles"></a>

```
type: object
  description: Roles granted to the group in addition to the group location.
properties:
  - location: $ref: #/components/schemas/folder-v2
  - roles: type: array
    items:
      $ref: #/components/schemas/role
```

## Model: permission
<a id="permission"></a>

```
type: object
  description: A single permission which governs access to resources.
properties:
  - name: type: string
  - description: type: string
  - category: type: string
  - entityType: $ref: #/components/schemas/permission-entity-type
  - dependsOn: type: array
    items:
      type: string
```

## Model: permission-entity-type
<a id="permission-entity-type"></a>

```
type: object
  description: The entity type a permission applies to.
properties:
  - name: type: string
  - description: type: string
```

## SDK

### .NET — `IVendorClient`

```csharp
Task<VendorOrderTemplate> CreateVendorOrderTemplateAsync(VendorOrderTemplateCreateRequest vendorId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `VendorOrderTemplateCreateRequest` | yes |
| `fields` | `string` | no |

### Java — `VendorApi`

```java
// POST /vendors/{vendorId}/order-templates?fields={fields}
VendorOrderTemplateResponse createVendorOrderTemplate(String vendorId, VendorOrderTemplateCreateRequest vendorOrderTemplateCreateRequest, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `vendorId` | `String` | yes |
| `vendorOrderTemplateCreateRequest` | `VendorOrderTemplateCreateRequest` | yes |
| `fields` | `String` | no |