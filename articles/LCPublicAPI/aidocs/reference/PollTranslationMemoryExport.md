# Trados Cloud Platform API Poll Translation Memory Export

Poll Translation Memory Export PollTranslationMemoryExport GET /translation-memory/exports/{exportId}

- Friendly name: Poll Translation Memory Export
- Operation ID: PollTranslationMemoryExport
- HTTP Method: GET
- Path: /translation-memory/exports/{exportId}

Polls a translation memory via an export operation. The exported translation memory can be downloaded once the status is `done`.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: translation-memory-poll-export-response (see model section below)

### 400

Error codes:
* "invalid": Invalid `exportId` in the path parameters.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": The authenticated user is not allowed to read the resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": The resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-memory-poll-export-response
<a id="translation-memory-poll-export-response"></a>

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

### .NET — `ITranslationMemoryExportClient`

```csharp
Task PollTranslationMemoryExportAsync(string exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `exportId` | `string` | yes |

### Java — `TranslationMemoryExportApi`

```java
// GET /translation-memory/exports/{exportId}
TranslationMemoryPollExportResponse pollTranslationMemoryExport(String exportId);
```

| Parameter | Type | Required |
|---|---|---|
| `exportId` | `String` | yes |