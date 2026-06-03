# Trados Cloud Platform API Poll Translation Memory Import

Poll Translation Memory Import PollTMImport GET /translation-memory/imports/{importId}

- Friendly name: Poll Translation Memory Import
- Operation ID: PollTMImport
- HTTP Method: GET
- Path: /translation-memory/imports/{importId}

Polls a Translation Memory import operation. The import is finished when the status is `done`.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: translation-memory-import-poll-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the path parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to read the entry.

### 404

Error codes:
* "notFound": The resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-memory-import-poll-response
<a id="translation-memory-import-poll-response"></a>

```
type: object
properties:
  - id: type: string
  - status: type: string enum: [queued, inProgress, failed, done, cancelled]
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

### .NET — `ITranslationMemoryImportClient`

```csharp
Task PollTMImportAsync(string importId);
```

| Parameter | Type | Required |
|---|---|---|
| `importId` | `string` | yes |

### Java — `TranslationMemoryImportApi`

```java
// GET /translation-memory/imports/{importId}
TranslationMemoryImportPollResponse pollTMImport(String importId);
```

| Parameter | Type | Required |
|---|---|---|
| `importId` | `String` | yes |