# Quotes: update and export

Update a project quote through the `quote` field of `PUT /projects/{projectId}`, and export a quote report as PDF or Excel.

## Update quote

`PUT` [UpdateProject](../reference/UpdateProject.md) with the `quote` field.

Two cost groups:
- **Language costs** (`languageCosts`): per language; types volume, percentage, hourly, perPage, conditional. `targetLanguage` is **required**.
- **Project costs**: project-level additional costs; types volume, percentage, hourly, perPage, conditional, perFile, perTargetLanguage.

Language and project costs have identical request/response bodies (except the `targetLanguage` requirement).

### Cost types

All examples assume translation cost 85.4 (854 words, rate 0.1) for `fr-FR`; `runningTotal` carries across costs by `costOrder`.

| `costType` | Request fields (as in docs example) | Formula | Type availability |
|---|---|---|---|
| `volume` | `name`, `costOrder`, `cost`, `volumeUnitType` (e.g. `Words`) | `total = count * cost` (count = words/characters) | language + project |
| `percentage` | `name`, `costOrder`, `count` (percent, may be negative) | `total = count% * previousRunningTotal` | language + project |
| `hourly` | `name`, `costOrder`, `count` (hours), `cost` | `total = count * cost` | language + project |
| `perPage` | `name`, `costOrder`, `count` (pages), `cost` | `total = count * cost` | language + project |
| `conditional` | `name`, `costOrder`, `conditionalCostVariable`, `conditionalCostOperator`, `conditionalCostThreshold`, `cost`, `conditionalCostType` | See below | language + project |
| `perTargetLanguage` | `name`, `costOrder`, `cost` | `total = (number of target languages) * cost` | project only |
| `perFile` | `name`, `costOrder`, `cost` | `total = (number of files) * cost` | project only |

`runningTotal = previous runningTotal + total` (the first additional cost adds to the translation costs).

Volume example (request then response):

```json
{ "name": "Volume Cost", "costOrder": 0, "cost": 0.5, "volumeUnitType": "Words", "costType": "volume" }
```

```json
{ "name": "Volume Cost", "count": 854.0, "total": 427.0, "cost": 0.5, "costType": "volume",
  "volumeUnitType": "words", "costOrder": 0, "runningTotal": 512.4 }
```

Chained example: 85.4 + 427 = 512.4; percentage -10 gives `total = -10% * 512.4 = -51.24`, `runningTotal = 461.16`; hourly (5 h at 1.5) gives 7.5 -> 468.66; perPage (10 at 0.2) gives 2 -> 470.66; conditional gives 100 -> 570.66; perTargetLanguage (1 at 5) -> 575.66; perFile (2 at 3) gives 6 -> 581.66.

### Conditional cost

Request:

```json
{ "name": "Conditional Cost", "costOrder": 4, "conditionalCostVariable": "wordCount",
  "conditionalCostOperator": "less", "conditionalCostThreshold": 1000,
  "cost": 100, "conditionalCostType": "relative", "costType": "conditional" }
```

Reads as: if `[conditionalCostVariable] [conditionalCostOperator] [conditionalCostThreshold]` then add/set `[cost]` `[conditionalCostType]`. Example: if `wordCount < 1000` (854 < 1000 = true) then add 100 relative.

| Condition result | `conditionalCostType` | `total` | `runningTotal` (previous 470.66) |
|---|---|---|---|
| true | `relative` | `cost` = 100 | 570.66 |
| false | any | 0 | unchanged (470.66) |
| true | `percentage` (cost 100) | `100% * 470.66 = 470.66` | 941.32 |
| true | `absolute` (cost 100) | `100 - 470.66 = -370.66` | 100 |

`absolute` cancels all previous costs for the project or target language.

### Cost order

`costOrder` defines calculation order; each cost uses the previous running total. Swapping order changes percentage results: with percentage `costOrder` 0 on translation cost 85.4: `total = -10% * 85.4 = -8.54`, `runningTotal = 76.86`; then volume (`costOrder` 1) gives 427 -> 503.86 (versus 461.16 when volume goes first).

## Export quote report

Three endpoints, called in this order:

1. [ExportQuoteReport](../reference/ExportQuoteReport.md) `POST /projects/{projectId}/quote-report/export` -> Accepted.
2. [PollQuoteReportExport](../reference/PollQuoteReportExport.md) `GET /projects/{projectId}/quote-report/export` -> wait for status `completed`.
3. [DownloadQuoteReport](../reference/DownloadQuoteReport.md) `GET /projects/{projectId}/quote-report/download`.

| Option | Query parameter | Values | Default |
|---|---|---|---|
| Format | `format` | PDF, Excel | PDF |
| Language | `languageId` | `en`, `de`, `fr`, `fr-CA`, `ja`, `es`, `zh-CN`, `nl`, `it` | - |

Notes:
- Download is one-time; the file is deleted after a download attempt (re-export to download again).
- Without a Quote Template the export response is empty.
- Rate limit: ExportQuoteReport (see [rate-limits.md](./rate-limits.md)).
- The old export quote endpoint is deprecated.

## Related

- Async pattern: [async-polling.md](./async-polling.md)
- PUT merge behaviour: [put-semantics.md](./put-semantics.md)
