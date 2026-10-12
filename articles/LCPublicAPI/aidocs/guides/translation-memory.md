# Translation memory: import, export and advanced configuration

Import and export of translation memories (TMs), and TM hard filters and field updates in project and project template settings.

A translation unit (TU) is a source/target segment pair; `fields` hold TU metadata.

## Import

Create the TM first with [CreateTranslationMemory](../reference/CreateTranslationMemory.md). Accepted import file formats: `tmx`, `sdltm`, `zip`, `tmx.gz`, `sdlxliff`.

`POST` [ImportTranslationMemory](../reference/ImportTranslationMemory.md) with `translationMemoryId`, the file and `properties`. **`properties` must come before `file`** in the multipart body (see [file-upload.md](./file-upload.md)). Response: import `id` and `status` (normally `queued`).

### Import properties

Only `sourceLanguageCode` and `targetLanguageCode` are required; the rest have defaults.

| Property | Meaning |
|---|---|
| `sourceLanguageCode`, `targetLanguageCode` | Language direction of the import (required) |
| `importAsPlainText` | When true, TUs are imported as plain text without markup |
| `exportInvalidTranslationUnits` | When true, TUs that failed to import are saved in a `tmx` file |
| `triggerRecomputeStatistics` | When true, recomputes fuzzy index statistics after import |
| `targetSegmentsDifferOption` | Handling when target segments differ (below) |
| `unknownFieldsOption` | Handling of unknown user-defined fields (below) |
| `onlyImportSegmentsWithConfirmationLevels` | Only import segments with the listed confirmation levels |

`targetSegmentsDifferOption`:

| Value | Effect |
|---|---|
| `addNew` | Add a new TU; leave the original TU with the same source untouched |
| `overwrite` | Overwrite all existing TUs whose source segment matches |
| `leaveUnchanged` | Keep existing TUs with the same source; ignore the new TU |
| `keepMostRecent` | Delete all existing TUs with matching source; retain only the most recent |

`unknownFieldsOption`:

| Value | Effect |
|---|---|
| `addToTranslationMemory` | TU processed; unknown user-defined fields added to the setup |
| `skipTranslationUnit` | TUs containing unknown user-defined fields are skipped |
| `ignore` | TU processed; unknown fields ignored (not added) |
| `failTranslationUnitImport` | Error thrown if any TU has an unknown user-defined field |

`onlyImportSegmentsWithConfirmationLevels` values: `translated` (fully translated, not reviewed), `approvedTranslation` (reviewed and approved, not signed-off), `approvedSignOff`, `draft` (target changed, not yet fully translated), `rejectedTranslation`, `rejectedSignOff`.

### Poll import

`GET` [PollTMImport](../reference/PollTMImport.md) with `importId` and `translationMemoryId`; complete when status is `done`.

## Export

1. `POST` [ExportTranslationMemory](../reference/ExportTranslationMemory.md) with `translationMemoryId` and a valid `languageDirection`. Response: `exportId` and `status` (error message on failure).
2. `GET` [PollTranslationMemoryExport](../reference/PollTranslationMemoryExport.md) with `exportId`; complete when status is `done`.
3. `GET` [DownloadExportedTranslationMemory](../reference/DownloadExportedTranslationMemory.md) with `exportId`; the file is `tmx.gz`.

See [async-polling.md](./async-polling.md).

## Advanced configuration

Applies to settings returned/updated by [GetProject](../reference/GetProject.md), [UpdateProject](../reference/UpdateProject.md), [GetProjectTemplate](../reference/GetProjectTemplate.md) and [UpdateProjectTemplate](../reference/UpdateProjectTemplate.md), under `settings.translationMemorySettings`.

### Hard filter

`settings.translationMemorySettings.filters.hardFilter` contains:
- `expression`: logical expression over TU fields
- `fields`: field definitions referenced by the expression (returned on GET only)

Logical operators (precedence from highest): `NOT`, `AND`, `OR`; parentheses allowed. Each comparison is a `"Field name" operator value` triplet. Field names must be quoted strings; values are quoted strings or unquoted integers (optional leading `-`).

```
(NOT "TU confirmation level" = "Not Translated" OR "Last modified on" > 2024-02-29T10:00:00.000Z) AND "Source segment length" >= 10
```

Operators: `=`, `!=`, `<`, `<=`, `>`, `>=`, `CONTAINS`, `DOES NOT CONTAIN`, `MATCHES`, `DOES NOT MATCH`. The expression is parsed by an ANTLR4 grammar `FilterExpression` (`expression: orExpression EOF`, `orExpression: andExpression (OR andExpression)*`, `andExpression: notExpression (AND notExpression)*`, `notExpression: NOT? primaryExpression`, `primaryExpression: comparison | LPAREN orExpression RPAREN`, `comparison: field operator value`).

Operator support by field type (Y = supported):

| Operator | singleString | multipleString | singlePicklist | multiplePicklist | dateTime | integer |
|---|:-:|:-:|:-:|:-:|:-:|:-:|
| `=` | Y | Y | Y | Y | Y | Y |
| `<`, `<=`, `>`, `>=` | - | - | - | - | Y | Y |
| `!=` | Y | - | Y | - | Y | Y |
| `CONTAINS`, `DOES NOT CONTAIN` | Y | Y | - | Y | - | - |
| `MATCHES`, `DOES NOT MATCH` | Y | - | - | - | - | - |

### System fields

| Field name | Type |
|---|---|
| `Last modified on` | `dateTime` |
| `Last modified by` | `singleString` |
| `Last used on` | `dateTime` |
| `Last used by` | `singleString` |
| `Usage count` | `integer` |
| `Created on` | `dateTime` |
| `Created by` | `singleString` |
| `TU confirmation level` | `singlePicklist` |
| `Source segment` | `singleString` |
| `Target segment` | `singleString` |
| `Source segment length` | `integer` |
| `Target segment length` | `integer` |
| `Number of tags in source segment` | `integer` |
| `Number of tags in target segment` | `integer` |

`TU confirmation level` accepted values (exact): `Not Translated`, `Draft`, `Translated`, `Translation Rejected`, `Translation Approved`, `Sign-off Rejected`, `Signed Off`.

Field types: `singleString`, `multipleString`, `singlePicklist`, `multiplePicklist`, `dateTime`, `integer`.

### Field updates

`settings.translationMemorySettings.updateTranslationMemoryFields`:

| Direction | Shape |
|---|---|
| PUT request | `fieldId` (system field name or custom field ID) and `values` (array; format depends on type). Metadata is resolved automatically; do not send the `fields` array |
| GET response | Adds `fieldTemplateId` (`system` or template ID), `fieldTemplateName`, `name`, `type`, `allowedValues` (picklists only) and `values`. `singleString`, `singlePicklist`, `integer`, `dateTime` hold exactly one value; `multipleString`, `multiplePicklist` may hold several |

PUT example:

```json
{
  "settings": {
    "translationMemorySettings": {
      "filters": {
        "hardFilter": {
          "expression": "(\"Created by\" CONTAINS \"API Integration\" OR \"TU confirmation level\" != \"Not Translated\") AND NOT (\"Text\" MATCHES \"exampleText\" AND \"Usage count\" >= 10)"
        }
      },
      "updateTranslationMemoryFields": [
        { "fieldId": "1e5b54da-9048-45f7-a5d8-c3878ac4c5b7", "values": ["11"] },
        { "fieldId": "bf6e413d-e617-4fcd-be13-e389af7ce7d4", "values": ["1Multi List", "2Multi List"] },
        { "fieldId": "6c6d9004-3a9e-4bde-97b4-62a6d2ec1a7f", "values": ["2025-10-29T12:00:00.000Z"] }
      ]
    }
  }
}
```

GET: request metadata with

```
fields=settings.translationMemorySettings.filters.hardFilter.fields,settings.translationMemorySettings.updateTranslationMemoryFields
```

See [fields.md](./fields.md).

## Related

- Multipart upload: [file-upload.md](./file-upload.md)
- Lookup and add/update TUs: [translation-api.md](./translation-api.md)
- Rate limits: [rate-limits.md](./rate-limits.md)
