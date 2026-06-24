# Webhooks

Apps can specify a list of webhooks that will be registered automatically when the app is installed on an account. That allows the app to specify a list of webhooks and consume them, allowing for asynchronous scenarios where the app can wait for events instead of polling constantly to check for a particular event or state improving performance both for the app and for Trados.

## Constraints

Not all accounts have webhooks enabled. Installing of the app requiring webhooks will be disabled (grayed out in UI) on accounts that don't have webhooks enabled.

> [!WARNING]
> Webhooks require one of the following [scopes](./Trados-Cloud-API.md#scopes) to be delivered: `TENANT` or `TENANT_READ`.

## Setup

The required list of webhooks must be specified in the descriptor in the `webhooks` property.

`webhooks` is an array of URLs and corresponding event types. You can specify a single URL for all webhook event types, or one URL for each event type, or any combination. This is done for maximum flexibility so you can decide if you want to ingest all webhooks through a single endpoint or have multiple endpoints maybe by event type or category, etc.

`url` can be an absolute URL or a path relative to `basePath`.

Example of a `webhooks` property in the app descriptor:

```json
{
  ...
  "webhooks": [
    {
      "url": "/webhooks-endpoint",
      "eventTypes": [ 
        { 
          "eventType": "PROJECT.TASK.ACCEPTED" 
        }, 
        { 
          "eventType": "PROJECT.TASK.CREATED" 
        } 
      ]
    }
  ]
  ...
}
```

This example will subscribe to `PROJECT.TASK.ACCEPTED` and `PROJECT.TASK.CREATED` events and will receive these events on the `<basePath>/webhooks-endpoint` URL.

Alternatively, you can split the events across multiple endpoints:

```json
{
  ...
  "webhooks": [
    {
      "url": "/project-webhooks-endpoint",
      "eventTypes": [ 
        { 
          "eventType": "PROJECT.CREATED" 
        }, 
        { 
          "eventType": "PROJECT.STARTED" 
        } 
      ]
    },
    {
      "url": "/task-webhooks-endpoint",
      "eventTypes": [
        {
          "eventType": "PROJECT.TASK.CREATED"
        }
      ]
    }
  ]
  ...
}
```

In this example, `PROJECT.CREATED` and `PROJECT.STARTED` events are routed to `/project-webhooks-endpoint`, while `PROJECT.TASK.CREATED` events are sent to a separate `/task-webhooks-endpoint`.

## Webhook-only app

If you only need to subscribe to webhooks and do not require other extensibility features, you can register a webhook-only app. This creates a minimal app that does not require any additional endpoints.

The following example shows a minimal descriptor that only requires a descriptor endpoint and a webhook receiver endpoint:

```json
{
    "name": "my-extension",
    "version": "1.0.0",
    "description": "A sample extension",
    "releaseNotes": "Initial release",
    "descriptorVersion": "1.4",
    "scopes": [ "TENANT_READ"], 
    "webhooks": [
        {
            "url": "/webhook-endpoint",
            "eventTypes": [
                {
                    "eventType": "PROJECT.CREATED"
                },
                {
                    "eventType": "PROJECT.STARTED"
                },
                {
                    "eventType": "PROJECT.TASK.CREATED"
                }
            ]
        }
    ],
    "baseUrl": "https://your.site",
    "vendor": { 
        "name": "Your Company",
        "url": "https://your.site",
        "email": "support@your.site"
    }
}
```

When installed, this app will register the `/webhook-endpoint` URL to receive `PROJECT.CREATED`, `PROJECT.STARTED`, and `PROJECT.TASK.CREATED` events. No other endpoints are required.

## Webhook events and payloads

Webhooks for apps are sent in a batched format.

The webhook payload description can be found in our [Trados Cloud Platform API documentation](https://eu.cloud.trados.com/lc/api-docs/batched-webhooks).

Webhooks are grouped in batches by callback URL, so it is likely that events from different tenants will be included in the same batch. It is the responsibility of the app developer to handle the events from the batch accordingly to their `accountId` from the event body.

> [!NOTE]
> **Note:** For *Webhook Authenticity*, ignore the described behavior in the above link and only consider the following chapter about *Signature Validation*.

## Signature Validation

Unlike webhooks created in the UI through the Applications, webhooks that are declared in the descriptor are received using app signature. The endpoint that receives the webhook should treat these as signed with JWS, just as any other endpoint in the app. See [Request Authentication](Request-Authentication.md) page for more details.
