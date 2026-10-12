# Trados Cloud Platform API Poll Termbase Import

Poll Termbase Import PollTermbaseImport GET /termbases/{termbaseId}/imports/{importId}

- Friendly name: Poll Termbase Import
- Operation ID: PollTermbaseImport
- HTTP Method: GET
- Path: /termbases/{termbaseId}/imports/{importId}

Polls a termbase import operation.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 200

OK

- Content: application/json
- Schema: termbase-poll-import-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to read entry.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

### 404

Error codes:
* "notFound": the resource could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: termbase-poll-import-response
<a id="termbase-poll-import-response"></a>

```
type: object
  description: The termbase poll import response.<br>
The import was successfully processed when the status is `done`.
properties:
  - id: type: string
  - status: type: string enum: [queued, processing, done, cancelled, failed, error]
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

### .NET — `ITermbaseImportClient`

```csharp
Task PollTermbaseImportAsync(string termbaseId, string importId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `importId` | `string` | yes |

### Java — `TermbaseImportApi`

```java
// GET /termbases/{termbaseId}/imports/{importId}
TermbasePollImportResponse pollTermbaseImport(String termbaseId, String importId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `importId` | `String` | yes |