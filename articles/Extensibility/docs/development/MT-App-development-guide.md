---
tags: [Development]
stoplight-id: y6tealkmfbf36
---


# Machine Translation

Machine Translation apps offer the possibility to use external machine translation providers within the Trados platform.

To build a new MT app we recommend starting by using the provided [app blueprints](https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints).

## Machine Translation Extension

An MT app needs to define at least one MT extension within its [descriptor](../../App-API.v1.json/paths/~1descriptor/get).
For example: 

```json
{
  ...
  "extensions": [
    {
      "id": "SAMPLE_MT_EXTENSION_ID",
      "name": "SAMPLE_MT_EXTENSION_NAME",
      "extensionPointVersion": "1",
      "extensionPointId": "lc.mtprovider",
      "description": "SAMPLE_MT_EXTENSION_DESCRIPTION",
      "configuration": {
        "endpoints": {
          "lc.mtprovider.translate": "/v1/translate",
          "lc.mtprovider.engines": "/v1/translation-engines"
        },
        "format": "html" // or "bcm"
      }
    }
  ]
  ...
}
```

- `id` - unique extension identifier provided by the app Developer
- `name` - provide a friendly and unique name. It might be shown to the end user, and it may be useful in helping the user distinguish between multiple extensions
- `extensionPointVersion` - the version of the extension point that is implemented in the Extension
- `extensionPointId` - the extension point identifier corresponding to this extensionType: **lc.mtprovider**
- `description` - the MT extension description
- `configuration` - the extension configuration
  - `endpoints` - the required endpoints for the MT extension
    - `lc.mtprovider.translate` - the endpoint used to receive and translate content from Trados
    - `lc.mtprovider.engines` - the endpoint used to retrieve the available translation engines (supported language pairs)
  - `format` - the content's format supported by the app on the `translate` endpoint.

### Translation Engines Endpoint

The `lc.mtprovider.engines` endpoint provides the available translation engines for the requested language pairs.

  Example: 
```html
GET /v1/translation-engines?model=NEURAL&sourceLanguage=en-US&targetLanguage=ro-RO&targetLanguage=ro-MD&targetLanguage=fr-FR&exactMatch=true
```

-   The `model` is the translation engine's type and its value can be either `NEURAL` or `BASELINE`.

-   The `exactMatch` will enforce the result to include only the languages that match the exact values of the requested languages.

-   There could be multiple target languages requested, thus the endpoint should return all translation engines for the supported ones.

-   The response would look like this:

```json
{
  "items": [
    {
      "id": "en_fr_nmt",
      "model": "nmt",
      "name": "nmt",
      "engineSourceLanguage": "en",
      "engineTargetLanguage": "fr",
      "matchingSourceLanguage": "en-US",
      "matchingTargetLanguages": [
        "fr-FR"
      ]
    },
    {
      "id": "en_ro_nmt",
      "model": "nmt",
      "name": "nmt",
      "engineSourceLanguage": "en",
      "engineTargetLanguage": "ro",
      "matchingSourceLanguage": "en-US",
      "matchingTargetLanguages": [
        "ro-RO",
        "ro-MD"
      ]
    }
  ],
  "itemCount": 2
}
```

-   `nmt` stands for "NEURAL MACHINE TRANSLATION"

#### Endpoint usage

This endpoint is going to be used when creating a new **Translation Engine** resource as shown below:

![MTengines](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevAppMTEngines.gif?raw=true)

The **Machine Translation models** are provided by the app via the `lc.mtprovider.engines` endpoint.

The blueprints contain placeholders from where you can start implementing the endpoint's functionality:
- [.NET blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/dotNetAppBlueprint/Rws.LC.AppBlueprint/Controllers/TranslationController.cs#L52)
- [Java blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppBlueprint/src/main/java/com/rws/lt/lc/blueprint/web/TranslationEnginesController.java#L21)

Please refer to the endpoint's [documentation](../../App-API.v1.json/paths/~1lc.mtprovider.engines/get) for further details.

### Translate Endpoint

  The `lc.mtprovider.translate` endpoint translates the content, namely the text provided in the format specified in the descriptor (_html_ of _bcm_).

  Example:

```json
POST /v1/translate

{
  "contents": [
    "<div i=\"24\">Here’a a smiley face <img i=\"25\"/></div>",
    "<div i=\"10\">Here’s a table:</div>"
  ],
  "engineId": "en_ro_nmt"
}
```

-   The `engineId` is the identifier of the engine used to translate the `contents`.

-   The response would look like this:

```json
{
  "translations": [
    "<div i=\"24\"> Iată un chip zâmbet <img i=\"25\"/></div>",
    "<div i=\"10\"> Iată un tabel: </div>"
  ]
}
```

> `<div i="1"> .. </div>` might cause problems for some engines. You can parse them out before sending them to the translation service if the order of the segments can be guaranteed. Once the translated segments are available, these need to be added back when sending the response.

#### Endpoint usage

To test the endpoint, first, you will need a workflow that contains the **Machine Translation** automatic task and the **Translation** human task. For example:

![SimpleTranslationWF](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevMTWF.png?raw=true)

Using that **workflow** and the **translation engine** created in the previous step, you can start a new project like this:

![CreateMTProject](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevCreateMTAppProject.gif?raw=true)

When the project reaches **Translation**, you can open it in the **Online Editor** and check the target segments. This is where you should find the translations performed by your app in the **Machine Translation** step. You can also search for Lookups to obtain alternative translations. This will invoke again the `lc.mtprovider.translate` endpoint.

![MTLookUp](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/MTAppOELookup.gif?raw=true)

You can find more details on how to use an MT app in the [consumer guide](../consumer/MT-App-consumer-guide.md).

The blueprints contain placeholders from where you can start implementing the endpoint's functionality:

- [.NET blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/dotNetAppBlueprint/Rws.LC.AppBlueprint/Controllers/TranslationController.cs#L35)
- [Java blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppBlueprint/src/main/java/com/rws/lt/lc/blueprint/web/TranslateController.java#L22)

Please refer to the endpoint's [documentation](../../App-API.v1.json/paths/~1lc.mtprovider.translate/post) for further details.
