# Custom Fields

Custom Fields allow associating typed metadata with projects. Definitions are configured in the Trados UI; values are set and retrieved via the API.

## Custom Field Definitions

| Endpoint | Operation |
|---|---|
| `GET /custom-field-definitions` | List all definitions. Default fields: `id`, `name`. |
| `GET /custom-field-definitions/{id}` | Get a single definition. Use `fields=id,key,description,type,defaultValue` to see all properties. |

Each definition has a `type`: `DATE`, `STRING`, `PICKLIST`, or `BOOLEAN`. A `defaultValue` may be set on the definition, which is applied to new projects if no value is specified.

## Custom Fields on Projects

### Creating with Custom Fields

Include a `customFields` array in the `POST /projects` request body:

```json
{
  "name": "My Project",
  "projectTemplate": { "id": "TEMPLATE_ID" },
  "languageDirections": [...],
  "location": "LOCATION_ID",
  "customFields": [
    { "key": "Custom_Field_Boolean_ps0xw", "value": true },
    { "key": "Custom_Field_Long_Text_qq4olq", "value": "Test custom field" }
  ]
}
```

- `key` is **required** for each entry.
- `value` is optional if the definition has a `defaultValue`.
- If a value does not match the definition's `type`, the response is `400 Bad Request`:
  ```json
  {
    "message": "Invalid input on create project.",
    "errorCode": "invalidInput",
    "details": [{"name": "project.customFields[0]", "code": "invalidInput", "value": "Test custom field"}]
  }
  ```
- When using a project template, fields marked `isMandatory: true` must be provided if no default value is set.

### Updating Custom Fields

`PUT /projects/{projectId}` — include `customFields` with keys and new values.

### Retrieving Custom Fields

```
GET /projects/{projectId}?fields=customFields.id,customFields.key,customFields.value
GET /projects?fields=customFields.id,customFields.key,customFields.value
```

## Custom Fields in Project Templates

Templates may define custom fields with `isMandatory` indicating whether the field must be populated at project creation. Retrieve them with:

```
GET /project-templates/{id}?fields=customFields.id,customFields.key,customFields.value
```
