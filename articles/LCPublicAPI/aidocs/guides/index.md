# Guides Index

| Guide | Description |
|---|---|
| [api-clients.md](./api-clients.md) | Installation, client initialization, authentication options, error handling and Postman setup for the Trados Cloud Pl... |
| [api-lifecycle.md](./api-lifecycle.md) | Definition of breaking changes, endpoint deprecation and sunset signalling, and notice periods. |
| [async-polling.md](./async-polling.md) | Long-running operations return an accepted/queued response with an identifier; poll a status endpoint until completio... |
| [auth.md](./auth.md) | Authenticate with an OAuth2 client-credentials Bearer token (Auth0) plus the `X-LC-Tenant` header on every Public API... |
| [custom-fields.md](./custom-fields.md) | Custom fields attach custom data to projects; definitions are created in the UI and read through the API. |
| [data-bridge.md](./data-bridge.md) | Read-only OData v4 API for analytical data (projects, tasks, costs, leverage, evaluation); same authentication as the... |
| [errors.md](./errors.md) | Error response shape, known behaviours, and the information to collect when reporting an API issue. |
| [fields.md](./fields.md) | Every endpoint that returns a resource representation accepts a `fields` query parameter to choose which properties a... |
| [file-formats.md](./file-formats.md) | Source and target files exist in native, SDLXLIFF or BCM format; which operations are allowed depends on the workflow... |
| [file-upload.md](./file-upload.md) | How to build `multipart/form-data` requests for upload endpoints when not using an SDK. |
| [headers.md](./headers.md) | Reference for the standard, custom and endpoint-specific headers used by the Public API, and how to handle optional r... |
| [language-codes.md](./language-codes.md) | Language codes in responses are case-insensitive; send correctly cased codes in requests. |
| [locations-folders.md](./locations-folders.md) | Resources live in a hierarchical folder tree; access depends on the folder and the user's groups, and list endpoints ... |
| [multi-region.md](./multi-region.md) | Each Trados Cloud Platform region has its own Public API host; all requests must target the region where the account ... |
| [pagination.md](./pagination.md) | List (`GET` collection) endpoints return items plus a total count and accept `top`, `skip` and `sort` query parameters. |
| [projects.md](./projects.md) | How to create, start, track and complete translation projects, and how to interact with tasks. |
| [put-semantics.md](./put-semantics.md) | All update (`PUT`) endpoints follow JSON Merge Patch semantics (RFC 7386); arrays are replaced entirely. |
| [quotes.md](./quotes.md) | Update a project quote through the `quote` field of `PUT /projects/{projectId}`, and export a quote report as PDF or ... |
| [rate-limits.md](./rate-limits.md) | Per-tenant request limits, rejection response format and retry guidance. |
| [termbases.md](./termbases.md) | Create and update termbases and termbase templates, manage entries and cross-references, and import/export termbases. |
| [translation-api.md](./translation-api.md) | Use a translation engine to look up translations, search concordance, and add or update translation units in its tran... |
| [translation-memory.md](./translation-memory.md) | Import and export of translation memories (TMs), and TM hard filters and field updates in project and project templat... |
| [webhooks.md](./webhooks.md) | Trados Cloud Platform calls an HTTPS endpoint you expose (HTTP `POST`) when events occur; delivery is signed, retried... |