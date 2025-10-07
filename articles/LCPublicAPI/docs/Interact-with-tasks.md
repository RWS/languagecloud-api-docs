# Interact with tasks

Once the project is started, you can interact with tasks in several ways:

### Find the task identifier

Make a `GET` request to the [`/tasks/assigned`](../api/Public-API.v1-fv.html#/operations/ListTasksAssignedToMe) endpoint and identify the `id` of the task you want to interact with.

### Reclaim tasks

If you make a `PUT` request to the [`/tasks/{taskId}/reclaim`](../api/Public-API.v1-fv.html#/operations/ReclaimTask) endpoint, the owner of task is removed and another user from the assignee's list can accept it. The task is not reassigned automatically.

### Complete tasks

To complete a task, make a `PUT` request to the [`/tasks/{taskId}/complete`](../api/Public-API.v1-fv.html#/operations/CompleteTask) endpoint.

### Assign tasks

If the tasks is rejected by all its assignees, you can update the list of assignees. Make a `GET` request to the [`/users`](../api/Public-API.v1-fv.html#/operations/ListUsers) or [`/groups`](../api/Public-API.v1-fv.html#/operations/ListGroups) endpoints and remember their identifiers. Then, make a `PUT` request to the [`/tasks/{taskId}/assign`](../api/Public-API.v1-fv.html#/operations/AssignTask) endpoint and provide the identifiers.

### List all the tasks in a project

Make a `GET` call to the [`/projects/{projectId}/tasks`](../api/Public-API.v1-fv.html#/operations/ListProjectTasks) endpoint to list all the tasks in a project by projectId. The response returns a total count of the tasks, and several details for each task: `taskId`, the input and outcome per task, the owner and assignees, the creation and due dates.


### Upload/Import a target file version

Make a `POST` call to the [`/projects/{projectId/target-files/{targetFileId}/versions/imports`](../api/Public-API.v1-fv.html#/operations/ImportTargetFileVersion) endpoint to upload (import) a new file version that can be used as part of a task. The response returns the `importId` which you can further use to check the import result by making a `GET` call to the [`/projects/{projectId}/target-files/{targetFileId}/versions/imports/{importId}`](../api/Public-API.v1-fv.html#/operations/PollTargetFileVersionImport) endpoint. The `projectId` can be retrieved by making a `POST` call to the [`/projects`](../api/Public-API.v1-fv.html#/operations/CreateProject) endpoint, while the `targetFileId` can be retrieved by making a `GET` call to the [`/projects/{projectId}/target-files`](../api/Public-API.v1-fv.html#/operations/ListTargetFiles) endpoint.



