# The fields query parameter

Every endpoint that returns a resource representation accepts a `fields` query parameter to choose which properties are returned.

## Syntax

- Comma-separated list of properties and/or subproperties.
- Subproperty format: `propertyname.subpropertyname` (nesting can go deeper, e.g. `languages.terms.termbaseFieldValues`).
- Properties examples: `id`, `name`, `customer`, `createdBy`.
- Subproperties examples: `customer.name`, `customer.keyContact`, `customer.location`, `createdBy.email`.

## What is returned

- Fields marked **required** are always returned.
- If fields are not customised for a given level and the requested field is non-null, the **default fields** are returned.
- If fields are customised for a given level and the requested field is non-null, the **requested fields** are returned.
- The same rules apply at nested levels.

## Example: `GET /projects/101`

| Request | Response contains |
|---|---|
| `GET /projects/101` | project `id`, `name`, language directions |
| `GET /projects/101?fields=customer` | project `id`; customer `id`, `name`, `keyContact`, `location` |
| `GET /projects/101?fields=customer.keyContact,customer.name` | project `id`; customer `name`, `keyContact` |

See [GetProject](../reference/GetProject.md).

## Other examples from the docs

| Use | Example `fields` value |
|---|---|
| Project custom fields | `customFields.id,customFields.key,customFields.value` |
| Task type name | `taskType` (on `GET /projects/{projectId}/tasks`) |
| Target file latest version | `latestVersion` (on `GET /projects/{projectId}/target-files`) |
| Project status and quote total | `status,quote.totalAmount` |
| Current user location and groups | `location.name,location.path,groups` (on [GetMyUser](../reference/GetMyUser.md)) |
| Custom field definition properties | `id,key,description,type,defaultValue` |
| TM hard filter field metadata | `settings.translationMemorySettings.filters.hardFilter.fields,settings.translationMemorySettings.updateTranslationMemoryFields` |
| Termbase entry content | `humanReadableId,languages.terms,languages.terms.termbaseFieldValues` |
| Termbase template | `name,location,description,languages,fields` |

Custom field definitions return `id` and `name` by default; other properties must be requested via `fields`.
