# Known issues

This page lists the known bugs and issues for Trados Cloud Platform API.

> [!NOTE]
> 5xx status codes might be returned on any endpoint. This means that the server has encountered an unexpected error. If the error persists, use the [How to report an issue](../docs/How-to-report-an-issue.md) guideline to gather the needed information for reporting the issue.

### Download Exported Quote Report

The [Download Exported Quote Report](../api/Public-API.v1-fv.html#/operations/DownloadQuoteReport) endpoint is designed to be a one-time operation. After a download attempt, the file is deleted and it's no longer available for download. If the file needs to be downloaded again, the user needs to request a new export of the quote report by using the [Export Quote Report](../api/Public-API.v1-fv.html#/operations/ExportQuoteReport) and [Poll Quote Report Export](../api/Public-API.v1-fv.html#/operations/PollQuoteReportExport) endpoints.

### Export Quote report
When the export is not using a Quote Template, the response for this call will be empty.

