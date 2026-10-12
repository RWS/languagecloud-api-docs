# Multi-region

Each Trados Cloud Platform region has its own Public API host; all requests must target the region where the account lives.

## Rules

- Host pattern: `https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/` (region codes include `eu`, `ca`).
- Accessing accounts or data that are not in the targeted region produces errors.
- Do not hard-code regional hosts in custom clients; new regions may be added. Discover regions and their Public API hosts with [List Regions](../../api/Global-Public-API.v1-fv.html#/operations/ListRegions) from the Global Public API on the global host `api.cloud.trados.com`.
- The .NET and Java SDKs already support multiple regions (see [api-clients.md](./api-clients.md)).

## Legacy domain

| Legacy | Options |
|---|---|
| `lc-api.sdl.com` | Use the Global Public API to discover the correct host for the desired region, or, if integrating only with the legacy EU region, use `api.eu.cloud.trados.com` |

## Other region-dependent behaviour

- Webhook requests carry the `X-LC-Region` header (region of the recipient's account). See [webhooks.md](./webhooks.md).
- Data Bridge daily quota reset time differs per region (EU: midnight UTC, CA: midnight EST). See [data-bridge.md](./data-bridge.md).
- Postman provides EU and CA environments; an environment-level `baseUrl` overrides the collection-level value. See [api-clients.md](./api-clients.md).
