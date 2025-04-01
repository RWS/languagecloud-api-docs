# Track projects

After you create a project, you can track it by making a `GET` request to the [`/projects/{projectId}`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}/get) endpoint to obtain information such as: creation date, due date, status, and resources used.

When requesting a list of projects, you can filter out projects that have a file download restriction by sending the `excludeOnline` query parameter.
