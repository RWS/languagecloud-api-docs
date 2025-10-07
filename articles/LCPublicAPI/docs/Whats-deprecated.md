# What's Deprecated
</br>

## 1 July 2024
We have removed the old fields in the folder/resource structure and are no longer available. Use the [path](../api/Public-API.v1-fv.html#/schemas/folder-v2) field going forward.

## 13 December 2023
- The `Export Quote` endpoint has been removed. 
- In the Get Project Template model we deprecated:
  - `forceOnline` field from root level and we added `forceOnline` to the settings â†’ general
  - `quoteTemplate` field from root level and we added `quoteTemplate` to the settings â†’ general
  They will only be available for use until July 2024.

## 17 August 2023
 
We updated the folder/resource locations to the new format, which now includes the [path](../api/Public-API.v1-fv.html#/schemas/folder-v2). The old fields are marked as deprecated and their decommissioning is scheduled at a minimum of six months from now.

## 12 August 2022
In the `Quote` code, we deprecated the `Export Quote` endpoint. It will only be available for use until December 2022. 


## 7 June 2022

In the `LanguageDirectionRequest` model we deprecated:
- the `sourceLanguageCode` field and introduced `sourceLanguage` as an object containing the `languageCode` field;
- the `targetLanguageCode` field and introduced `targetLanguage` as an object containing the `languageCode` field.

They will no longer be available to use starting with November 2022.

## 8 September 2021

We removed deprecated fields from the ErrorResponse model.

