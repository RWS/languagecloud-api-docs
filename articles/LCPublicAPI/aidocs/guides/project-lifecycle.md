# Project Lifecycle

## Prerequisites

- Service user and application credentials configured (see [auth.md](./auth.md)).
- Project resources (translation engine, file processing configuration, workflow, pricing model) created in the Trados UI beforehand. The API does not support creating these resources.
- Language codes: retrieve via `GET /languages`.

## Method A: Create from Project Template

The simplest path. A template bundles all required resources.

```
POST /projects
```

```json
{
  "name": "My Project",
  "description": "...",
  "dueBy": "2025-01-01T00:00:00.000Z",
  "projectTemplate": { "id": "TEMPLATE_ID" },
  "languageDirections": [
    {
      "sourceLanguage": { "languageCode": "en-US" },
      "targetLanguage": { "languageCode": "fr-FR" }
    }
  ],
  "location": "LOCATION_ID"
}
```

Response: `201 Created`. Capture the `id` field — needed for all subsequent operations.

## Method B: Create from Scratch

Requires explicit resource IDs for all required resources.

```json
{
  "name": "My Project",
  "translationEngine": { "id": "...", "strategy": "copy" },
  "fileProcessingConfiguration": { "id": "...", "strategy": "copy" },
  "workflow": { "id": "...", "strategy": "copy" },
  "pricingModel": { "id": "...", "strategy": "copy" },
  "languageDirections": [...],
  "location": "LOCATION_ID"
}
```

`strategy` values:
- `copy` — clones the resource into the project (recommended; changes to the original do not affect the project).
- `use` — links to the shared resource (not recommended; external changes affect the project).

## Add Source Files

```
POST /projects/{projectId}/source-files
```

Multipart body (`properties` part first, then `file`). See [file-upload.md](./file-upload.md).

```json
{
  "language": "en-US",
  "type": "native",
  "role": "translatable",
  "name": "document.docx"
}
```

`role`: `translatable` or `reference`.

Projects without source files cannot be started.

## Start Project

```
PUT /projects/{projectId}/start
```

Response: `202 Accepted`.

## Track Project and Tasks

```
GET /projects/{projectId}
GET /projects/{projectId}/tasks?fields=taskType,status
```

Project status values indicate current state. All tasks `status: completed` means translation is done.

## Interact with Tasks

| Operation | Endpoint |
|---|---|
| List tasks assigned to me | `GET /tasks/assigned` |
| List all tasks in a project | `GET /projects/{projectId}/tasks` |
| Accept a task | implicit via workflow |
| Complete a task | `PUT /tasks/{taskId}/complete` |
| Reclaim a task (remove owner) | `PUT /tasks/{taskId}/reclaim` |
| Assign / reassign a task | `PUT /tasks/{taskId}/assign` |

To assign, first retrieve user/group IDs from `GET /users` or `GET /groups`.

## Download Translated Files

```
GET /projects/{projectId}/target-files
GET /projects/{projectId}/target-files/{targetFileId}/versions/{versionId}/download
```

For SDLXLIFF or native-format export (convert from BCM), use the async export flow: see [async-polling.md](./async-polling.md).

## Restrict File Downloads

To prevent file downloads for certain roles, set `forceOnline: true` in the project creation request, or use a template that has this restriction enabled.

## Filter Projects by Download Restriction

Use `excludeOnline=true` query parameter on `GET /projects` to filter out projects with download restrictions.

## Language Codes

Language codes in responses are case-insensitive (e.g. `en-US`, `en-us`, `EN-US` are equivalent). When sending requests, use correct casing to avoid unexpected behavior.

## Quote Report

Async export flow (trigger → poll → download). See [async-polling.md](./async-polling.md). Formats: `PDF` (default), `Excel`. Localizations: `en`, `de`, `fr`, `fr-CA`, `ja`, `es`, `zh-CN`, `nl`, `it`.

To update quote costs, use `PUT /projects/{projectId}` with the `quote` field. Cost types: `volume`, `percentage`, `hourly`, `perPage`, `conditional`, `perFile`, `perTargetLanguage`.
