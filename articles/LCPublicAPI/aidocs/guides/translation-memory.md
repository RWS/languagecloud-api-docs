# Translation Memory

## Import

Supported input formats: `tmx`, `sdltm`, `zip`, `tmx.gz`, `sdlxliff`.

**Create a TM first** before importing via `POST /translation-memories`.

```
POST /translation-memories/{translationMemoryId}/import
```

Multipart body — `properties` part first, then `file`.

### Import Properties

| Property | Required | Description |
|---|---|---|
| `sourceLanguageCode` | Yes | Source language of the import. |
| `targetLanguageCode` | Yes | Target language of the import. |
| `importAsPlainText` | No | If `true`, strip markup and import as plain text. |
| `exportInvalidTranslationUnits` | No | If `true`, failed TUs are saved to a `tmx` file. |
| `triggerRecomputeStatistics` | No | If `true`, recompute fuzzy index statistics after import. |
| `targetSegmentsDifferOption` | No | How to handle TUs with same source but different target: `addNew`, `overwrite`, `leaveUnchanged`, `keepMostRecent`. |
| `unknownFieldsOption` | No | How to handle TUs with unknown user-defined fields: `addToTranslationMemory`, `skipTranslationUnit`, `ignore`, `failTranslationUnitImport`. |
| `onlyImportSegmentsWithConfirmationLevels` | No | Filter by confirmation level: `translated`, `approvedTranslation`, `approvedSignOff`, `draft`, `rejectedTranslation`, `rejectedSignOff`. |

Response: import `id` + `status: queued`.

### Poll Import

```
GET /translation-memories/{translationMemoryId}/import/{importId}
```

Poll until `status: done`.

## Export

```
POST /translation-memories/{translationMemoryId}/export
```

Body: `translationMemoryId` + `languageDirection`. Response: `exportId` + `status`.

### Poll Export

```
GET /translation-memories/export/{exportId}
```

Poll until `status: done`.

### Download Export

```
GET /translation-memories/export/{exportId}/download
```

Response format: `tmx.gz`.

## Advanced Configuration (TM Filters and Field Updates)

Applicable endpoints: `GET/PUT /projects/{projectId}`, `GET/PUT /project-templates/{projectTemplateId}`.

### Hard Filters

Hard filters restrict which TUs are considered matches by applying logical expressions on TU fields.

Filter configuration:
- `expression`: string expression in the grammar below.
- `fields`: array of field definitions referenced in the expression.

**Logical operators:** `AND`, `OR`, `NOT`

**Example expression:**
```
(NOT "TU confirmation level" = "Not Translated" OR "Last modified on" > 2024-02-29T10:00:00.000Z) AND "Source segment length" >= 10
```

**Operators:** `=`, `!=`, `<`, `<=`, `>`, `>=`, `CONTAINS`, `DOES NOT CONTAIN`, `MATCHES`, `DOES NOT MATCH`

**Field names must be quoted strings. Values are quoted strings or unquoted integers.**

### System Fields Available in Filter Expressions

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

### TU Confirmation Level Values

`Not Translated`, `Draft`, `Translated`, `Translation Rejected`, `Translation Approved`, `Translation Approved` (sign-off approved)
