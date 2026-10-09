# Webhooks

Trados Cloud Platform calls an HTTPS endpoint you expose (HTTP `POST`) when events occur; delivery is signed, retried with back-off, and not ordered.

Schemas: [Webhook](../../api/Webhooks.v1-fv.html#/schemas/webhook), [Webhook batch](../../api/Webhooks.v1-fv.html#/schemas/webhook-batch).

## Subscribing

Webhooks are configured on a custom application (UI, as a human Administrator): account menu → **Integrations** → **Applications** → select/edit application → **Webhooks** page.

- Enter a default callback URL (applies to all webhooks defined for the application), and/or a **Webhook URL** plus one or more event types (press Enter). One webhook per event, or several event types per webhook.
- Webhook URLs must be **HTTPS**.
- Deleting the application deletes its webhooks.
- Prerequisites: a service user in the correct customer folder; an application based on that service user (saved in the same folder); the application's webhooks configured for that customer.
- A webhook triggers for projects located in the same folder as the service user. Webhooks follow folder inheritance, and are delivered only for users having READ permission on the resource that triggered the event.

Example (Root > Customer1 > {Customer2, Customer3}; Group1/2/3 at Customer1/2/3; service users S1/S2/S3 with webhooks WB1/WB2/WB3 in those groups):

| Project created in | Webhooks called |
|---|---|
| Customer1 | WB1 |
| Customer2 | WB1, WB2 |
| Customer3 | WB1, WB3 |

## Event ordering

Delivery order is **not guaranteed** (parallel sending, retries, network). Use the payload `timestamp` (moment the event occurred, not sent):
1. Order events chronologically by `timestamp`.
2. Process idempotently by tracking the last processed timestamp per entity.
3. Ignore an entity's webhook if its timestamp is older than the last successfully processed event for that entity.

## Request

Standard envelope (same for all events); only `data` varies:

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

### Request headers

| Header | Meaning |
|---|---|
| `X-LC-Signature` | Message digital signature |
| `X-LC-Signature-Algo` | Signing algorithm; possible value `SHA256withRSA` |
| `X-LC-Retry-Num` | Retry counter; initial value 0, incremented on each redelivery |
| `X-LC-Retry-Reason` | Description of the previous error that caused the redelivery |
| `X-LC-Transmission-Time` | Delivery date/time, ISO 8601 |
| `X-LC-Application` | ID of the application receiving the message |
| `X-LC-Webhook` | ID of the webhook definition (not exposed in the UI; can be ignored) |
| `X-LC-Region` | Region of the recipient's account |

### Event types

| Event | `data` model | Triggered by (API / UI) |
|---|---|---|
| `PROJECT.CREATED` | `project-event` | Create project |
| `PROJECT.STARTED` | `project-event` | Start project |
| `PROJECT.UPDATED` | `project-event` | Start project (also emitted with `PROJECT.STARTED`); update any project field; complete project; cancel source file (API); complete target file. UI: edit Project Information/Configuration/Custom Fields, complete, set back in progress, cancel project |
| `PROJECT.DELETED` | `project-event` | Delete project |
| `PROJECT.TASK.CREATED` | `task-event` | Generate task |
| `PROJECT.TASK.ACCEPTED` | `task-event` | Accept task / accept error task |
| `PROJECT.TASK.COMPLETED` | `task-event` | Complete task |
| `PROJECT.TASK.UPDATED` | `task-event` | Generate, accept, reject, release, assign, reassign, complete task |
| `PROJECT.TASK.DELETED` | `task-event` | Delete project and its tasks |
| `PROJECT.ERROR.TASK.CREATED` | `error-task-event` | Generate error task |
| `PROJECT.ERROR.TASK.ACCEPTED` | `error-task-event` | Accept error task |
| `PROJECT.ERROR.TASK.COMPLETED` | `error-task-event` | Complete error task |
| `PROJECT.TEMPLATE.CREATED` | `project-template-event` | UI: create project template |
| `PROJECT.TEMPLATE.UPDATED` | `project-template-event` | UI: create or update project template |
| `PROJECT.TEMPLATE.DELETED` | `project-template-event` | UI: delete project template |
| `PROJECT.SOURCE.FILE.CREATED` | `source-file-event` | API: add source file / attach source files. UI: add reference or translatable file |
| `PROJECT.SOURCE.FILE.UPDATED` | `source-file-event` | API: update source file `name`, add source file version, project reaches *File Type Detection* or *File Format Conversion*. UI: change `fileType`/`fileRole`, replace file, delete version, cancel source file, same task transitions |
| `PROJECT.SOURCE.FILE.DELETED` | `source-file-event` | Delete project and its tasks |
| `PROJECT.TARGET.FILE.CREATED` | `target-file-event` | Project reaches *File Format Conversion* |
| `PROJECT.TARGET.FILE.UPDATED` | `target-file-event` | Add/import target file version, update name, project reaches *File Format Conversion*, *Copy Source to Target*, *Machine Translation*, *Bilingual Engineering*, *Translation*, *Linguistic Review*, *Customer Review*, *Implement Customer Review* or *Target File Generation*. UI: upload SDLXLIFF, replace/delete/cancel target file |
| `PROJECT.TARGET.FILE.DELETED` | `target-file-event` | Delete project and its tasks |
| `PROJECT.GROUP.PROJECT.MEMBERSHIP.CHANGE` | `project-group-event` | Add/remove project to/from project group |

`data` schemas: `{task|project|project-template|source-file|target-file|project-group|error-task}-event` under `../../api/Webhooks.v1-fv.html#/schemas/`.

Example `data` for `PROJECT.CREATED`: `id`, `name`, `description`, `customFields[]` (`id`, `key`, `value`).

## Batched webhooks

Multiple events are sent in a single HTTP request.

```json
{
  "itemCount": 42,
  "items": [
    { "eventId": "EVENT_ID", "eventType": "PROJECT.CREATED", "version": "1.0", "timestamp": "TIMESTAMP", "accountId": "ACCOUNT_ID", "data": { } }
  ]
}
```

| Aspect | Value |
|---|---|
| Max batch size | 100 events |
| Max interval | 1 second |
| Success timeout | 2xx within **20 s** (3 s for single webhooks) |

Batch size/interval values may change without notice. Authenticity, success/failure rules, retry policy, circuit breaker and headers are the same as for single webhooks. Use a single URL for batched webhooks, and one webhook subscribed to multiple event types. The endpoint must be able to process multiple events per request.

## Validating notifications

Webhooks are validated for authenticity, integrity and confidentiality.

- **Authenticity**: signature over `transmissionTime|applicationId|webhookId|crc32`, where `crc32` is the CRC32 checksum of the HTTP request body. Verify with the application's public key (UI: Integrations → Applications → open application → **Webhooks** tab → **Secret Key** field) using the algorithm from `X-LC-Signature-Algo`.
- **Integrity**: the signature covers the payload checksum (CRC32).
- **Confidentiality**: only HTTPS webhook URLs are accepted.

Java verification sample:

```java
// retrieve transmissionTime, applicationId, webhookId, signatureAlg & signature from request headers
CRC32 checkSum = new CRC32();
checkSum.update(event.getBytes(UTF_8));   // event = request body
long crc32Val = checkSum.getValue();

String message = transmissionTime + "|" + applicationId + "|" + webhookId + "|" + crc32Val;

byte[] bytes = Base64.decode(publicKeyAsString.getBytes());
X509EncodedKeySpec ks = new X509EncodedKeySpec(bytes);
KeyFactory kf = KeyFactory.getInstance("RSA");
PublicKey publicKey = kf.generatePublic(ks);

Signature publicSignature = Signature.getInstance(signatureAlg);
publicSignature.initVerify(publicKey);
publicSignature.update(message.getBytes(UTF_8));
byte[] signatureBytes = Base64.getDecoder().decode(signature);
publicSignature.verify(signatureBytes);
```

A valid signature means the message was sent by Trados Cloud Platform.

## Responses, retries, circuit breaker

| Outcome | Condition |
|---|---|
| Success | 2xx within **3 seconds** (response body is not inspected) |
| Failure | 2xx after 3 s; any 3xx (redirects are not followed); 4xx; 5xx |

Do minimal work on receipt (e.g. enqueue and process asynchronously).

Retries: up to **8** deliveries with exponential back-off, carrying `X-LC-Retry-Num` and `X-LC-Retry-Reason`.

| Retry | Interval since last attempt (min) | Since original attempt (min) |
|---|---|---|
| 1 | 5 | 5 |
| 2 | 10 | 15 |
| 3 | 30 | 45 |
| 4 | 120 (2h) | 165 |
| 5 | 360 (6h) | 525 |
| 6 | 600 (10h) | 1125 |
| 7 | 960 (16h) | 2085 |
| 8 | 1440 (24h) | 3525 |

Circuit breaker: triggers when 3 calls to a URL fail within a short window (URLs that do not respond in time; HTTP code is irrelevant because the connection is closed). Opens for **1 hour** for that URL only (not the whole tenant); webhooks to that URL are scheduled for the next retry. Webhooks that harm platform performance may be removed without advance notice.

## Related

- Application setup and credentials: [auth.md](./auth.md)
- Folder inheritance: [locations-folders.md](./locations-folders.md)
