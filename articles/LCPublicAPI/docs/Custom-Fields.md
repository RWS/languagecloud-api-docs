# Custom fields

Custom Fields allow associating custom data with a project. Custom Fields can be defined in the UI, and then listed and accessed using the List and Get endpoints. The Custom Field values are retrieved through the Project endpoints.

## Custom Field Definitions

To list the available Custom Field Definitions make a `GET` request to the [`/custom-field-definitions`](../api/Public-API.v1-fv.html#/operations/ListCustomFields) endpoint. The response contains: the Custom Fields total count, and by default, the `id` and the `name` for each Custom Field. By specifying the `fields` query parameter, the other properties of these entities can be retrieved.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/ListCustomFieldsPostman.gif?raw=true)

To get a particular Custom Field Definition make a `GET` request to the [`/custom-field-definitions/{customFieldDefinitionId}`](../api/Public-API.v1-fv.html#/operations/GetCustomField) endpoint, and specify the `customFieldDefinitionId` path parameter.
The default fields for custom field are `id` and `name`, but the other fields can be seen by specifying them into `fields` query param. For example: `id,key,description,type,defaultValue`

![Get custom field](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/GetCustomFieldPostman.gif?raw=true)

A default value can be specified on the Custom Field Definition, which will be applied to a project if no other value is specified when creating the project.

## Custom fields in Projects

At project level, Custom Fields can be set either when creating a project or when updating one. Moreover, custom fields are exposed when users search for a project or list all projects.

**Creating projects with Custom Fields** 

To create or update a project with Custom Fields, follow the instructions for creating/updating projects, but also populate the `customFields` property in the request payload.

The `key` property is mandatory and must be specified for each Custom Field. Its value, however, is optional and the Custom Field Definition might contain a default value that will be applied if not otherwise specified. If the value doesn't correspond to the type of Custom Field selected, a validation message with a Bad Request status will be returned in the response. The value type can be checked in the Custom Field Definition in the `type` field, for ex: `DATE`, `STRING`, `PICKLIST`.

When creating a project using a template, Custom Fields that are marked with `isMandatory: true` must be included in the create request and values set, if a default value is not specified. 

The following is an example for creating a project body with valid Custom Fields:

***Request***:

```json
...
{
    "name": "API project with valid custom fields",
    "projectTemplate": {
        "id": "60c1f06d1d8ff66537d674c3"
    },
    "languageDirections": [
        {
            "sourceLanguage": {
                "languageCode": "en-gb"
            },
            "targetLanguage": {
                "languageCode": "fr-be"
            }
        }
    ],
    "location": "d1d6bd4e2ec14ab99e2ec41682553ac0",
    "customFields": [
        {
            "key": "Custom_Field_Boolean_ps0xw",
            "value": true
        },
		{
            "key": "Custom_Field_Long_Text_qq4olq",
            "value": "Test custom field"
        }
    ]
}
...
```

***Response***:

```json
...
{
    "id": "60fa9b729011f339266a2e3b",
    "name": "API project with valid custom fields",
    "languageDirections": [
        {
            "sourceLanguage": {
                "languageCode": "en-GB",
                "englishName": "English (United Kingdom)"
            },
            "targetLanguage": {
                "languageCode": "fr-BE",
                "englishName": "French (Belgium)"
            }
        }
    ],
    "location": {
        "id": "d1d6bd4e2ec14ab99e2ec41682553ac0",
        "name": "RWS"
    },
    "customFields": [
        {
            "id": "60c3539b06e09d00019c0a2d"
        },
        {
            "id": "60c353ec06e09d00019c0a2f"
        }
    ]
}
...
```

![Create project with custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/CreateProjectWithCustomFieldsPostman.gif?raw=true)

An example for creating a project with an invalid value set for a custom field:

***Request***:

```json
...
{
    "name": "API project with invalid custom fields",
    "projectTemplate": {
        "id": "60c1f06d1d8ff66537d674c3"
    },
    "languageDirections": [
        {
            "sourceLanguage": {
                "languageCode": "en-gb"
            },
            "targetLanguage": {
                "languageCode": "fr-be"
            }
        }
    ],
    "location": "d1d6bd4e2ec14ab99e2ec41682553ac0",
    "customFields": [
        {
            "key": "Custom_Field_Boolean_ps0xw",
            "value": "Test custom field" //invalid value
        }
    ]
}
...
```

***Response***:
This will have an HTTP code 400 Bad Request

```json
...
{
    "message": "Invalid input on create project.",
    "errorCode": "invalidInput",
    "details": [
        {
            "name": "project.customFields[0]",
            "code": "invalidInput",
            "value": "Test custom field"
        }
    ]
}
...
```

**Updating projects with Custom Fields**
 
To update the Custom Fields of a project make a `PUT` request to the [`/projects/{projectId}`](../api/Public-API.v1-fv.html#/operations/UpdateProject) endpoint. Specify new values for the Custom Fields that need updating.

![Update project with custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/UpdateProjectWithCustomFieldsPostman.gif?raw=true)

**Getting Custom Fields for projects**

To get the Custom Fields for a project, make a `GET` request to the [`/projects/{projectId}`](../api/Public-API.v1-fv.html#/operations/GetProject) endpoint and request the desired fields in the `fields` query parameters: `customFields.id,customFields.key,customFields.value`. Similarly, this can be done when making a `GET` request to the [`/projects`](../api/Public-API.v1-fv.html#/operations/ListProjects) endpoint.

![Get project with custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/GetProjectWithCustomFieldsPostman.gif?raw=true)

## Custom Fields in Project Templates

Custom Fields can be defined in Project Templates. `isMandatory` on a Custom Field indicates that it must be populated when a project is created with that template.

To get the Custom Fields for a project template, make a `GET` request to the [`/project-templates/{projectTemplateId}`](../api/Public-API.v1-fv.html#/operations/GetProjectTemplate) endpoint or a `GET` request to the [`/project-templates`](../api/Public-API.v1-fv.html#/operations/ListProjectTemplates) endpoint and specify the desired fields in the `fields` query parameters: `customFields.id,customFields.key,customFields.value`.

![Get project template with custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/GetProjectTemplateWithCustomFieldsPostman.gif?raw=true)
