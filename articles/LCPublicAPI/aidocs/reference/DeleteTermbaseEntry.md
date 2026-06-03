# Trados Cloud Platform API Delete Termbase Entry

Delete Termbase Entry DeleteTermbaseEntry DELETE /termbases/{termbaseId}/entries/{entryId}

- Friendly name: Delete Termbase Entry
- Operation ID: DeleteTermbaseEntry
- HTTP Method: DELETE
- Path: /termbases/{termbaseId}/entries/{entryId}

Deletes a termbase entry.

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
* "forbidden": - The authenticated user is not allowed to delete the termbase entries.
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
Task DeleteTermbaseEntryAsync(string termbaseId, string entryId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `entryId` | `string` | yes |

### Java — `TermbaseApi`

```java
// DELETE /termbases/{termbaseId}/entries/{entryId}
void deleteTermbaseEntry(String termbaseId, String entryId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `entryId` | `String` | yes |