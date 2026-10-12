# Projects: creation and task flow

How to create, start, track and complete translation projects, and how to interact with tasks.

Resources (translation engines, file processing configurations, pricing models, workflows, project templates) cannot be created through this API version via `POST`; define them in the Trados UI beforehand. Some resources, such as pricing models, must be set up in the UI. Termbases and translation memories can be created via the API.

## Prerequisites

- Authentication and tenant: [auth.md](./auth.md)
- Rate limits (CreateProject 2/s, 10/min, 500/day): [rate-limits.md](./rate-limits.md)
- Project and file size limits: RWS page "File and project size limit".
- The project template ID and location ID are provided by RWS (some steps may be done by Trados engineering).

## Basic flow

| # | Step | Endpoint | Success |
|---|---|---|---|
| 1 | Create project | [CreateProject](../reference/CreateProject.md) `POST /projects` | 201 Created, body has project `id` |
| 2 | Add source file | [AddSourceFile](../reference/AddSourceFile.md) `POST /projects/{projectId}/source-files` | 201 Created |
| 3 | Start project | [StartProject](../reference/StartProject.md) `PUT /projects/{projectId}/start` | 202 Accepted |
| 4 | List tasks | [ListProjectTasks](../reference/ListProjectTasks.md) `GET /projects/{projectId}/tasks?fields=taskType,status` | 200; all tasks `completed` = files translated |
| 5 | List target files | [ListTargetFiles](../reference/ListTargetFiles.md) `GET /projects/{projectId}/target-files?fields=latestVersion` | 200 |
| 6 | Download file | [DownloadFileVersion](../reference/DownloadFileVersion.md) `GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download` | 200, file body |
| 7 | Complete project | [CompleteProject](../reference/CompleteProject.md) | - |
| 8 | List projects | [ListProjects](../reference/ListProjects.md) | - |

A project without source files cannot be started.

### 1. Create project

```http
POST https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects
```

```json
{
	"name": "Name of the Project",
	"description": "Test Project",
	"dueBy": "2021-09-04T08:14:05.858Z",
	"projectTemplate": { "id": "xxxxxxxxxxxxxxxxxxxxxxxx" },
	"languageDirections": [
		{
			"sourceLanguage": { "languageCode": "en-US" },
			"targetLanguage": { "languageCode": "fr-FR" }
		}
	],
	"location": "xxxxxxxxxxxxxxxxxxxxxxxx"
}
```

Response includes `id`, `name`, `languageDirections` (with `englishName`) and `location` (`id`, `name`). Language codes come from [ListLanguages](../reference/ListLanguages.md) (see [language-codes.md](./language-codes.md)). Always send `location` (see [locations-folders.md](./locations-folders.md)).

### 2. Add source file

`properties` part (before the `file` part, see [file-upload.md](./file-upload.md)):

```json
{ "language": "en-US", "type": "native", "role": "translatable", "name": "nameOfTheFile.extension" }
```

### 4. Task list response

```json
{
	"items": [
		{ "id": "613f621fe5ed2804ba31870e", "status": "completed",
		  "taskType": { "id": "607932f25c7cc701241f0f60", "key": "scan", "name": "File Type Detection" } }
	],
	"itemCount": 11
}
```

### 5. Target file response

`items[]` with target file `id` and `latestVersion` (`id` = file version ID, `type`, e.g. `native`).

## Creating a project from a template

1. [ListProjectTemplates](../reference/ListProjectTemplates.md): note the template `id`.
2. [ListLanguages](../reference/ListLanguages.md): note `languageCode` values. A template may contain more languages than needed; send only the ones you want.
3. Get the customer folder `locationId` via [GetCustomer](../reference/GetCustomer.md) `GET /customers/{customerId}` (usually the same location as the template).
4. [CreateProject](../reference/CreateProject.md) with template `id` and `location`. All template resources are included.
5. Add files; start the project.

Custom fields and project settings can be set via the API **only through a project template** configured in the UI (see [custom-fields.md](./custom-fields.md)).

## Creating a project from scratch

1. Get resource IDs via GET on: translation engines ([ListTranslationEngines](../reference/ListTranslationEngines.md), required), file processing configurations ([ListFileProcessingConfigurations](../reference/ListFileProcessingConfigurations.md), required), workflows ([ListWorkflows](../reference/ListWorkflows.md), required), pricing models ([ListPricingModels](../reference/ListPricingModels.md), optional), custom field definitions ([ListCustomFields](../reference/ListCustomFields.md), optional).
2. Get language codes ([ListLanguages](../reference/ListLanguages.md)).
3. Choose a location (customer folder `locationId`); if not specified the project is created in Root.
4. `POST /projects` with IDs for the required resources. Each resource object has a `strategy`:

| `strategy` | Effect |
|---|---|
| `copy` (recommended) | A copy (clone) of the resource is included in the project |
| `use` | The actual resource is included; you lose control over updates made elsewhere |

5. Add source files; start the project.

### Add files

[AddSourceFile](../reference/AddSourceFile.md): add translatable and reference files (`role`), in `native`/`bcm`/`sdxliff` (`type`). Source file language is required; `targetLanguages` and `path` are optional. Multiple files: [AddSourceFiles](../reference/AddSourceFiles.md).

Optional PerfectMatch: [CreatePerfectMatchMapping](../reference/CreatePerfectMatchMapping.md) (after files are added, before start).

## Restricting file downloads

Use a project template with the restriction enabled, or create the project from scratch with `forceOnline`:

```json
{ "name": "Restricted Project Name", "description": "Restricted Project Description", "forceOnline": true }
```

When listing projects, `excludeOnline` filters out projects that have a file download restriction.

## Tracking

[GetProject](../reference/GetProject.md) returns creation date, due date, status and resources used. Example with fields: `status,quote.totalAmount`.

## Interacting with tasks

| Action | Endpoint | Behaviour |
|---|---|---|
| Find task ID | [ListTasksAssignedToMe](../reference/ListTasksAssignedToMe.md) `GET /tasks/assigned` | Pick the task `id` |
| List all tasks in a project | [ListProjectTasks](../reference/ListProjectTasks.md) `GET /projects/{projectId}/tasks` | Returns count and per-task: `taskId`, input and outcome, owner and assignees, creation and due dates |
| Reclaim | [ReclaimTask](../reference/ReclaimTask.md) `PUT /tasks/{taskId}/reclaim` | Removes the owner; another user in the assignees list can accept it; not reassigned automatically |
| Complete | [CompleteTask](../reference/CompleteTask.md) `PUT /tasks/{taskId}/complete` | - |
| Assign | [AssignTask](../reference/AssignTask.md) `PUT /tasks/{taskId}/assign` | For tasks rejected by all assignees: get IDs from [ListUsers](../reference/ListUsers.md) or [ListGroups](../reference/ListGroups.md), then PUT the identifiers |
| Import target file version | [ImportTargetFileVersion](../reference/ImportTargetFileVersion.md) | See [file-formats.md](./file-formats.md) |

## Related

- File versions and workflow input types: [file-formats.md](./file-formats.md)
- Quotes: [quotes.md](./quotes.md)
- Webhooks for project/task events: [webhooks.md](./webhooks.md)
