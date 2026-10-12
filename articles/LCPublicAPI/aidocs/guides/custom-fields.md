# Custom fields

Custom fields attach custom data to projects; definitions are created in the UI and read through the API.

## Definitions

| Operation | Endpoint | Notes |
|---|---|---|
| List | [ListCustomFields](../reference/ListCustomFields.md) `GET /custom-field-definitions` | Returns total count and by default `id` and `name`; request more via `fields` |
| Get | [GetCustomField](../reference/GetCustomField.md) `GET /custom-field-definitions/{customFieldDefinitionId}` | Default `id`, `name`; e.g. `fields=id,key,description,type,defaultValue` |

A definition may have a default value, applied to a project when no value is supplied at creation. Definition `type` examples: `DATE`, `STRING`, `PICKLIST`.

## On projects

Set on create or update through the `customFields` array of the request.

- `key` is **mandatory** for each custom field; `value` is optional (the definition's default is applied if omitted).
- A value that does not match the field type returns **400 Bad Request**.
- When creating from a project template, fields marked `isMandatory: true` must be included with values, unless a default value is defined.
- Update: `PUT` [UpdateProject](../reference/UpdateProject.md) with new values for the fields to change (JSON Merge Patch rules, see [put-semantics.md](./put-semantics.md)).
- Read: [GetProject](../reference/GetProject.md) or [ListProjects](../reference/ListProjects.md) with `fields=customFields.id,customFields.key,customFields.value`.

Create request:

```json
{
    "name": "API project with valid custom fields",
    "projectTemplate": { "id": "60c1f06d1d8ff66537d674c3" },
    "languageDirections": [
        { "sourceLanguage": { "languageCode": "en-gb" }, "targetLanguage": { "languageCode": "fr-be" } }
    ],
    "location": "d1d6bd4e2ec14ab99e2ec41682553ac0",
    "customFields": [
        { "key": "Custom_Field_Boolean_ps0xw", "value": true },
        { "key": "Custom_Field_Long_Text_qq4olq", "value": "Test custom field" }
    ]
}
```

Response (default): `id`, `name`, `languageDirections`, `location`, `customFields[]` with `id`.

Invalid value (boolean field given a string) returns 400:

```json
{
    "message": "Invalid input on create project.",
    "errorCode": "invalidInput",
    "details": [
        { "name": "project.customFields[0]", "code": "invalidInput", "value": "Test custom field" }
    ]
}
```

## On project templates

- Templates can define custom fields; `isMandatory` marks fields that must be populated when creating a project with that template.
- Read: [GetProjectTemplate](../reference/GetProjectTemplate.md) or [ListProjectTemplates](../reference/ListProjectTemplates.md) with `fields=customFields.id,customFields.key,customFields.value`.

## Related

- Project creation: [projects.md](./projects.md)
- Webhook payloads include `customFields` for project events: [webhooks.md](./webhooks.md)
