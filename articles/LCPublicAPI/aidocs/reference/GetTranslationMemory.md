# Trados Cloud Platform API Get Translation Memory

Get Translation Memory GetTranslationMemory GET /translation-memory/{translationMemoryId}

- Friendly name: Get Translation Memory
- Operation ID: GetTranslationMemory
- HTTP Method: GET
- Path: /translation-memory/{translationMemoryId}

Get a single Translation Memory by identifier.

## Parameters

- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: translation-memory (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the query parameter mentioned in the “name” field on the error response.

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
* "notFound": The translation memory could not be found by identifier.

- Content: application/json
- Schema: error-response (see model section below)


## Model: translation-memory
<a id="translation-memory"></a>

```
type: object
  description: 
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - copyright: type: string
  - location: $ref: #/components/schemas/folder
  - languageDirections: type: array
    items:
      $ref: #/components/schemas/translation-memory-language-direction
  - languageProcessingRule: $ref: #/components/schemas/language-processing-rule
  - fieldTemplate: $ref: #/components/schemas/translation-memory-field-template
  - createdAt: type: string (format: date-time)
  - createdBy: $ref: #/components/schemas/user
  - lastRecomputedAt: type: string (format: date-time)
  - lastReIndexedAt: type: string (format: date-time)
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

## Model: folder
<a id="folder"></a>

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

## Model: translation-memory-language-direction
<a id="translation-memory-language-direction"></a>

```
type: object
  description: A language direction representation specific to translation memories.
properties:
  - languageDirection: $ref: #/components/schemas/simple-language-direction
  - translationUnits: type: integer
  - unalignedTranslationUnits: type: integer
```

## Model: language-processing-rule
<a id="language-processing-rule"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
```

## Model: translation-memory-field-template
<a id="translation-memory-field-template"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - location: $ref: #/components/schemas/folder-v2
  - fieldDefinitions: type: array
    items:
      $ref: #/components/schemas/translation-memory-field
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

## Model: simple-language-direction
<a id="simple-language-direction"></a>

```
type: object
  description: A basic language direction.
properties:
  - id: type: string
  - sourceLanguage: $ref: #/components/schemas/language
  - targetLanguage: $ref: #/components/schemas/language
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

## Model: translation-memory-field
<a id="translation-memory-field"></a>

```
type: object
  description: The unique identifier of the field.
properties:
  - id: type: string
  - name: type: string
  - type: type: string enum: [unknown, singleString, multipleString, dateTime, singlePicklist, multiplePicklist, integer]
  - values: type: array
    items:
      $ref: #/components/schemas/translation-memory-field-value
```

## Model: account
<a id="account"></a>

```
type: object
properties:
  - id: type: string
  - name: type: string
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

## Model: translation-memory-field-value
<a id="translation-memory-field-value"></a>

```
type: object
properties:
  - id: type: string
  - value: type: string
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

### .NET — `ITranslationMemoryClient`

```csharp
Task<TranslationMemory> GetTranslationMemoryAsync(string translationMemoryId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `string` | yes |
| `fields` | `string` | no |

### Java — `TranslationMemoryApi`

```java
// GET /translation-memory/{translationMemoryId}?fields={fields}
TranslationMemory getTranslationMemory(String translationMemoryId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `translationMemoryId` | `String` | yes |
| `fields` | `String` | no |