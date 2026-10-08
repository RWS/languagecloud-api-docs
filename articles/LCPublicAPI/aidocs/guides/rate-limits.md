# Rate limits

Per-tenant request limits, rejection response format and retry guidance.

Limits are subject to change without notice. Always rely on response headers; never hard-code limit values. Daily limits use a fixed window reset nightly at 00:00 UTC. Contact support to increase account limits.

## Default limits (per tenant)

| Scope | Per second | Per minute | Per day |
|---|---|---|---|
| All API requests | 10 | 200 | 200 000 |
| [CreateProject](../reference/CreateProject.md) | 2 | 10 | 500 |
| [ExportQuoteReport](../reference/ExportQuoteReport.md) | 2 | 10 | 1000 |
| Import / export Translation Memory | 2 | 10 | 2000 |
| Project file operations (below) | 5 | 200 | 5000 |

Project file operations covered by the last row, each:
- [AddSourceFile](../reference/AddSourceFile.md)
- [DownloadSourceFileVersion](../reference/DownloadSourceFileVersion.md)
- [DownloadExportedTargetFileVersion](../reference/DownloadExportedTargetFileVersion.md)
- [DownloadFileVersion](../reference/DownloadFileVersion.md)
- [AddSourceFileVersion](../reference/AddSourceFileVersion.md)
- [AddTargetFileVersion](../reference/AddTargetFileVersion.md)
- [ImportTargetFileVersion](../reference/ImportTargetFileVersion.md)

Inspect individual limits with [ListRateLimits](../reference/ListRateLimits.md).

The Auth0 token limit (16/day) is separate; see [auth.md](./auth.md). Data Bridge adds a data-volume quota; see [data-bridge.md](./data-bridge.md).

## Rejection response

Status **429** (`Too Many Requests`):

```json
{
    "errorCode": "TOO_MANY_REQUESTS_EXCEPTION",
    "message": "Quota exceeded. Please check X-RateLimit-Reset response header",
    "details": []
}
```

| Response header | Meaning |
|---|---|
| `X-RateLimit-Limit` | The exceeded quota value (e.g. `2`). Does not state which limit type was exceeded; use `X-RateLimit-Reset` and `X-RateLimit-Policy` to decide when to retry |
| `X-RateLimit-Reset` | Exact time the client can resume, RFC 1123 datetime, e.g. `Tue, 3 Jun 2008 11:05:30 GMT` |
| `X-RateLimit-Remaining` | Always `0` (reserved for future use) |
| `X-RateLimit-Policy` | Name of the violated policy (operation + time interval); see ListRateLimits |

## Recommended handling

1. Unless time-critical, send requests sequentially, not in parallel.
2. On HTTP 429: block all requests and wait until `X-RateLimit-Reset`.
3. Retry.

SDKs do not handle 429 for you; implement it yourself (see [api-clients.md](./api-clients.md)).
