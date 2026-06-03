# Trados Cloud Platform API Poll Quote Report Export

Poll Quote Report Export PollQuoteReportExport GET /projects/{projectId}/quote-report/export

- Friendly name: Poll Quote Report Export
- Operation ID: PollQuoteReportExport
- HTTP Method: GET
- Path: /projects/{projectId}/quote-report/export

Polls a quote report via an export operation. The quote report can be [downloaded](../api/Public-API.v1-fv.html#/operations/DownloadQuoteReport) once the status is "completed". The recommended polling interval is 20 seconds.

If the `exportId` query parameter is not provided, the polling action will return the status for the last generated export.

> [!WARNING] 
> The export ID has a time-to-live (TTL) of 20 minutes, starting from when the export operation was initiated (not when the underlying async operation completes). If the TTL expires, this endpoint will return a `404 Not Found` error. Ensure you poll and download the export within this timeframe.


## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **format** (query, string) - optional: The file format of the quote report.
- **exportId** (query, string) - optional: The export identifier.

## Request body

No request body.

## Response

### 200



- Content: application/json
```
type: object
properties:
  - status: type: string enum: [inProgress, completed]
```

### 400

Error codes:
* “invalid”: invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project could not be found.

- Content: application/json
- Schema: error-response (see model section below)


## Model: error-response
<a id="error-response"></a>

```
type: object
  description: Error response properties.
properties:
  - message: type: string
  - errorCode: type: string
  - details: type: array
    items:
      $ref: #/components/schemas/error-detail-response
```

## Model: error-detail-response
<a id="error-detail-response"></a>

```
type: object
  description: Error detail response properties.
properties:
  - name: type: string
  - code: type: string
  - value: type: string
```

## SDK

### .NET — `IQuoteClient`

```csharp
Task PollQuoteReportExportAsync(string projectId, Format2? format = null, string exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `format` | `Format2` | no |
| `exportId` | `string` | yes |

### Java — `QuoteApi`

```java
// GET /projects/{projectId}/quote-report/export?format={format}&exportId={exportId}
PollQuoteReportExport200Response pollQuoteReportExport(String projectId, String format, String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `format` | `String` | no |
| `exportId` | `String` | no |