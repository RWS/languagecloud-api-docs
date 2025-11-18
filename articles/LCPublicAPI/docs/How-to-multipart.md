---
stoplight-id: 1hfz3c15wpkbf
---

# Multipart considerations

This page goes into deeper details for uploading files. Generally you might be interested in this subject when not using the provided SDKs and are implementing your own SDK. This page should help you debug potential problems you might encounter.

> [!NOTE]
> Our APIs follows standard HTTP/1.1 protocol as described in [RFC2616](https://www.rfc-editor.org/rfc/rfc2616) and subsequent RFCs. This page does not describe any custom HTTP behavior.

## How to perform POST requests with multipart

Whenever you make use of endpoints that do file uploads using `multipart/form-data`, some additional details may be required to be sent alongside the file, for example a `properties` part.

Let's take as an example the [Add Source File Version](../api/Public-API.v1-fv.html#/operations/AddSourceFileVersion) endpoint. The API specifies that the request content is `multipart/form-data` and has a `properties` part that should be serialized as a JSON (this might not be mentioned explicitly in the documentation, but any structures in multiparts should be serialized as JSON). The second property is `file` and though it is of type `string`, that means that the raw content of the file should be sent in that part.

> [!NOTE]
> The order of parts is important! Please send the parts in the order these are specified in the API contract.

To confirm that you are sending the correct content, you can intercept the request and view the raw request (this can be done in many ways, with either built in tools if available in your IDE/tooling or even free software). 

A simplified raw HTTP request is presented bellow:

```http
POST /tasks/<taskId>/source-files/<sourceFileId>/versions HTTP/1.1
HOST: host.example.com
Content-Type: multipart/form-data; boundary=--------------------------818668410602542750275539

----------------------------818668410602542750275539
Content-Disposition: form-data; name="properties"
Content-Type: application/json

{ 
    "type":"native",
    "fileTypeSettingsId": "<FILE_TYPE_SETTINGS_ID>"
}
----------------------------818668410602542750275539
Content-Disposition: form-data; name="file"; filename="<FILENAME.EXTENSION>"
Content-Type: <MATCHING CONTENT TYPE FOR YOUR FILE TYPE>

<FILE CONTENT GOES HERE>
----------------------------818668410602542750275539--

```

For the file, there is usually the filename that needs to be sent, along with file `Content-type` and finally the content.



