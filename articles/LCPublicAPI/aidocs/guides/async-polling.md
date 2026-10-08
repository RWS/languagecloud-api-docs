# Asynchronous operations and polling

Long-running operations return an accepted/queued response with an identifier; poll a status endpoint until completion, then download or continue.

## Pattern

1. Start the operation (`POST`/`PUT`); keep the returned identifier (`importId`, `exportId`, or the project ID).
2. Poll the status endpoint with `GET` until the completion status is reached.
3. Download the result (exports) or continue the flow.

Mind the rate limits on start/download endpoints (see [rate-limits.md](./rate-limits.md)); poll sequentially and handle HTTP 429.

## Operations

| Operation | Start | Poll | Download | Completion status |
|---|---|---|---|---|
| Start project | [StartProject](../reference/StartProject.md) `PUT /projects/{projectId}/start` (HTTP 202 Accepted) | Track via [ListProjectTasks](../reference/ListProjectTasks.md) | - | all tasks `completed` |
| Export target file version (BCM to native/SDLXLIFF) | [ExportTargetFileVersion](../reference/ExportTargetFileVersion.md) | [PollTargetFileVersionExport](../reference/PollTargetFileVersionExport.md) | [DownloadExportedTargetFileVersion](../reference/DownloadExportedTargetFileVersion.md) | see API reference |
| Import target file version (SDLXLIFF) | [ImportTargetFileVersion](../reference/ImportTargetFileVersion.md) (returns `importId`) | [PollTargetFileVersionImport](../reference/PollTargetFileVersionImport.md) | - | see API reference |
| Export quote report | [ExportQuoteReport](../reference/ExportQuoteReport.md) (response: Accepted) | [PollQuoteReportExport](../reference/PollQuoteReportExport.md) | [DownloadQuoteReport](../reference/DownloadQuoteReport.md) (one-time) | `completed` |
| Import translation memory | [ImportTranslationMemory](../reference/ImportTranslationMemory.md) (returns `id`, `status`, normally `queued`) | [PollTMImport](../reference/PollTMImport.md) (`importId`, `translationMemoryId`) | - | `done` |
| Export translation memory | [ExportTranslationMemory](../reference/ExportTranslationMemory.md) (returns `exportId`, `status`) | [PollTranslationMemoryExport](../reference/PollTranslationMemoryExport.md) | [DownloadExportedTranslationMemory](../reference/DownloadExportedTranslationMemory.md) (`tmx.gz`) | `done` |
| Import termbase | [ImportTermbase](../reference/ImportTermbase.md) (returns `importId`, `status`) | [PollTermbaseImport](../reference/PollTermbaseImport.md) (`importId`, `termbaseId`) | - | `done` |
| Export termbase | [ExportTermbase](../reference/ExportTermbase.md) (returns `exportId`, `status`, `downloadUrl`; on failure `errorMessage`) | [PollExportTermbase](../reference/PollExportTermbase.md) (`exportId`, `termbaseId`) | [DownloadExportedTermbase](../reference/DownloadExportedTermbase.md) | `done` |

## Quote report example (strict order)

1. `POST /projects/{projectId}/quote-report/export`: Accepted.
2. `GET /projects/{projectId}/quote-report/export`: wait until body status is `completed`.
3. `GET /projects/{projectId}/quote-report/download`: file is deleted after the download attempt.

## Project tracking

- [GetProject](../reference/GetProject.md) returns creation date, due date, status and resources used.
- Listing projects accepts `excludeOnline` to filter out projects with a file download restriction.
- Task flow after start: see [projects.md](./projects.md).

## Related

- Webhooks notify an application of project, task and file events: [webhooks.md](./webhooks.md)
