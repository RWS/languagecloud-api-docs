# Termbase import and export
</br>

## Importing a termbase

The following termbase formats are supported: `tbx` and `xml`. 

> Before importing a termbase, make sure you already created one using the [Create Termbase](../../api/Public-API.v1-fv.html#/operations/CreateTermbase) endpoint.

To import a `tbx` or an `xml` termbase, perform a `POST` request to the [Import Termbase](../../api/Public-API.v1-fv.html#/operations/ImportTermbase) endpoint and provide the `termbaseId` and the termbase file. Optionally, you can specify two import settings via query parameters:

1. `duplicateEntriesStrategy` - It determines how the duplicate entries will be handled and it can have one of the following values:

  - `ignore` The content of the current entry with the same identifier will be kept and the new entry will be ignored.

  - `merge` The content of the current entry with the same identifier will be merged into the imported entry. If the identifier is not provided, the content will be merged by text.

  - `override` The content of the current entry with the same identifier will be replaced by the imported entry.

>   If `duplicateEntriesStrategy` is not sent, the default behavior will be `override`.


2. `strictImport` - It specifies if the entries are imported only into the exact language that matches your imported file and it can have one of the following values:

  - `true`  The import will only occur if the language in your import file matches exactly a language in your termbase.

  - `false` The import will occur even if there are non-matching languages, by trying to match them to a relevant main language or language variant, if available.

>   If `strictImport` is not sent, the default behavior will be `true`.

If the import is successful, you will get back an `importId` and the import `status`. 


![Import Termbase](https://raw.githubusercontent.com/RWS/language-cloud-public-api-doc-resources/main/PublicAPI/ImportTermbasePostman.gif?raw=true)

</br>

## Polling a termbase import
Some imports may take longer, depending on the size of the termbase. 

To check if the import finished, you can perform a `GET` request to the [Poll Termbase Import](../../api/Public-API.v1-fv.html#/operations/PollTermbaseImport) endpoint and supply the `importId` and the `termbaseId`. The import is complete when the status is `done`.

</br>

## Exporting a termbase
The following termbase formats are supported: `tbx` and `xml`. 

To export a `tbx` or an `xml` termbase, perform a `POST` request to the [Export Termbase](../../api/Public-API.v1-fv.html#/operations/ExportTermbase) endpoint and provide the `termbaseId`. 
Optionally, you can specify in body, one of the two allowed formats. If none is specified, the default format will be `tbx`. Also, in the body, it can be specified if the download should be compressed (zipped) or not. By default, this property is set to `false`.

If the export is successful, you will get back an `exportId`, the export `status` and the `downloadUrl` for this. If the export did not succeed, the response will contain an `errorMessage`.

![Export Termbase](https://raw.githubusercontent.com/RWS/language-cloud-public-api-doc-resources/main/PublicAPI/ExportTermbasePostman.gif?raw=true)

</br>

## Polling a termbase export
Some exports may take longer, depending on the size of the termbase.

To check if the export finished, you can perform a `GET` request to the [Poll Termbase Export](../../api/Public-API.v1-fv.html#/operations/PollExportTermbase) endpoint and supply the `exportId` and the `termbaseId`. The export is complete when the status is `done`.

</br>

## Downloading a termbase export
If an export is completed (the status received at the polling is `done`), it can be downloaded by performing a `GET` request to the [Download Exported Termbase](../../api/Public-API.v1-fv.html#/operations/DownloadExportedTermbase) endpoint. Supply as path parameters the `exportId` and the `termbaseId` and the response will contain the exported termbase file.
</br>
