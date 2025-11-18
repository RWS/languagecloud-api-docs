# Translation Memory import and export

## Concepts


Concept | Explanation |
---------|----------|
 Translation Unit | A pair made of source and target segments |
 Fields | The `fields` contain metadata about the translation unit. |

## Importing a translation memory

The translation memory that you want to import must have one of the following formats: `tmx`, `sdltm`, `zip`, `tmx.gz` or `sdlxliff`.

> [!NOTE]
> Before the import action, make sure you have already created a translation memory using the [Create Translation Memory](../../api/Public-API.v1-fv.html#/operations/CreateTranslationMemory) endpoint.

To import a translation memory, perform a `POST` request to the [Import Translation Memory](../../api/Public-API.v1-fv.html#/operations/ImportTranslationMemory) endpoint and provide these details: `translationMemoryId`, the translation memory file and a couple of properties.

> [!WARNING]
> Pay special attention to the order of `properties` and `file`. It must be exactly as described in the contract (properties first).

If you are not sure what properties to include, here's a short description for each of them:
1. `sourceLanguageCode` and `targetLanguageCode` - These fields represent the language direction of your import. Make sure to provide both of them as they are required fields.
2. `importAsPlainText` - When true, the translation units will be imported as plain text, excluding any text markup.
3. `exportInvalidTranslationUnits` - When true, all the translation units that failed to import are saved in a `tmx` file.
4. `triggerRecomputeStatistics` - When true, will recompute the fuzzy index statistics once the import is done.
5. `targetSegmentsDifferOption` - Option to specify how to handle translation units in the Translation Memory, if the target segments differ.
    - `addNew` - Add a new translation unit and leave the original translation unit with the same source untouched.
    - `overwrite` - Overwrite all the existing translation units where the source segment matches with the new content.
    - `leaveUnchanged` - Do not change the existing translation units with the same source segment and ignore the new translation unit.
    - `keepMostRecent` - Delete all the existing translation units with matching source segments and retain only the most recent translation unit
6. `unknownFieldsOption` - Option to specify how to handle translation units and unknown fields in the Translation Memory.
    - `addToTranslationMemory` - The translation unit is processed and the unknown user-defined fields are automatically added to the setup.
    - `skipTranslationUnit` - The translation units containing unknown user-defined fields are skipped.
    - `ignore` - The translation unit is processed and the unknown user-defined fields are ignored (not added to the setup).
    - `failTranslationUnitImport` - If any translation unit contains an unknown user-defined field an error is thrown.
7. `onlyImportSegmentsWithConfirmationLevels` - Only segments with the specified confirmation levels will be imported.
    - `translated` - The segment has been fully translated, but not yet reviewed.
    - `approvedTranslation` - The translation has been reviewed and approved, but not signed-off.
    - `approvedSignOff` - The translation has been approved and signed-off.
    - `draft` - The target segment may have been changed, but it's not yet considered fully translated.
    - `rejectedTranslation` - The translation has been reviewed and rejected.
    - `rejectedSignOff` - The translation was rejected in the sign-off process.

Note that only the `sourceLanguageCode` and `targetLanguageCode` fields are **required**, the others already have default values, so you don't have to set them.

If the import is successful, you will get back the import `id` and the `status`(normally `queued`).

For more details about translation memory imports you can also check out the [Importing TM content](https://docs.rws.com/791595/741139/trados-enterprise/importing-tm-content) page.

![Import TM](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/ImportTM.gif?raw=true)


## Polling a translation memory import
Some imports may take longer, depending on the size of the Translation Memory. 

To check if the import finished, you can perform a `GET` request to the [Poll Translation Memory Import](../../api/Public-API.v1-fv.html#/operations/PollTMImport) endpoint and supply the `importId` and the `translationMemoryId`. The import is complete when the status is `done`.


## Exporting a translation memory

To export a translation memory, perform a `POST` request to the [Export Translation Memory](../../api/Public-API.v1-fv.html#/operations/ExportTranslationMemory) endpoint and provide the `translationMemoryId` and a valid `languageDirection` of your translation memory. 

If the export is successful, you will get back an `exportId` and the export `status`. If the export did not succeed, the response will contain an error message.

![Export TM](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/ExportTM.gif?raw=true)

## Polling a translation memory export

Some exports may take longer, depending on the size of the Translation Memory.

To check if the export finished, you can perform a `GET` request to the [Poll Translation Memory Export](../../api/Public-API.v1-fv.html#/operations/PollTranslationMemoryExport) endpoint and supply the `exportId`. The export is complete when the status is `done`.

## Downloading a translation memory export

If an export is completed successfully (the status received at the polling is `done`), it can be downloaded by performing a `GET` request to the [Download Exported Translation Memory](../../api/Public-API.v1-fv.html#/operations/DownloadExportedTranslationMemory) endpoint. Just supply as `path` parameter the `exportId` and the response will contain the exported translation memory file in `tmx.gz` format.

