# How to report an issue

When reporting an issue it is important to include as much information as you can. 

## Use this template

Here below is a template that we recommend using when raising a new ticket:

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

You don't have to fill in all the fields, but the more details you provide, the easier it will be to investigate and get to a solution faster. Besides these details you can also add anything that you consider helpful for the investigation.

## Obtaining the details

- Endpoint - identify the endpoint where the issue was observed from the [Trados Cloud Platform API](https://languagecloud.sdl.com/lc/api-docs/9033e3227d21f-rws-language-cloud-api) and paste the link to it.
- X-LC-Tenant - is the tenant identifier as sent in the request headers. This is required on all endpoints.
- X-LC-TraceId - is a unique identifier for the request and it can be found in the response headers. It is very useful when investigating the issue, thus it **should always be provided**, if possible.
- Request URL - the URL in the request as sent from your application (including the domain, endpoint path and any query parameters). If that is not available, at least include the query parameters used to perform the request. Some of the most relevant ones are: `fields`, `top`, `skip`, `location`, `locationStrategy` and others, depending on the case.
- Request body - the `json` content sent.
- Response status code - the HTTP status code returned.
- Response body - the response received. Error responses are also relevant.
- Expected result - what was the expected outcome.
- Actual result - what was the actual outcome.
- Description - a short description about what you are trying to achieve and possible answers to questions like "How did you end up in the current situation?" or "Did you find a workaround?"

## Example

You can simply copy the format from above and fill in the details. For example:

- Endpoint: https://eu.cloud.trados.com/lc/api-docs/025707d21ecc0-create-project
- X-LC-Tenant: <YOUR_TENANT_ID>
- X-LC-TraceId: 90d9147c-6afd-4d19-b0ac-99cac9ece970
- Request URL: https://api.eu.cloud.trados.com/public-api/v1/projects?fields=dueBy,status,customer.name 
- Request body: 
  ```json
  {
    "name": "Invalid projectTemplate",
    "description": "How to report an issue",
    "projectTemplate": {
      "id": "invalid_project_template_id"
    }
  }
  ```
- Response status code: 404
- Response body: 
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
- Expected result: The project is created.
- Actual result: The project is not created due to `projectTemplate.id` not being found.
- Description: When attempting to create a new project I get the error mentioned above.


> [!NOTE]
> Check the [Multi-Region](../docs/Multi-region.md) page for regional API details.