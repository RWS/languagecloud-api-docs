# Authentication

We recommend using the provided [Postman Collection](../docs/Language-Cloud-APIs-for-Postman.md) to get started.

## Base API URL
The base API address is **`https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/`**.
> [!NOTE]
> Check the [Multi-Region](../docs/Multi-region.md) page for regional API details.

## Authorization headers
When making any call to the Trados Cloud Platform API, make sure you provide the following `Header` information:
- `Authorization` = access token
- `X-LC-Tenant` = tenant ID

Also note that the `Authorization` header should use the Bearer schema, for example:
```
Authorization: Bearer {{token}}
```
</br>

## How do I find the tenant ID?

A service user can be part of only one account. If you're not sure what the tenant ID is for a service user, you can:

1. Log in to the Trados UI, and make sure to select the same account where the service user was created.
2. In the top right-hand corner, select your profile, and then select **Manage Account**.
3. In the **Account Information** tab, check the value for **Trados Account ID**.

> [!NOTE]
> There are 2 identifiers that might be confused. The identifier you need looks something like this: **2ef3c10e74fc39104e633c11**.
</br>

## Generating the Bearer Token

For generating the token, Trados Cloud Platform API uses the Auth0 authorization server (`https://sdl-prod.eu.auth0.com/oauth/token`) and the [client credentials flow](https://auth0.com/docs/flows/client-credentials-flow).

The request to Auth0 can be done using JSON or URL Form Encoded. There is no difference between them, so you can choose whichever best suits you in terms of code. Here are some example payloads for both approaches:

`POST` to `https://sdl-prod.eu.auth0.com/oauth/token` with `Content-Type: application/json`:
```
{
    "client_id": "{{the client ID for the application}}",
    "client_secret": "{{the Client Secret for the application}}",
    "grant_type": "client_credentials",
    "audience":"https://api.sdl.com"
}
```
Alternatively, you can `POST` to `https://sdl-prod.eu.auth0.com/oauth/token` with `Content-Type: application/x-www-form-urlencoded`:

```json
client_id={{the Client ID for the application}}&client_secret={{the Client Secret for the application}}&grant_type=client_credentials&audience=https://api.sdl.com
```


The response will be a JSON that contains the token, for example:
```json
{
  "access_token": "eyJhbGciO....4NXz8TXatw",
  "expires_in": 86400,
  "token_type": "Bearer"
}
```
The token is provided in the `access_token` property. This is then used to make authenticated calls to the Trados Cloud Platform API by using the Authorization header, and the X-LC-Tenant header:
```json
Authorization: Bearer {{access_token}}
X-LC-Tenant: {{tenantId}}
```
</br>

## Token management

The previous example of an Auth0 response body that contains the `access_token`, also contains an expiry value `"expires_in": 86400`. That property informs the service of how long the token is valid for. An application should use this value to cache the token for that duration minus a few minutes (to avoid clock drift issues).

The application is responsible for getting a fresh token once the token is about to expire, by using the same mechanism described above.

> [!NOTE]
> While it's technically possible to get a fresh token for every single call, there is no reason to do so, and the calling application IP risks to be blocked by Auth0 as it might consider it a DoS attack.

> [!WARNING]
> Please limit the number of requests for the Bearer token to a maximum of 16 per day. It's acceptable to exceed this limit only if you need to deploy multiple versions of your application, in a single day.
