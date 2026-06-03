# Trados Cloud Platform API Delete Termbase

Delete Termbase DeleteTermbase DELETE /termbases/{termbaseId}

- Friendly name: Delete Termbase
- Operation ID: DeleteTermbase
- HTTP Method: DELETE
- Path: /termbases/{termbaseId}

Deletes a termbase by identifier.

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
* "forbidden": the authenticated user is not allowed to delete the termbase
* "benefitNotAvailable": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the termbase could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidStatus": The termbase cannot be deleted as is currently being processed.

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
Task DeleteTermbaseAsync(string termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |

### Java — `TermbaseApi`

```java
// DELETE /termbases/{termbaseId}
void deleteTermbase(String termbaseId);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |