# Async Operations and Polling

Several API operations are asynchronous: they accept a request, return an identifier, and complete in the background. The caller must poll a status endpoint until completion, then optionally download the result.

## General Pattern

1. **Trigger** — `POST` or `PUT` to start the operation. Response: `202 Accepted` (or `201 Created`) with an operation ID.
2. **Poll** — `GET` the status endpoint with the operation ID. Repeat until `status` is `done` (or `completed`).
3. **Consume** — `GET` the download endpoint (if applicable).

## Operations Using This Pattern

### Target File Export

| Step | Method | Endpoint |
|---|---|---|
| Trigger | `POST` | `/projects/{projectId}/target-files/{targetFileId}/versions/{versionId}/export` |
| Poll | `GET` | `/projects/{projectId}/target-files/{targetFileId}/versions/{versionId}/export` |
| Download | `GET` | `/projects/{projectId}/target-files/{targetFileId}/versions/{versionId}/export/download` |

The export converts a BCM target file to native or SDLXLIFF format (controlled by the `format` query parameter). Only available on tasks where the output is a bilingual target file. BCM and native format files must be downloaded directly via [Download Target File Version](../../api/Public-API.v1-fv.html#/operations/DownloadFileVersion).

### Target File Import (SDLXLIFF)

| Step | Method | Endpoint |
|---|---|---|
| Trigger | `POST` | `/projects/{projectId}/target-files/{targetFileId}/versions/imports` |
| Poll | `GET` | `/projects/{projectId}/target-files/{targetFileId}/versions/imports/{importId}` |

Returns `importId`. Poll until complete.

### Translation Memory Import

| Step | Method | Endpoint |
|---|---|---|
| Trigger | `POST` | `/translation-memories/{translationMemoryId}/import` |
| Poll | `GET` | `/translation-memories/{translationMemoryId}/import/{importId}` |

Supported input formats: `tmx`, `sdltm`, `zip`, `tmx.gz`, `sdlxliff`. Poll until `status` = `done`.

### Translation Memory Export

| Step | Method | Endpoint |
|---|---|---|
| Trigger | `POST` | `/translation-memories/{translationMemoryId}/export` |
| Poll | `GET` | `/translation-memories/export/{exportId}` |
| Download | `GET` | `/translation-memories/export/{exportId}/download` |

Downloaded file format: `tmx.gz`.

### Quote Report Export

| Step | Method | Endpoint |
|---|---|---|
| Trigger | `POST` | `/projects/{projectId}/quote-report/export` |
| Poll | `GET` | `/projects/{projectId}/quote-report/export` |
| Download | `GET` | `/projects/{projectId}/quote-report/download` |

Format options: `PDF` (default), `Excel`. Language options via `languageId`: `en`, `de`, `fr`, `fr-CA`, `ja`, `es`, `zh-CN`, `nl`, `it`.

## Project Status Tracking

Projects are not polled via a separate endpoint — use `GET /projects/{projectId}` and inspect the `status` field. Use `GET /projects/{projectId}/tasks?fields=taskType,status` to monitor individual task completion. A project is fully translated when all tasks have `status: completed`.

## Polling Recommendations

- Do not poll at a rate that could trigger rate limits (see [rate-limits.md](./rate-limits.md)).
- Use exponential back-off for long-running operations such as large TM imports/exports.
- For file upload/download operations, check applicable [rate limits](./rate-limits.md) (5 req/s, 5,000/day for file endpoints).
