# Webhooks payload

**The request body** has the same standard JSON format for all [Trados Cloud Platform events](../../api/Webhooks.v1-fv.html#/schemas/webhook).

An example of request for a `PROJECT_CREATED` event:

```json
{
  "eventId": "EVENT_ID",
  "eventType": "PROJECT.CREATED",
  "version": "1.0",
  "timestamp": "TIMESTAMP",
  "accountId": "ACCOUNT_ID",
  "data": {
    "id": "DATA_ID",
    "name": "PROJECT_NAME",
    "description": "PROJECT_DESCRIPTION",
    "customFields": [
      {
        "id": "CUSTOM_FIELD_ID1",
        "key": "CUSTOM_FIELD_KEY1",
        "value": "CUSTOM_FIELD_VALUE1"
      },
      {
        "id": "CUSTOM_FIELD_ID2",
        "key": "CUSTOM_FIELD_KEY2",
        "value": "CUSTOM_FIELD_VALUE2"
      }
    ]
  }
}
```

> Note: Depending on the event type, the `data` field will contain a different object, representing the Data Payload Object as mentioned in the next example. This will include different details relevant to that event type, please check the table below.

This is the envelope that is common to all events, and only the < Data Payload Object part > is specific and depending on the event type.

```json
{
  "eventId": "EVENT_ID",
  "eventType": "PROJECT.CREATED",
  "version": "1.0",
  "timestamp": "TIMESTAMP",
  "accountId": "ACCOUNT_ID",
  "data": {
    < Data Payload Object part >
  }
}
```
<br>

| Event  | Data payload object model  | Trigger operations in Trados Cloud Platform API | Trigger operations in Trados UI  |
|---|---|---|---|
|  `PROJECT.TASK.ACCEPTED` |  [`task-event`](../../api/Webhooks.v1-fv.html#/schemas/task-event) | Accept task <br> Accept error task | Accept task <br> Accept error task |
| `PROJECT.TASK.CREATED` | [`task-event`](../../api/Webhooks.v1-fv.html#/schemas/task-event) | Generate task | Generate task |
| `PROJECT.TASK.COMPLETED` | [`task-event`](../../api/Webhooks.v1-fv.html#/schemas/task-event) | Complete task | Complete task |
| `PROJECT.TASK.UPDATED` | [`task-event`](../../api/Webhooks.v1-fv.html#/schemas/task-event) | Generate task <br> Accept task <br> Reject task <br> Release task <br> Assign task <br> Reassign task <br> Complete task | Generate task <br>Accept task <br> Reject task <br> Release task <br> Assign task <br> Reassign task <br> Complete task |
| `PROJECT.TASK.DELETED` | [`task-event`](../../api/Webhooks.v1-fv.html#/schemas/task-event) | Delete project and its tasks | Delete project and its tasks |
| `PROJECT.CREATED` | [`project-event`](../../api/Webhooks.v1-fv.html#/schemas/project-event) | Create project | Create project |
| `PROJECT.STARTED` | [`project-event`](../../api/Webhooks.v1-fv.html#/schemas/project-event) | Start project  | Start project  |
| `PROJECT.UPDATED` | [`project-event`](../../api/Webhooks.v1-fv.html#/schemas/project-event) | Start project (This event will also be emitted in addition to `PROJECT.STARTED`)<br>Update project by changing any field <br>Complete project <br> Cancel source file  <br> Complete target file | Start project (This event will also be emitted in addition to `PROJECT.STARTED`)<br> Update project by changing the `Project Information`, `Configuration` or `Custom Fields` fields in the `Settings` tab <br> Complete project <br> Set project back in progress <br> Cancel project <br> Complete target file |
| `PROJECT.DELETED` | [`project-event`](../../api/Webhooks.v1-fv.html#/schemas/project-event)  | Delete project | Delete project |
| `PROJECT.TEMPLATE.CREATED` | [`project-template-event`](../api/Webhooks.v1-fv.html#/schemas/project-template-event) |  | Create project template |
| `PROJECT.TEMPLATE.UPDATED`  | [`project-template-event`](../../api/Webhooks.v1-fv.html#/schemas/project-template-event) |  | Create project template <br> Update project template |
| `PROJECT.TEMPLATE.DELETED` | [`project-template-event`](../../api/Webhooks.v1-fv.html#/schemas/project-template-event) | | Delete project template |
| `PROJECT.SOURCE.FILE.CREATED` | [`source-file-event`](../api/Webhooks.v1-fv.html#/schemas/source-file-event) | Add source file to project <br> Attach source files to project | Add reference file to project <br> Add translatable file to project |
| `PROJECT.SOURCE.FILE.UPDATED` | [`source-file-event`](../../api/Webhooks.v1-fv.html#/schemas/source-file-event) | Update source file by changing the `name` field <br> Add source file version <br> The project reaches the `File Type Detection` task <br> The project reaches the `File Format Conversion` task | Update source file by changing the `fileType` or `fileRole` fields <br> Add source file version via `Replace file` action <br> Delete source file version <br> Cancel source file <br> The project reaches the `File Type Detection` task <br> The project reaches the `File Format Conversion` task |
| `PROJECT.SOURCE.FILE.DELETED` | [`source-file-event`](../../api/Webhooks.v1-fv.html#/schemas/source-file-event) |Delete project and its tasks | Delete project and its tasks |
| `PROJECT.TARGET.FILE.CREATED` | [`target-file-event`](../../api/Webhooks.v1-fv.html#/schemas/target-file-event) | The project reaches the `File Format Conversion` task | The project reaches the `File Format Conversion` task |
| `PROJECT.TARGET.FILE.UPDATED` | [`target-file-event`](../../api/Webhooks.v1-fv.html#/schemas/target-file-event) | Update source file by changing the `name` field <br> Add target file version <br> Import target file version <br> The project reaches the `File Format Conversion` task <br> The project reaches the `Copy Source to Target` task <br> The project reaches the `Machine Translation` task <br> The project reaches the `Bilingual Engineering` task <br> The project reaches the `Translation` task <br> The project reaches the `Linguistic Review` task <br> The project reaches the `Customer Review` task <br> The project reaches the `Implement Customer Review` task <br> The project reaches the `Target File Generation` task | Add target file version via `Upload SDLXLIFF` action <br> Replace target file <br> Delete target file version <br> Cancel target file <br> The project reaches the `File Format Conversion` task <br> The project reaches the `Copy Source to Target` task <br> The project reaches the `Machine Translation` task <br> The project reaches the `Bilingual Engineering` task <br> The project reaches the `Translation` task <br> The project reaches the `Linguistic Review` task <br> The project reaches the `Customer Review` task <br> The project reaches the `Implement Customer Review` task <br> The project reaches the `Target File Generation` task |
| `PROJECT.TARGET.FILE.DELETED` | [`target-file-event`](../../api/Webhooks.v1-fv.html#/schemas/target-file-event) | Delete project and its tasks | Delete project and its tasks |
| `PROJECT.GROUP.PROJECT.MEMBERSHIP.CHANGE` | [`project-group-event`](../../api/Webhooks.v1-fv.html#/schemas/project-group-event) | Add project to project group <br> Remove project from project group  | Add project to project group <br> Remove project from project group |
| `PROJECT.ERROR.TASK.CREATED` | [`error-task-event`](../../api/Webhooks.v1-fv.html#/schemas/error-task-event) | Generate error task | Generate error task |
| `PROJECT.ERROR.TASK.COMPLETED` | [`error-task-event`](../../api/Webhooks.v1-fv.html#/schemas/error-task-event) | Complete error task | Complete error task |
| `PROJECT.ERROR.TASK.ACCEPTED` | [`error-task-event`](../../api/Webhooks.v1-fv.html#/schemas/error-task-event) | Accept error task | Accept error task |


