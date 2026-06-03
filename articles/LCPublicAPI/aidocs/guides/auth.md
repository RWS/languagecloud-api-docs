# Authentication and Identity

## Base API URL

`https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/`

Region codes are discoverable via `GET https://api.cloud.trados.com` — [List Regions](../../api/Global-Public-API.v1-fv.html#/operations/ListRegions). Do not hard-code region hosts; new regions may be added at any time. Legacy domain `lc-api.sdl.com` redirects to `api.eu.cloud.trados.com`.

## Required Headers on Every Request

| Header | Value |
|---|---|
| `Authorization` | `Bearer {access_token}` |
| `X-LC-Tenant` | Tenant ID (24-character hex, e.g. `2ef3c10e74fc39104e633c11`) |

Both headers are required on all endpoints. Headers are case-insensitive per HTTP spec.

## Service Users and Custom Applications

Service users are non-human users that authenticate via the API. They have no login credentials and access the platform only through the API.

**Setup sequence (performed by an Administrator in the Trados UI):**

1. Create a Service User: **Users → Service Users → New Service User**. Assign a name, location (folder), and one or more groups. Group membership determines the role and permissions.
2. Create a Custom Application: **Account menu → Integrations → Applications → New Application**. Assign the service user to the application.
3. Retrieve credentials from the application's **API Access** page: `Client ID` and `Client Secret`.

**Note:** Changing the service user on an existing application takes 10–20 minutes to propagate due to caching. During this period, calls may use either the old or new service user. To avoid this, create a new application instead.

## Generating a Bearer Token

Token endpoint: `POST https://sdl-prod.eu.auth0.com/oauth/token`

**JSON body:**
```json
{
  "client_id": "{{CLIENT_ID}}",
  "client_secret": "{{CLIENT_SECRET}}",
  "grant_type": "client_credentials",
  "audience": "https://api.sdl.com"
}
```

**URL-encoded form body** (`Content-Type: application/x-www-form-urlencoded`):
```
client_id={{CLIENT_ID}}&client_secret={{CLIENT_SECRET}}&grant_type=client_credentials&audience=https://api.sdl.com
```

**Response:**
```json
{
  "access_token": "eyJhbGci....",
  "expires_in": 86400,
  "token_type": "Bearer"
}
```

## Token Management

- Token expiry: `expires_in` seconds (default 86400 = 24 hours).
- Cache the token and refresh it `expires_in - buffer` seconds after issue (subtract a few minutes to avoid clock drift).
- **Maximum 16 Auth0 token requests per day** per integration. This limit applies to token requests, not to API calls.
- Scenarios that cause additional token requests: multiple application instances (each holds its own cache), application restarts (destroys cache).
- The SDKs (.NET and Java) handle token caching automatically.

## Finding the Tenant ID

In the Trados UI: profile menu → **Manage Account** → **Account Information** tab → **Trados Account ID**. Looks like `2ef3c10e74fc39104e633c11`.

## Multi-Region

All API requests are region-scoped. Data from one region is not accessible via another region's host. Use the Global API (`api.cloud.trados.com`) to discover available regions and their Public API hosts before building multi-tenant integrations.

## Response Headers

| Header | Type | Description |
|---|---|---|
| `Content-Type` | Standard | e.g. `application/octet-stream` for binary downloads |
| `Content-Disposition` | Endpoint-specific | Provides a filename for downloaded content. When both `filename` and `filename*` params are present, use `filename*` (RFC 5987 encoding). Both headers are optional — treat them as advisory. |
| `X-LC-TraceId` | Custom | Unique request identifier; always include in support tickets. |
| `Deprecation` / `Sunset` | Standard | Indicates endpoint retirement timeline. See the Public API Management Process. |

## Webhook Authentication (Outgoing)

When Trados Cloud Platform sends webhook `POST` requests, it signs the payload. See [webhooks.md](./webhooks.md) for signature validation details.
