# Trados Cloud Platform API Poll File Analysis

Poll File Analysis PollFileAnalysis GET /files/analysis/{operationId}

- Friendly name: Poll File Analysis
- Operation ID: PollFileAnalysis
- HTTP Method: GET
- Path: /files/analysis/{operationId}

Monitor the [File Analysis](#/operations/RequestFileAnalysis) operation and receive the analysis results.

> File analysis results will be available for 24 hours after generation.

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
- Schema: file-analysis-response (see model section below)

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
* "forbidden": the authenticated user is not allowed to read resource.

- Content: application/json
- Schema: error-response (see model section below)

### 404

Error codes:
* "notFound": the quoting operation could not be found.

- Content: application/json
- Schema: error-response (see model section below)


## Model: file-analysis-response
<a id="file-analysis-response"></a>

```
type: object
properties:
  - status: type: string enum: [converting, analysis, costCalculation, completed, error]
  - wordCount: type: integer
  - estimatedCosts: $ref: #/components/schemas/file-analysis-cost-response
  - fileStatistics: type: array
    items:
      $ref: #/components/schemas/file-analysis-file-statistics
  - errorMessage: type: string
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

## Model: file-analysis-cost-response
<a id="file-analysis-cost-response"></a>

```
type: object
properties:
  - currencyCode: type: string
  - total: type: number
  - translationCosts: type: number
  - languageCosts: type: number
  - additionalCosts: type: number
```

## Model: file-analysis-file-statistics
<a id="file-analysis-file-statistics"></a>

```
type: object
properties:
  - fileId: type: string
  - wordCount: type: integer
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

### .NET — `IFileClient`

```csharp
Task PollFileAnalysisAsync(string operationId, string fields = null);
```

| Parameter | Type | Required |
|---|---|---|
| `operationId` | `string` | yes |
| `fields` | `string` | no |

### Java — `FileApi`

```java
// GET /files/analysis/{operationId}?fields={fields}
FileAnalysisResponse pollFileAnalysis(String operationId, String fields);
```

| Parameter | Type | Required |
|---|---|---|
| `operationId` | `String` | yes |
| `fields` | `String` | no |