# API rate limits

Trados Cloud Platform API enforces rate limits to prevent overuse and spikes of requests that could degrade the platform performance. 

The default limits are chosen as to cover the needs of most integrators, but there might be cases when these limits are insufficient. In this case you should contact support for help in increasing your account limits.


## Default Trados Cloud Platform API Rate Limits
> Note: Please remember our current limits and that they are subject to change without notice. You must always rely on response headers and never hardcode any limit values.

>Note: Daily limits are calculated in a fixed time window, that is reset nightly at 00:00 UTC.

Each tenant is entitled to:

1. Up to 10 API requests per second.
2. Up to 200 API requests per minute.
3. Up to 200 000 API requests per day.

####  Projects Rate Limits
For [Create Project Operation](../reference/Public-API.v1.json/paths/~1projects/post): 

each tenant is entitled to:
1. Up to 2 API requests per second.
2. Up to 10 API requests per minute.
3. Up to 500 API requests per day.

####  Export Quote Rate Limits
For [Export Quote Report](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1export/post): 

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

- [Add Source File](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files/post)
- [Download Source File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files~1{sourceFileId}~1versions~1{fileVersionId}~1download/get)
- [Download Exported Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1exports~1{exportId}~1download/get)
- [Download Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1download/get)
- [Add Source File Version](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1source-files~1{sourceFileId}~1versions/post)
- [Add Target File Version](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1target-files~1{targetFileId}~1versions/post)
- [Import Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1imports/post)

each tenant is entitled to:
1. Up to 5 API requests per second.
2. Up to 200 API requests per minute.
3. Up to 5000 API requests per day.



#### Rate Limit verification endpoint
Individual rate limits can be consulted below:

- [List Rate Limits](../reference/Public-API.v1.json/paths/~1rate-limits/get)

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
- `X-RateLimit-Policy`: the name of the Rate Limit policy that was violated, made up by the operation and the time interval. Please see also the [List Rate Limits](../reference/Public-API.v1.json/paths/~1rate-limits/get). 

## Implementation recommendations

Unless it's a time-critical scenario, don't make requests in parallel. It is better to keep all the requests in sequence.

It's important to handle responses with the HTTP Status 429. There are multiple approaches to handle it and a simple strategy would be:
1. Expect the HTTP code (429)
2. Block all the requests, and wait until `X-RateLimit-Reset` 
3. Try again. 