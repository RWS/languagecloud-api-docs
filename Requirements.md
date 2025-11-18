# Requirements

Create a powershell script (convert-reference-links.ps1) that will:

- Find all links in markdown files in "./articles/LCPublicAPI/docs/" and for links that start with "../reference/<file-name>.json/paths/" replace with:
  - for links that link to operations: "../api/<file-name>-fv.html#/operations/<operation-id>"
  - for links that link to scheams: "../api/<file-name>-fv.html#/schemas/<schema-name>"
- Current links in the markdown relative paths are not correct. those are  actually referencing files from the /articles/LCPublicAPI/api 

Second powershell script (convert-contract-links.ps1) that will:

- Find all links in markdown format (ex: `[Translation API](../docs/translations/Translations.md)`) in a provided contract file (.json file in "/articles/Extensibility/api" or "/articles/LCPublicAPI/api") and rename them to *.html
- Find all links in markdown format (ex: `[Upload Zip File](../reference/Public-API.v1.json/paths/~1files/post)`) in the given contract (same as above) and:
  - change the url to operationId using hash, example: `[Poll Upload Zip File](../reference/Public-API.v1.json/paths/~1files~1{fileId}/get)` becomes `[Poll Upload Zip File](#/operations/PollUploadZipFile)`
    - for schemas the path becomes `#/schemas/..`
  - if the url is relative to another contract file format a full relative path, ex: `[Poll Upload Zip File](../reference/Public-API.v1.json/paths/~1files~1{fileId}/get)` becomes `[Poll Upload Zip File](../../LCPublicAPI/api/Public-API.v1-fv.html#/operations/PollUploadZipFile)`



















<!-- - transform the links (ignore the absolute ones) relative to either "/articles/Extensibility/docs/.." or "/articles/LCPublicAPI/docs/.."
- liks to .md should be transformed to links to .html
- Example: `[Translation API](../docs/translations/Translations.md)` should be transformed to: `[Translation API](../docs/translations/Translations.html)` -->