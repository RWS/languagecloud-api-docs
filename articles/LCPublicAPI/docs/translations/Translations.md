# Translation API

The Translation API provides endpoints for performing translation operations using translation engines. These endpoints allow you to lookup translations, perform concordance searches, and manage translation units within your translation memories.

## Overview

The Translation API enables you to:
- **Lookup translations** for text or BCM fragments using translation memories and machine translation
- **Perform concordance searches** to find similar segments within translation memories
- **Add new translation units** to translation memories
- **Update existing translation units** in translation memories

All translation operations require a translation engine that defines which translation memories, machine translation engines, and termbases to use for the translation process.

> [!NOTE]
> The BCM fragment format is used for input and output as JSON string, meaning that you will need to serialize and deserialize the BCM fragments when sending requests or processing responses. For .NET you can use the `Sdl.Core.Bcm.API` [nuget package](https://www.nuget.org/packages/Sdl.Core.Bcm.API).

## Endpoints

### Translation Lookup

[`POST /translations/lookup`](../../api/Public-API.v1-fv.html#/operations/TranslationsLookup)

Translates a phrase in plain text or a BCM fragment containing a single segment. The translated content will be returned as a [BCM fragment](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html) or [term](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Skeleton.Term.html).

**Use cases:**
- Get translation suggestions for a source segment
- Retrieve matches from translation memories
- Get machine translation proposals
- Access termbase entries for specific terms

**Key features:**
- Supports both plain text and BCM fragment input
- Returns translations from multiple resource types (TM, MT, TB)
- Configurable match thresholds and penalties

**Request body example:**
```json
{
  "input": {
    "content": "Hello world",
    "contentType": "text"
  },
  "languageDirection": {
    "sourceLanguage": { 
        "languageCode": "en-US" 
    },
    "targetLanguage": { 
        "languageCode": "fr-FR" 
    }
  },
  "definition": {
    "translationEngineId": "your-translation-engine-id"
  },
  "settings": {
    "translationMemory": {
      "minimumMatchValue": 70,
      "penalties": {
        "standardPenalties": {
          "missingFormatting": 1,
          "differentFormatting": 1
        }
      }
    }
  }
}
```

> [!NOTE]
> The `translationProposal` field in the response can be either a BCM fragment or a term. You can rely on the `responseType` field to determine the content type and deserialize it accordingly.

### Concordance Search

[`POST /translations/concordance`](../../api/Public-API.v1-fv.html#/operations/TranslationsConcordanceSearch)

Performs a concordance search for a given text within the translation memories linked to the specified translation engine. This helps you find segments that contain specific words or phrases.

**Use cases:**
- Research how certain phrases have been translated previously
- Quality assurance and consistency checking
- Translation memory analysis

**Key features:**
- Search within source or target segments
- Support for exact and fuzzy matching
- Configurable search parameters and penalties
- Returns matching segments with context

> [!NOTE]
> The Translation Memory penalty defined in the Translation Engine will be automatically included in the translation score.

**Request body example:**
```json
{
  "input": {
    "content": "user interface"
  },
  "languageDirection": {
    "sourceLanguage": { 
        "languageCode": "en-US" 
    },
    "targetLanguage": { 
        "languageCode": "fr-FR" 
    }
  },
  "definition": {
      "translationEngineId": "your-translation-engine-id"
  },
  "targetOnly": false,
  "settings": {
    "translationMemory": {
      "minimumMatchValue": 80
    }
  }
}
```

### Translation Unit Management

#### Update Translation Unit

[`PUT /translations/translation-unit`](../../api/Public-API.v1-fv.html#/operations/TranslationsUpdate)

Updates an existing translation unit in the translation memories. The system identifies matching translation units based on the `originalTranslationHash` provided in the BCM fragment.

> [!NOTE]
> After each update the `targetContent.translationOrigin.originalTranslationHash` is updated. The new values are returned in the response on the `translationHash` field.
> Subsequent updates can be performed by updating the `targetContent.translationOrigin.originalTranslationHash` in the BCM fragment with the new `translationHash`, otherwise the system will add a new translation unit instead of updating the existing one.

> [!WARNING]
> Changing any fields in the `sourceContent` of a BCM fragment will result in a new translation unit being added instead of updating the existing one.

**Use cases:**
- Correct existing translations
- Update translation metadata
- Modify translation unit fields
- Maintain translation memory quality

**Key features:**
- Smart matching of existing translation units
- Preserve or update translation metadata
- Configurable update behavior
- Support for custom fields

**Request body example for both add and update:**
```json
{
  "input": {
    "content": "BCM fragment"
  },
  "definition": {
    "translationEngineId": "your-translation-engine-id"
  },
  "settings": {
    "fields": [
      {
        "name": "field-name",
        "values": [ "field-value" ]
      }
    ]
  }
}
```

#### Add Translation Unit

[`POST /translations/translation-unit`](../../api/Public-API.v1-fv.html#/operations/TranslationsAdd)

Adds a new translation unit to the translation memories.

**Use cases:**
- Add new translations units whose existence in the translation memory is unknown
- If, however, the translation unit with the same source already exists, it will be updated based on the `ifTargetSegmentsDiffer` field
- Populate translation memories with approved content

**Key features:**
- Automatic duplicate handling
- Field template support for metadata
- Configurable behavior for existing translations
- BCM fragment support for rich content

## BCM Fragments

Many Translation API endpoints work with BCM (Binary Content Model) fragments. BCM is RWS's content model that preserves formatting, tags, and metadata within translation content.

**BCM advantages:**
- Preserves inline formatting and tags
- Maintains content structure during translation
- Supports complex document elements
- Enables accurate translation memory matching

For more information about BCM fragments, see the [BCM documentation](https://developers.rws.com/languagecloud-api-docs/api/bcm/Sdl.Core.Bcm.BcmModel.Fragment.html).

Example of a BCM fragment:
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
			{
				"id": "c0cff9db-46e4-493d-b578-25e78d578ea7",
				"placeholderTagDefinitionId": 1,
				"tagNumber": "50",
				"type": "placeholderTag",
				"metadata": {
					"SDL:IsSoftBreak": "True",
					"SpecialCharacterPlaceholder": "â€Ś",
					"frameworkOriginalTagId": "50",
					"SDL:IsWordStop": "False"
				}
			},
			{
				"id": "4b5cbfc4-53b1-462c-86a4-dbc061b5f266",
				"text": "This is a sample text",
				"type": "text"
			}
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
			"originalTranslationHash": "-377851791",
			"createdBy": "some-user-id",
			"createdOn": "2023-09-25T14:24:04.000Z",
			"modifiedBy": "some-user-id",
			"modifiedOn": "2025-02-12T09:25:57.000Z",
			"metadata": {
				"used_on": "04/01/2025 13:56:28",
				"used_by": "some-user-id",
				"use_count": "8"
			}
		},
		"type": "segment",
		"metadata": {
			"Contexts": [
				{
					"Context1": 0,
					"Context2": 0,
					"Segment1": null,
					"Segment2": null,
					"LeftSource": 0,
					"LeftTarget": 0
				}
			]
		},
		"children": [
			{
				"id": "6143602c-5548-43d0-a2fc-1a5a7f2aeb35",
				"text": "Ceci est un exemple de texte",
				"type": "text"
			}
		]
	}
}
```

## Translation Memory Penalties

The Translation API supports various penalty types to fine-tune translation matching:

### Standard Penalties
- **Missing Formatting**: Penalty for matches missing formatting tags
- **Different Formatting**: Penalty for matches with different formatting
- **Multiple Translations**: Penalty for segments with multiple translation options

### Translation Unit Status Penalties
- **Translated**: Penalty for translated but not reviewed segments
- **Approved Translation**: Penalty for approved translations
- **Rejected Translation**: Penalty for rejected translations

Learn more about [Translation Memory penalties](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/trados-tm-penalties-1159224) and [Translation Unit status penalties](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/editing-project-tm-and-verification-settings-800732).

## Best Practices

### Performance Optimization
- Set appropriate minimum match values to reduce processing time
- Use reasonable penalty values to balance quality and performance

### Quality Management
- Configure penalties based on your quality requirements
- Regularly update translation units to maintain accuracy

### Translation Memory Maintenance
- Add high-quality translations to build reliable TMs
- Update outdated translations to keep content current
- Use appropriate field templates for metadata management

## Related APIs

- **[Translation Memory API](../translation-memory/Translation-memory-import-export.md)**: Bulk import/export of translation memories
- **[Translation Engine API](../../api/Public-API.v1-fv.html#/operations/UpdateTranslationEngine)**: Manage translation engine configurations
- **[Termbase API](../termbase/Termbase.md)**: Manage terminology resources

## Examples and Use Cases

### Building a Translation Workflow

1. **Setup**: Configure translation engine with TMs, MT, and termbases
2. **Lookup**: Use `/translations/lookup` for translation suggestions
3. **Research**: Use `/translations/concordance` for plain text research  
4. **Quality**: Add/update translation units with the updated BCM fragments retrieved from the previous requests to improve TM quality
5. **Maintenance**: Regular TM updates and quality checks
