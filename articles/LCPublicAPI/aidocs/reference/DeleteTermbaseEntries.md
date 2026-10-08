# Trados Cloud Platform API Delete Termbase Entries

Delete Termbase Entries DeleteTermbaseEntries DELETE /termbases/{termbaseId}/entries

- Friendly name: Delete Termbase Entries
- Operation ID: DeleteTermbaseEntries
- HTTP Method: DELETE
- Path: /termbases/{termbaseId}/entries

Deletes all the entries in the termbase.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

No request body.

## Response

### 204

No Content

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": - The authenticated user is not allowed to delete an entry.
* "entitlementMissing": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)


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

### .NET — `ITermbaseClient`

```csharp
Task DeleteTermbaseEntriesAsync(string termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |

### Java — `TermbaseApi`

```java
// DELETE /termbases/{termbaseId}/entries
void deleteTermbaseEntries(String termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |