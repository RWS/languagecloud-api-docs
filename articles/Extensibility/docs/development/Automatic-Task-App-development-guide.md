---
tags: [Development]
stoplight-id: 2dlyn1ep2e2p5
---


# Automatic Task

Automatic Task extensions offer the possibility to add custom functionality within a project's workflow.

Examples of automatic tasks:
- send notifications about the project
- update project details
- copy the project files to a shared location

Most of the Automatic Task extensions will need to perform certain requests to [Trados Cloud Platform API](https://languagecloud.sdl.com/lc/api-docs/72b66de24898e-rws-language-cloud-api) in order to achieve the desired result. The Trados Cloud Platform API SDKs (for [Java](https://languagecloud.sdl.com/lc/api-docs/java-client) and [.NET](https://languagecloud.sdl.com/lc/api-docs/net-client)) are publicly available.

In order to build a new Automatic Task extension we recommend to start by using the provided [app blueprints](https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints).

## Automatic Task Extension

For an app to offer Automatic Task functionality, it must define at least one Automatic Task extension within its [descriptor](../../App-API.v1.json/paths/~1descriptor/get).
For example: 

```json
{
  ...
  "extensions": [
    {
      "extensionPointId": "lc.automatictask",
      "id": "SAMPLE_AUTOMATICTASK_EXTENSION_ID",
      "name": "SAMPLE_AUTOMATICTASK_EXTENSION_NAME",
      "description": "SAMPLE_AUTOMATICTASK_EXTENSION_DESCRIPTION",
      "extensionPointVersion": "1",
      "configuration": {
        "endpoints": {
          "lc.automatictask.submit": "/v1/submit"
        },
        "supportedInputFileType": "nativeSource",
        "outputFileType": "nativeSource",
        "scope": "file",
        "outcomes": [
          {
            "default": true,
            "description": "Done.",
            "outcome": "done"
          }
        ],
        "workflowTemplateConfigurations": [
          {
            "name": "SAMPLE_AUTOMATICTASK_EXTENSION_CONFIG_NAME",
            "id": "SAMPLE_AUTOMATICTASK_EXTENSION_CONFIG_ID",
            "description": "SAMPLE_AUTOMATICTASK_EXTENSION_CONFIG_DESCRIPTION",
            "optional": false,
            "defaultValue": "SAMPLE_DEFAULT_VALUE",
            "dataType": "string"
          }
        ]
      }
    }
  ]
  ...
}
```

- `extensionPointId` - the identifier of the extension point corresponding to this extensionType: **lc.automatictask**
- `id` - unique extension identifier provided by the app developer
- `name` - provide a friendly and unique name. It might be shown to the end user, and it may be useful in helping the user distinguish between multiple extensions
- `description` - the description of the automatic task extension 
- `extensionPointVersion` - the version of the extension point that is implemented in the Extension
- `configuration` - the task configuration

  - `endpoints`
    - `lc.automatictask.submit` - the path of the endpoint that accepts a task for execution

  - `supportedInputFileType` - the input file type supported by the task. All tasks can have input files, regardless of their scope.

      Acceptable values:

      - `nativeSource`: processes source files in their native upload form (for example: FileTypeDetection, Engineering, FileFormatConversion)

      - `bcmSource`: processes source files in their converted "bcm" form (for example: DocumentContentAnalysis, CopySourceToTarget)

      - `bcmTarget`: processes target files in their "bcm" form (for example: Translation, Linguistic Review, MachineTranslation, TranslationMemoryMatching, TranslationMemoryUpdate, TargetFileGeneration)

      - `nativeTarget`: processes target files in their native "generated" form (for example: DTP, FinalCheck)

      - `sdlxliffTarget`: processes target files in their "sdlxliff" form, specifically for Import tasks. It is not recommended for automated task types at this time (early 2022).

      - `none`: does not process the file content, neither to read nor to update it

  - `outputFileType` - describes what the output files are for the given task.

      Acceptable values:

      - idem with `supportedInputFileType`

      >The `supportedInputFileType` and `outputFileType` parameters affect the extension task order in the workflow template, as follows:
      >- an extension task can only follow another task with the same `outputFileType` as its `supportedInputFileType` (except for the extension tasks with `supportedInputFileType: nativeSource` which can be placed first in the workflow).
      >- a normal task can only follow an external task with the same `outputFileType` as its `supportedInputFileType`.

  - `scope` - describes the applicability of a task within a project

      Acceptable values:

      - `file`: the task will be applicable for every file in the project. It will process either the source or the target files, based on the relation with supportedInputFileType and outputFileType

      - `targetLanguage`: the task will be applicable for every target language of the project

      - `batch`: the task is applicable only once for a batch execution within a project

      - `task`: the task is applicable to other tasks. Specifically tailored for Error tasks. Not recommended for automated task types at this time (early 2022).

      - `vendorOrder`: the task is part of the vendor negotiation process. Not recommended for automated task types at this time (early 2022).

  - `outcomes` - the possible outcomes of this automatic task:

      - `outcome` - a custom outcome value

      - `description` - the outcome description

      - `default` - if `TRUE`, this outcome will be used when no specific outcome is provided. At least one outcome must be set as default.

  - `workflowTemplateConfigurations` - definitions of the configurations that the app needs at runtime in order to execute a task. The task will be configured when you create a workflow template, a workflow or a project. The configuration values will be passed to the app when a task is submitted for execution. For example, an extension that uploads a file to an FTP can have the location as a configuration.

    - `name` - short, user-friendly name for the configuration settings

    - `id` - an alphanumeric identifier, including underscores

    - `description` - a user-friendly description of the configuration settings, describing what the user should set in the textbox

    - `optional` - if the configuration setting is optional

    - `defaultValue` - the default value of the setting

    - `dataType` - specifies the data type for the value, to be used for input type generation

    - `options` - a list of setting options

You can define as many automatic extensions as you need. They could have the same extension point (submit endpoint) or different ones, depending on your app design.

### Extension Usage

You can integrate your extension task within a **Workflow Template** as shown below:

![AutomaticTask](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevAppTaskWFT.gif?raw=true)

The `workflowTemplateConfigurations` can be configured as follows:

![AutomaticTaskConfigs](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevAppTaskConfiguration.gif?raw=true) 

Based on the created **Workflow Template** you can create a new **Workflow**.

![AutomaticTaskWF](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevAppTaskWF.gif?raw=true)

The last step is to start a **Project** using the **Workflow** created in the previous step.

![CreateATProject](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevCreateATAppProject.gif?raw=true)

Find more details on how to use an Automatic Task app in the [consumer guide](../consumer/Automatic-Task-App-consumer-guide.md).

### Scopes

Depending on the actions performed by the app you may need to request access to the account's resources, otherwise the requests to the Trados Cloud Platform API will fail due to insufficient permissions.

To request access from the consumers, you need to specify one or more scopes within the app's descriptor, as shown below:

```json
{
  ...
  "scopes" : [
    "TENANT",
    "TENANT_READ",
    "ACCESS_SECURE_PROJECT_CONTENT"
  ]
  ...
}
```
The allowed values are:
- `TENANT` - Read/write/delete all tenant data (resources).
- `TENANT_READ` - Read-only access to all tenant data (resources).
- `ACCESS_SECURE_PROJECT_CONTENT` - Access to secure project content.

They will be presented to the consumers at installation time in order for them to decide if they want to proceed with the installation and allow access to the app.

### Submit Endpoint

The `lc.automatictask.submit` endpoint is used to receive and process the tasks from Trados. This endpoint should only schedule the task and return `200`. The scheduled task would be picked up by a background process that will send the result to the received callbackUrl.

  Example:

```json
POST /v1/submit
X-LC-Tenant: LC-TENANT_ID

{
  "projectId": "SAMPLE_PROJECT_ID",
  "correlationId": "SAMPLE_TASK_ID",
  "callbackUrl": "http://theCallback/callThisBack",
  "workflowConfiguration": [
    {
      "id": "SAMPLE_CONFIG_ID",
      "value": "SAMPLE_CONFIG_VALUE"
    }
  ]
}
```

-   The `correlationId` is the task identifier from Trados. You can also find it in the project details page under the _Task History_ tab.

-   The `callbackUrl` is a Trados endpoint where the app will send the outcome after the task is processed.

-   The `X-LC-Tenant` header has to be kept in order to perform the callback request. Find more details in the dedicated section below.

The blueprints contain placeholders from where you can start implementing the endpoint's functionality:
- [.NET blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/dotNetAppBlueprint/Rws.LC.AppBlueprint/Controllers/AutomaticTaskController.cs#L36)
- [Java blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppBlueprint/src/main/java/com/rws/lt/lc/blueprint/web/AutomaticTaskController.java#L16)

Please refer to the endpoint's [documentation](../../App-API.v1.json/paths/~1lc.automatictask.submit/post) for further details.

### Callback Endpoint

This is a Trados endpoint used to receive the task outcome from the Automatic Task apps. Each automatic task will have its own callback URL.

  Example:

```json
POST /external-job/v1/callback?token=CALLBACK_TOKEN
X-LC-Tenant: LC-TENANT_ID

{
  "success": true,
  "outcome": "Done",
  "errors": null
}
```

-   The request needs to include the `X-LC-Tenant` header.

-   The `token` should be already present in the received `callbackUrl` on the submit endpoint.

Please refer to the endpoint's [documentation](../../App-API.v1.json/paths/~1external-job~1v1~1callback/post) for further details.