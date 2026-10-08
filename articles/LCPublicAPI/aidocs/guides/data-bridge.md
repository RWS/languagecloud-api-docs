# Trados Data Bridge (Data API)

Read-only OData v4 API for analytical data (projects, tasks, costs, leverage, evaluation); same authentication as the Public API, plus a daily data-volume quota.

Reference: `../../api/Data-Bridge-API.v1-fv.html`. Host per region: see the base URL in the contract and [multi-region.md](./multi-region.md).

## Authentication and limits

- Same mechanism as the Public API: service user, application, client credentials token, `Authorization: Bearer` and `X-LC-Tenant` ([auth.md](./auth.md)).
- `{{lc_tenant}}` is the account ID, for example `LC-00000000000000000`.
- Same rate limits as the Public API ([rate-limits.md](./rate-limits.md)).
- Additional daily data transfer quota, measured by data volume retrieved (not request count):

| Region | Quota reset |
|---|---|
| Europe | midnight UTC |
| Canada | midnight EST |

Requests exceeding the quota return HTTP **429** until the reset time.

## Data availability

- Most data becomes available after the **Analysis** workflow task completes.
- Revenue data requires **Quote Generation** task completion.
- Some metrics update in real time as workflow tasks complete.

## Query options

| Parameter | Purpose | Example |
|---|---|---|
| `$filter` | Filter by condition | `$filter=revenue gt 1000` |
| `$select` | Choose returned fields | `$select=projectId,projectStatus,revenue` |
| `$expand` | Include related entities | `$expand=project,customer` |
| `$orderby` | Sort | `$orderby=projectCreationDate desc` |
| `$top` | Limit result count | `$top=50` |
| `$skip` | Skip results | `$skip=100` |

### `$filter` operators and functions

| Kind | Items |
|---|---|
| Comparison | `eq`, `ne`, `gt`, `ge`, `lt`, `le` |
| Logical | `and`, `or`, `not` |
| Grouping | parentheses, e.g. `(projectShortId lt 16867 and projectShortId gt 16800) and projectStatus eq 'completed'` |
| String | `contains(projectName,'Marketing')`, `startswith(customerName,'ABC')`, `endswith(fileName,'.docx')` |
| Date | `year(projectCreationDate) eq 2024`, `month(approveDate) eq 3`, `day(completionDate) eq 15` |

### Paging

| Setting | Value |
|---|---|
| Default page size (no `$top`) | 500 |
| Maximum page size | 5,000 |

```
$filter=revenue gt 1000&$top=25&$skip=0&$orderby=revenue desc
```

Recommendations from the docs: filter to reduce response size (date ranges, status), use `$select`, expand only when necessary, paginate with `$top` and `$skip`.

## Data sets and dimensions (`$expand`)

| Data set | Content | Available after | Dimensions |
|---|---|---|---|
| File Translation Status | One entry per target file; human workflow data (source words, pre-translated words and distribution, human-translated and human-reviewed words, total workflow duration); missing workflow steps are null | Analysis task | `project`, `customer`, `languagePair`, `sourceFile`, `projectCreationDate`, `translationDate`, `translator`, `reviewDate`, `reviewer`, `customerReviewDate`, `customerReviewer`, `finalizationDate` |
| Language Revenue Details | Costs per project and language direction: total revenue, number of units that generated revenue | Customer Quote Generation task | `quoteDate`, `customer`, `project`, `languagePair`, `revenueType`, `currency`, `projectCreationDate` |
| Language Revenue | Costs per language direction: translation cost per target language, additional cost per target language and per project, total cost, source words and files per source language, discounts | Customer Quote Generation task | `customer`, `project`, `languagePair`, `approveDate`, `currency`, `quoteApprover`, `quoteDate` |
| Task Status | Per-task metrics: actual, estimated and delivery duration, word count | Analysis task; updated on each workflow task completion | `project`, `customer`, `taskType`, `taskState`, `languagePair`, `sourceFile`, `taskOwner` |
| Translation Leverage | File-level words per leverage bucket from automated translation | Analysis task | `translationDate`, `customer`, `project`, `languagePair`, `sourceFile`, `leverageBand` |
| Translation Quality Evaluation | Smart Review and MTQE (Evolve) evaluation across all project segments; no per-segment data | not stated | `project`, `customer`, `linguist`, `originalTranslationOrigin`, `finalTranslationOrigin`, `taskType`, `languagePair`, `sourceFile`, `translationQualityEvaluationCategory` |
| Vendor Cost | Vendor costs per project and language direction | Vendor Quote Generation task | `project`, `customer`, `languagePair`, `vendorOrderTemplate`, `serviceType`, `currency` |

## Postman

Collection: `https://github.com/sdl/language-cloud-public-api-postman/blob/develop/postmanDataCollection.json?raw=true`. Import via Link, Raw Text or File. Set `{{lc_tenant}}` with the `LC-` prefix. Run **Obtain a client credentials access token** in the `Authentication (Start Here)` folder to populate `{{lc-access-token}}`. Do not send Postman default query parameter values; invalid data returns an API error. See [api-clients.md](./api-clients.md).
