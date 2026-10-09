# File formats and file versions

Source and target files exist in native, SDLXLIFF or BCM format; which operations are allowed depends on the workflow task and its input file type.

## Formats

| Format | Description |
|---|---|
| native | File as attached by the user. The project's File Type Configuration determines which native extensions are allowed |
| SDLXLIFF | XML (`*.sdlxliff`); used to download files for offline translation/review |
| BCM | Bilingual Content Model; JSON content, stored as `.json`; used internally |

## Task input file types

A new file version can be added only if its format matches the input file type supported by the task.

| Input file type | Meaning | Example tasks |
|---|---|---|
| `nativeSource` | Source file versions in uploaded native format | FileTypeDetection, Engineering, FileFormatConversion |
| `bcmSource` | Source files in BCM | DocumentContentAnalysis, CopySourceToTarget |
| `bcmTarget` | Target files in BCM | Translation, Linguistic Review, MachineTranslation, TranslationMemoryMatching, TranslationMemoryUpdate, TargetFileGeneration |
| `nativeTarget` | Target files in native "generated" form | DTP, FinalCheck |
| `sdlxliffTarget` | Target files in SDLXLIFF; specifically for Import tasks | Import tasks |
| `none` | Task does not read or modify file content | - |

Task input/output types per task are listed on the RWS page "Rules for sequencing tasks correctly".

## Source files

| Operation | Endpoint | Notes |
|---|---|---|
| Add one source file | [AddSourceFile](../reference/AddSourceFile.md) | If the extension is supported by the File Type Configuration, a BCM source version is created automatically by the *File Format Conversion* task |
| Add several | [AddSourceFiles](../reference/AddSourceFiles.md) | Attach multiple source files |
| Add a version (native or BCM) | [AddSourceFileVersion](../reference/AddSourceFileVersion.md) | Allowed in the *Engineering* task, custom tasks with task type *Engineering*, and extension tasks handling source files |
| Download a version (native or BCM) | [DownloadSourceFileVersion](../reference/DownloadSourceFileVersion.md) | e.g. in the *Engineering* task |

- A started project whose native source file has an unsupported extension generates an error task in *File Type Detection* and the workflow is interrupted.
- Extension tasks that add source or target file versions must declare `scope` = `"file"` in the task type configuration.

## Target files

The *Copy source to target* task converts the native file into a target file version in BCM format.

| Operation | Endpoint | Notes |
|---|---|---|
| Add a version (native or BCM) | [AddTargetFileVersion](../reference/AddTargetFileVersion.md) | Extension tasks need `scope` = `"file"` |
| Download BCM/native version | [DownloadFileVersion](../reference/DownloadFileVersion.md) | e.g. while the project is in the *Translation* task |
| Export BCM version to native or SDLXLIFF | [ExportTargetFileVersion](../reference/ExportTargetFileVersion.md) | Async; `format` query parameter selects output; see below |
| Import SDLXLIFF version | [ImportTargetFileVersion](../reference/ImportTargetFileVersion.md) | Replaces a version using a processed SDLXLIFF; triggers update of the associated BCM file; mostly for offline work. Async |

### Export flow (BCM to native/SDLXLIFF)

1. `POST` [ExportTargetFileVersion](../reference/ExportTargetFileVersion.md) (`format` query parameter).
2. Poll [PollTargetFileVersionExport](../reference/PollTargetFileVersionExport.md).
3. Download with [DownloadExportedTargetFileVersion](../reference/DownloadExportedTargetFileVersion.md).

Constraints:
- Export applies only to file versions in BCM format, and only on tasks whose supported output is a bilingual target file.
- To download BCM or native versions directly, use DownloadFileVersion instead.

### Import flow (SDLXLIFF)

1. `POST /projects/{projectId}/target-files/{targetFileId}/versions/imports` ([ImportTargetFileVersion](../reference/ImportTargetFileVersion.md)); response returns `importId`.
2. Poll `GET /projects/{projectId}/target-files/{targetFileId}/versions/imports/{importId}` ([PollTargetFileVersionImport](../reference/PollTargetFileVersionImport.md)).

`targetFileId` comes from [ListTargetFiles](../reference/ListTargetFiles.md); `projectId` from [CreateProject](../reference/CreateProject.md).

## Related

- Multipart request construction: [file-upload.md](./file-upload.md)
- Polling pattern: [async-polling.md](./async-polling.md)
- Rate limits on file operations: [rate-limits.md](./rate-limits.md)
