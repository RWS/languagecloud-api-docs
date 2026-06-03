# Trados Cloud Platform API Get File Type Setting

Get File Type Setting GetFileTypeSetting GET /file-processing-configurations/{fileProcessingConfigurationId}/file-type-settings/{fileTypeSettingId}

- Friendly name: Get File Type Setting
- Operation ID: GetFileTypeSetting
- HTTP Method: GET
- Path: /file-processing-configurations/{fileProcessingConfigurationId}/file-type-settings/{fileTypeSettingId}

Retrieves a file type setting by identifier.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.
- **fields** (query, string) - optional: A comma separated list of fields to include in the response.
        Every value in the list should either consist of a top-level property name (excluding the items envelope for endpoints returning lists) or refer to a property of a top-level property of type object, in the following form: "toplevelpropertyname.subpropertyname".
        When this query parameter is omitted, default resource representations are returned (excluding fields marked as optional). The same applies to nested objects when just specifying the top-level property name, without explicitly listing sub-property names. When specifying the fields query parameter, only the specified fields are returned.
        The id property is always returned.

## Request body

No request body.

## Response

### 200



- Content: application/json
- Schema: file-type-setting (see model section below)

### 400

Error codes:
* “invalid”: invalid input in the query parameter mentioned in the “name” field on the error response.

- Content: application/json
- Schema: error-response (see model section below)

### 401

The user could not be identified.

- Content: application/json
- Schema: error-response (see model section below)

### 403

Error codes:
* "forbidden": not allowed to read file type setting.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes
* "notFound": file type setting could not be found.

- Content: application/json
- Schema: error-response (see model section below)


## Model: file-type-setting
<a id="file-type-setting"></a>

```
type: object
  description: 
properties:
  - id: type: string
  - name: type: string
  - description: type: string
  - typeId: type: string
  - enabled: type: boolean
  - excluded: type: boolean
  - deprecated: type: boolean
  - orderNumber: type: integer
  - extensions: type: array
    items:
      type: string
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

### .NET — `IFileProcessingConfigurationClient`

```csharp
Task<FileTypeSetting> GetFileTypeSettingAsync(string fileProcessingConfigurationId, string fileTypeSettingId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `fileProcessingConfigurationId` | `string` | yes |
| `fileTypeSettingId` | `string` | yes |
| `fields` | `string` | no |

### Java — `FileProcessingConfigurationApi`

```java
// GET /file-processing-configurations/{fileProcessingConfigurationId}/file-type-settings/{fileTypeSettingId}?fields={fields}
FileTypeSetting getFileTypeSetting(String fileProcessingConfigurationId, String fileTypeSettingId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `fileProcessingConfigurationId` | `String` | yes |
| `fileTypeSettingId` | `String` | yes |
| `fields` | `String` | no |