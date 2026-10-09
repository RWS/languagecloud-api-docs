# Multipart file uploads

How to build `multipart/form-data` requests for upload endpoints when not using an SDK.

The API follows standard HTTP/1.1 (RFC 2616 and subsequent RFCs); no custom HTTP behaviour.

## Rules

- File upload endpoints use `multipart/form-data` and may require extra parts beside the file, typically a `properties` part.
- Structures in multipart parts are serialised as **JSON** (even if not stated explicitly in the contract); the `properties` part has `Content-Type: application/json`.
- The `file` part is declared `type: string` in the contract, meaning the raw file content is sent in that part.
- **Part order matters**: send parts in the order given by the API contract (`properties` first, then `file`).
- The file part carries `filename`, a `Content-Type` matching the file type, and the content.
- To debug, intercept the request and inspect the raw HTTP.

## Raw request example (Add Source File Version)

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

## Properties examples

[AddSourceFile](../reference/AddSourceFile.md) `properties`:

```json
{
	"language": "en-US",
	"type": "native",
	"role": "translatable",
	"name": "nameOfTheFile.extension"
}
```

`role` distinguishes translatable files (value `translatable`) from reference files; `type`: `native`, `bcm`, `sdxliff`. Optional: `targetLanguages`, `path`.

[ImportTranslationMemory](../reference/ImportTranslationMemory.md): send `properties` before `file` (see [translation-memory.md](./translation-memory.md)).

## Related

- File formats and workflow rules: [file-formats.md](./file-formats.md)
- Rate limits: [rate-limits.md](./rate-limits.md)
