# Errors and issue reporting

Error response shape, known behaviours, and the information to collect when reporting an API issue.

## Error response body

```json
{
    "errorCode": "notFound",
    "message": "Invalid input on create project.",
    "details": [
        {
            "name": "project.template.id",
            "code": "notFound",
            "value": "invalid_project_template_id"
        }
    ]
}
```

| Field | Meaning |
|---|---|
| `errorCode` | Error code (e.g. `notFound`, `invalidInput`, `TOO_MANY_REQUESTS_EXCEPTION`) |
| `message` | Summary message (wording may change; do not parse) |
| `details[]` | Per-field entries: `name` (property path, e.g. `project.customFields[0]`), `code`, `value` |

Observed examples:

| Situation | Status | `errorCode` |
|---|---|---|
| Project created with unknown `projectTemplate.id` | 404 | `notFound` |
| Custom field value does not match field type | 400 | `invalidInput` |
| Rate limit exceeded | 429 | `TOO_MANY_REQUESTS_EXCEPTION` |
| Create without `location` and no access to Root | forbidden error | - |

Specific codes per endpoint are in the API reference. The .NET SDK exposes constants in the `ErrorCodes` class (see [api-clients.md](./api-clients.md)).

- 5xx can be returned by any endpoint (unexpected server error). If it persists, report it as below.
- Changes to error message descriptions are not breaking changes (see [api-lifecycle.md](./api-lifecycle.md)).

## Known behaviours

| Endpoint | Behaviour |
|---|---|
| [DownloadQuoteReport](../reference/DownloadQuoteReport.md) | One-time download: the file is deleted after a download attempt. To download again, export a new report with [ExportQuoteReport](../reference/ExportQuoteReport.md) and poll with [PollQuoteReportExport](../reference/PollQuoteReportExport.md). |
| [ExportQuoteReport](../reference/ExportQuoteReport.md) | When no Quote Template is used, the response is empty. |

## Reporting an issue

Template:

```
- Endpoint: 
- X-LC-Tenant: 
- X-LC-TraceId: 
- Request URL:
- Request body: 
- Response status code:
- Response body: 
- Expected result: 
- Actual result: 
- Description: 
```

| Item | Source |
|---|---|
| Endpoint | Link to the endpoint in the API docs |
| X-LC-Tenant | Tenant ID sent in request headers (required on all endpoints) |
| X-LC-TraceId | Unique request ID from the **response headers**; should always be provided if possible |
| Request URL | Full URL (domain, path, query parameters). If unavailable, at least the query parameters, e.g. `fields`, `top`, `skip`, `location`, `locationStrategy` |
| Request body | JSON sent |
| Response status code / body | HTTP status and body (error bodies included) |
| Expected / actual result, description | What you tried, how you got there, any workaround |

Not all fields are required; more detail speeds up investigation. Also check [multi-region.md](./multi-region.md) for regional API details.
