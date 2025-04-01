# Interact with tasks

Once the project is started, you can interact with tasks in several ways:

### Find the task identifier

Make a `GET` request to the [`/tasks/assigned`](../reference/Public-API.v1.json/paths/~1tasks~1assigned/get) endpoint and identify the `id` of the task you want to interact with.

### Reclaim tasks

If you make a `PUT` request to the [`/tasks/{taskId}/reclaim`](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1reclaim/put) endpoint, the owner of task is removed and another user from the assignee's list can accept it. The task is not reassigned automatically.

### Complete tasks

To complete a task, make a `PUT` request to the [`/tasks/{taskId}/complete`](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1complete/put) endpoint.

### Assign tasks

If the tasks is rejected by all its assignees, you can update the list of assignees. Make a `GET` request to the [`/users`](../reference/Public-API.v1.json/paths/~1users/get) or [`/groups`](../reference/Public-API.v1.json/paths/~1groups/get) endpoints and remember their identifiers. Then, make a `PUT` request to the [`/tasks/{taskId}/assign`](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1assign/put) endpoint and provide the identifiers.

### List all the tasks in a project

Make a `GET` call to the [`/projects/{projectId}/tasks`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1tasks/get) endpoint to list all the tasks in a project by projectId. The response returns a total count of the tasks, and several details for each task: `taskId`, the input and outcome per task, the owner and assignees, the creation and due dates.


### Upload/Import a target file version

Make a `POST` call to the [`/projects/{projectId/target-files/{targetFileId}/versions/imports`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1imports/post) endpoint to upload (import) a new file version that can be used as part of a task. The response returns the `importId` which you can further use to check the import result by making a `GET` call to the [`/projects/{projectId}/target-files/{targetFileId}/versions/imports/{importId}`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1imports~1{importId}/get) endpoint. The `projectId` can be retrieved by making a `POST` call to the [`/projects`](../reference/Public-API.v1.json/paths/~1projects/post) endpoint, while the `targetFileId` can be retrieved by making a `GET` call to the [`/projects/{projectId}/target-files`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files/get) endpoint.


