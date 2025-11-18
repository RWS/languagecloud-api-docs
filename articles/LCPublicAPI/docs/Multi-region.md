---
stoplight-id: nfdrob1smwn00
---

# Multi-region

Trados Cloud Platform operates in multiple regions, and it's essential to know how to use the Public API correctly for each region.

Each region has a unique Public API host, and all requests must be specific to that region. If you try to access accounts or data not available in a region, you will encounter errors.

## Legacy integrations

The domains for the Trados Cloud Platform API have been updated. If you are using the old domain `lc-api.sdl.com` in a legacy integration, please consider the following options:
- Use the new endpoints to discover the correct Public API host for your desired region.
- If you are only integrating with the EU region (legacy), update the host to: `api.eu.cloud.trados.com`

## Supporting multi-region

This information is especially relevant if you are building multi-tenant integrations.

The provided .NET and Java SDKs already support multiple regions. For details on using these SDKs, refer to their documentation.


> [!NOTE]
> If you're building your own client, avoid hard-coding Trados Cloud Platform API hosts, as new regions may be added in the future, requiring updates to hard-coded hosts. You can discover all available regions and their corresponding Public API hosts using the [List Regions](../api/Global-Public-API.v1-fv.html#/operations/ListRegions) endpoint from the new Global Public API, which is accessible on a new global host `api.cloud.trados.com`.
