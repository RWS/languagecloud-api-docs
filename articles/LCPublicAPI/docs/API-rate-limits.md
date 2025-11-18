# API rate limits

Trados Cloud Platform API enforces rate limits to prevent overuse and spikes of requests that could degrade the platform performance. 

The default limits are chosen as to cover the needs of most integrators, but there might be cases when these limits are insufficient. In this case you should contact support for help in increasing your account limits.


## Default Trados Cloud Platform API Rate Limits
> [!NOTE]
> Please remember our current limits and that they are subject to change without notice. You must always rely on response headers and never hardcode any limit values.

> [!NOTE]
> Daily limits are calculated in a fixed time window, that is reset nightly at 00:00 UTC.

Each tenant is entitled to:

1. Up to 10 API requests per second.
2. Up to 200 API requests per minute.
3. Up to 200 000 API requests per day.

####  Projects Rate Limits
For [Create Project Operation](../api/Public-API.v1-fv.html#/operations/CreateProject): 

each tenant is entitled to:
1. Up to 2 API requests per second.
2. Up to 10 API requests per minute.
3. Up to 500 API requests per day.

####  Export Quote Rate Limits
For [Export Quote Report](../api/Public-API.v1-fv.html#/operations/ExportQuoteReport): 

each tenant is entitled to:
1. Up to 2 API requests per second.
2. Up to 10 API requests per minute.
3. Up to 1000 API requests per day.

#### Import / Export Translation Memory limits:
1. Up to 2 API requests per second.
2. Up to 10 API requests per minute.
3. Up to 2000 API requests per day.

####  Project Files Rate Limits
For each of the API operations listed below:

- [Add Source File](../api/Public-API.v1-fv.html#/operations/AddSourceFile)
- [Download Source File Version](../api/Public-API.v1-fv.html#/operations/DownloadSourceFileVersion)
- [Download Exported Target File Version](../api/Public-API.v1-fv.html#/operations/DownloadExportedTargetFileVersion)
- [Download Target File Version](../api/Public-API.v1-fv.html#/operations/DownloadFileVersion)
- [Add Source File Version](../api/Public-API.v1-fv.html#/operations/AddSourceFileVersion)
- [Add Target File Version](../api/Public-API.v1-fv.html#/operations/AddTargetFileVersion)
- [Import Target File Version](../api/Public-API.v1-fv.html#/operations/ImportTargetFileVersion)

each tenant is entitled to:
1. Up to 5 API requests per second.
2. Up to 200 API requests per minute.
3. Up to 5000 API requests per day.



#### Rate Limit verification endpoint
Individual rate limits can be consulted below:

- [List Rate Limits](../api/Public-API.v1-fv.html#/operations/ListRateLimits)

## Rejection response

In case a request is blocked or rejected the following details are sent to the Client:

Error Response Status Code: **TOO_MANY_REQUESTS** (429, "Too Many Requests"). Example of a response message:
```json
{
    "errorCode": "TOO_MANY_REQUESTS_EXCEPTION",
    "message": "Quota exceeded. Please check X-RateLimit-Reset response header",
    "details": []
}
```

Response headers can provide more details:
- `X-RateLimit-Limit`: the limit that was exceeded. For example, the value "2" represents the available quota. It does not provide the type of limit that has been exceeded, for those details  the `X-RateLimit-Reset` and `X-RateLimit-Policy` should be used (for deciding when to retry the call).
- `X-RateLimit-Reset`: the exact moment in time when the Client can resume activity. This is datetime in RFC-1123 format, for example: "Tue, 3 Jun 2008 11:05:30 GMT".
- `X-RateLimit-Remaining`: the value is always  "0". This is reserved for future enhancements.
- `X-RateLimit-Policy`: the name of the Rate Limit policy that was violated, made up by the operation and the time interval. Please see also the [List Rate Limits](../api/Public-API.v1-fv.html#/operations/ListRateLimits). 

## Implementation recommendations

Unless it's a time-critical scenario, don't make requests in parallel. It is better to keep all the requests in sequence.

It's important to handle responses with the HTTP Status 429. There are multiple approaches to handle it and a simple strategy would be:
1. Expect the HTTP code (429)
2. Block all the requests, and wait until `X-RateLimit-Reset` 
3. Try again. 
