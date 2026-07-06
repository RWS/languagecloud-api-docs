# Trados Cloud Platform API Update Custom Field

Update Custom Field UpdateCustomField PUT /projects/{projectId}/custom-fields/{customFieldKey}

- Friendly name: Update Custom Field
- Operation ID: UpdateCustomField
- HTTP Method: PUT
- Path: /projects/{projectId}/custom-fields/{customFieldKey}

Allows updating individual custom fields on a project.

## Parameters

No parameters.

## Request body

- Content: application/json

- Schema: custom-field-update-request (see model section below)

## Response

### 204

No Content

### 400

Error codes:
* “invalid”: Invalid input for a readOnly field, with a different value than the deafult one. Also this code is used for invalid input values

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": the authenticated user is not allowed to update the Custom field for the Project.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the Project could not be found by identifier or Custom field key could not be found or does not belong to the desired resource type.

- Content: application/json
- Schema: error-response (see model section below)


## Model: custom-field-update-request
<a id="custom-field-update-request"></a>

```
type: object
  description: 
properties:
  - value: type: object
      description: The value of the custom field. A date will be serialized as a ISO_8601 string. For read only custom fields (`isReadOnly`), it must be set exactly as the `defaultValue` from custom field definition.
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

### .NET — `IProjectClient`

```csharp
Task UpdateCustomFieldAsync(string projectId, string customFieldKey);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `string` | yes |
| `customFieldKey` | `string` | yes |

### Java — `ProjectApi`

```java
// PUT /projects/{projectId}/custom-fields/{customFieldKey}
void updateCustomField(String projectId, String customFieldKey, CustomFieldUpdateRequest customFieldUpdateRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `projectId` | `String` | yes |
| `customFieldKey` | `String` | yes |
| `customFieldUpdateRequest` | `CustomFieldUpdateRequest` | no |