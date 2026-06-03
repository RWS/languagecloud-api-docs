# Trados Cloud Platform API - Index

## Account

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/accounts` | [ListMyAccounts](./ListMyAccounts.md) | Retrieves the accounts the authenticated user is part of.   > For service users only the account where the user is defined is returned. |  |

## Integration

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| POST | `/applications` | [CreateApplication](./CreateApplication.md) | Creates a new integration application. |  |
| GET | `/applications` | [ListApplications](./ListApplications.md) | Retrieves a list of applications the authenticated user has access to. |  |
| PUT | `/applications/{applicationId}` | [UpdateApplication](./UpdateApplication.md) | Updates an integration application. |  |
| GET | `/applications/{applicationId}` | [GetApplication](./GetApplication.md) | Retrieves an integration application by identifier. |  |
| DELETE | `/applications/{applicationId}` | [DeleteApplication](./DeleteApplication.md) | Deletes an integration application. |  |

## Connected AI

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/connected-ai/llm-configurations` | [ListLlmConfigurations](./ListLlmConfigurations.md) | List the account configured Large Language Models. |  |

## Customer

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| PUT | `/customers/{customerId}` | [UpdateCustomer](./UpdateCustomer.md) | Updates a customer by identifier. |  |
| GET | `/customers/{customerId}` | [GetCustomer](./GetCustomer.md) | Retrieves a customer by identifier. |  |
| DELETE | `/customers/{customerId}` | [DeleteCustomer](./DeleteCustomer.md) | Deletes a customer. |  |
| GET | `/customers` | [ListCustomers](./ListCustomers.md) | Retrieves a list of all the customers in an account. |  |
| POST | `/customers` | [CreateCustomer](./CreateCustomer.md) | Create customer in a tenant.  For adding a customer to a tenant the authenticated user must have 'Create Customer' permission.  To also create an account for the key contact, you need to have the specific entitlements. |  |

## Custom Field

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/custom-field-definitions` | [ListCustomFields](./ListCustomFields.md) | Retrieves a list of all the custom field definitions. |  |
| GET | `/custom-field-definitions/{customFieldDefinitionId}` | [GetCustomField](./GetCustomField.md) | Retrieves a Custom Field by identifier. |  |

## File Processing Configuration

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/file-processing-configurations/{fileProcessingConfigurationId}` | [GetFileProcessingConfiguration](./GetFileProcessingConfiguration.md) | Retrieves a file processing configuration by identifier. |  |
| GET | `/file-processing-configurations` | [ListFileProcessingConfigurations](./ListFileProcessingConfigurations.md) | Retrieves a list of all the file processing configurations in an account. |  |
| GET | `/file-processing-configurations/{fileProcessingConfigurationId}/file-type-settings/{fileTypeSettingId}` | [GetFileTypeSetting](./GetFileTypeSetting.md) | Retrieves a file type setting by identifier. |  |
| GET | `/file-processing-configurations/{fileProcessingConfigurationId}/file-type-settings` | [ListFileTypeSettings](./ListFileTypeSettings.md) | Retrieves a list of all the file type settings in a file processing configuration. |  |

## File

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| POST | `/files` | [UploadZipFile](./UploadZipFile.md) | Uploads an archive containing source files in `.zip` format, which will be extracted and used during project creation.  Status of the upload operation can be tracked using the [Poll Upload Zip File](#/operations/PollUploadZipFile) endpoint.  Once this Upload Zip File operation has finished extracting the files, they can be added to the desired project using the [Attach Source Files](#/operations/AddSourceFiles) endpoint. Alternatively, they can be used to [Request File Analysis](#/operations/RequestFileAnalysis) details like word counts and estimated costs.   Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files. |  |
| POST | `/files/analysis` | [RequestFileAnalysis](./RequestFileAnalysis.md) | This endpoint allows you to request the word count and an estimated cost for your files.     Use the [Upload Zip File](#/operations/UploadZipFile) / [Poll Upload Zip File](#/operations/PollUploadZipFile) endpoints to upload your files and get the `fileIds`. Send these `fileIds` together with the `languageProcessingRuleId` and `sourceLanguage` to receive the word count.    Optionally, send the `quotingOptions` object to receive the `estimatedCosts`.    Use the [Poll File Analysis](#/operations/PollFileAnalysis) endpoint to monitor the operation and receive the analysis results.    > File analysis results will be available for 24 hours after generation. |  |
| GET | `/files/analysis/{operationId}` | [PollFileAnalysis](./PollFileAnalysis.md) | Monitor the [File Analysis](#/operations/RequestFileAnalysis) operation and receive the analysis results.    > File analysis results will be available for 24 hours after generation. |  |
| GET | `/files/{fileId}` | [PollUploadZipFile](./PollUploadZipFile.md) | Monitors the unzipping operation for a previously uploaded archive and retrieves details about the extracted files.    Once the [Upload Zip File](#/operations/UploadZipFile) operation has finished extracting the files, they can be added to the desired project using the [Attach Source Files](#/operations/AddSourceFiles) endpoint.   Alternatively, they can be used to [Request File Analysis](#/operations/RequestFileAnalysis) details like word counts and estimated costs.   |  |

## Folder

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/folders/{folderId}` | [GetFolder](./GetFolder.md) | Retrieves a folder by identifier. |  |
| GET | `/folders/root` | [GetRootFolder](./GetRootFolder.md) | Retrieves the Root folder in the account. |  |
| GET | `/folders` | [ListFolders](./ListFolders.md) | Retrieves a list of all the folders in an account. |  |

## Group

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/groups/{groupId}` | [GetGroup](./GetGroup.md) | Retrieves a group by identifier. |  |
| PUT | `/groups/{groupId}` | [UpdateGroup](./UpdateGroup.md) | Updates a group. We recommend reading this page too [Updating data with PUT](../docs/Updating-data-with-PUT.html). |  |
| DELETE | `/groups/{groupId}` | [DeleteGroup](./DeleteGroup.md) | Deletes a group by identifier. |  |
| GET | `/groups` | [ListGroups](./ListGroups.md) | Retrieves a list of all the groups in an account. |  |
| POST | `/groups` | [CreateGroup](./CreateGroup.md) | Creates a group. Group roles will take effect based on the location, where the group is being created. Read more at [How to use location and folders](../docs/How-to-use-location-and-folders.html). |  |

## Language

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/languages` | [ListLanguages](./ListLanguages.md) | Retrieves a list of all the languages.  The supported values for language `type` filter are: "all", "specific" or "neutral".\ The "neutral" languages are the generic languages, e.g.: en -> English.\ The "specific" languages are the sub-languages, e.g.: en-150 -> English (Europe), en-us -> English (United States). |  |

## Language Processing

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/language-processing-rules` | [ListLanguageProcessingRules](./ListLanguageProcessingRules.md) | Returns a list of Language Processing Rules. |  |
| GET | `/language-processing-rules/{languageProcessingRuleId}` | [GetLanguageProcessingRule](./GetLanguageProcessingRule.md) | Returns a Language Processing Rule by identifier. |  |

## PerfectMatch Mapping

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| POST | `/perfect-match-mappings` | [CreatePerfectMatchMapping](./CreatePerfectMatchMapping.md) | For more details on the PerfectMatch feature please consult the [official documentation](https://docs.rws.com/791595/1155478/trados-enterprise---accelerate/perfectmatch-general-information).    After creating a mapping, target files from the `matchingProjects` are automatically matched to the source files in the new project. This is a long-running background operation, and its `status` can be tracked by polling  the [Get PerfectMatch Mapping](#/operations/GetPerfectMatchMapping) endpoint. |  |
| GET | `/perfect-match-mappings/{mappingId}` | [GetPerfectMatchMapping](./GetPerfectMatchMapping.md) | Retrieves the details of a PerfectMatch mapping. |  |
| POST | `/perfect-match-mappings/{mappingId}/batch-mappings` | [AddPerfectMatchBatchMapping](./AddPerfectMatchBatchMapping.md) | Adds a new PerfectMatch batch mapping.    When new source files are introduced to a mid-project, a new batch must be added to the current mapping to leverage PerfectMatch. This action triggers a background operation that identifies matching candidates for the newly added files. |  |
| PUT | `/perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}` | [UpdatePerfectMatchBatchMapping](./UpdatePerfectMatchBatchMapping.md) | Updates a PerfectMatch batch mapping.    Pay special attention to how [updating works](../docs/Updating-data-with-PUT.html). |  |
| PUT | `/perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/project-file` | [UpdatePerfectMatchFileMappingWithProjectFile](./UpdatePerfectMatchFileMappingWithProjectFile.md) | Updates a PerfectMatch file mapping with an existing target file from a PerfectMatch candidate. Only valid candidates can be used to request an update.    Use the [Candidates](#/operations/GetPerfectMatchCandidates) endpoint to retrieve a list of valid `fileId` and `projectId` to provide as matching data.  |  |
| POST | `/perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/file` | [UpdatePerfectMatchFileMappingWithManuallyUploadedFile](./UpdatePerfectMatchFileMappingWithManuallyUploadedFile.md) | Updates a PerfectMatch file mapping with a manually uploaded file. |  |
| DELETE | `/perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/target-languages/{targetLanguage}` | [DeletePerfectMatchFileMappingForFile](./DeletePerfectMatchFileMappingForFile.md) | Deletes a PerfectMatch file mapping for a specific file and target language. |  |
| GET | `/perfect-match-mappings/{mappingId}/batch-mappings/{batchMappingId}/file-mappings/{fileMappingId}/target-languages/{targetLanguage}/candidates` | [GetPerfectMatchCandidates](./GetPerfectMatchCandidates.md) | Retrieves a list of file candidates that can be selected for PerfectMatch. |  |

## Machine Translation

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/machine-translation` | [ListMachineTranslations](./ListMachineTranslations.md) | Retrieves a list of machine translations that can be used in a translation engine. |  |

## Pricing Model

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/pricing-models` | [ListPricingModels](./ListPricingModels.md) | Retrieves a list of all the pricing models in an account.    Sorting is supported for the following fields: `name`, `description`, `currencyCode` and `location`. |  |
| POST | `/pricing-models` | [CreatePricingModel](./CreatePricingModel.md) | Creates a new pricing model. |  |
| GET | `/pricing-models/{pricingModelId}` | [GetPricingModel](./GetPricingModel.md) | Retrieves a pricing model by identifier. |  |
| PUT | `/pricing-models/{pricingModelId}` | [UpdatePricingModel](./UpdatePricingModel.md) | Updates a pricing model. |  |
| DELETE | `/pricing-models/{pricingModelId}` | [DeletePricingModel](./DeletePricingModel.md) | Deletes a pricing model. |  |

## Project

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/projects` | [ListProjects](./ListProjects.md) | Retrieves a list of all the projects in the account. |  |
| POST | `/projects` | [CreateProject](./CreateProject.md) | Creates a new project.  When creating a project using a project template that supports multiple source languages, you must supply the `languageDirections`.  Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when creating projects.  The values from a selected project template will take precedence over the individual resources when creating a new project. |  |
| GET | `/projects/{projectId}` | [GetProject](./GetProject.md) | Retrieves a project by identifier.  For detailed information about Translation Memory advanced configuration including filters and field updates, see [Translation Memory Advanced Configuration](../docs/translation-memory/Translation-memory-advanced-configuration.html). |  |
| PUT | `/projects/{projectId}` | [UpdateProject](./UpdateProject.md) | Updates the project in terms of: name, description, due date, quote, and project resources. Observe the rules of [JSON Merge Patch Semantics](https://tools.ietf.org/html/rfc7386).   Project rescheduling (updating dueBy) is permitted only if:  * there is no Customer Quote Approval task in the associated flow  * at least one Customer Quote Approval was closed(in case multiple project batches)   Update `projectPlan.taskConfigurations` are now permitted before project is started. Elements are now pre-populated at project creation time.  For detailed information about Translation Memory advanced configuration including filters and field updates, see [Translation Memory Advanced Configuration](../docs/translation-memory/Translation-memory-advanced-configuration.html). |  |
| DELETE | `/projects/{projectId}` | [DeleteProject](./DeleteProject.md) | Deletes a project. |  |
| GET | `/projects/{projectId}/configuration` | [GetProjectConfiguration](./GetProjectConfiguration.md) | Get the configuration settings of an existing project. |  |
| PUT | `/projects/{projectId}/configuration` | [UpdateProjectConfiguration](./UpdateProjectConfiguration.md) | Updates the configuration settings for an existing project. |  |
| PUT | `/projects/{projectId}/pricing-model` | [UpdateProjectPricingModel](./UpdateProjectPricingModel.md) | Update project pricing model only during Customer Quote Review task type. |  |
| PUT | `/projects/{projectId}/start` | [StartProject](./StartProject.md) | Starts a project. Translatable files should be uploaded before starting the project. If the action is executed on an already started project, the new translatable files should be uploaded first. |  |
| PUT | `/projects/{projectId}/complete` | [CompleteProject](./CompleteProject.md) | Marks a project as "completed". |  |
| POST | `/projects/{projectId}/files/exports` | [ExportProjectFiles](./ExportProjectFiles.md) | Generates an asynchronous export operation. To monitor the progress until completion, use the [Poll Project Files Export](../api/Public-API.v1-fv.html#/operations/ExportProjectFilesStatus)  endpoint.   This operation triggers the packaging of the project files into a `zip` format. > [!WARNING]  > The export ID has a time-to-live (TTL) of 20 minutes, starting from when this export operation is initiated (not when the underlying async operation completes). Ensure you poll and download the export within this timeframe, or you will receive a `404 Not Found` error. |  |
| GET | `/projects/{projectId}/files/exports/{exportId}` | [ExportProjectFilesStatus](./ExportProjectFilesStatus.md) | Retrieves the state of the export operation.    Once the state is marked as `done`, you can download the generated `zip` file using the following endpoint: [Download Exported Project Files](../api/Public-API.v1-fv.html#/operations/DownloadFile).  > [!WARNING]  > The export ID has a time-to-live (TTL) of 20 minutes, starting from when the export operation was initiated (not when the underlying async operation completes). If the TTL expires, this endpoint will return a `404 Not Found` error. Ensure you poll and download the export within this timeframe. |  |
| GET | `/projects/{projectId}/files/exports/{exportId}/download` | [DownloadFile](./DownloadFile.md) | Downloads the generated `zip` file containing the files according to initial export operation parameters.   The final ZIP file will be named using the project name.    When the export operation is performed with `downloadFlat=true` and one target language specified, the resulting ZIP file name will be a combination of the project name and the target language code, as defined by the [Export Project Files](#/operations/ExportProjectFiles) endpoint. |  |
| PUT | `/projects/{projectId}/files/{fileId}/cancel` | [CancelProjectFile](./CancelProjectFile.md) | Cancels a project file.  The `fileId` path parameter can be either a source file identifier or a target file identifier. Use the [List Source Files](#/operations/ListSourceFiles) endpoint to obtain source file identifiers, or the [List Target Files](#/operations/ListTargetFiles) endpoint to obtain target file identifiers. |  |
| GET | `/projects/{projectId}/tasks` | [ListProjectTasks](./ListProjectTasks.md) | Lists the tasks of a specific project. |  |
| PATCH | `/projects/{projectId}/tasks/reschedule` | [RescheduleProjectTasks](./RescheduleProjectTasks.md) | Reschedules the tasks of a specific project. |  |
| PUT | `/projects/{projectId}/custom-fields/{customFieldKey}` | [UpdateCustomField](./UpdateCustomField.md) | Allows updating individual custom fields on a project. |  |

## Source File

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/projects/{projectId}/source-files` | [ListSourceFiles](./ListSourceFiles.md) | Retrieves the source files in a project. |  |
| POST | `/projects/{projectId}/source-files` | [AddSourceFile](./AddSourceFile.md) | Adds a source file to the project. Files can be uploaded before starting a project or after the project has started. When adding a `translatable` file after the project started, a new start project request should be performed.  Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files.  > Note: The maximum character size of the sum between the `name` and the `path` fields must not exceed 255. Otherwise the request cannot be validated.  > Note: Zip files will be added as reference files. If you want to upload zip files, please use the [Upload Zip File](#/operations/UploadZipFile) endpoint. |  |
| PUT | `/projects/{projectId}/source-files` | [UpdateSourceFiles](./UpdateSourceFiles.md) | Updates multiple source files. If any of the files fails to be updated, an error will be returned for each file.  |  |
| POST | `/projects/{projectId}/source-files/attach-files` | [AddSourceFiles](./AddSourceFiles.md) | This endpoint can only be used after files have been uploaded via the [Upload Zip File](#/operations/UploadZipFile) endpoint. It allows you to add multiple source files to a project.    Each file must be individually attached by setting the `fileUrl` to the `associatedFiles.id` returned by the [Poll Upload Zip File](#/operations/PollUploadZipFile) endpoint, once the `unzipStatus` is `extracted`.   If a file is attached after the project has already been started, a new start project request must be made.  > Note: The maximum character size of the sum between the `name` and the `path` fields must not exceed 255. Otherwise the request cannot be validated.  |  |
| GET | `/projects/{projectId}/source-files/{sourceFileId}` | [GetSourceFile](./GetSourceFile.md) | Retrieves a source file from the project. |  |
| PUT | `/projects/{projectId}/source-files/{sourceFileId}` | [UpdateSourceFile](./UpdateSourceFile.md) | Updates a source file. |  |
| GET | `/projects/{projectId}/source-files/{sourceFileId}/versions` | [ListSourceFileVersions](./ListSourceFileVersions.md) | Retrieves all the versions of a source file. |  |
| POST | `/tasks/{taskId}/source-files/{sourceFileId}/versions` | [AddSourceFileVersion](./AddSourceFileVersion.md) | Adds a new version of the source file in [BCM](../../BCM/BCM.NET_client_API.html) or native format. More information about file formats can be found on the [File formats](../docs/File-formats.html) page.  The version is added on the task represented by `taskId`. To successfully  execute the add operation the task should already be assigned and accepted by a user. If the task is automatic, it's possible to add a source file version only when the status of task is `inProgress`.  The file versions added need to respect the output file type declared by the task type of the enclosing task. On the [Rules for sequencing tasks correctly](https://docs.rws.com/791595/885137/trados-enterprise/rules-for-sequencing-tasks-correctly) page from the official RWS Documentation Center, you can find out what output file type is supported by each task.  For adding a source file version using an extension task, the configuration of the task must declare the `scope`'s value as "file".  If the file type of the new added file is different than the supported source file type, the new `fileTypeSettingsId` must be specified in the body or an update of file type should be performed after the add operation, using the [Update Source File Properties](#/operations/UpdateSourceProperties).  The value of `fileTypeSettingsId` is one of the identifiers listed by the [List File Type Settings](#/operations/ListFileTypeSettings) endpoint.  The [List File Type Settings](#/operations/ListFileTypeSettings) endpoint must be called with the File Processing Configuration identifier of your project.  The File Processing Configuration of your project can be retrieved from [Get Project](#/operations/GetProject) endpoint.  The multipart parameters in the body should respect and strictly follow the order specified in our documentation.   Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when adding files.  |  |
| GET | `/projects/{projectId}/source-files/{sourceFileId}/versions/{fileVersionId}/download` | [DownloadSourceFileVersion](./DownloadSourceFileVersion.md) | Downloads a source file version. |  |
| GET | `/tasks/{taskId}/source-files/{sourceFileId}` | [GetSourceFileProperties](./GetSourceFileProperties.md) | Retrieves the properties for a source file. |  |
| PUT | `/tasks/{taskId}/source-files/{sourceFileId}` | [UpdateSourceProperties](./UpdateSourceProperties.md) | Updates the properties of the source file.   The value of `fileTypeSettingsId` should be one of the identifiers listed by the [List File Type Settings](#/operations/ListFileTypeSettings)  endpoint called with an identifier of a File Processing Configuration that exists on the project. The list of File Processing Configurations from a project can be retrieved by using the [List File Processing Configurations](#/operations/ListFileProcessingConfigurations) endpoint. |  |

## Target File

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/projects/{projectId}/target-files/{targetFileId}` | [GetTargetFile](./GetTargetFile.md) | Retrieves a target file from a project. |  |
| PUT | `/projects/{projectId}/target-files/{targetFileId}` | [UpdateTargetFile](./UpdateTargetFile.md) | Updates a target file. |  |
| GET | `/projects/{projectId}/target-files` | [ListTargetFiles](./ListTargetFiles.md) | Retrieves the target files for a project. |  |
| PUT | `/projects/{projectId}/target-files` | [UpdateTargetFiles](./UpdateTargetFiles.md) | Updates multiple target files. If any of the files fails to be updated, an error will be returned for each file.  |  |
| GET | `/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}` | [GetTargetFileVersion](./GetTargetFileVersion.md) | Retrieves one version of a target file. |  |
| GET | `/projects/{projectId}/target-files/{targetFileId}/versions` | [ListTargetFileVersions](./ListTargetFileVersions.md) | Retrieves the versions of a target file. |  |
| POST | `/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports` | [ExportTargetFileVersion](./ExportTargetFileVersion.md) | Generates an asynchronous export operation. Use the [Get Target File Version Export](#/operations/PollTargetFileVersionExport) endpoint to poll until the export is completed. Used only for [BCM](../../BCM/BCM.NET_client_API.html) file versions.  This operation triggers a conversion of the BCM target file version in a native or SDLXLIFF format, based on the value of the `format` query parameter used.  Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files. |  |
| GET | `/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}` | [PollTargetFileVersionExport](./PollTargetFileVersionExport.md) | Polls a target file version via an export operation. The new version can be downloaded once the status is "completed". |  |
| GET | `/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports/{exportId}/download` | [DownloadExportedTargetFileVersion](./DownloadExportedTargetFileVersion.md) | Downloads a completed target file version via an export operation. |  |
| GET | `/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download` | [DownloadFileVersion](./DownloadFileVersion.md) | Downloads the file version (native or BCM).   If the `fileVersionId` path parameter represents a native file version, the native file will be downloaded. If the `fileVersionId` is an identifier of a version in [BCM format](../../BCM/BCM.NET_client_API.html), the BCM file will be downloaded. |  |
| POST | `/projects/{projectId}/target-files/{targetFileId}/versions/imports` | [ImportTargetFileVersion](./ImportTargetFileVersion.md) | Generates an asynchronous import operation. Use [Poll Target File Version Import endpoint](#/operations/PollTargetFileVersionImport) to poll until the import is completed. Only `sdlxliff` files can be imported.  Import should be used when a file is downloaded as an `sdlxliff`, processed and then, replaced.  The import operation triggers internally the update of the [BCM](../../BCM/BCM.NET_client_API.html) file associated with the imported file. It should mostly be used for offline work.  Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files. |  |
| GET | `/projects/{projectId}/target-files/{targetFileId}/versions/imports/{importId}` | [PollTargetFileVersionImport](./PollTargetFileVersionImport.md) | Polls a target file version via an import operation. The new version can be seen on the file versions once the status is "completed". |  |
| POST | `/tasks/{taskId}/target-files/{targetFileId}/versions` | [AddTargetFileVersion](./AddTargetFileVersion.md) | Adds a new  version of the target file. Only the `native` and `bcm` file formats are accepted. For the `sdlxliff` files, you should use the [Import Target File endpoint](#/operations/ImportTargetFileVersion). More information about file formats can be found on the [File formats](../docs/File-formats.html) page. Additional details on BCM files can be found [here](../../BCM/BCM.NET_client_API.html).  The version is added on the task represented by `taskId`. To be able to execute the add operation the task should be assigned and accepted by user. If the task is automatic, it is possible to add a target file version only if the status is `inProgress`.  The added file versions need to respect the output file type declared by the task type of the enclosing task. On the [Rules for sequencing tasks correctly](https://docs.rws.com/791595/885137/trados-enterprise/rules-for-sequencing-tasks-correctly) page from the official RWS Documentation Center, you can find out what output file type is supported by each task.  For adding a target file version using an extension task, the configuration of the task type must declare the `scope`'s value as "file".  The multipart parameters in the body should respect and strictly follow the order specified in our documentation.  Consider the [file and project size limit](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) when uploading files. |  |

## Quote

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| POST | `/projects/{projectId}/quote-report/export` | [ExportQuoteReport](./ExportQuoteReport.md) | Generates an asynchronous quote export operation for the project in either PDF or Excel format. Use the [polling endpoint](../api/Public-API.v1-fv.html#/operations/PollQuoteReportExport) to check when the export is completed.  <br><br> Built-in quotes are only available in the same languages as the user interface. See [this page](https://docs.rws.com/791595/1084405/trados-enterprise---accelerate/ui-languages) for more information. <br> Customers who use non-default quote templates are responsible for the implementation of a suitable localization approach.  > [!WARNING]  > The export ID has a time-to-live (TTL) of 20 minutes, starting from when this export operation is initiated (not when the underlying async operation completes). Ensure you poll and download the export within this timeframe, or you will receive a `404 Not Found` error. |  |
| GET | `/projects/{projectId}/quote-report/export` | [PollQuoteReportExport](./PollQuoteReportExport.md) | Polls a quote report via an export operation. The quote report can be [downloaded](../api/Public-API.v1-fv.html#/operations/DownloadQuoteReport) once the status is "completed". The recommended polling interval is 20 seconds.  If the `exportId` query parameter is not provided, the polling action will return the status for the last generated export.  > [!WARNING]  > The export ID has a time-to-live (TTL) of 20 minutes, starting from when the export operation was initiated (not when the underlying async operation completes). If the TTL expires, this endpoint will return a `404 Not Found` error. Ensure you poll and download the export within this timeframe.  |  |
| GET | `/projects/{projectId}/quote-report/download` | [DownloadQuoteReport](./DownloadQuoteReport.md) | Downloads a quote report generated by the [asynchronous export operation](#/operations/ExportQuoteReport).   If the `exportId` query parameter is not provided, the last generated export quote will be downloaded. |  |

## Project Group

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/project-groups` | [ListProjectGroups](./ListProjectGroups.md) | Retrieves a list of all the project groups in an account. |  |
| POST | `/project-groups` | [CreateProjectGroup](./CreateProjectGroup.md) | Creates a new project group. |  |
| GET | `/project-groups/{projectGroupId}` | [GetProjectGroup](./GetProjectGroup.md) | Retrieves a project group by identifier. |  |
| PUT | `/project-groups/{projectGroupId}` | [UpdateProjectGroup](./UpdateProjectGroup.md) | Updates the project group. |  |
| DELETE | `/project-groups/{projectGroupId}` | [DeleteProjectGroup](./DeleteProjectGroup.md) | Deletes a project group. |  |
| POST | `/project-groups/{projectGroupId}/projects` | [AddProjectsToGroup](./AddProjectsToGroup.md) | Adds projects to the project group.  The projects are not added instantly. To check the status use the [Get Project Group](#/operations/GetProjectGroup) endpoint. |  |
| DELETE | `/project-groups/{projectGroupId}/projects` | [RemoveProjectsFromGroup](./RemoveProjectsFromGroup.md) | Removes projects from the project group.  The projects are not removed instantly. To check the status use the [Get Project Group](#/operations/GetProjectGroup) endpoint. |  |

## Project Template

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/project-templates/{projectTemplateId}` | [GetProjectTemplate](./GetProjectTemplate.md) | Retrieves a project template by identifier.  For detailed information about Translation Memory advanced configuration including filters and field updates, see [Translation Memory Advanced Configuration](../docs/translation-memory/Translation-memory-advanced-configuration.html). |  |
| PUT | `/project-templates/{projectTemplateId}` | [UpdateProjectTemplate](./UpdateProjectTemplate.md) | Updates a project template by id.  For detailed information about Translation Memory advanced configuration including filters and field updates, see [Translation Memory Advanced Configuration](../docs/translation-memory/Translation-memory-advanced-configuration.html). |  |
| DELETE | `/project-templates/{projectTemplateId}` | [DeleteProjectTemplate](./DeleteProjectTemplate.md) | Deletes a project template by id. |  |
| GET | `/project-templates` | [ListProjectTemplates](./ListProjectTemplates.md) | Retrieves a list of all the project templates in an account. |  |
| POST | `/project-templates` | [CreateProjectTemplate](./CreateProjectTemplate.md) | Creates a new project template. |  |

## Rate Limits

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/rate-limits` | [ListRateLimits](./ListRateLimits.md) | Retrieves a list of all rate limits applicable for an account. |  |

## Role and Permission

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/roles` | [ListRoles](./ListRoles.md) | Retrieves a list of all roles available for the account. |  |
| POST | `/roles` | [CreateRole](./CreateRole.md) | Creates a custom role.  See [List Permissions](#/operations/ListPermissions) for available permission names. |  |
| GET | `/roles/{roleId}` | [GetRole](./GetRole.md) | Retrieves a role by identifier. |  |
| PUT | `/roles/{roleId}` | [UpdateRole](./UpdateRole.md) | Updates a role by identifier. Pay special attention to how [updating](../docs/Updating-data-with-PUT.html) works.  See [List Permissions](#/operations/ListPermissions) for available permission names.  > Note: Only custom roles can be updated. Provisioned roles cannot be modified. |  |
| DELETE | `/roles/{roleId}` | [DeleteRole](./DeleteRole.md) | Deletes a role by identifier.  > Note: Only custom roles can be deleted. Provisioned roles cannot be removed. |  |
| GET | `/permissions` | [ListPermissions](./ListPermissions.md) | Retrieves a list of all permissions available for the account. |  |

## Schedule Template

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/schedule-templates` | [ListScheduleTemplates](./ListScheduleTemplates.md) | Retrieves a list of all the schedule templates in an account. |  |
| POST | `/schedule-templates` | [CreateScheduleTemplate](./CreateScheduleTemplate.md) | Creates a new schedule template. |  |
| GET | `/schedule-templates/{scheduleTemplateId}` | [GetScheduleTemplate](./GetScheduleTemplate.md) | Retrieves a schedule template by identifier. |  |
| DELETE | `/schedule-templates/{scheduleTemplateId}` | [DeleteScheduleTemplate](./DeleteScheduleTemplate.md) | Deletes a schedule template. |  |
| PUT | `/schedule-templates/{scheduleTemplateId}` | [UpdateScheduleTemplate](./UpdateScheduleTemplate.md) | Updates the schedule template identified by `scheduleTemplateId`. |  |

## Task

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/tasks/{taskId}` | [GetTask](./GetTask.md) | Retrieves a task. |  |
| GET | `/tasks/assigned` | [ListTasksAssignedToMe](./ListTasksAssignedToMe.md) | Retrieves the tasks assigned to the authenticated user. |  |
| PUT | `/tasks/{taskId}/accept` | [AcceptTask](./AcceptTask.md) | Accepts a task. The authenticated user becomes the owner of the accepted task and can start work on it. Optionally, the task can be accepted on behalf of a group by providing the `onBehalfOfGroup` query parameter. In this case, the authenticated user must be a member of the specified group, and the group must be present in the task's assignee list. The `onBehalfOfGroup` parameter is allowed only if the [task](#/operations/GetTask) has `configuration.CONCURRENT_EDITING_ENABLED = true`. |  |
| PUT | `/tasks/{taskId}/reject` | [RejectTask](./RejectTask.md) | Rejects a task. The authenticated user will be removed from the task's list of available assignee users. |  |
| PUT | `/tasks/{taskId}/complete` | [CompleteTask](./CompleteTask.md) | Completes a task. The task is required to be in "inProgress" state and will be marked as "completed". |  |
| PUT | `/tasks/{taskId}/release` | [ReleaseTask](./ReleaseTask.md) | Releases the task from its owner so that other task assignees will be able to accept it. |  |
| PUT | `/tasks/{taskId}/reclaim` | [ReclaimTask](./ReclaimTask.md) | The current owner of task is removed so that other assignees can accept it.  The task is not reassigned automatically. |  |
| PUT | `/tasks/{taskId}/assign` | [AssignTask](./AssignTask.md) | Assigns a task. The task assignees will be updated. |  |

## Task Type

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/task-types/{taskTypeId}` | [GetTaskType](./GetTaskType.md) | Retrieves a task type by identifier. |  |
| GET | `/task-types` | [ListTaskTypes](./ListTaskTypes.md) | Retrieves all the task types in an account. |  |

## Translation Engine

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/translation-engines/{translationEngineId}` | [GetTranslationEngine](./GetTranslationEngine.md) | Retrieves a translation engine. |  |
| PUT | `/translation-engines/{translationEngineId}` | [UpdateTranslationEngine](./UpdateTranslationEngine.md) | Updates a translation engine.   It can be used to update a stand-alone translation engine or a project's translation engine.  The identifier of a project's translation engine can be retrieved only by calling [Get Project](#/operations/GetProject) endpoint.  Pay special attention that some properties can not be changed for a project's translation engine. These include: name, description, definition.languageProcessingId, and language pairs can not be added/removed from definition.languagePairDefinitions.   Pay special attention to how [updating](../docs/Updating-data-with-PUT.html) works. |  |
| GET | `/translation-engines` | [ListTranslationEngines](./ListTranslationEngines.md) | Retrieves all the translation engines in an account. |  |

## Termbase Template

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/termbase-templates` | [ListTermbaseTemplates](./ListTermbaseTemplates.md) | List termbase templates. |  |
| POST | `/termbase-templates` | [CreateTermbaseTemplate](./CreateTermbaseTemplate.md) | Creates a new termbase template. |  |
| GET | `/termbase-templates/{termbaseTemplateId}` | [GetTermbaseTemplate](./GetTermbaseTemplate.md) | Get a termbase template by identifier. |  |
| DELETE | `/termbase-templates/{termbaseTemplateId}` | [DeleteTermbaseTemplate](./DeleteTermbaseTemplate.md) | Deletes a termbase template by identifier. |  |
| PUT | `/termbase-templates/{termbaseTemplateId}` | [UpdateTermbaseTemplate](./UpdateTermbaseTemplate.md) | Updates the termbase template. |  |
| POST | `/termbase-templates/convert-xdt` | [ConvertTermbaseTemplate](./ConvertTermbaseTemplate.md) | Converts a termbase definition (XDT file) to a termbase structure that will be returned in the response.<br> The structure will not be stored in the Trados Cloud Platform. |  |

## Termbase

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/termbases` | [ListTermbase](./ListTermbase.md) | List termbases. |  |
| POST | `/termbases` | [CreateTermbase](./CreateTermbase.md) | Creates a new termbase. The termbase can be created with a termbase template by providing the templateId or by providing a custom termbaseStructure.  If only a `termbaseTemplateId` was provided, the termbase will be created using data from the template.  If only a `termbaseStructure` was provided, the termbase will be created using data from the structure.  If both, `termbaseTemplateId` and `termbaseStructure` are added in the request, the `termbaseStructure` takes precedence. |  |
| GET | `/termbases/{termbaseId}` | [GetTermbase](./GetTermbase.md) | Retrieves a termbase by identifier. |  |
| DELETE | `/termbases/{termbaseId}` | [DeleteTermbase](./DeleteTermbase.md) | Deletes a termbase by identifier. |  |
| PUT | `/termbases/{termbaseId}` | [UpdateTermbase](./UpdateTermbase.md) | Updates the termbase. The termbase can be updated with a termbase template by providing the termbaseTemplateId or by providing a custom termbaseStructure.   If only a `termbaseTemplateId ` was provided, the termbase will be updated using data from the template.  If only a `termbaseStructure` was provided, the termbase will be updated using data from the structure.  If both, `termbaseTemplateId` and `termbaseStructure` are added in the request, the `termbaseStructure` takes precedence. |  |
| POST | `/termbases/{termbaseId}/entries` | [CreateTermbaseEntry](./CreateTermbaseEntry.md) | Creates a new termbase entry. For more information about how to use `fieldValueLinks` see [`Create termbase entry`](../docs/termbase/Termbase-entries.html#creating-a-termbase-entry). |  |
| GET | `/termbases/{termbaseId}/entries` | [ListTermbaseEntries](./ListTermbaseEntries.md) | Retrieves a list of all the entries in a termbase. |  |
| DELETE | `/termbases/{termbaseId}/entries` | [DeleteTermbaseEntries](./DeleteTermbaseEntries.md) | Deletes all the entries in the termbase. |  |
| GET | `/termbases/{termbaseId}/entries/{entryId}` | [GetTermbaseEntry](./GetTermbaseEntry.md) | Retrieves a termbase entry by identifier. |  |
| PUT | `/termbases/{termbaseId}/entries/{entryId}` | [UpdateTermbaseEntry](./UpdateTermbaseEntry.md) | Updates a termbase entry by identifier. The request body will overwrite the existing data. |  |
| DELETE | `/termbases/{termbaseId}/entries/{entryId}` | [DeleteTermbaseEntry](./DeleteTermbaseEntry.md) | Deletes a termbase entry. |  |
| GET | `/termbases/{termbaseId}/terms/{sourceLanguageCode}` | [ListTermbaseTerms](./ListTermbaseTerms.md) | Retrieves a list of all the terms of the termbase. Search types: - normal: Use normal search to look for terms that match the text exactly as entered. - linguistic: Use linguistic search to look for terms that are similar to the search term. Linguistic search is based on stemming and other language-dependent aspects. - fuzzy: Use fuzzy search to look for terms that are similar to the search term. Fuzzy search is more fault-tolerant than linguistic search. |  |

## Termbase Export

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| POST | `/termbases/{termbaseId}/exports` | [ExportTermbase](./ExportTermbase.md) | Generates an asynchronous export operation.<br> Use the [Poll Export Termbase](#/operations/PollExportTermbase) endpoint to poll until the export status is `done`. |  |
| GET | `/termbases/{termbaseId}/exports/{exportId}` | [PollExportTermbase](./PollExportTermbase.md) | Polls a termbase via an export operation. The exported termbase can be downloaded once the status is `done`. |  |
| GET | `/termbases/{termbaseId}/exports/{exportId}/download` | [DownloadExportedTermbase](./DownloadExportedTermbase.md) | Downloads the exported termbase when the poll operation status is `done`. |  |
| GET | `/termbases/{termbaseId}/export-template` | [DownloadTermbaseDefinition](./DownloadTermbaseDefinition.md) | Downloads the termbase definition. |  |

## Termbase Import

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/termbases/{termbaseId}/imports` | [GetImportHistory](./GetImportHistory.md) | Gets the import history for a termbase. |  |
| POST | `/termbases/{termbaseId}/imports` | [ImportTermbase](./ImportTermbase.md) | Generates an asynchronous import operation.<br> Use the Poll Import Termbase endpoint to poll until the import status is `done`.<br> |  |
| GET | `/termbases/{termbaseId}/imports/{importId}` | [PollTermbaseImport](./PollTermbaseImport.md) | Polls a termbase import operation. |  |
| GET | `/termbases/{termbaseId}/imports/{importId}/logs` | [DownloadTermbaseImportLog](./DownloadTermbaseImportLog.md) | Downloads the termbase import logs. |  |

## TQA Profile

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/tqa-profiles` | [ListTqaProfiles](./ListTqaProfiles.md) | List TQA Profiles. |  |
| GET | `/tqa-profiles/{profileId}` | [GetTqaProfile](./GetTqaProfile.md) | Get a TQA Profile By identifier. |  |

## Translation Memory

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/translation-memory/{translationMemoryId}` | [GetTranslationMemory](./GetTranslationMemory.md) | Get a single Translation Memory by identifier. |  |
| PUT | `/translation-memory/{translationMemoryId}` | [UpdateTranslationMemory](./UpdateTranslationMemory.md) | Updates a Translation Memory. We recommend reading this page too [Updating data with PUT](../docs/Updating-data-with-PUT.html). |  |
| DELETE | `/translation-memory/{translationMemoryId}` | [DeleteTranslationMemory](./DeleteTranslationMemory.md) | Deletes a Translation Memory. |  |
| POST | `/translation-memory/{translationMemoryId}/copy` | [CopyTranslationMemory](./CopyTranslationMemory.md) | Creates a copy of a Translation Memory. The name will be suffixed with ' (Copy) ' |  |
| GET | `/translation-memory` | [ListTranslationMemories](./ListTranslationMemories.md) | Retrieves all the Translation Memories. |  |
| POST | `/translation-memory` | [CreateTranslationMemory](./CreateTranslationMemory.md) | Create a new Translation Memory. |  |
| GET | `/translation-memory/field-templates` | [ListFieldTemplates](./ListFieldTemplates.md) | Retrieves all the Field Templates. |  |
| GET | `/translation-memory/field-templates/{fieldTemplateId}` | [GetFieldTemplate](./GetFieldTemplate.md) | Get a single Field Template by identifier. |  |

## Translation Memory Import

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/translation-memory/{translationMemoryId}/imports` | [GetTMImportHistory](./GetTMImportHistory.md) | Gets the import history for a translation memory. It returns the history of last 7 days. |  |
| POST | `/translation-memory/{translationMemoryId}/imports` | [ImportTranslationMemory](./ImportTranslationMemory.md) | Generates an asynchronous import operation.  <br> <br> Read more about prerequisites and limitations on the [official documentation center](https://docs.rws.com/791595/741139/trados-enterprise/importing-tm-content). <br> Note: The order of the multipart form parameter must be implemented as such: properties first, file second. <br> Use the Poll Translation Memory Import endpoint to poll until the import status is `done`.<br> To track the progress of the import please refer to [Poll Translation Memory Import](#/operations/PollTMImport). |  |
| GET | `/translation-memory/imports/{importId}` | [PollTMImport](./PollTMImport.md) | Polls a Translation Memory import operation. The import is finished when the status is `done`. |  |

## Translation Memory Export

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| POST | `/translation-memory/{translationMemoryId}/exports` | [ExportTranslationMemory](./ExportTranslationMemory.md) | Generates an asynchronous export operation. Use the [Poll Translation Memory Export](#/operations/PollTranslationMemoryExport) endpoint to poll until the export status is `done`. |  |
| GET | `/translation-memory/exports/{exportId}` | [PollTranslationMemoryExport](./PollTranslationMemoryExport.md) | Polls a translation memory via an export operation. The exported translation memory can be downloaded once the status is `done`. |  |
| GET | `/translation-memory/exports/{exportId}/download` | [DownloadExportedTranslationMemory](./DownloadExportedTranslationMemory.md) | Downloads the exported translation memory in the `tmx.gz` format when the poll operation status is `done`. |  |

## Translation

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| POST | `/translations/lookup` | [TranslationsLookup](./TranslationsLookup.md) | Translates a phrase in plain text or a BCM fragment containing a single segment. The translated content will be returned as a BCM [fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html) or [term](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Skeleton.Term.html).    For detailed concepts and examples see the [Translation API](../docs/translations/Translations.html) page. |  |
| POST | `/translations/concordance` | [TranslationsConcordanceSearch](./TranslationsConcordanceSearch.md) | Performs a concordance search for a given text within the TM linked to the specified translation engine. The translated content will be returned as a BCM [fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html) or [term](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Skeleton.Term.html).    For detailed concepts and examples see the [Translation API](../docs/translations/Translations.html) page. |  |
| PUT | `/translations/translation-unit` | [TranslationsUpdate](./TranslationsUpdate.md) | Updates a translation unit. The system identifies matching translation units in the TM based on the provided BCM [fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html).    For detailed concepts and examples see the [Translation API](../docs/translations/Translations.html) page. |  |
| POST | `/translations/translation-unit` | [TranslationsAdd](./TranslationsAdd.md) | Adds a translation unit. The system identifies matching translation units in the TM based on the provided BCM [fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html).    For detailed concepts and examples see the [Translation API](../docs/translations/Translations.html) page. |  |

## User

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/users/me` | [GetMyUser](./GetMyUser.md) | Retrieves the authenticated user. |  |
| GET | `/users` | [ListUsers](./ListUsers.md) | Retrieves a list of all the users in an account. |  |
| POST | `/users` | [CreateUser](./CreateUser.md) | Creates a new user in an account. |  |
| GET | `/users/{userId}` | [GetUser](./GetUser.md) | Retrieves a user by identifier. |  |
| PUT | `/users/{userId}` | [UpdateUser](./UpdateUser.md) | Updates a user within the account.    Please follow the update rules detailed on the [Updating data with PUT](../docs/Updating-data-with-PUT.html) page.    When performing an update, fields that are related to a different type of user will be ignored. |  |
| DELETE | `/users/{userId}` | [DeleteUser](./DeleteUser.md) | Deletes a user. |  |

## Public Keys

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/.well-known/jwks.json` | [ListPublicKeys](./ListPublicKeys.md) | List all available Public Keys. |  |
| GET | `/.well-known/jwks.json/{kid}` | [GetPublicKey](./GetPublicKey.md) | Retrieves a public key by it's identifier. |  |

## Workflow

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/workflows/{workflowId}` | [GetWorkflow](./GetWorkflow.md) | Retrieves a workflow by identifier. |  |
| PUT | `/workflows/{workflowId}` | [UpdateWorkflow](./UpdateWorkflow.md) | Updates the workflow in terms of: name, description, task configuration (and its details), and task type configuration values (`configurationValues`). Observe the rules of [JSON Merge Patch Semantics](https://tools.ietf.org/html/rfc7386). |  |
| GET | `/workflows` | [ListWorkflows](./ListWorkflows.md) | Retrieves all the workflows in an account. |  |

## Translation Domain

| Method | Path | OperationId | Description | Notes |
|--------|------|-------------|-------------|-------|
| GET | `/translation-domain/service-types` | [ListTranslationServiceTypes](./ListTranslationServiceTypes.md) | List all available service types. |  |

