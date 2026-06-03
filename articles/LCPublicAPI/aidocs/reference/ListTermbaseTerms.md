# Trados Cloud Platform API List Termbase Terms

List Termbase Terms ListTermbaseTerms GET /termbases/{termbaseId}/terms/{sourceLanguageCode}

- Friendly name: List Termbase Terms
- Operation ID: ListTermbaseTerms
- HTTP Method: GET
- Path: /termbases/{termbaseId}/terms/{sourceLanguageCode}

Retrieves a list of all the terms of the termbase.
Search types:
- normal: Use normal search to look for terms that match the text exactly as entered.
- linguistic: Use linguistic search to look for terms that are similar to the search term. Linguistic search is based on stemming and other language-dependent aspects.
- fuzzy: Use fuzzy search to look for terms that are similar to the search term. Fuzzy search is more fault-tolerant than linguistic search.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **top** (query, integer) - optional: The number of items to include inside the page.
- **skip** (query, integer) - optional: The number of items that are skipped to reach the desired page.
- **search** (query, string) - optional: The text to search for.
- **searchType** (query, string) - optional: The type of the search performed.
- **targetLanguageCode** (query, string) - optional: The target language code used to list the terms.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: list-termbase-terms-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.
* "minSize": Minimum size exceeded for the value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to read the entries.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 416

Error codes:
* "requestedRangeNotSatisfiable":  The requested entity or one of it's dependencies attempted to retrieve data outside the allowed range. Skip+Top might be outside the supported range.

- Content: application/json
- Schema: error-response (see model section below)


## Model: list-termbase-terms-response
<a id="list-termbase-terms-response"></a>

```
type: object
  description: The list termbase terms response.
properties:
  - items: type: array
    items:
      $ref: #/components/schemas/termbase-term
  - itemCount: type: integer
```

## Model: error-response
<a id="error-response"></a>

```
type: object
  description: Error response properties.
properties:
  - message: type: string
  - errorCode: type: string
  - details: type: array
    items:
      $ref: #/components/schemas/error-detail-response
```

## Model: termbase-term
<a id="termbase-term"></a>

```
type: object
  description: The termbase term.
properties:
  - id: type: string
  - entryId: type: string
  - text: type: string
```

## Model: error-detail-response
<a id="error-detail-response"></a>

```
type: object
  description: Error detail response properties.
properties:
  - name: type: string
  - code: type: string
  - value: type: string
```

## SDK

### .NET — `ITermbaseClient`

```csharp
Task<ListTermbaseTermsResponse> ListTermbaseTermsAsync(string termbaseId, string sourceLanguageCode, int? top = null, int? skip = null, string search, SearchType? searchType = null, string targetLanguageCode);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `sourceLanguageCode` | `string` | yes |
| `top` | `int` | no |
| `skip` | `int` | no |
| `search` | `string` | yes |
| `searchType` | `SearchType` | no |
| `targetLanguageCode` | `string` | yes |

### Java — `TermbaseApi`

```java
// GET /termbases/{termbaseId}/terms/{sourceLanguageCode}?top={top}&skip={skip}&search={search}&searchType={searchType}&targetLanguageCode={targetLanguageCode}
ListTermbaseTermsResponse listTermbaseTerms(String termbaseId, String sourceLanguageCode, Integer top, Integer skip, String search, String searchType, String targetLanguageCode);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `sourceLanguageCode` | `String` | yes |
| `top` | `Integer` | no |
| `skip` | `Integer` | no |
| `search` | `String` | no |
| `searchType` | `String` | no |
| `targetLanguageCode` | `String` | no |