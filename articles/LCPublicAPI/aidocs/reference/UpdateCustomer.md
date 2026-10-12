# Trados Cloud Platform API Update Customer

Update Customer UpdateCustomer PUT /customers/{customerId}

- Friendly name: Update Customer
- Operation ID: UpdateCustomer
- HTTP Method: PUT
- Path: /customers/{customerId}

Updates a customer by identifier.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: customer-update-request (see model section below)

## Response

### 204

No Content


### 400

Error codes: 
* “invalid”: Invalid input in “name” field on the error response.
* "deleted": Some of the selected values were deleted and cannot be selected for some values of the  "customFields" field.


- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.



- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes: 
* "forbidden": the authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": duplicate name of a customer is not allowed.

- Content: application/json
- Schema: error-response (see model section below)


## Model: customer-update-request
<a id="customer-update-request"></a>

```
type: object
  description: Input for Customer update.


properties:
  - name: type: string
  - keyContactId: type: string
  - ragStatus: type: string enum: [green, amber, red]
  - customFieldDefinitions: type: array
    items:
      $ref: #/components/schemas/custom-field-resource
  - folderVisibility: type: string enum: [default, private]
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

## Model: custom-field-resource
<a id="custom-field-resource"></a>

```
type: object
  description: A Custom Field resource model.
properties:
  - key: type: string
  - value: type: object
      description: The value of the custom property. A date will be serialized as an ISO_8601 string.
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

### .NET — `ICustomerClient`

```csharp
Task UpdateCustomerAsync(CustomerUpdateRequest customerId);
```

| Parameter | Type | Required |
|---|---|---|
| `customerId` | `CustomerUpdateRequest` | yes |

### Java — `CustomerApi`

```java
// PUT /customers/{customerId}
void updateCustomer(String customerId, CustomerUpdateRequest customerUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `customerId` | `String` | yes |
| `customerUpdateRequest` | `CustomerUpdateRequest` | yes |