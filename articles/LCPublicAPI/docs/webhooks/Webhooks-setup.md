---
stoplight-id: eg4ja9nrs9wtk
---

# Webhooks Setup

A webhook is a web callback by which Trados Cloud Platform notifies an external application when a specific event occurs in a specific account in Trados Cloud Platform. You can subscribe to events by registering webhooks from within the Trados UI.

> [!NOTE]
> When integrating with our webhook service, please be aware that we cannot guarantee the order of webhook event deliveries. This means that notifications may arrive out of sequence, and consumers should not rely on receiving messages in a specific order. Instead, make use of the `timestamp` field to determine the event generation time.
 
## Subscribe to Webhook events

You subscribe to Webhook events from the Trados UI by creating a Trados Cloud Platform custom application.

Several prerequisites must be met so that you can configure the right webhooks for the right customer, namely:

1. Create a Service User in the correct customer folder.
2. Create an application based on the Service User created above. This means that the application is saved in the same customer folder as the Service User.
3. Use the application to configure the webhooks for your customer.

Here are the detailed steps:

1. Log in to the Trados UI as a human Administrator user. 
2. Expand the account menu on the top right-hand corner and select **Integrations**. 
3. Select the **Applications** sub-tab.
4. Select **New Application** and enter the following information:
    - **Name** - Enter a unique name for your custom application.
    - (Optional) **URL** - Enter your custom application URL.
    - **Service User** - Select a service user from the dropdown list. To understand how service users are added in Trados Cloud Platform, check step 1 in the [Authenticate](../../docs/Service-credentials.md) topic.
5. Select **Add**.
6. Back in the **Applications** sub-tab, select the check box corresponding to your application.
7. Select **Edit**.
8. On the **Overall Information** page change any of the following, if necessary: name, URL, description.
9. On the **API Access** page you can find your **Client ID** and **Client Secret**.
10. On the **Webhooks** page:
    - Enter a default callback URL for your application Webhooks (all Webhooks defined in Trados Cloud Platform).
    - Enter a value for **Webhook URL** (this is your Webhook endpoint URL which you expose and which Trados Cloud Platform calls), select one or more event types, and hit Enter. You can create a separate webhook for every event you are interested in or combine notifications for multiple event types to one webhook. If you delete your application, all its associated webhooks are also deleted.
11. Select **Save**.

A webhook is triggered for all the projects located in the same folder as the selected service user. 

> [!NOTE]
> Similar to other resource types, webhooks are governed by inheritance, the propagation rule giving users visibility and work access with resources in the [account hierarchy](https://docs.rws.com/791595/797020/trados-enterprise---accelerate/inheritance-within-the-account). <br>
> Please be aware that the webhooks will be delivered only for the users having the READ permission on the resource triggering the webhook.

For example, given there is a folder structure: 

- Root
  - Customer1 
    - Customer2
    - Customer3

Let's say that:
- the `Group1` has the location `Customer1`
- the `Group2` has the location `Customer2`
- the `Group3` has the location `Customer3` 

Let's presume that:
- the service user `S1`, with the webhook `WB1`, is in the group `Group1`
- the service user `S2`, with the webhook `WB2`, is in the group `Group2`
- the service user `S3`, with the webhook `WB3`, is in the group `Group3`

The followings are true:
1. if you create a project in `Customer1`:
    - the webhook event is sent to `WB1`;

2. if you create a project in `Customer2`:
    - the webhook event is sent to `WB1` url and `WB2` url;

3. if you create a project in `Customer3`:
    - the webhook event is sent to `WB1` url and `WB3` url.



Remember that each time events occur, Trados Cloud Platform will call your server on a `POST` request, on the URL you configured in the Trados Cloud Platform application, and the request body will emulate the [Webhook](../../api/Webhooks.v1-fv.html#/schemas/webhook)  object format. 

## Validate the Webhook notifications

In terms of security, you must ensure that Trados Cloud Platform is the system which sent the event. For this, webhook requests must be verified in terms of authenticity, integrity, and confidentiality.

### Webhook authenticity

The webhook `POST` request sent by Trados Cloud Platform will include a digital signature which concatenates the following information: `transmissionTime|applicationId|webhookId|crc32 `. For more information on request headers, check the *Reference* section at the end. The [crc32](https://en.wikipedia.org/wiki/Cyclic_redundancy_check) component is a checksum for the HTTP request body.

The signature is decrypted using your Public Key. You can get the Public Key as follows:

1. Log in to the Trados UI as a human Administrator user.
2. Expand the account menu on the top right-hand corner and select **Integrations**. 
3. Select the **Applications** sub-tab.
4. Open your application and go to the **Webhooks** tab. Copy the value from the **Secret Key** field. This is the Public Key which validates and decrypts the signature sent by the header.

The validation process mimics the generation sequence, where the recipient system use its Public Key to verify the received signature using the same concatenation: `transmissionTime|applicationId|webhookId|crc32 `.

**Here is a Java sample:**

```
//retrieve transmissionTime, applicationId, webhookId, signatureAlg & signature from request headers*

// event = request message body
//generate crc32 from the request body

CRC32 checkSum = new CRC32();
checksum.update(event.getBytes(UTF_8));
long crc32Val = checksum.getValue();

//build the message
String message = transmissionTime + “|” + applicationId + “|” + webhookId + “|” + crc32Val;

//build PublicKey
byte[]  bytes = org.springframework.security.crypto.codec.Base64.decode(publicKeyAsString.getBytes());
X509EncodeKeySpec ks = new X509EncodeKeySpec(bytes);
KeyFactory kf = KeyFactory.getInstance(“RSA”);
PublicKey publicKey = kf.generatePublic(ks);

//verify signature

Signature publicSignature = Signature.getInstance(signatureAlg);
publicSignature.initVerify(publicKey);
publicSignature.update(message.getBytes(UTF_8));
byte[] signatureBytes = Base64.getDecoder().decode(signature);

publicSignature.verify(signatureBytes);
```

A valid message implies that the message was sent by Trados Cloud Platform.

### Webhook integrity

The fact that the signature is created based on payload content ensures that the message is not altered ([CRC32](https://en.wikipedia.org/wiki/Cyclic_redundancy_check)).

### Webhook confidentiality

To ensure that the message cannot be read by 3rd-parties, Trados Cloud Platform Webhooks only accept the HTTPS communication protocol specified in the webhook URLs you provide.

## Return notification responses

### Success notifications

A notification delivery is considered successful when applications respond with a 2xx status code within 3 seconds.

> [!NOTE]
> It is recommended that applications perform little processing when receiving events and, for instance, that they make use of a queuing mechanism to perform further processing asynchronously after having acknowledged the event notification request.

Trados Cloud Platform does not inspect the HTTP response body.

### Failure notifications

Notifications will fail in the following scenarios:
- Response time: the response status code is `2xx`, but the response is received after 3 seconds
- Response status code:
	- `3xx`: Trados Cloud Platform does not follow redirects
	- `4xx`
	- `5xx`

### Retry policies

Trados Cloud Platform will try its best to redeliver the notification. Retries will include specific headers with information about the retry:
- `X-LC-Retry-Num`: header indicating the retry number (1, 2 or 3)
- `X-LC-Retry-Reason`: header indicating why the retry is sent

Trados Cloud Platform will try to delivery the notification up to 8 times using an exponential back-off strategy (namely, it will delay the next delivery attempt exponentially with the number of retries already made).

Retry No.| Interval (relative to last retry)/ Minutes| Interval (relative to original attempt)/ Minutes|
----     |----                                       |----                                             |
1        |5                                          |5                                                |
2        |10                                         |15                                               |
3        |30                                         |45                                               |
4        |120 (2h)                                   |165                                              |
5        |360 (6h)                                   |525                                              |
6        |600 (10h)                                  |1125                                             |
7        |960 (16h)                                  |2085                                             |
8        |1440 (24h)                                 |3525                                             |

### Circuit Breaker

To protect the platform and ensure problems from one tenant do not affect other tenants, we have a circuit breaker that will stop sending webhook on URLs that do not respond within the allowed time (mentioned in **Failure** notifications section). The actual HTTP response code is not relevant since the connection is closed before the response is received.

The circuit breaker is triggered when 3 calls to a URL fail within a short time window. The circuit breaker is opened for an hour only for that URL, not for the tenant. During that hour, any webhooks sent to that URL are scheduled for the next retry.

> [!NOTE]
> Frequent timeouts may compromise the performance of our delivery system. <br>
> We may need to remove your webhook from our database without advance notice if it is negatively impacting the platform. <br>
> This action is reserved for cases of major incidents and is necessary to prevent potential issues that can arise from  repeated delivery attempts.
## Reference

**The request headers** are:

* `X-LC-Signature`: Contains the message digital signature (see section on *Webhook authenticity* above).

* `X-LC-Signature-Algo`: Contains the algorithm used for signing the message. Possible values: "*SHA256withRSA*".

* `X-LC-Retry-Num`: Contains the retry attempt counter. Initial value is 0, which will be increased with each attempt at redelivering the webhook message.

* `X-LC-Retry-Reason`: Contains a textual description of the previous error, which resulted in the current attempt to redeliver the webhook message.

* `X-LC-Transmission-Time`: Contains the date/time when the webhook message was delivered, in ISO 8601 date time format.

* `X-LC-Application`: Unique identifier of the Trados Cloud Platform application, which is the recipient of the webhook message. Every webhook has an application associated in Trados Cloud Platform, which can be found in the Trados UI, in the account dropdown menu from the top right corner, under the **Applications** tab, in **Integrations**. The configured webhooks for an application are listed on the **Webhooks** tab of the respective application.

* `X-LC-Webhook`: Unique identifier of the webhook defined for the LC application which is the recipient of the webhook message. It can be ignored because it is not exposed in the Trados UI.

* `X-LC-Region`: Region of the account of the user, which is the recipient of the webhook message.

