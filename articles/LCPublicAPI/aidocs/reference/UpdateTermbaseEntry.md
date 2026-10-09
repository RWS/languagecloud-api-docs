# Trados Cloud Platform API Update Termbase Entry

Update Termbase Entry UpdateTermbaseEntry PUT /termbases/{termbaseId}/entries/{entryId}

- Friendly name: Update Termbase Entry
- Operation ID: UpdateTermbaseEntry
- HTTP Method: PUT
- Path: /termbases/{termbaseId}/entries/{entryId}

Updates a termbase entry by identifier.
The request body will overwrite the existing data.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: termbase-entry-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the “name” field on the error response.
* "empty": Empty mandatory value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to update the entry.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidStatus": The termbase cannot be updated as is currently being processed.
* "duplicate" : An entry with the same value already exists.


## Model: termbase-entry-update-request
<a id="termbase-entry-update-request"></a>

```
type: object
  description: The termbase entry update request.
properties:
  - humanReadableId: type: string
  - languages: type: array
    items:
      $ref: #/components/schemas/termbase-entry-language-update-request
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-update-request
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

## Model: termbase-entry-language-update-request
<a id="termbase-entry-language-update-request"></a>

```
type: object
  description: The termbase entry language update request.
properties:
  - id: type: string
  - language: $ref: #/components/schemas/language-request
  - terms: type: array
    items:
      $ref: #/components/schemas/termbase-entry-term-update-request
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-update-request
```

## Model: termbase-field-value-update-request
<a id="termbase-field-value-update-request"></a>

```
type: object
  description: The termbase field value update request.
properties:
  - id: type: string
  - name: type: string
  - termbaseFieldId: type: string
  - value: type: string
  - fieldValueLinks: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-link-update-request
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

## Model: language-request
<a id="language-request"></a>

```
type: object
properties:
  - languageCode: type: string
```

## Model: termbase-entry-term-update-request
<a id="termbase-entry-term-update-request"></a>

```
type: object
  description: The termbase entry term update request.
properties:
  - id: type: string
  - text: type: string
  - systemStatus: $ref: #/components/schemas/termbase-entry-term-system-status-request
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-update-request
```

## Model: termbase-field-value-link-update-request
<a id="termbase-field-value-link-update-request"></a>

```
type: object
  description: The field value link update request.
properties:
  - type: type: string enum: [term, entry, external]
  - value: type: string
```

## Model: termbase-entry-term-system-status-request
<a id="termbase-entry-term-system-status-request"></a>

```
type: string enum: [preferred, draft, inReview, deprecated, recommended, admitted, forbidden, rejected, superseded]
```

## SDK

### .NET — `ITermbaseClient`

```csharp
Task UpdateTermbaseEntryAsync(string termbaseId, string entryId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `entryId` | `string` | yes |

### Java — `TermbaseApi`

```java
// PUT /termbases/{termbaseId}/entries/{entryId}
void updateTermbaseEntry(String termbaseId, String entryId, TermbaseEntryUpdateRequest termbaseEntryUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `entryId` | `String` | yes |
| `termbaseEntryUpdateRequest` | `TermbaseEntryUpdateRequest` | no |