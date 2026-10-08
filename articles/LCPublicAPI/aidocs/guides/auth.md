# Authentication

Authenticate with an OAuth2 client-credentials Bearer token (Auth0) plus the `X-LC-Tenant` header on every Public API call; credentials come from a custom application bound to a service user.

## Base URL

```
https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/
```

`{REGION_CODE}` is region-specific (e.g. `eu`, `ca`). See [multi-region.md](./multi-region.md).

## Required request headers

| Header | Value |
|---|---|
| `Authorization` | `Bearer {access_token}` |
| `X-LC-Tenant` | Tenant (account) ID, e.g. `2ef3c10e74fc39104e633c11` |

`X-LC-Tenant` is required on all endpoints. A service user belongs to exactly one account.

Finding the tenant ID (UI): Manage Account → Account Information tab → **Trados Account ID** (select the same account where the service user was created). Two similar identifiers exist; the tenant ID looks like `2ef3c10e74fc39104e633c11`. In Postman and Data Bridge the `{{lc_tenant}}` variable is the account ID prefixed with `LC-` (e.g. `LC-00000000000000000`).

## Generating the token

- Auth server: `https://sdl-prod.eu.auth0.com/oauth/token`
- Flow: client credentials
- `Content-Type`: `application/json` or `application/x-www-form-urlencoded` (equivalent)

JSON request:

```http
POST https://sdl-prod.eu.auth0.com/oauth/token
Content-Type: application/json

{
    "client_id": "{{client_id}}",
    "client_secret": "{{client_secret}}",
    "grant_type": "client_credentials",
    "audience": "https://api.sdl.com"
}
```

Form-encoded request body:

```
client_id={{client_id}}&client_secret={{client_secret}}&grant_type=client_credentials&audience=https://api.sdl.com
```

Response:

```json
{
  "access_token": "eyJhbGciO....4NXz8TXatw",
  "expires_in": 86400,
  "token_type": "Bearer"
}
```

Use the token on API calls:

```http
Authorization: Bearer {{access_token}}
X-LC-Tenant: {{tenantId}}
```

## Token management

| Rule | Detail |
|---|---|
| Lifetime | `expires_in` = 86400 s (24 h) |
| Caching | Cache the token for `expires_in` minus a few minutes (clock drift) |
| Refresh | Application must fetch a new token before expiry using the same request |
| Auth0 request limit | Max **16 token requests per day**; may exceed only when deploying multiple application versions in one day |
| Per-call tokens | Do not request a token per API call; the calling IP risks being blocked by Auth0 as a suspected DoS |

The 16/day limit applies to Auth0 token requests only, not to API calls (see [rate-limits.md](./rate-limits.md)).

Extra token requests happen when:
- Multiple application instances run (each holds its own cache).
- The application restarts (cache and token are lost).

## Service users and applications

- Service users are non-human users, have no login credentials, and can access the platform only through the API.
- Administrators (human Administrator user type) manage service users. A service user is placed in one or more groups; each group has a predefined role with a set of permissions, and resource access follows those permissions.
- One service user is assigned per custom application.
- When a client authenticates with application credentials, API calls assume the identity of the service user for authorization.

## Obtaining client credentials (UI steps, performed by an Administrator)

1. **Add a service user**: Users view → **Service Users** sub-tab → **New Service User**.
   - **Name** (unique), **Location** (Root or a child folder), **Groups** (from the same Location), optional **Description** → **Create**.
2. **(Optional) Additional notification users**: select the service user → **Additional users to notify** (existing users notified by email) → **Save**.
3. **Create a custom application**: account menu → **Integrations** → **Applications** sub-tab → **New Application**.
   - **Name** (unique), optional **URL**, optional **Description**, **Service User** (dropdown) → **Add**.
   - Select the application → **Edit**:
     - **Overall Information**: name, URL, description.
     - **Webhooks**: default callback URL and per-event webhook URLs (see [webhooks.md](./webhooks.md)). Deleting the application deletes its webhooks.
     - **API Access**: **Client ID** and **Client Secret**.

> Changing the application's service user later is not recommended: due to caching layers the change takes 10 to 20 minutes to take effect, and during that window calls may randomly use either the old or the new service user. If services cannot be paused, create a new application with the new service user and delete the old one.

## Related

- Region hosts: [multi-region.md](./multi-region.md)
- Header behaviour: [headers.md](./headers.md)
- Folders, locations and permissions: [locations-folders.md](./locations-folders.md)
- SDK token handling: [api-clients.md](./api-clients.md)
