# Error Reporting and Diagnostics

## X-LC-TraceId

Every API response includes an `X-LC-TraceId` response header containing a unique UUID for the request. Always capture and log this value; it is the primary identifier needed when reporting issues to support.

## Support Issue Template

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

### Field notes

| Field | Notes |
|---|---|
| Endpoint | Link to the specific operation in the API docs. |
| X-LC-Tenant | Tenant identifier sent in the request header. |
| X-LC-TraceId | From the response header. **Always provide if available.** |
| Request URL | Full URL including domain, path, and query parameters. Most relevant params: `fields`, `top`, `skip`, `location`, `locationStrategy`. |
| Request body | JSON payload sent. |
| Response status code | HTTP status returned. |
| Response body | Full response, including error bodies. |

## Common Error Response Shape

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

## Example Populated Report

```
- Endpoint: https://eu.cloud.trados.com/lc/api-docs/025707d21ecc0-create-project
- X-LC-Tenant: <YOUR_TENANT_ID>
- X-LC-TraceId: 90d9147c-6afd-4d19-b0ac-99cac9ece970
- Request URL: https://api.eu.cloud.trados.com/public-api/v1/projects?fields=dueBy,status,customer.name
- Response status code: 404
- Response body:
  {
    "errorCode": "notFound",
    "message": "Invalid input on create project.",
    "details": [{"name":"project.template.id","code":"notFound","value":"invalid_project_template_id"}]
  }
- Expected result: Project created.
- Actual result: 404 — project template not found.
```
