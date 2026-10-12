# Trados Cloud Platform API Update Termbase Template

Update Termbase Template UpdateTermbaseTemplate PUT /termbase-templates/{termbaseTemplateId}

- Friendly name: Update Termbase Template
- Operation ID: UpdateTermbaseTemplate
- HTTP Method: PUT
- Path: /termbase-templates/{termbaseTemplateId}

Updates the termbase template.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

- Schema: termbase-template-update-request (see model section below)

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
* "forbidden": - The authenticated user is not allowed to update the termbase template.
* "benefitNotAvailable": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "duplicate": There is already a termbase template with the same name.
* "conflict": cannot update system termbase template

- Content: application/json
- Schema: error-response (see model section below)


## Model: termbase-template-update-request
<a id="termbase-template-update-request"></a>

```
type: object
  description: The termbase template update request.
properties:
  - name: type: string
  - description: type: string
  - copyright: type: string
  - languages: type: array
    items:
      $ref: #/components/schemas/language-request
  - fields: type: array
    items:
      $ref: #/components/schemas/termbase-field-update-request
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

### .NET — `ITermbaseTemplateClient`

```csharp
Task UpdateTermbaseTemplateAsync(string termbaseTemplateId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseTemplateId` | `string` | yes |

### Java — `TermbaseTemplateApi`

```java
// PUT /termbase-templates/{termbaseTemplateId}
void updateTermbaseTemplate(String termbaseTemplateId, TermbaseTemplateUpdateRequest termbaseTemplateUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseTemplateId` | `String` | yes |
| `termbaseTemplateUpdateRequest` | `TermbaseTemplateUpdateRequest` | no |