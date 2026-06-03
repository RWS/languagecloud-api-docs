# Guides Index

| Guide | Description |
|---|---|
| [api-clients.md](./api-clients.md) | Both SDKs are auto-generated from the API contracts. Minor version bumps do not guarantee backward compatibility. |
| [async-polling.md](./async-polling.md) | Several API operations are asynchronous: they accept a request, return an identifier, and complete in the background.... |
| [auth.md](./auth.md) | `https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/` |
| [custom-fields.md](./custom-fields.md) | Custom Fields allow associating typed metadata with projects. Definitions are configured in the Trados UI; values are... |
| [errors.md](./errors.md) | Every API response includes an `X-LC-TraceId` response header containing a unique UUID for the request. Always captur... |
| [fields.md](./fields.md) | All endpoints returning a resource representation support the `fields` query parameter for selecting which properties... |
| [file-upload.md](./file-upload.md) | File upload endpoints use `multipart/form-data`. The API follows standard HTTP/1.1 (RFC 2616 and subsequent RFCs). |
| [locations-folders.md](./locations-folders.md) | Trados Cloud Platform uses a hierarchical folder structure for organizing and controlling access to resources. Each r... |
| [pagination.md](./pagination.md) | Applies to all `GET` list endpoints that return a collection with a total count. |
| [project-lifecycle.md](./project-lifecycle.md) | - Service user and application credentials configured (see auth.md). |
| [put-semantics.md](./put-semantics.md) | All update (`PUT`) endpoints follow JSON Merge Patch semantics (RFC 7396). |
| [rate-limits.md](./rate-limits.md) | Rate limits are enforced per tenant. Limits are subject to change; always read values from response headers rather th... |
| [translation-memory.md](./translation-memory.md) | Supported input formats: `tmx`, `sdltm`, `zip`, `tmx.gz`, `sdlxliff`. |
| [webhooks.md](./webhooks.md) | Webhooks deliver `POST` HTTP notifications to your endpoint when events occur in a Trados Cloud Platform account. Web... |