# Trados Cloud Platform API List my Accounts

List my Accounts ListMyAccounts GET /accounts

- Friendly name: List my Accounts
- Operation ID: ListMyAccounts
- HTTP Method: GET
- Path: /accounts

Retrieves the accounts the authenticated user is part of. 

> For service users only the account where the user is defined is returned.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-my-accounts-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-my-accounts-response
<a id="list-my-accounts-response"></a>

```
type: object
  description: A response for the List My Accounts endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/account
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

## Model: account
<a id="account"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
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

### .NET — `IAccountClient`

```csharp
Task<ListMyAccountsResponse> ListMyAccountsAsync();
```

### Java

_Not found in Java SDK — [Manual Review Needed]_