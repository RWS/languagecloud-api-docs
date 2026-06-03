# Rate Limits

Rate limits are enforced per tenant. Limits are subject to change; always read values from response headers rather than hard-coding them.

Daily limits reset at **00:00 UTC** (fixed window).

## Default Limits (All Endpoints)

| Window | Limit |
|---|---|
| Per second | 10 requests |
| Per minute | 200 requests |
| Per day | 200,000 requests |

## Endpoint-Specific Limits

| Operation | Per Second | Per Minute | Per Day |
|---|---|---|---|
| Create Project | 2 | 10 | 500 |
| Export Quote Report | 2 | 10 | 1,000 |
| Import/Export Translation Memory | 2 | 10 | 2,000 |
| Add/Download Source File, Add/Download/Import Target File | 5 | 200 | 5,000 |

Use [List Rate Limits](../../api/Public-API.v1-fv.html#/operations/ListRateLimits) to retrieve current limits programmatically.

## 429 Response

```json
{
  "errorCode": "TOO_MANY_REQUESTS_EXCEPTION",
  "message": "Quota exceeded. Please check X-RateLimit-Reset response header",
  "details": []
}
```

HTTP status: `429 Too Many Requests`

## Rate Limit Response Headers

| Header | Description |
|---|---|
| `X-RateLimit-Limit` | The quota that was exceeded (numeric value). |
| `X-RateLimit-Reset` | DateTime (RFC-1123) when the client may resume. E.g. `Tue, 3 Jun 2008 11:05:30 GMT`. |
| `X-RateLimit-Remaining` | Always `0` (reserved for future use). |
| `X-RateLimit-Policy` | Name of the violated policy (operation + interval). |

## Handling 429

Recommended retry strategy:
1. Detect HTTP 429.
2. Suspend all requests.
3. Wait until `X-RateLimit-Reset`.
4. Retry.

Unless the scenario is time-critical, prefer sequential requests over parallel ones to reduce the likelihood of hitting limits.
