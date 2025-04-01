# Known issues

This page lists the known bugs and issues for Trados Cloud Platform API.

> Note: 5xx status codes might be returned on any endpoint. This means that the server has encountered an unexpected error. If the error persists, use the [How to report an issue](../docs/How-to-report-an-issue.md) guideline to gather the needed information for reporting the issue.

### Download Exported Quote Report

The [Download Exported Quote Report](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1download/get) endpoint is designed to be a one-time operation. After a download attempt, the file is deleted and it's no longer available for download. If the file needs to be downloaded again, the user needs to request a new export of the quote report by using the [Export Quote Report](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1export/post) and [Poll Quote Report Export](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1export/get) endpoints.

### Export Quote report
When the export is not using a Quote Template, the response for this call will be empty.
