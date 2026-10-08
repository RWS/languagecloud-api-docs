# Trados Cloud Platform API Get Public Key

Get Public Key GetPublicKey GET /.well-known/jwks.json/{kid}

- Friendly name: Get Public Key
- Operation ID: GetPublicKey
- HTTP Method: GET
- Path: /.well-known/jwks.json/{kid}

Retrieves a public key by it's identifier.

## Parameters

No parameters.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: jwk (see model section below)

### 404

Error codes:
* "notFound": the public key could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


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

### .NET — `IPublicKeysClient`

```csharp
Task<PublicKey> GetPublicKeyAsync(string kid);
```

| Parameter | Type | Required |
|---|---|---|
| `kid` | `string` | yes |

### Java — `PublicKeysApi`

```java
// GET /.well-known/jwks.json/{kid}
Jwk getPublicKey(String kid);
```

| Parameter | Type | Required |
|---|---|---|
| `kid` | `String` | yes |