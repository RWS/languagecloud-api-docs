# Trados Cloud Platform API Request File Analysis

Request File Analysis RequestFileAnalysis POST /files/analysis

- Friendly name: Request File Analysis
- Operation ID: RequestFileAnalysis
- HTTP Method: POST
- Path: /files/analysis

This endpoint allows you to request the word count and an estimated cost for your files. 

Use the [Upload Zip File](#/operations/UploadZipFile) / [Poll Upload Zip File](#/operations/PollUploadZipFile) endpoints to upload your files and get the `fileIds`. Send these `fileIds` together with the `languageProcessingRuleId` and `sourceLanguage` to receive the word count.

Optionally, send the `quotingOptions` object to receive the `estimatedCosts`.

Use the [Poll File Analysis](#/operations/PollFileAnalysis) endpoint to monitor the operation and receive the analysis results.

> File analysis results will be available for 24 hours after generation.

## Parameters

- **Authorization** (header, string) - required: The bearer access token provided by Auth0.
- **X-LC-Tenant** (header, string) - required: The identifier of the account where the request is executed.

## Request body

- Content: application/json

```
type: object
properties:
  - fileIds: type: array
    items:
      type: string
  - sourceLanguage: $ref: #/components/schemas/source-language-request
  - languageProcessingRuleId: type: string
  - fileProcessingConfigurationId: type: string
  - quotingOptions: type: object
      description: Set these resources to calculate an estimated translation cost.
    properties:
      - pricingModelId: type: string
      - targetLanguages: type: array
        items:
          $ref: #/components/schemas/target-language-request
```

## Response

### 202



- Content: application/json
- Schema: file-analysis-operation-response (see model section below)

### 400

Error codes:
* “invalid”: Invalid input in the request body parameter mentioned in the “name” field on the error response.

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
* "notFound": the resource could not be found.

- Content: application/json
- Schema: error-response (see model section below)


## Model: source-language-request
<a id="source-language-request"></a>

```
type: object
properties:
  - languageCode: type: string
```

## Model: target-language-request
<a id="target-language-request"></a>

```
type: object
  description: 
properties:
  - languageCode: type: string
```

## Model: file-analysis-operation-response
<a id="file-analysis-operation-response"></a>

```
type: object
properties:
  - id: type: string
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

### .NET — `IFileClient`

```csharp
Task RequestFileAnalysisAsync();
```

### Java — `FileApi`

```java
// POST /files/analysis
FileAnalysisOperationResponse requestFileAnalysis(RequestFileAnalysisRequest requestFileAnalysisRequest);
```

| Parameter | Type | Required |
|---|---|---|
| `requestFileAnalysisRequest` | `RequestFileAnalysisRequest` | no |