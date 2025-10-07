# Headers considerations

The purpose of this page is to showcase the header types that could capture your interest.

> Headers must be treated as [case-insensitive](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers).

The Trados Cloud Platform API response headers can be classified as follows:

Header type | Example 
---------|----------
 Standard | `Content-Type`
 Custom | `X-LC-TraceId` 
 Endpoint specific | `Content-Disposition`

## Content-Type header

The `application/octet-stream` content type  is used to indicate that a body contains arbitrary binary data. The recommended action for a consumer that receives an
`application/octet-stream` entity is to simply offer to put the data
in a file, read more in the [RFC2046](https://www.rfc-editor.org/rfc/rfc2046#section-4.5.1) space.

## Content-Disposition header

For operations expected to return content that can be handled as a file, the `Content-Disposition` header can be sent in the response headers to provide more information about the response payload. The Trados Cloud Platform API will provide this header in certain situations, and its primary goal is to supply a file name for the content being downloaded or exported.
You can read more about the `Content-Disposition` header on the [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Disposition) website or in the [RFC6266](https://www.rfc-editor.org/rfc/rfc6266) space.

The `Content-Disposition` response header can be usually found on various download API endpoints like [Download Source File Version](../api/Public-API.v1-fv.html#/operations/DownloadSourceFileVersion), [Download Target File Version](../api/Public-API.v1-fv.html#/operations/DownloadFileVersion), [Download Exported Quote Report](../api/Public-API.v1-fv.html#/operations/DownloadQuoteReport) and others.

> Please note that both `Content-Type` and `Content-Disposition` are  **not required** and APIs might not include them in the response. There are no guarantees that an endpoint that used to return a `Content-Type` or `Content-Disposition` header will still do so, under any circumstance. Please treat these headers as **optional** for all APIs.

### Retrieving the file name

Here's an example of how the `Content-Type` and the `Content-Disposition` headers look like:
```
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="Public API Download.pdf"; filename*=UTF-8''Public%20API%20Download.pdf
```

The parameters `filename` and `filename*`, to be matched case-
insensitively, provide information on how to construct a filename for
storing the message payload.

The parameters `filename` and `filename*` differ only in that
`filename*` uses the encoding defined in [RFC5987](https://www.rfc-editor.org/rfc/rfc5987), allowing the use of characters not present in the ISO-8859-1 character set.

> When both `filename` and `filename*` are present in a single header field value, you **must** pick `filename*` and ignore `filename`.

If the `Content-Disposition` header is missing or you simply want to have a different file name, you need to provide a name and the file extension. The extension can be usually inferred from the required `Content-Type` header and also from the operation that is invoked.


## Deprecation and sunset headers

These types of headers are used in our endpoint retirement process and are covered broadly in the [Public API Management Process](../docs/Public-API-Management-Process.md#endpoint-retirement-process) page.
