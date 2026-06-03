# Trados Cloud Platform API Export Quote Report

Export Quote Report ExportQuoteReport POST /projects/{projectId}/quote-report/export

- Friendly name: Export Quote Report
- Operation ID: ExportQuoteReport
- HTTP Method: POST
- Path: /projects/{projectId}/quote-report/export

Generates an asynchronous quote export operation for the project in either PDF or Excel format. Use the [polling endpoint](../api/Public-API.v1-fv.html#/operations/PollQuoteReportExport) to check when the export is completed.  <br><br>
Built-in quotes are only available in the same languages as the user interface. See [this page](https://docs.rws.com/791595/1084405/trados-enterprise---accelerate/ui-languages) for more information. <br>
Customers who use non-default quote templates are responsible for the implementation of a suitable localization approach.

> [!WARNING] 
> The export ID has a time-to-live (TTL) of 20 minutes, starting from when this export operation is initiated (not when the underlying async operation completes). Ensure you poll and download the export within this timeframe, or you will receive a `404 Not Found` error.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **format** (query, string) - optional: The file format of the quote report.
- **languageId** (query, string) - optional: The language used for localization.

## Request body

No request body.

## Response

### 202

Accepted

- Content: application/json
- Schema: export-quote-report-response (see model section below)

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
* "forbidden": the authenticated user is not allowed to read resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the project could not be found.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "conflict": the project is in a phase which doesn’t allow the quote to be exported.

- Content: application/json
- Schema: error-response (see model section below)


## Model: export-quote-report-response
<a id="export-quote-report-response"></a>

```
type: object
  description: Export quote report response.
properties:
  - id: type: string
```

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
Task ExportQuoteReportAsync(string projectId, Format2? format = null, string languageId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `format` | `Format2` | no |
| `languageId` | `string` | yes |

### Java — `QuoteApi`

```java
// POST /projects/{projectId}/quote-report/export?format={format}&languageId={languageId}
ExportQuoteReportResponse exportQuoteReport(String projectId, String format, String languageId);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `format` | `String` | no |
| `languageId` | `String` | no |