# Trados Cloud Platform API List Public Keys

List Public Keys ListPublicKeys GET /.well-known/jwks.json

- Friendly name: List Public Keys
- Operation ID: ListPublicKeys
- HTTP Method: GET
- Path: /.well-known/jwks.json

List all available Public Keys.

## Parameters

No parameters.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: well-known-jwks-response (see model section below)

### 416

Error codes:
* "requestedRangeNotSatisfiable":  The requested entity or one of it's dependencies attempted to retrieve data outside the allowed range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: well-known-jwks-response
<a id="well-known-jwks-response"></a>

```
type: object
properties:
  - keys: $ref: #/components/schemas/list-jwks
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

## Model: list-jwks
<a id="list-jwks"></a>

```
type: array
items:
  $ref: #/components/schemas/jwk
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

## Model: jwk
<a id="jwk"></a>

```
type: object
  description: A Json Web Key. 
<br>
See https://datatracker.ietf.org/doc/html/rfc7517 for details.
properties:
  - kty: type: string
  - n: type: string
  - e: type: string
  - alg: type: string
  - kid: type: string
  - use: type: string
```

## SDK

### .NET — `IPublicKeysClient`

```csharp
Task<ListPublicKeysResponse> ListPublicKeysAsync();
```

### Java

_Not found in Java SDK — [Manual Review Needed]_