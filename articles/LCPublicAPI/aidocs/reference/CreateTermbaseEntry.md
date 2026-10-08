# Trados Cloud Platform API Create Termbase Entry

Create Termbase Entry CreateTermbaseEntry POST /termbases/{termbaseId}/entries

- Friendly name: Create Termbase Entry
- Operation ID: CreateTermbaseEntry
- HTTP Method: POST
- Path: /termbases/{termbaseId}/entries

Creates a new termbase entry. For more information about how to use `fieldValueLinks` see [`Create termbase entry`](../docs/termbase/Termbase-entries.html#creating-a-termbase-entry).

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

- Content: application/json

- Schema: termbase-entry-create-request (see model section below)

## Response

### 201

Created

- Content: application/json
- Schema: termbase-entry (see model section below)

### 400

Error codes:
* "invalid": Invalid input in the query parameter mentioned in the “name” field on the error response.
* "invalidLevel" : The termbaseFieldId is invalid for the current termbaseField type
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
* "forbidden": - The authenticated user is not allowed to create an entry.
* "benefitNotAvailable": - Your subscription does not include access to the requested type of benefit.

- Content: application/json
- Schema: error-response (see model section below)

### 409

Error codes:
* "invalidStatus": The termbase cannot be updated as is currently being processed.
* "duplicate" : An entry with the same value already exists.

- Content: application/json
- Schema: error-response (see model section below)


## Model: termbase-entry-create-request
<a id="termbase-entry-create-request"></a>

```
type: object
  description: The termbase entry create request.
properties:
  - humanReadableId: type: string
  - languages: type: array
    items:
      $ref: #/components/schemas/termbase-entry-language-create-request
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-create-request
```

## Model: termbase-entry
<a id="termbase-entry"></a>

```
type: object
  description: The termbase entry.
properties:
  - id: type: string
  - humanReadableId: type: string
  - languages: type: array
    items:
      $ref: #/components/schemas/termbase-entry-language
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value
  - createdAt: type: string (format: date-time)
  - createdBy: $ref: #/components/schemas/user
  - lastModifiedAt: type: string (format: date-time)
  - lastModifiedBy: $ref: #/components/schemas/user
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

## Model: termbase-entry-language-create-request
<a id="termbase-entry-language-create-request"></a>

```
type: object
  description: The termbase entry language create request.
properties:
  - language: $ref: #/components/schemas/language-request
  - terms: type: array
    items:
      $ref: #/components/schemas/termbase-term-create-request
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-create-request
```

## Model: termbase-field-value-create-request
<a id="termbase-field-value-create-request"></a>

```
type: object
  description: The termbase field value create request.
properties:
  - termbaseFieldId: type: string
  - value: type: string
  - fieldValueLinks: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-link-create-request
```

## Model: termbase-entry-language
<a id="termbase-entry-language"></a>

```
type: object
  description: The termbase entry language.
properties:
  - id: type: string
  - language: $ref: #/components/schemas/language
  - terms: type: array
    items:
      $ref: #/components/schemas/termbase-entry-term
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value
  - createdAt: type: string (format: date-time)
  - createdBy: $ref: #/components/schemas/user
  - lastModifiedAt: type: string (format: date-time)
  - lastModifedBy: $ref: #/components/schemas/user
```

## Model: termbase-field-value
<a id="termbase-field-value"></a>

```
type: object
  description: The termbase field value.
properties:
  - id: type: string
  - name: type: string
  - termbaseFieldId: type: string
  - value: type: string
  - fieldValueLinks: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-link
  - createdAt: type: string (format: date-time)
  - createdBy: $ref: #/components/schemas/user
  - lastModifiedAt: type: string (format: date-time)
  - lastModifiedBy: $ref: #/components/schemas/user
```

## Model: user
<a id="user"></a>

```
type: object
  description: User in the account.
properties:
  - id: type: string
  - description: type: string
  - email: type: string
  - name: type: string
  - firstName: type: string
  - lastName: type: string
  - anonymized: type: boolean
  - anonymizedUserName: type: string
  - account: $ref: #/components/schemas/account
  - location: $ref: #/components/schemas/folder-v2
  - groups: type: array
    items:
      $ref: #/components/schemas/group
  - userType: $ref: #/components/schemas/user-type
  - status: $ref: #/components/schemas/user-status
  - invitationLink: type: string
  - membership: $ref: #/components/schemas/account-membership-type
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
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

## Model: termbase-term-create-request
<a id="termbase-term-create-request"></a>

```
type: object
  description: The termbase entry term request.
properties:
  - text: type: string
  - systemStatus: $ref: #/components/schemas/termbase-entry-term-system-status-request
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value-create-request
```

## Model: termbase-field-value-link-create-request
<a id="termbase-field-value-link-create-request"></a>

```
type: object
  description: The field value link create request.
properties:
  - type: type: string enum: [term, entry, external]
  - value: type: string
```

## Model: language
<a id="language"></a>

```
type: object
  description: The language object.
properties:
  - languageCode: type: string
  - englishName: type: string
  - direction: type: string
  - parentLanguageCode: type: string
  - defaultSpecificLanguageCode: type: string
  - isNeutral: type: boolean
```

## Model: termbase-entry-term
<a id="termbase-entry-term"></a>

```
type: object
  description: The termbase entry term.
properties:
  - id: type: string
  - text: type: string
  - termbaseFieldValues: type: array
    items:
      $ref: #/components/schemas/termbase-field-value
  - createdAt: type: string (format: date-time)
  - createdBy: $ref: #/components/schemas/user
  - lastModifiedAt: type: string (format: date-time)
  - lastModifiedBy: $ref: #/components/schemas/user
  - systemStatus: $ref: #/components/schemas/termbase-entry-term-system-status
```

## Model: termbase-field-value-link
<a id="termbase-field-value-link"></a>

```
type: object
  description: The field value link.
properties:
  - type: type: string enum: [term, entry, external]
  - value: type: string
```

## Model: account
<a id="account"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
```

## Model: folder-v2
<a id="folder-v2"></a>

```
type: object
  description: Folder used for resource storage.
properties:
  - id: type: string
  - name: type: string
  - hasParent: type: boolean
  - path: type: array
    items:
      $ref: #/components/schemas/folder-path
```

## Model: group
<a id="group"></a>

```
type: object
  description: Group of Users.
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - users: type: array
    items:
      $ref: #/components/schemas/user
  - roles: type: array
    items:
      $ref: #/components/schemas/role
  - additionalRoles: type: array
    items:
      $ref: #/components/schemas/group-additional-roles
  - groupType: type: string enum: [default, custom, vendor, customer]
  - metadata: <schema>
      title: Metadata
      description: Additional metadata values in a key–value pair format
```

## Model: user-type
<a id="user-type"></a>

```
type: string enum: [user, serviceUser]
```

## Model: user-status
<a id="user-status"></a>

```
type: string enum: [inactive, active, deleted, provisioned]
```

## Model: account-membership-type
<a id="account-membership-type"></a>

```
type: string enum: [member, collaborator]
```

## Model: termbase-entry-term-system-status-request
<a id="termbase-entry-term-system-status-request"></a>

```
type: string enum: [preferred, draft, inReview, deprecated, recommended, admitted, forbidden, rejected, superseded]
```

## Model: termbase-entry-term-system-status
<a id="termbase-entry-term-system-status"></a>

```
type: string enum: [preferred, draft, inReview, deprecated, recommended, admitted, forbidden, rejected, superseded]
```

## Model: folder-path
<a id="folder-path"></a>

```
type: object
  description: Path of a folder.
properties:
  - id: type: string
  - name: type: string
  - location: type: string
  - hasParent: type: boolean
```

## Model: role
<a id="role"></a>

```
type: object
  description: Role in the account.
properties:
  - id: type: string
  - type: type: string enum: [provisioned, custom]
  - name: type: string
  - description: type: string
  - permissions: type: array
    items:
      $ref: #/components/schemas/permission
```

## Model: group-additional-roles
<a id="group-additional-roles"></a>

```
type: object
  description: Roles granted to the group in addition to the group location.
properties:
  - location: $ref: #/components/schemas/folder-v2
  - roles: type: array
    items:
      $ref: #/components/schemas/role
```

## Model: permission
<a id="permission"></a>

```
type: object
  description: A single permission which governs access to resources.
properties:
  - name: type: string
  - description: type: string
  - category: type: string
  - entityType: $ref: #/components/schemas/permission-entity-type
  - dependsOn: type: array
    items:
      type: string
```

## Model: permission-entity-type
<a id="permission-entity-type"></a>

```
type: object
  description: The entity type a permission applies to.
properties:
  - name: type: string
  - description: type: string
```

## SDK

### .NET — `ITermbaseClient`

```csharp
Task<TermbaseEntry> CreateTermbaseEntryAsync(string termbaseId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `string` | yes |
| `fields` | `string` | no |

### Java — `TermbaseApi`

```java
// POST /termbases/{termbaseId}/entries?fields={fields}
TermbaseEntry createTermbaseEntry(String termbaseId, String fields, TermbaseEntryCreateRequest termbaseEntryCreateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `termbaseId` | `String` | yes |
| `fields` | `String` | no |
| `termbaseEntryCreateRequest` | `TermbaseEntryCreateRequest` | no |