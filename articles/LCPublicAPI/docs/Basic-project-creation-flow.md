# Basic project creation flow

Please read carefully about [authentication and prerequisites](../docs/Authentication.md) , and take into consideration that some steps might be done by Trados engineering.

Details about what are the rate limits for Trados Cloud Platform API can be found on [API rate limits](../docs/API-rate-limits.md) page. 

Additional information regarding file and project size limits can be found [here](https://docs.rws.com/791595/815967/trados-enterprise---accelerate/file-and-project-size-limit).

> This small [Postman collection](https://raw.githubusercontent.com/RWS/language-cloud-public-api-postman/develop/basicProjectCreationFlow.json) can help you get started with the basic project creation flow. For details on Postman setup please see the main [Postman](../docs/Language-Cloud-APIs-for-Postman.md) page.
> 
> In the [Create Project](../api/Public-API.v1-fv.html#/operations/CreateProject) endpoint body, the `projectTemplate` value should be replaced with a valid `templateId`. From that point on all the necessary identifiers will be automatically populated throughout Postman.
>
> Check the [Multi-Region](../docs/Multi-region.md) page for regional API details.

Steps to create a basic translation project:
1. Create Project	
2. Add project source file	
3. Start Project	
4. List Project's Tasks	
5. List Project Target Files	
6. Download File
7. Complete Project
8. List Projects	

### 1. Create Project	
Creates a new project.

Endpoint: [`POST /projects`](../api/Public-API.v1-fv.html#/operations/CreateProject)

For running this endpoint you need to supply the required project details (body tab in Postman):
> `POST` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects
```json
{
	"name": "Name of the Project",
	"description": "Test Project",
	"dueBy": "2021-09-04T08:14:05.858Z",
	"projectTemplate": {
		"id": "xxxxxxxxxxxxxxxxxxxxxxxx" // Provided by RWS
	},
	"languageDirections": [
		{
			"sourceLanguage": {
				"languageCode": "en-US"
			},
			"targetLanguage": {
				"languageCode": "fr-FR"
			}
		}
	]
}
```

Source and Target Language Codes can be obtained from [here](../api/Public-API.v1-fv.html#/operations/ListLanguages).

The API should respond with:
- HTTP Status Code: 201 Created.
- Body â€“ your project details consisting of `projectId`, `project name`, `language direction`, `location` and other optional fields.

Example:
```json
{
    "id": "xxxxxxxxxxxxxxxxxxxxxxxx", // The project identifier.
    "name": "Name of the Project",
    "languageDirections": [
        {
            "sourceLanguage": {
                "languageCode": "en-US",
                "englishName": "English (United States)"
            },
            "targetLanguage": {
                "languageCode": "fr-FR",
                "englishName": "French (France)"
            }
        }
    ],
    "location": {
        "id": "xxxxxxxxxxxxxxxxxxxxxxxx",
        "name": "Project Location"
    }
}
```
</br>


![Create simple project](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/CreateSimpleProjectPostman.gif?raw=true)

</br>

#### Scenario:
If your company has multiple divisions, you can imagine a hierarchy like this:

**YOUR COMPANY**
-	**Marketing Division**
-	**Management Division**
-	**HR Division**

If you want to create projects for different divisions, this can be done by using the `location` parameter, which will be added in the body. When location is not set, the system will try to create the resource in the higher folder in the hierarchy, the Root folder. It might not have access to that folder and the request will fail with forbidden error.

```json
{
	"name": "Name of the Project",
	"description": "Test Project",
	"dueBy": "2021-09-04T08:14:05.858Z",
	"projectTemplate": {
		"id": "xxxxxxxxxxxxxxxxxxxxxxxx" // Provided by RWS
	},
	"languageDirections": [
		{
			"sourceLanguage": {
				"languageCode": "en-US"
			},
			"targetLanguage": {
				"languageCode": "fr-FR"
			}
		}
	],
	"location": "xxxxxxxxxxxxxxxxxxxxxxxx" // Provided by RWS
}
```

Using this request your project will be created in the specified Division and it will be visible only there. 

Detailed information about location and folders can be found on the [How to use location and folders](../docs/How-to-use-location-and-folders.md) page.


![Create project with location](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/CreateProjectWithLocationPostman.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/CreateProject).

### 2. Add Source File

Adds a source file to the project.

Endpoint: [`POST /projects/{projectId}/source-files`](../api/Public-API.v1-fv.html#/operations/AddSourceFile)

For running this endpoint you need to:
-	Replace `{projectId}` from the URL with the identifier received from the Create Project endpoint response: 
> `POST` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects/{projectId}/source-files
- Add the file to the request body.
-	Complete the details from Body tab - Properties field.
```json
Properties field:
{
	"language": "en-US",
	"type": "native",
	"role": "translatable",
	"name": "nameOfTheFile.extension"
}
```

Responses:
-	HTTP Code 201 Created.
-	Body â€“  a list with the identifier, name and role of the file.


![Add source file](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/AddSourceFilePostman.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/AddSourceFile).

### 3. Start Project

Starts a project.

Endpoint: [`PUT /projects/{projectId}/start`](../api/Public-API.v1-fv.html#/operations/StartProject)

For running this endpoint you need to:
-	Replace `{projectId}` from the URL with the identifier received from the Create Project endpoint response: 
> `PUT` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects/{projectId}/start

Responses:
-	HTTP Code 202 Accepted


![Start project](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/StartProjectPostman.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/StartProject).

### 4. List Project's Tasks

List the tasks of a specific project. If all the tasks have the status `completed`, all the files are translated.

Endpoint: [`GET /projects/{projectId}/tasks`](../api/Public-API.v1-fv.html#/operations/ListProjectTasks)

For running this endpoint you need to:
-	Replace `{projectId}` from the URL with the identifier received from the Create Project endpoint response: 
> `GET` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects/{projectId}/tasks?fields=taskType,status

Use `?fields=taskType` if you want to observe the task name.

Responses:
-	HTTP Code 200 Ok.
-	Body â€“  a list with task identifier and status.

Example:
```json
{
	"items": [
		{
			"id": "613f621fe5ed2804ba31870e",
			"status": "completed",
			"taskType": {
				"id": "607932f25c7cc701241f0f60",
				"key": "scan",
				"name": "File Type Detection"
			}
		},
		{
			"id": "613f623040d9943308ef7c3b",
			"status": "completed",
			"taskType": {
				"id": "607932f3ce8af15851b70205",
				"key": "convert",
				"name": "File Format Conversion"
			}
		},
                ...
	],
	"itemCount": 11
}
```
</br>


![List project's task](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/ListProjectTasks.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/ListProjectTasks).

### 5. List Project Target Files

Retrieves the target `fileId` for a project and the latest version for the translated file.

Endpoint: [`GET /projects/{projectId}/target-files`](../api/Public-API.v1-fv.html#/operations/ListTargetFiles)

For running this endpoint you need to:
-	Replace `{projectId}` from the URL with the identifier received from the Create Project endpoint response: 
> `GET` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects/{projectId}/target-files?fields=latestVersion

Responses:
-	HTTP Code 200 Ok.
-	Body â€“ a list with objects that contain: 
      - source file and target file identifiers
      - source and target languages

Example:
```json
{
	"items": [
		{
			"id": "613f623ae5ed2804ba318a40", // This is the target file identifier.
			"latestVersion": {
				"id": "613f628540d9943308ef8497", // This is the file version identifier.
				"type": "native"
			}
		},
		{
			"id": "613f623ae5ed2804ba318a43",
			"latestVersion": {
				"id": "613f628a40d9943308ef84cd",
				"type": "native"
			}
		}
	],
	"itemCount": 2
}
```
</br>


![List project target files](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/ListProjectTargetFilesPostman.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/ListTargetFiles).

### 6. Download File

Downloads the translated file.

Endpoint: [`GET /projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download`](../api/Public-API.v1-fv.html#/operations/DownloadFileVersion)

For running this endpoint you need to:
-	Replace `{projectId}` from the URL with the identifier received from the Create Project endpoint response
-	Replace `{targetFileId}` from the URL with the identifier received from the List Project Target Files endpoint response
-	Replace `{fileVersionId}` from the URL with the identifier received from the List Project Target Files endpoint response

> `GET` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects/{projectId}/target-files/{targetFileId}/versions/{fileVersionId}/download

Responses:
-	HTTP Code 200 OK.
-	Body â€“  the translated file. The file can be also saved from Save Response option.


![Download file](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/DownloadFilePostman.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/DownloadFileVersion).


### 7. Complete Project

Marks a project as `completed`.

Endpoint: [`PUT /projects/{projectId}/complete`](../api/Public-API.v1-fv.html#/operations/CompleteProject)

For running this endpoint you need to:
-	Replace `{projectId}` from the URL with the identifier received from the Create Project endpoint response
> `PUT` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects/{projectId}/complete

Responses:
-	HTTP Code 204 No Content.


![Complete project](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/CompleteProjectPostman.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/CompleteProject).

### 8. List Projects	

Retrieves a list of all the projects in the account.

Endpoint: [`GET /projects`](../api/Public-API.v1-fv.html#/operations/ListProjects)

For running this endpoint make a request to:
> `GET` https://api.{REGION_CODE}.cloud.trados.com/public-api/v1/projects
 
Responses:
-	HTTP Code 200 OK.
- Body â€“ a list of projects with details consisting of project identifier, project name, language direction, location and other optional fields

Example:
```json
{
	"items": [
		{
			"id": "xxxxxxxxxxxxxxxxxxxxxxxx",
			"name": "Translation Project 1",
			"languageDirections": [
				{
					"sourceLanguage": {
						"languageCode": "en-US",
						"englishName": "English (United States)"
					},
					"targetLanguage": {
						"languageCode": "fr-FR",
						"englishName": "French (France)"
					}
				}
			],
			"location": {
				"id": "xxxxxxxxxxxxxxxxxxxxxxxx",
				"name": "Project Location"
			}
		},
		{
			"id": "xxxxxxxxxxxxxxxxxxxxxxxx",
			"name": "Translation Project 2",
			"languageDirections": [
				{
					"sourceLanguage": {
						"languageCode": "en-US",
						"englishName": "English (United States)"
					},
					"targetLanguage": {
						"languageCode": "fr-FR",
						"englishName": "French (France)"
					}
				}
			],
			"location": {
				"id": "xxxxxxxxxxxxxxxxxxxxxxxx",
				"name": "Project Location"
			}
		}
	],
	"itemCount": 2
}
```

</br>


![List projects](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/ListProjectsPostman.gif?raw=true)

More details about this endpoint can be found [here](../api/Public-API.v1-fv.html#/operations/ListProjects).
