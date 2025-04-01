# Request Authentication

Requests made from Trados to the app are authenticated, except for some public endpoints on the app. Getting the current account identity is explained in this article in the [**Trados Claims** section](#trados-claims).

## Endpoints

All but a few of the endpoints are required to check for valid Authentication. The API documentation specifies for each endpoint if authentication is required.

Trados might send the Authorization header even on the endpoints that do not need authentication, but the app is not required to validate them. If the header is sent, the app should either ignore it or validate it. But if the token is not valid, then this should result in a 401/403 result.

> Note: the provided blueprints (both Java and .NET Core) have authentication implemented and working out of the box. You can skip the rest of this document unless you're interested in the technical details.

## Authorization header

The HTTPS requests are all authenticated using the `x-lc-signature` header using a JWS token. For example:

```
x-lc-signature: <JWS Token>
```

## JSON Web Signature token

Trados follows the JWS RFCs [\[RFC 7797\]](https://datatracker.ietf.org/doc/html/rfc7797) and [\[RFC 7515\]](https://datatracker.ietf.org/doc/html/rfc7515) for defining the structure of the JSON Web Signature token that contains the signature that validates the authenticity of the request.

If you're already familiar with JWT tokens, you can treat the JWS as a JWT, with the main difference being the token-body component, which is not part of the token (in our Trados implementation) - it is replaced with the hash signature of the request body. All claims are sent in the JWS header.

### JWS validation

The JWS token consists of 3 parts: `<JWS header>.<JWS body>.<JWS signature>` The 3 parts are Base64url encoded and separated with a dot: '.'. The JWS token that is received in the `x-lc-signature` header has only the header and signature components, with the body missing (`<JWS header>..<JWS signature>`).

`<JWS body>` is omitted from the received JWS, following the RFC 7515 - Detached content approach. It should be calculated, when received, on the app side:
```
<JWS body> = Base64url(SHA256(HTTP Payload)) 
```

If the request does not contain a body (ex. in the case of GET requests), then it's calculated as an empty string `''`. In that case `<JWS body>` can be replaced with the constant: `47DEQpj8HBSa-_TImW-5JCeuQeRkm5NMpJWZG3hSuFU` which is equivalent to `Base64url(SHA256(''))`.

Once the `<JWS body>` is calculated, the JWS token should be considered in its entirety as `<JWS header>.<JWS body>.<JWS signature>`. 

The `<JWS signature>` on the received JWS token needs to be validated. The validation is done using the public keys that are available at `https://lc-api.sdl.com/public-api/v1/.well-known/jwks.json` (this endpoint is public and does not require authentication).

Since the JWS body is the hash of the HTTP request payload, the JWS token will have all the claims defined in the header segment `<JWS header>`.

JWS `kid` claim is used to identify the public key that the JWS was signed with.

Signing will be done using the SHA256withRSA algorithm which is standard for JWS (`"alg":"RS256"`). But since algorithms change, you should not hard code the algorithms, but always rely on the `alg` claim to identify the signing algorithm.

Once the signature was validated, you should also validate the other claims:

- `iss` - the issuer of the token. Must be `https://languagecloud.rws.com/`. It is required.
- `aud` - the audience should match `baseUrl` from the descriptor. This ensures that the token was generated for that particular app. It is required.
- `exp` - expiry time of the token, expired tokens should not be accepted. It is required.
- `iat` - issued at time. Tokens issued in the future should not be allowed. It is optional and should be validated only if present.

Clock skew should be taken into consideration when validating time claims. A few seconds (up to 60) should be added to validation limits. For example for `iat` claim, it should be checked that it's not issued before `now() - clockSkew`, otherwise with under 1-second clock differences there might be cases where `iat` can be in the future because the receiving server clock is 1 second behind the Trados server, and the token will not validate.

#### Validating multiple audiences

There will always be a single `aud` claim in the JWS. But in the rare case when an App changes `baseUrl`, the received `aud` will be either the old or new `baseUrl`. All operations for accounts that did not yet update to the version with the new `baseUrl` will send `aud` claim with the old `baseUrl`.

The provided blueprints and samples by default handle a single `baseUrl`, and will fail with authentication issues in such a scenario.

In .NET, validating `aud` against multiple audiences is fairly simple. In `appsettings.json` add a key for `previousBaseUrl` set it to the value of previous `baseUrl`. In `Startup.cs` find `services.AddAuthentication` and update it to looks similar to:

```csharp
services.AddAuthentication(JwsDefaults.AuthenticationScheme)
    .AddJws(options =>
    {
        options.JwksUri = Configuration["Authorization:JwksUri"];
        options.TokenValidationParameters.ValidIssuer = Configuration["Authorization:Issuer"];
        options.TokenValidationParameters.ValidAudiences = new[] {
            Configuration["baseUrl"],
            Configuration["previousBaseUrl"]
        };
    });
```

In Java, this can be accomplished by adding multiple values, separated by commas, to the `authentication.audience` parameter in the [application.yml](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppBlueprint/src/main/resources/application.yml#L61) file. For example:

```yaml
authentication:
  ...
  audience: https://my.base.url,https://my.previous.base.url
```

### Trados Claims

Trados can send any number of custom claims (in the JWS header segment), to provide additional information as to the current identity.

`aid` is used for identifying the current Account(known as Tenant). This should be used for any operations that perform account-related operations. For example: saving the configuration to a database should always be tied to an account.
