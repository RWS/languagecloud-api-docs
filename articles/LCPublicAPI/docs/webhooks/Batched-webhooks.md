# Batched Webhooks  

Webhooks can be batched to reduce the number of HTTP requests. Batched webhooks are sent as a single HTTP request to the configured webhook URL.  
The request body follows the [Webhook Batch](../../reference/Webhooks.v1.json/components/schemas/webhook-batch) structure and contains a set of [Trados Cloud Platform events](../../reference/Webhooks.v1.json/components/schemas/webhook).  

## Considerations for Consuming Batched Webhooks																																	 

* Create the webhook endpoint to handle batched webhooks. The endpoint must be capable of processing multiple events in a single request.  
* The same [webhook authenticity](Webhooks-setup.md#webhook-authenticity) rules apply to both batched and single webhooks.  
* The same **success/failure** rules for webhook notifications apply, as described in [notification responses](Webhooks-setup.md#return-notification-responses).
  * **Note:** A notification delivery is considered successful if the application responds with a 2xx status code within 20 seconds (compared to 3 seconds for individual webhooks).
* The **retry policies** and **circuit breaker** mechanisms for webhook notifications are the same as those described in [notification responses](Webhooks-setup.md#return-notification-responses).  
* The same **headers** are included in batched webhooks as in single webhooks, as outlined in the [reference](Webhooks-setup.md#reference).  

## Example Request for a Batched Webhook  

```json
{
  "itemCount": 42,
  "items": [
    {
      "eventId": "EVENT_ID",
      "eventType": "PROJECT.CREATED",
      "version": "1.0",
      "timestamp": "TIMESTAMP",
      "accountId": "ACCOUNT_ID",
      "data": { ... }
    },
    {
      "eventId": "EVENT_ID",
      "eventType": "PROJECT.TASK.CREATED",
      "version": "1.0",
      "timestamp": "TIMESTAMP",
      "accountId": "ACCOUNT_ID",
      "data": { ... }
    },
	  ...
  ]
}
```  

## Batch Size and Frequency  

Batched webhooks are sent when either the maximum batch size is reached or a predefined time interval elapses.  
The current configuration for the Trados Cloud Platform is:

* The maximum batch size is 100 events.
* The maximum time interval is 1 second.

> **Note:** These values are subject to change without prior notice to enhance system efficiency and ensure platform stability.  

## Key Considerations for Efficient Batching  

* Ensure that a single URL is set for receiving batched webhooks in the Trados Cloud Platform.  
* Create a single webhook under [Webhooks Setup](Webhooks-setup.md#subscribe-to-webhook-events) that subscribes to multiple event types.  
