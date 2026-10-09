# Translation API: lookup, concordance and translation units

Use a translation engine to look up translations, search concordance, and add or update translation units in its translation memories.

All operations require a translation engine (`definition.translationEngineId`) that defines the translation memories, machine translation engines and termbases to use. BCM fragments are exchanged as JSON strings: serialize/deserialize them in requests and responses. For .NET, the NuGet package `Sdl.Core.Bcm.API` can be used.

## Endpoints

| Operation | Endpoint | Purpose |
|---|---|---|
| [TranslationsLookup](../reference/TranslationsLookup.md) | `POST /translations/lookup` | Translate plain text or a BCM fragment with a single segment; returns TM, MT and termbase results |
| [TranslationsConcordanceSearch](../reference/TranslationsConcordanceSearch.md) | `POST /translations/concordance` | Find segments containing a word or phrase in the engine's translation memories |
| [TranslationsUpdate](../reference/TranslationsUpdate.md) | `PUT /translations/translation-unit` | Update an existing translation unit |
| [TranslationsAdd](../reference/TranslationsAdd.md) | `POST /translations/translation-unit` | Add a translation unit |

### Lookup request

```json
{
  "input": { "content": "Hello world", "contentType": "text" },
  "languageDirection": {
    "sourceLanguage": { "languageCode": "en-US" },
    "targetLanguage": { "languageCode": "fr-FR" }
  },
  "definition": { "translationEngineId": "your-translation-engine-id" },
  "settings": {
    "translationMemory": {
      "minimumMatchValue": 70,
      "penalties": { "standardPenalties": { "missingFormatting": 1, "differentFormatting": 1 } }
    }
  }
}
```

The response `translationProposal` is either a BCM fragment or a term. Use `responseType` to decide how to deserialize it.

### Concordance request

```json
{
  "input": { "content": "user interface" },
  "languageDirection": {
    "sourceLanguage": { "languageCode": "en-US" },
    "targetLanguage": { "languageCode": "fr-FR" }
  },
  "definition": { "translationEngineId": "your-translation-engine-id" },
  "targetOnly": false,
  "settings": { "translationMemory": { "minimumMatchValue": 80 } }
}
```

The Translation Memory penalty defined in the translation engine is automatically included in the translation score.

### Add and update request

Same body for both:

```json
{
  "input": { "content": "BCM fragment" },
  "definition": { "translationEngineId": "your-translation-engine-id" },
  "settings": { "fields": [ { "name": "field-name", "values": [ "field-value" ] } ] }
}
```

- Add: if a translation unit with the same source already exists, it is updated according to the `ifTargetSegmentsDiffer` field.
- Update: the existing unit is matched using `targetContent.translationOrigin.originalTranslationHash` in the BCM fragment.

## Hash chaining on update

After each update, `targetContent.translationOrigin.originalTranslationHash` changes; the new value is returned in the response field `translationHash`. For the next update, set `originalTranslationHash` to that `translationHash`; otherwise a new translation unit is added instead of updating the existing one.

Changing any field in `sourceContent` also results in a new translation unit being added instead of an update.

## BCM fragment structure (example, abbreviated)

```json
{
	"sourceLanguageCode": "en-US",
	"targetLanguageCode": "fr-FR",
	"sourceContent": {
		"id": "166fbfdd-8e0a-46aa-97bf-7b2b62014e5f",
		"segmentNumber": "1",
		"confirmationLevel": "Translated",
		"type": "segment",
		"children": [
			{ "id": "4b5cbfc4-53b1-462c-86a4-dbc061b5f266", "text": "This is a sample text", "type": "text" }
		]
	},
	"targetContent": {
		"id": "166fbfdd-8e0a-46aa-97bf-7b2b62014e5f",
		"segmentNumber": "1",
		"confirmationLevel": "Translated",
		"translationOrigin": {
			"originType": "tm",
			"originSystem": "Example TM",
			"matchPercent": 92,
			"textContextMatchLevel": "None",
			"originalTranslationHash": "-377851791"
		},
		"type": "segment",
		"children": [
			{ "id": "6143602c-5548-43d0-a2fc-1a5a7f2aeb35", "text": "Ceci est un exemple de texte", "type": "text" }
		]
	}
}
```

Node `type` values in the example: `segment`, `text`, `placeholderTag`. BCM reference: `https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html`.

## Penalties

| Group | Types |
|---|---|
| Standard | Missing Formatting, Different Formatting, Multiple Translations |
| Translation unit status | Translated, Approved Translation, Rejected Translation |

Lookup request field example: `settings.translationMemory.penalties.standardPenalties.missingFormatting`.

## Related

- TM bulk import/export: [translation-memory.md](./translation-memory.md)
- Terminology: [termbases.md](./termbases.md)
- File format background (BCM): [file-formats.md](./file-formats.md)
