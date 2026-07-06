# Webhooks

## Overview

Webhooks deliver `POST` HTTP notifications to your endpoint when events occur in a Trados Cloud Platform account. Webhooks are configured via the Trados UI within a Custom Application.

## Setup

**Prerequisites:**
1. Create a Service User in the correct customer folder.
2. Create a Custom Application assigned to that Service User.
3. In the Application's **Webhooks** tab:
   - Set a default callback URL.
   - Add per-event-type webhook URLs. Multiple event types can share one URL.

Webhooks fire for all projects in the same folder as the service user, subject to inheritance: a service user at folder `X` receives webhooks for events in `X` and all descendant folders.

**Scope example:**

| Project location | Webhooks notified |
|---|---|
| Customer1 (parent) | WB1 (service user in Customer1) |
| Customer2 (child of Customer1) | WB1 + WB2 |
| Customer3 (child of Customer1) | WB1 + WB3 |

## Event Types and Payload Objects

| Event | Payload schema |
|---|---|
| `PROJECT.CREATED` | `project-event` |
| `PROJECT.STARTED` | `project-event` |
| `PROJECT.UPDATED` | `project-event` |
| `PROJECT.DELETED` | `project-event` |
| `PROJECT.TASK.CREATED` | `task-event` |
| `PROJECT.TASK.ACCEPTED` | `task-event` |
| `PROJECT.TASK.COMPLETED` | `task-event` |
| `PROJECT.TASK.UPDATED` | `task-event` |
| `PROJECT.TASK.DELETED` | `task-event` |
| `PROJECT.SOURCE.FILE.CREATED` | `source-file-event` |
| `PROJECT.SOURCE.FILE.UPDATED` | `source-file-event` |
| `PROJECT.SOURCE.FILE.DELETED` | `source-file-event` |
| `PROJECT.TARGET.FILE.CREATED` | `target-file-event` |
| `PROJECT.TARGET.FILE.UPDATED` | `target-file-event` |
| `PROJECT.TARGET.FILE.DELETED` | `target-file-event` |
| `PROJECT.TEMPLATE.CREATED` | `project-template-event` |
| `PROJECT.TEMPLATE.UPDATED` | `project-template-event` |
| `PROJECT.TEMPLATE.DELETED` | `project-template-event` |
| `PROJECT.ERROR.TASK.CREATED` | `error-task-event` |
| `PROJECT.ERROR.TASK.ACCEPTED` | `error-task-event` |
| `PROJECT.ERROR.TASK.COMPLETED` | `error-task-event` |
| `PROJECT.GROUP.PROJECT.MEMBERSHIP.CHANGE` | `project-group-event` |

## Payload Envelope

All events share this envelope:

```json
{
  "eventId": "EVENT_ID",
  "eventType": "PROJECT.CREATED",
  "version": "1.0",
  "timestamp": "TIMESTAMP",
  "accountId": "ACCOUNT_ID",
  "data": { }
}
```

`data` contains the event-specific payload object. The `timestamp` field is the time the event occurred (not the delivery time).

## Event Ordering

Delivery order is **not guaranteed**. Use the `timestamp` field to determine chronological order. Implement idempotent event processing: track the last processed timestamp per entity and ignore events with older timestamps.

## Request Headers

| Header | Description |
|---|---|
| `X-LC-Signature` | Digital signature: `transmissionTime\|applicationId\|webhookId\|crc32` |
| `X-LC-Signature-Algo` | Signing algorithm. Possible value: `SHA256withRSA` |
| `X-LC-Transmission-Time` | ISO 8601 delivery timestamp |
| `X-LC-Application` | Application ID |
| `X-LC-Webhook` | Webhook ID |
| `X-LC-Region` | Region of the account |
| `X-LC-Retry-Num` | Retry attempt counter (0 = initial delivery) |
| `X-LC-Retry-Reason` | Reason for retry (on retries only) |

## Signature Validation (Java Example)

```java
CRC32 checksum = new CRC32();
checksum.update(event.getBytes(UTF_8));
long crc32Val = checksum.getValue();

String message = transmissionTime + "|" + applicationId + "|" + webhookId + "|" + crc32Val;

byte[] bytes = Base64.decode(publicKeyAsString.getBytes());
X509EncodedKeySpec ks = new X509EncodedKeySpec(bytes);
PublicKey publicKey = KeyFactory.getInstance("RSA").generatePublic(ks);

Signature sig = Signature.getInstance(signatureAlg);
sig.initVerify(publicKey);
sig.update(message.getBytes(UTF_8));
boolean valid = sig.verify(Base64.getDecoder().decode(signature));
```

The public key is in the Application's **Webhooks** tab → **Secret Key** field.

## Success / Failure Rules

| Condition | Result |
|---|---|
| Response `2xx` within **3 seconds** | Success (single webhook) |
| Response `2xx` within **20 seconds** | Success (batched webhook) |
| Response `3xx` | Failure — redirects are not followed |
| Response `4xx` or `5xx` | Failure |
| No response within timeout | Failure |

Trados Cloud Platform does not inspect the response body.

## Retry Policy

Up to 8 retries using exponential back-off:

| Retry # | Interval from previous / minutes | Cumulative offset / minutes |
|---|---|---|
| 1 | 5 | 5 |
| 2 | 10 | 15 |
| 3 | 30 | 45 |
| 4 | 120 | 165 |
| 5 | 360 | 525 |
| 6 | 600 | 1,125 |
| 7 | 960 | 2,085 |
| 8 | 1,440 | 3,525 |

## Circuit Breaker

Triggered when **3 calls to a URL fail** within a short window. The circuit stays open for **1 hour** for that URL (not the entire tenant). Webhooks to the affected URL are scheduled for the next retry attempt. Persistent failures may result in the webhook being removed from the database.

## Batched Webhooks

Webhooks can be batched to reduce HTTP requests. Batch envelope:

```json
{
  "itemCount": 42,
  "items": [
    { "eventId": "...", "eventType": "PROJECT.CREATED", "version": "1.0", "timestamp": "...", "accountId": "...", "data": {} },
    { "eventId": "...", "eventType": "PROJECT.TASK.CREATED", ... }
  ]
}
```

**Batch limits:**
- Maximum batch size: **100 events**
- Maximum time interval before flush: **1 second**

These values may change without notice.

**To use batching efficiently:**
- Configure a single URL for all event types in one webhook subscription.
- The same signature validation, success/failure rules, retry policy, and circuit breaker apply.
- Timeout for success: **20 seconds** (vs. 3 seconds for single webhooks).

**Recommendation:** Acknowledge the event quickly and enqueue for asynchronous processing.
