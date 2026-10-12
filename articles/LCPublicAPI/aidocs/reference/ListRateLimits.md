# Trados Cloud Platform API List Rate Limits

List Rate Limits ListRateLimits GET /rate-limits

- Friendly name: List Rate Limits
- Operation ID: ListRateLimits
- HTTP Method: GET
- Path: /rate-limits

Retrieves a list of all rate limits applicable for an account.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-rate-limits-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-rate-limits-response
<a id="list-rate-limits-response"></a>

```
type: object
  description: A response for the List Rate Limits endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/rate-limit
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

## Model: rate-limit
<a id="rate-limit"></a>

```
type: object
  description: Rate Limit entry
properties:
  - policyName: type: string
  - description: type: string
  - limit: type: integer
  - remainingQuota: type: integer
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

### .NET — `IRateLimitsClient`

```csharp
Task<ListRateLimitsResponse> ListRateLimitsAsync(int? top = null, int? skip = null);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `int` | no |
| `skip` | `int` | no |

### Java — `RateLimitsApi`

```java
// GET /rate-limits?top={top}&skip={skip}
ListRateLimitsResponse listRateLimits(Integer top, Integer skip);
```

| Parameter | Type | Required |
|---|---|---|
| `top` | `Integer` | no |
| `skip` | `Integer` | no |