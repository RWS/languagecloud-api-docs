# Trados Cloud Platform API Update Termbase

Update Termbase UpdateTermbase PUT /termbases/{termbaseId}

- Friendly name: Update Termbase
- Operation ID: UpdateTermbase
- HTTP Method: PUT
- Path: /termbases/{termbaseId}

Updates the termbase.
The termbase can be updated with a termbase template by providing the termbaseTemplateId or by providing a custom termbaseStructure. 

If only a `termbaseTemplateId ` was provided, the termbase will be updated using data from the template. 
If only a `termbaseStructure` was provided, the termbase will be updated using data from the structure. 
If both, `termbaseTemplateId` and `termbaseStructure` are added in the request, the `termbaseStructure` takes precedence.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: termbase-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the “name” field on the error response.
* "empty": Empty mandatory value mentioned in the "name" field on the error response.
* "maxSize": Maximum size exceeded for the value mentioned in the "name" field on the error response.
* "duplicate": The field name must be unique within the list.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to update the termbase.
* "benefitNotAvailable": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": - The specified termbase identifier was not found.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": There is already a termbase with the same name.
* "invalidStatus": The termbase cannot be updated as is currently being processed.

- Content: application/json
- Schema: error-response (see model section below)


## Model: termbase-update-request
<a id="termbase-update-request"></a>

```
type: object
  description: Termbase update request.
properties:
  - name: type: string
  - description: type: string
  - copyright: type: string
  - termbaseTemplateId: type: string
  - termbaseStructure: $ref: #/components/schemas/termbase-structure-update-request
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

## Model: termbase-structure-update-request
<a id="termbase-structure-update-request"></a>

```
type: object
  description: The termbase structure update request.
properties:
  - languages: type: array
    items:
      $ref: #/components/schemas/language-request
  - fields: type: array
    items:
      $ref: #/components/schemas/termbase-field-update-request
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

## Model: termbase-field-update-request
<a id="termbase-field-update-request"></a>

```
type: object
  description: The termbase field update request.

If dataType is `picklist` and pickListValues array is empty `allowCustomValues` must be true.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - level: type: string enum: [entry, language, term]
  - dataType: type: string enum: [text, double, date, picklist, boolean]
  - pickListValues: type: array
    items:
      type: string
  - allowCustomValues: type: boolean
  - allowMultiple: type: boolean
  - isMandatory: type: boolean
```

## SDK

### .NET — `ITermbaseClient`

```csharp
Task UpdateTermbaseAsync(string termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |

### Java — `TermbaseApi`

```java
// PUT /termbases/{termbaseId}
void updateTermbase(String termbaseId, TermbaseUpdateRequest termbaseUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `termbaseUpdateRequest` | `TermbaseUpdateRequest` | no |