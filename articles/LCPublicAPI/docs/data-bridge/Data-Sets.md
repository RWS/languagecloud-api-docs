---
stoplight-id: w743d2ir4w8v6
---

# Data Sets

## File Translation Status

This data source shows an entry for each target file in the system, as well as tabular data about the human workflow. The data about translation and review workflow steps is displayed on one line. If the workflow does not contain all the steps, the columns reserved for them show null placeholders.

The metrics included in this data source are:
- Total number of source words
- Total number of words translated in the pre-translated task (and their distribution)
- Total number of human-translated words
- Total number of human-reviewed words
- Total workflow duration (from project creation to finalization)
The data for the File Translation Status data source becomes available after the Analysis workflow task has been completed.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/FTSExpand.gif?raw=true)

### You have the possibility to expand the File Translation Status Data Set with the following dimensions:
- project
- customer
- languagePair
- sourceFile
- projectCreationDate
- translationDate
- translator
- reviewDate
- reviewer
- customerReviewDate
- customerReviewer
- finalizationDate

## Language Revenue Details

This data source shows the costs of each project per language direction.

The metrics included in the data source are:
- Total revenue
- Total number of units that generated revenue
The data for the Language Revenue Details data source becomes available after the Customer Quote Generation task has been completed.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/LRDExpand.gif?raw=true)

### You have the possibility to expand the Language Revenue Details Data Set with the following dimensions:
- quoteDate
- customer
- project
- languagePair
- revenueType
- currency
- projectCreationDate

## Language Revenue

This data source shows the costs of each language direction.

The metrics included in this data source are:
- Translation cost per target language
- Additional cost per target languages
- Additional cost per project
- Total cost
- Total number of source words per source language
- Total number of files per source language
- Discounts
The data for the Language Revenues data source becomes available after the Customer Quote Generation task has been completed.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/LRExpand.gif?raw=true)

### You have the possibility to expand the Language Revenue Data Set with the following dimensions:
- customer
- project
- languagePair
- approveDate
- currency
- quoteApprover
- quoteDate

## Task Status

This data source shows metrics for each task executed in the system.

The metrics included in this data source are:
- Actual duration
- Estimated duration
- Delivery duration
- Word count
The data for the Task Status data source becomes available after the Analysis workflow task has been completed and is updated every time a workflow task is completed.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/TSExpand.gif?raw=true)

### You have the possibility to expand the Task Status Data Set with the following dimensions:
- project
- customer
- taskType
- taskState
- languagePair
- sourceFile
- taskOwner

## Translation Leverage

This data source shows information about the translation leverage metrics obtained as a result of automated translation. The data source exposes file-level metrics detailing the number of words for each leverage bucket.

The data for the Translation Leverage data source becomes available after the Analysis workflow task has been completed.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/TLExpand.gif?raw=true)

### You have the possibility to expand the Translation Leverage Data Set with the following dimensions:
- translationDate
- customer
- project
- languagePair
- sourceFile
- leverageBand

## Translation Quality Evaluation

This data source shows details about the evaluation done with Smart Review and MTQE (Evolve) in a project. This data source takes into account all project segments, and does not currently provide information for individual segments.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/TQEExpand.gif?raw=true)

### You have the possibility to expand the Translation Quality Evaluation Data Set with the following dimensions:
- project
- customer
- linguist
- originalTranslationOrigin
- finalTranslationOrigin
- taskType
- languagePair
- sourceFile
- translationQualityEvaluationCategory

## Vendor Cost

This data source shows metrics about the costs associated with each vendor for each project and language direction.

The data for the Vendor Cost data source becomes available after the Vendor Quote Generation task has been completed.

![List custom fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/VCExpand.gif?raw=true)

### You have the possibility to expand the Vendor Cost Data Set with the following dimensions:
- project
- customer
- languagePair
- vendorOrderTemplate
- serviceType
- currency


