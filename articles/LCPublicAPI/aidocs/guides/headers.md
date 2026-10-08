# Headers

Reference for the standard, custom and endpoint-specific headers used by the Public API, and how to handle optional response headers.

Headers must be treated as case-insensitive.

## Header classes

| Type | Example |
|---|---|
| Standard | `Content-Type` |
| Custom | `X-LC-TraceId` |
| Endpoint specific | `Content-Disposition` |

## Request headers

See [auth.md](./auth.md): `Authorization: Bearer {token}` and `X-LC-Tenant: {tenantId}` on every call.

## Trace ID

`X-LC-TraceId` is a unique request identifier returned in response headers. Always include it when reporting an issue (see [errors.md](./errors.md)). The Java and .NET SDKs generate a unique trace ID per request when using the provided credential-based clients.

## Content-Type

`application/octet-stream` indicates arbitrary binary data; a consumer should offer to save it as a file.

## Content-Disposition

Sent on file-like responses (downloads/exports) to supply a file name, e.g. [DownloadSourceFileVersion](../reference/DownloadSourceFileVersion.md), [DownloadFileVersion](../reference/DownloadFileVersion.md), [DownloadQuoteReport](../reference/DownloadQuoteReport.md).

```
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="Public API Download.pdf"; filename*=UTF-8''Public%20API%20Download.pdf
```

Rules:
- `Content-Type` and `Content-Disposition` are **optional** on all endpoints. There is no guarantee an endpoint that returned them before will continue to do so.
- `filename` and `filename*` are matched case-insensitively.
- `filename*` uses RFC 5987 encoding (allows characters outside ISO-8859-1). When both are present, **use `filename*` and ignore `filename`**.
- If the header is missing, or a different name is wanted, supply your own file name and extension; the extension can usually be inferred from `Content-Type` and the invoked operation.

## Rate limit headers

`X-RateLimit-Limit`, `X-RateLimit-Reset`, `X-RateLimit-Remaining`, `X-RateLimit-Policy` on HTTP 429 responses. See [rate-limits.md](./rate-limits.md).

## Webhook headers

`X-LC-Signature`, `X-LC-Signature-Algo`, `X-LC-Retry-Num`, `X-LC-Retry-Reason`, `X-LC-Transmission-Time`, `X-LC-Application`, `X-LC-Webhook`, `X-LC-Region`. See [webhooks.md](./webhooks.md).

## Deprecation and sunset headers

Used in the endpoint retirement process. See [api-lifecycle.md](./api-lifecycle.md).
