# Trados Cloud Platform API List Service Types

List Service Types ListTranslationServiceTypes GET /translation-domain/service-types

- Friendly name: List Service Types
- Operation ID: ListTranslationServiceTypes
- HTTP Method: GET
- Path: /translation-domain/service-types

List all available service types.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: list-translation-service-types-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-translation-service-types-response
<a id="list-translation-service-types-response"></a>

```
type: object
  description: A response for the List Translation Service Types endpoint.
properties:
  - itemCount: type: integer
  - items: type: array
    items:
      $ref: #/components/schemas/translation-service-type
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

## Model: translation-service-type
<a id="translation-service-type"></a>

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

### .NET — `ITranslationDomainClient`

```csharp
Task<ListTranslationServiceTypesResponse> ListTranslationServiceTypesAsync();
```

### Java

_Not found in Java SDK — [Manual Review Needed]_