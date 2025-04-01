# What's new

</br>

## 10 March 2025

- We've introduced the concept of [Batched Webhooks](../docs/webhooks/Batched-webhooks.md).
- We've updated the models for [Import Translation Memory](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1imports/post), [Export Translation Memory](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1exports/post) and [Get Translation Memory Import History](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1imports/get). 
  - As part of this, the existing `status` field is now marked as deprecated in the response model of [Import Translation Memory](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1imports/post) and [Export Translation Memory](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1exports/post).
  - Additionally, the fields `importAsPlainText` and `triggerRecomputeStatistics` are marked as deprecated in the request model of [Import Translation Memory](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1imports/post) and in the response model of [Get Translation Memory Import History](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1imports/get), alongside the `traceId` field. 
  - Their decommissioning is scheduled at a minimum of six months from now. 


## 10 December 2024
- You can now associate existing users with a service user to notify them of actions via email, using Trados UI. More details [here](../docs/Service-credentials.md#step-2-trados-cloud-platform-administrators-add-additional-notification-options-for-service-users).
- We have officially rebranded from RWS Language Cloud API to Trados Cloud Platform API. All references to our previous brand name will now reflect our new identity, Trados.
- Provided [Postman Environments](../docs/Language-Cloud-APIs-for-Postman.md) for multi-region.

## 18 November 2024
- As part of our multi-region support, we have added global endpoints to facilitate the discovery of available regions and hosts. For more details, see the [Multi-region](../docs/Multi-region.md)  page.
- We have updated the documentation on how to use the new SDK with multi-region features.
- Additionally, we made various minor contract corrections.
- As a reminder, we want to let our users know that the field `languageProcessingRuleId` under [Update Translation Engine](../reference/Public-API.v1.json/paths/~1translation-engines~1{translationEngineId}/put) endpoint will become mandatory.

## 6 November 2024
- We are planning to transition the hosting of our API from **lc-api.sdl.com** to **api.eu.cloud.trados.com** on November 9th:

  - **lc-api.sdl.com** for API and integrations will remain active.

  - Existing integrations will continue to work as before. We do recommend planning to change the URL when possible.

  - For new integrations, we recommend using the new URL to avoid additional work in the future.

- You now have the ability to add notes to customer quotes.

 - We have updated the deprecated types for the `language` and `targetLanguages` fields in the [Add Source File Request](../reference/Public-API.v1.json/components/schemas/source-file-request) model, which now reference [Language Request](../reference/Public-API.v1.json/components/schemas/language-request) model. In the updated API contract, these fields have been changed from simple strings to structured objects containing a `languageCode` property, enhancing clarity and consistency in language handling.
 
  > We will provide backwards compatibility until May 2025. However, starting with this release, SDKs will be updated to use the new types. Please ensure your integration is updated to use the new [Language Request](../reference/Public-API.v1.json/components/schemas/language-request) model.

- We fixed various bugs.
## 11 September 2024

- With this release we deliver the [PerfectMatch](https://docs.rws.com/791595/1155478/trados-enterprise---accelerate/perfectmatch-general-information) functionality. You can apply PerfectMatch either at the start of a project or midway through the translation process. These capabilities are accessible via the [PerfectMatch Mapping](../reference/Public-API.v1.json/paths/~1perfect-match-mappings/post) menu.
- We've improved filtering for projects lists. See the [List Projects](../reference/Public-API.v1.json/paths/~1projects/get) endpoint.
- A recent update has been made to the [Webhooks Setup](../docs/webhooks/Webhooks-setup.md)  page, informing the customers that the order of webhook event deliveries cannot be guaranteed. Please take this into consideration using the `timestamp` field to determine the event generation time.
- You can now set due dates for tasks during project creation.
- We fixed various bugs.


## 28 August 2024
- We have introduced a new option which allows users to switch to a different pricing model at the Customer Quote Review task using the dedicated endpoint [Update Project Pricing Model](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1pricing-model/put).
- You now have the ability to view the locking color options for MTQE segments by utilizing the [Get Project Template](../reference/Public-API.v1.json/paths/~1project-templates~1{projectTemplateId}/get) endpoint.
- The parameter `termbaseStructure.fields.type` in the [Get Termbase](../reference/Public-API.v1.json/paths/~1termbases~1{termbaseId}/get) endpoint is no longer marked as mandatory.
- We fixed various bugs.

## 1 July 2024
- We updated the folder/resource locations to the new format, which now includes the [path](../reference/Public-API.v1.json/components/schemas/folder).
- We fixed various bugs.

## 9 May 2024
 
- You can configure the number of days after which projects are given the Completed or Archived status automatically using the `completionConfiguration` option under the following endpoints: [Create](../reference/Public-API.v1.json/paths/~1projects/post) and [Update](../reference/Public-API.v1.json/paths/~1projects~1{projectId}/put) Project, [Create](../reference/Public-API.v1.json/paths/~1project-templates/post) and [Update](../reference/Public-API.v1.json/paths/~1project-templates~1{projectTemplateId}/put) Project Template.
- The field `languageProcessingRuleId` under [Update Translation Engine](../reference/Public-API.v1.json/paths/~1translation-engines~1{translationEngineId}/put) endpoint will become mandatory. The enforcement is scheduled at a minimum of six months from now.
- As a reminder, we want to let our users know that we updated the folder/resource locations to the new format, which now includes the [path](../reference/Public-API.v1.json/components/schemas/folder-v2). The old fields are marked as deprecated and their decommissioning is planned for near future. Please ensure you update the implementation if you are using fields that are marked as deprecated.
- We fixed various bugs.

## 8 April 2024

- We extended the information available on the webhooks setup page, [Circuit Breaker](../docs/webhooks/Webhooks-setup.md#circuit-breaker)  section.
- We removed the `languageId` allowed values for the [Export Quote Report](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1export/post) endpoint.
- As a reminder, we want to let our users know that we updated the folder/resource locations to the new format, which now includes the [path](../reference/Public-API.v1.json/components/schemas/folder-v2). The old fields are marked as deprecated and their decommissioning is planned for near future. Please ensure you update the implementation if you are using fields that are marked as deprecated.
- We fixed various bugs.

## 27 February 2024

- With this release we deliver the [Update](../reference/Public-API.v1.json/paths/~1project-templates~1{projectTemplateId}/put) and [Delete Project Template](../reference/Public-API.v1.json/paths/~1project-templates~1{projectTemplateId}/delete) endpoints. Subsequent iterations with new implementations will follow, ensuring continuous enhancement for project template update.
- We published a new page about [multipart considerations](../docs/How-to-multipart.md)
- We fixed various bugs.

## 13 December 2023

- With this release we deliver the [Create Project Template](../reference/Public-API.v1.json/paths/~1project-templates/post) endpoint. Subsequent iterations with new implementations will follow, ensuring continuous enhancement for project template creation.
- We enhanced the response model for the [Get Project Template](../reference/Public-API.v1.json/paths/~1project-templates~1{projectTemplateId}/get) endpoint, which now includes settings for verification and batch tasks. The existing `forceOnline` and `quoteTemplate` fields from root level are now marked as deprecated, as they have been moved to the `settings` section. Their decommissioning is scheduled at a minimum of six months from now.
- Webhooks will stop trying to send on urls that cause timeouts, retrying later. Read more [here](../docs/webhooks/Webhooks-setup.md#circuit-breaker).
- We fixed various bugs. 

## 16 November 2023
- We introduced the `applicableOutcomes` field under the [get task](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}/get) endpoint to be used when completing the tasks.
- You can now change the folder visibility when updating a customer.
- We fixed various bugs.

## 17 October 2023 
- This release delivers more integrations for the customer resource type. You can now [create](../reference/Public-API.v1.json/paths/~1customers/post), [update](../reference/Public-API.v1.json/paths/~1customers~1{customerId}/put) and [delete](../reference/Public-API.v1.json/paths//~1customers~1{customerId}/delete) customers.
- We enhanced the response model for [pricing](../reference/Public-API.v1.json/paths/~1pricing-models/get) endpoints.
- As previously announced, we made the `dueBy`, the `location` and the `languageDirections` fields mandatory for [creating a project](../reference/Public-API.v1.json/paths/~1projects/post).
- We added `deliveredBy` as a new field for the [update project](../reference/Public-API.v1.json/paths/~1projects~1{projectId}/put) capabilities.
- We extended the information available on the [webhooks setup](../docs/webhooks/Webhooks-setup.md) page.
- We fixed various bugs.

## 06 September 2023
- With this release we deliver the [create](../reference/Public-API.v1.json/paths/~1schedule-templates/post), [read](../reference/Public-API.v1.json/paths/~1schedule-templates~1{scheduleTemplateId}/get), [update](../reference/Public-API.v1.json/paths/~1schedule-templates~1{scheduleTemplateId}/put) and [delete](../reference/Public-API.v1.json/paths/~1schedule-templates~1{scheduleTemplateId}/delete) endpoints of the new schedule template resource. You will find the endpoints under the [schedule templates](../reference/Public-API.v1.json/paths/~1schedule-templates/get) menu. You can also retrieve the schedule template attached to a [project](../reference/Public-API.v1.json/paths/~1projects~1{projectId}/get) or to a [project template](../reference/Public-API.v1.json/paths/~1project-templates~1{projectTemplateId}/get) using the relevant fields.
- Additionally, the [create project](../reference/Public-API.v1.json/paths/~1projects/post) now supports the schedule template resource, either individually or from the project template.
- We added the `apiInternalId`  to [task type](../reference/Public-API.v1.json/components/schemas/task-type) and [workflow task template](../reference/Public-API.v1.json/components/schemas/workflow-task-template) to easily identify custom tasks.
- We fixed various bugs.

## 17 August 2023
- We updated the folder/resource locations to the new format, which now includes the [path](../reference/Public-API.v1.json/components/schemas/folder-v2). The old fields are marked as deprecated and their decommissioning is scheduled at a minimum of six months from now. Please ensure you update the implementation if you are using fields that are marked as deprecated.
- Enhanced [project configuration](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1configuration/put) now includes new choices for updating translation memory settings.
- We fixed various bugs.
- As a reminder, we want to let our users know that validations related to the following fields used at project creation: `dueBy`, `location` and `languageDirections` will become **required** in near future.

## 02 August 2023
- With this release we provide a new endpoint to allow integrators to update only one [custom field](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1custom-fields~1{customFieldKey}/put) of a project
- We extended the information available on the [webhooks](../docs/webhooks/Webhooks-payload.md) page
- You can now update a translation engine as a stand alone resource or one that is linked to a live project.  Read this [page](../reference/Public-API.v1.json/paths/~1translation-engines~1{translationEngineId}/put) for more details.
- We fixed various bugs. 

## 15 June 2023
- We extended the information provided for both [source](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files~1{sourceFileId}~1versions/get) and [target](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions/get) files in a task with the `name`, the `version` and `originatingTaskId` details
- We made available a new [rate-limits](../reference/Public-API.v1.json/paths/~1rate-limits/get) endpoint and a new header which includes the relevant policy name, namely, the `X-RateLimit-Policy` header. Read the [API-rate-limits](../docs/API-rate-limits.md) page for more details.
- We improved descriptions for the `default` and `required` fields [here](../docs/Use-fields-in-your-requests.md).
- We updated the JAVA samples to reflect changes in the SDK.
- We fixed various bugs.


## 19 May 2023
- We replaced the `friendlyId` on all Project Group endpoints with `shortId` and we've exposed it on all Project endpoints too. 
- As a security enhancement, we will restrict some characters in naming projects and project files. The unsupported characters are: `<`, `>`, `:`, `"`, `/`, `\`, `|`, `?`, `*`. 
- In 6 months we will introduce the following breaking change: on the [Export Quote Report](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1export/post) endpoint, if the quote is not generated using a Quote Template, the response will be an empty object. 
- We will enforce validations related to the following fields at project creation: `dueBy`, `location` and `languageDirections`. These fields will become **required** in 3 months.
- As a reminder, we want to let our users know that for security issues or bugs we may introduce breaking changes at any time.



## 20 April 2023
- With this release we enforce validations listed in the documentation for the Create and Update Project endpoints. This impacts the SDKs, so please update your integration accordingly.
- We extended the [webhooks](../docs/Webhooks.md) functionality to support error tasks
- We introduced the `customFields` field for project webhooks, and the `dueBy` field for task webhooks
- We added the `name` of the `customFields` under the response for the Get Project endpoint
- We fixed various bugs.

## 21 March 2023
- We extended the list of [webhooks](../docs/Webhooks.md) available for tasks, projects, project files, project templates and enabled the first webhook for project group
- We fixed several bugs.

## 03 March 2023
- We introduced fields displaying the project status history and the `completedAt` date for a task.
- We exposed the project creator as a sorting option on list projects.
- We fixed several bugs
- We want to remind our users we will enforce validations listed in the documentation for the Create and Update Project endpoints.

## 15 February 2023
- We enabled support for the Trados Enterprise Quote Template functionality
- We introduced the `projectManagers` field to enable the selection of individuals or of users groups at [project creation](../reference/Public-API.v1.json/paths/~1projects/post).
- We removed unnecessary outcome values for the [Task Completed Request](../reference/Public-API.v1.json/components/schemas/task-complete-request) model on the [Complete Task](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1complete/put) operation. This impacts the SDKs, so update your integration accordingly.
- You can now specify the `projectCreator` as an assignee type for a task when [updating a project](../reference/Public-API.v1.json/paths/~1projects~1{projectId}/put).
- We will enforce validations related to the following fields at project creation: `dueBy`, `location` and `languageDirections`. These fields will become **required** in 6 months.


## 11 January 2023

- You can now [create](../reference/Public-API.v1.json/paths/~1project-groups/post), [read](../reference/Public-API.v1.json/paths/~1project-groups~1{projectGroupId}/get), [update](../reference/Public-API.v1.json/paths/~1project-groups~1{projectGroupId}/put) and [delete](../reference/Public-API.v1.json/paths/~1project-groups~1{projectGroupId}/delete) Project Groups
- We've improved filtering for projects lists, namely by status and by creation date
- We've introduced fields displaying more details for error tasks
- We fixed various bugs


## 22 November 2022
- To enable support for the Trados Enterprise multi-source resources functionality, we're introducing an important breaking change: when creating workflows with multi-source languages from the TE UI, please use the new `languageDirection` scope value. As the new feature may limit previously working functionality, inconsistencies within applications or certain products may appear. For integrations that are impacted, please contact their developers to update the integrations.
- We've made 3 new endpoints available for [TM export](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1exports/post)
- We removed the old 10 MB size limitations for files, termbases and translation memories. We now support [these values](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit) for files and [these values](https://docs.rws.com/791595/741139/trados-enterprise---accelerate/importing-tm-content) for importing translation memory content. 
- Users can now retrieve task comments.
- We've added the [TM Import history](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1imports/get) endpoint. 
- We are postponing the breaking change in the `LanguageDirectionRequest` model, previously announced for November, and consequently the model can be used until the end of 2022.
- 4 new endpoints are subject to [API limits](https://languagecloud.sdl.com/lc/api-docs/d2266fabaa1bf-api-rate-limits#project-files-rate-limits)
- We fixed various bugs.     

## 28 October 2022
- You can [import translation memories](../docs/translation-memory/Translation-memory-import-export.md) using the [import](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1imports/post) and [poll](../reference/Public-API.v1.json/paths/~1translation-memory~1imports~1{importId}/get) endpoints. Note that the maximum size for an imported translation memory is 10 MB.  
- We added traceability fields for terminology entries:  createdAt, createdBy, lastModifiedAt, lastModifiedBy
- We added recommendations for [HTTP headers](../docs/Headers-considerations.md) 
- We updated the recommendations for [Authentication](../docs/Authentication.md)  and the [API rate limits](../docs/API-rate-limits.md) with token values and other details 
- We fixed various bugs

## 15 September 2022
- We introduced a new [Export Quote Report](../docs/Export-quote-report.md) mechanism and deprecated the older endpoint
- We updated the constrains for the 'name' and 'description' fields for the [Create Project](../reference/Public-API.v1.json/paths/~1projects/post) and [Update Project](../reference/Public-API.v1.json/paths/~1projects~1{projectId}/put) endpoints that will be enforced starting December 2022
- We introduced a new page for the currently [Known issues](../docs/Known-Issues.md)
- We fixed various bugs


## 22 August 2022
- You can now read [language processing rules](../reference/Public-API.v1.json/paths/~1language-processing-rules/get) and [translation memory field templates](../reference/Public-API.v1.json/paths/~1translation-memory~1field-templates/get)
- You can now [create](../reference/Public-API.v1.json/paths/~1translation-memory/post), [read](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}/get), [update](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}/put), [delete](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}/delete) and [copy](../reference/Public-API.v1.json/paths/~1translation-memory~1{translationMemoryId}~1copy/post) translation memories

## 12 August 2022
- Retiring of the Export Quote endpoint will happen in 6 months. You can read more about it [here](../docs/Public-API-Management-Process.md#endpoint-retirement-process). 
- We now support the Export Quote Report functionality with 3 new endpoints: [Poll Quote Export Report](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1export/get), [Export Quote](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1export/post) and [Download Exported Quote](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1quote-report~1download/get).
- You can now upload [source](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1source-files~1{sourceFileId}~1versions/post) and [target](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1target-files~1{targetFileId}~1versions/post) file versions
- We published a new page about [File formats](../docs/File-formats.md)
- We fixed various bugs

## 28 July 2022
- We published a new page about [How to use location and folders](../docs/How-to-use-location-and-folders.md) 
- We published a new page about [How to report an API issue](../docs/How-to-report-an-issue.md) 
- We fixed various bugs

## 19 July 2022

- You can now update [source](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files~1{sourceFileId}/put) and [target](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}/put) file names
- We fixed various bugs

## 28 June 2022

- You can now [read](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1configuration/get) and [update](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1configuration/put) translation memory settings for a project's configuration
- We updated the user guide page for [using fields](../docs/Use-fields-in-your-requests.md) with new animated gifs
- We fixed various bugs


## 07 June 2022
- We have increased the API limits, you can find the new limits on [this page](../docs/API-rate-limits.md).
- Deprecation of the language direction code will happen in 6 months. You can read more about it [here](../docs/Whats-deprecated.md).
- Enforce validations related to the length of the *name* and *description* fields and the accepted input values for the Create and Update Project endpoints will be delivered in 6 months.

## 24 May 2022
- To address potentially infected files, we've updated our API contracts to support In-Product Antivirus scanning

## 04 May 2022
- You can now upload a .zip archive using [this](../reference/Public-API.v1.json/paths/~1files/post) endpoint and then [poll](../reference/Public-API.v1.json/paths/~1files~1{fileId}/get) for the extracted files. After extraction, you can upload multiple source files to a project using a [single call](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files~1attach-files/post). The maximum size for an imported .zip file is 10 MB.
- Our Java SDK client is now available in **public beta**. [Here](../docs/api-clients/java/Java-Client.md) are more details on how to start integrating it into your solution
- We published the API limits [here](../docs/API-rate-limits.md) 
- We updated the Custom fields [page](../docs/Custom-Fields.md) with useful gifs
- We fixed various bugs

**We update the .NET and Java client versions with each API release.**

## 11 March 2022
- You can now export a termbase and a termbase template in Trados Enterprise using the Trados Cloud Platform API
- We fixed various bugs

## 22 February 2022
- You can now convert an xdt file into a termbase structure using [this](../reference/Public-API.v1.json/paths/~1termbase-templates~1convert-xdt/post) dedicated endpoint
- When updating a termbase entry you will have to provide either the name or the identifier for the `termbaseFieldValues`
- We fixed various bugs 
    
## 2 February 2022
- You can now import a termbase in Trados Enterprise using the Trados Cloud Platform API. The supported extensions are `xml` and `tbx`. The maximum size for an imported termbase is 10 MB.
- Our .NET SDK client is now available in **public beta**. [Here](../docs/api-clients/net/NET-Client.md) are more details on how to start integrating it into your solution.
- We updated the [basic project creation](../docs/Basic-project-creation-flow.md) page with useful gifs and added a small Postman collection to help you get started quickly
- We fixed various bugs


## 15 December 2021
- You can now create, read, update and delete terminology termbases, termbase templates and termbase entries
- We fixed various bugs

## 18 November 2021
- You can now update the configurations of future tasks using the `projectPlan` field, in the [`update project`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}/put) endpoint
- Fixed various bugs

## 20 October 2021
- Basic project creation flow added
- Fixed various bugs

## 04 October 2021
- Added multiple date formats
- Added pagination for [`List File Processing Configurations`](../reference/Public-API.v1.json/paths/~1file-processing-configurations/get) endpoint
- Fixed various bugs

## 08 September 2021
- Added support for downloading quote files
- Enum values updated to follow camelCase convention
- Updated documentation for projectTemplate in create project request
- Renamed customProperty to customFields in error responses
- Improved documentation for [Reclaim Task](../docs/Interact-with-tasks.md)
- Updated documentation for [Quotes](../docs/Export-quote-report.md)

## 26 August 2021
- Added support to restrict file downloads
- When creating/updating projects using a project template which has mandatory custom fields, you must supply those custom fields
- Fixed various bugs

**We will remove deprecated fields from the [`ErrorResponse`](../reference/Public-API.v1.json/components/schemas/error-response) model in an upcoming release. Please ensure you are not using fields marked as deprecated!**

## 29 July 2021
- Added endpoints for custom field definitions.
- Added support for custom fields on projects and project templates.
- The `translationEngine`, `fileProcessingConfiguration`, `workflow` fields are now required on the [`/projects`](../reference/Public-API.v1.json/paths/~1projects/post) endpoint.
- The `isSkipped` field is now marked as required on the [`/workflow/updateworkflow`](../reference/Public-API.v1.json/paths/~1workflows~1{workflowId}/put) endpoint.
- Added new assignee type `projectCreator` when retrieving workflows.
- Improved contract documentation on TQA endpoints.
- Fixed various bugs.

## 08 June 2021
* For endpoints that return multiple items, the `top` query parameter has a default value of `100` and a maximum value of `100`; `skip` has a default value of `0`.
* The `Authorization` and `X-LC-Tenant` headers are now required for all endpoints.
* Improved the returned error structure.
* Fixed various issues with incorrect contract.
* Added new conditional cost fields (`costOrder`,  `conditionalCostType`, `conditionalCostOperator`, `conditionalCostVariable`, `conditionalCostThreshold`) when working with project quotes.
* Added currency types for quote model.

## 17 May 2021
A Postman Collection is now available for integrators. Check out [this](../docs/Language-Cloud-APIs-for-Postman.md) page for details.

## 10 February 2021

* **Target File** > **Download File Version** endpoint

When you make a `GET` request to the [`/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1download/get) endpoint, you can now perform a direct download of the native file as well as of the `BCM` file version.

* **Target File** > **Export Target File Version** endpoint

When you make a `POST` request to the [`/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/exports`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1exports/post) endpoint, you now have a query parameter where you can specify whether the file version export should be a native file or an `sdlxliff` file. The default value is `native`.

## 28 January 2021

* **Project** > **List Project’s Tasks** endpoint

When you make a `GET` request to the [`/projects/{projectId}/tasks`](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1tasks/get) endpoint, you can now retrieve the available project tasks and their details.


* **Retrieving tasks**

Retrieving tasks provides the following new additional details:

- the Vendor Order Quote information
- the translation status for each task: the type of matches, the number of segments, the number of words/characters.

* **Specifying target languages for source files**

When adding source files to a project, you can specify their target languages via the `targetLanguages` and `path` elements.




<span style='color: #f5f5f5; font-size:10px;'>₍^. .^₎⟆</span>