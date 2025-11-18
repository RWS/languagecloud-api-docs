# Create projects
To create a project, you need to specify the following resources:
- A translation engine: determines which translation memories, MT engines and termbases should be used in the project
- A file processing configuration: determines which translatable file types this project should support, and the specific configuration of those file types
- A pricing model: the set of rules based on which the project quote is calculated
- A workflow: the sequence of steps the project goes through from inception to completion and the assignees for each step

Instead of specifying every resource separately, you can also specify a project template, which brings together all the elements needed during project creation: a translation engine, a file processing configuration, a pricing model, and a workflow.

You must define your project resources before you start creating your project. This API version does not allow any `POST` requests to create project resources. Your project resources must be created from the Trados UI beforehand.

## Create projects from scratch
You can create projects from scratch, which means that you must add all the project resources (all their identifiers) above to your project, one by one.

You cannot specify custom fields and project settings directly via the Trados Cloud Platform API. These can only be configured within a project template from the Trados UI. Therefore, if you want to include custom fields and project settings in your project, you must create projects from a project template which is already configured in the Trados UI.

### 1. Decide which project resources you want to use.

Make a `GET` request to the following resource endpoints and identify the identifiers of the resources you want to include in your project:
- [`/translation-engine`](../api/Public-API.v1-fv.html#/operations/ListTranslationEngines) *required*
- [`/file-processing-configuration`](../api/Public-API.v1-fv.html#/operations/ListFileProcessingConfigurations) *required*
- [`/workflow`](../api/Public-API.v1-fv.html#/operations/ListWorkflows) *required*
- [`/pricing-model`](../api/Public-API.v1-fv.html#/operations/ListPricingModels) *optional*
- [`/custom-field-definitions`](../api/Public-API.v1-fv.html#/operations/ListCustomFields) *optional*


### 2. Decide which language pairs (source - target) you want to use.

Make a `GET` request to the [`/languages`](../api/Public-API.v1-fv.html#/operations/ListLanguages) endpoint and identify the `languageCode` parameter values.

### 3. Decide where you want to save your project.

When you create your project, you must save it in a location (or customer folder). You will need the `locationId` of that customer folder. To retrieve the `locationId` of a given customer folder, make a `GET` request to the [`/customers/{customerId}`](../api/Public-API.v1-fv.html#/operations/GetCustomer) endpoint and check the `locationId` value in the response. If you do not specify a location, the project will be created in the Root folder.

### 4. Create your project.

Make a `POST` request to the [`/projects`](../api/Public-API.v1-fv.html#/operations/CreateProject) endpoint. You must provide identifiers for all the **required** resources: translation engine, file processing configuration and workflow.

Each resource object has a `strategy` parameter you must specify in the request body. The strategy parameter has 2 available values: `copy` and `use`. Trados recommends that you choose the `copy` value, which means that you include a copy (clone) of your resource in the project. If you choose the `use` value, then the actual resource is included in your project.

> [!NOTE]
> Issues may arise when `strategy=use` because you have no control over how the resource is updated from the other places where it is being used.

Make sure that you remember the value of the project `id` parameter in the response. You will need it for tracking your project, interacting with tasks, and completing projects.

### 5. Add your project files.

Make a `POST` request to the [`/projects/{projectId}/source-files`](../api/Public-API.v1-fv.html#/operations/AddSourceFile) endpoint. You can add both translatable files and reference files (by specifying the `role` property), and various file formats (by specifying the `type` property - native/bcm/sdxliff). You must provide the language of your source file, and, optionally, the values of the `targetLanguages` and `path` elements. 

### 5.1 Perfect Match (optional)
At this point you can make use of the [PerfectMatch](../api/Public-API.v1-fv.html#/operations/CreatePerfectMatchMapping) feature. You can read more about it [here](https://docs.rws.com/791595/1155478/trados-enterprise---accelerate/perfectmatch-general-information).

### 6. Start your project.

Make a `PUT` request to the [`/projects/{projectId}/start`](../api/Public-API.v1-fv.html#/operations/StartProject) endpoint.


## Create projects based on a template
You can create projects based on a project template already configured from the Trados UI, which means that you must only add a project template (its identifier) to your project. All the resources in your project template are automatically included in your project.

### 1. Decide which project template you want to use.

Make a `GET` request to the [`/project-templates`](../api/Public-API.v1-fv.html#/operations/ListProjectTemplates) endpoint. Remember the project template `id` parameter in the response.

### 2. Decide which language pairs (source - target) you want to use.

A project template may include more languages than you need. If this is the case, you can keep only the languages of interest. Make a `GET` request to the [`/languages`](../api/Public-API.v1-fv.html#/operations/ListLanguages) endpoint and identify the `languageCode` parameter values.

### 3. Decide where you want to save your project.

A project template is saved in a location or a customer folder. Most of the times, when you create your project, you want to save it in the same location (customer folder) as the project template it is based on. You will need the `locationId` of that customer folder. To retrieve the `locationId` of a given customer folder, make a `GET` request to the [`/customers/{customerId}`](../api/Public-API.v1-fv.html#/operations/GetCustomer) endpoint and check the `locationId` value in the response.

### 4. Create your project.

Make a `POST` request to the [`/projects`](../api/Public-API.v1-fv.html#/operations/CreateProject) endpoint. Provide the project template `id` and the location `id`. 

Make sure that you remember the value of the project `id` parameter in the response. You will need it for tracking your project, interacting with tasks, and completing projects.

### 5. Add your project files

Make a `POST` request to the [`/projects/{projectId}/source-files`](../api/Public-API.v1-fv.html#/operations/AddSourceFile) endpoint. You can add both translatable files and reference files (by specifying the `role` property), and various file formats (by specifying the `type` property - native/bcm/sdxliff). You must provide the language of your source file, and, optionally, the values of the `targetLanguages` and `path` elements.

### 5.1 Perfect Match (optional)
At this point you can make use of the [PerfectMatch](../api/Public-API.v1-fv.html#/operations/CreatePerfectMatchMapping) feature. You can read more about it [here](https://docs.rws.com/791595/1155478/trados-enterprise---accelerate/perfectmatch-general-information).

### 6. Start your project.

Make a `PUT` request to the [`/projects/{projectId}/start`](../api/Public-API.v1-fv.html#/operations/StartProject) endpoint.

## Restrict file downloads for a project
To restrict file downloads for certain roles, you may create a project as usual and choose to:

#### Use a project template that has the restriction enabled
or
#### Create a project from scratch
Create the project as usual, but specify an additional boolean field named `forceOnline` in the project creation request:
```json
{
    "name": "Restricted Project Name",
    "description": "Restricted Project Description",
    ...,
    "forceOnline": true
}
```
