# File Upload (Multipart)

## Overview

File upload endpoints use `multipart/form-data`. The API follows standard HTTP/1.1 (RFC 2616 and subsequent RFCs).

## Part Order

**The order of parts matters.** Send parts in the exact order specified in the API contract. For most file endpoints, `properties` comes before `file`.

## File Formats

| Format | Description | Extension |
|---|---|---|
| native | Original file as uploaded by the user | varies |
| SDLXLIFF | Bilingual XML format for offline translation | `.sdlxliff` |
| BCM | Bilingual Content Model — internal JSON format | `.json` |

## Supported Input File Types by Task

| Input file type | Example tasks |
|---|---|
| `nativeSource` | `FileTypeDetection`, `Engineering`, `FileFormatConversion` |
| `bcmSource` | `DocumentContentAnalysis`, `CopySourceToTarget` |
| `bcmTarget` | `Translation`, `LinguisticReview`, `MachineTranslation`, `TMMatching`, `TMUpdate`, `TargetFileGeneration` |
| `nativeTarget` | `DTP`, `FinalCheck` |
| `sdlxliffTarget` | Import tasks |
| `none` | Tasks that do not read or modify file content |

## Source Files

- **Add source file (single):** `POST /projects/{projectId}/source-files`
- **Attach source files (multiple):** `POST /projects/{projectId}/source-files/attach`
- **Add source file version:** `POST /tasks/{taskId}/source-files/{sourceFileId}/versions` — allowed in Engineering task, custom Engineering-type tasks, or extension tasks with `scope: "file"`.
- **Download source file version:** `GET` — available from Engineering task onward.

## Target Files

- **Add target file version:** `POST` — native or BCM format.
- **Download target file version (BCM/native):** `GET /projects/{projectId}/target-files/{targetFileId}/versions/{versionId}/download`
- **Export target file version (BCM → native or SDLXLIFF):** async; see [async-polling.md](./async-polling.md).
- **Import target file version (SDLXLIFF):** async; triggers update of the associated BCM file. Use for offline work.

## Raw HTTP Example — Add Source File Version

```http
POST /tasks/<taskId>/source-files/<sourceFileId>/versions HTTP/1.1
HOST: api.eu.cloud.trados.com
Content-Type: multipart/form-data; boundary=--------------------------818668410602542750275539

----------------------------818668410602542750275539
Content-Disposition: form-data; name="properties"
Content-Type: application/json

{
  "type": "native",
  "fileTypeSettingsId": "<FILE_TYPE_SETTINGS_ID>"
}
----------------------------818668410602542750275539
Content-Disposition: form-data; name="file"; filename="<FILENAME.EXTENSION>"
Content-Type: <MATCHING_CONTENT_TYPE>

<FILE CONTENT>
----------------------------818668410602542750275539--
```

## Content-Disposition in Download Responses

When a download endpoint returns a file, the response may include:

```
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="file.pdf"; filename*=UTF-8''file.pdf
```

When both `filename` and `filename*` are present, **use `filename*`** (RFC 5987). If the header is absent, derive the filename from the operation and `Content-Type`.
