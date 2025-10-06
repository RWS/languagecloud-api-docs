# Java Client

This client library targets Java 11 and above. It provides API clients organized by API documentation sections.

The generated Java clients are based on [OpenFeign](https://spring.io/projects/spring-cloud-openfeign).

<!-- theme: info -->
>  The Java Client library is auto-generated from the current API contracts, so any updates to the contract will reflect as changes in the SDK client. Minor version increases do not guarantee backwards compatibility.

## Installation
You can add this library to your project as a [Maven](https://search.maven.org/artifact/com.rws.lt.lc.public-api/lc-public-api-sdk/24.0.9/jar) dependency.

Include the client library in the `pom.xml`:

```java
<dependency>
  <groupId>com.rws.lt.lc.public-api</groupId>
  <artifactId>lc-public-api-sdk</artifactId>
  <version>24.0.9</version>
</dependency>
```
> Make sure to always reference the latest available version. Check the [Maven Central Repository](https://search.maven.org/artifact/com.rws.lt.lc.public-api/lc-public-api-sdk) for more info.


## Usage
We will use the project creation flow as an example to show how the API clients can be used.

API clients can be initialized individually based on the endpoints you need to target.
If authorization was provided when instantiating the client, it's not required again when calling its methods.

Trados Cloud Platform operates in multiple regions; ensure you select the correct region for your integration.
*See the [Multi Region](../../../docs/Multi-Region.md) page for more details.*

The default region for `LanguageCloudClientProvider` is `eu`, but you can override it.
For example, to use Project features, instantiate a Project client like this:

```java

// define credentials
ServiceCredentials serviceCredentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");

// instantiate the LanguageCloudClientProvider
LanguageCloudClientProvider languageCloudClientProvider = LanguageCloudClientProvider.builder()
        .withRegionCode("ca") // default is "eu"
        .withServiceCredentials(serviceCredentials)
        .build();

// instantiate the client
ProjectApi projectApi = languageCloudClientProvider.getProjectClient();
```

#### 1. Create a new project:

```java
ProjectCreateRequest projectCreateRequest = new ProjectCreateRequest();
projectCreateRequest.setName("YOUR_PROJECT_NAME");
projectCreateRequest.setDueBy(DateTime.parse("2025-01-01T00:00:00.000Z"));
projectCreateRequest.setProjectTemplate(new ObjectIdRequest().id("YOUR_PROJECT_TEMPLATE_ID"));

// Set the `fields` query parameter so the response is populated with `projectPlan.taskConfigurations`
ProjectApi.CreateProjectQueryParams queryParams = new ProjectApi.CreateProjectQueryParams();
queryParams.fields("projectPlan.taskConfigurations");
Project projectCreateResponse = projectApi.createProject(projectCreateRequest, queryParams);
```

#### 2. Attach a source file to the project:

Projects that do not contain source files cannot be started.

```java
SourceFileApi sourceFileApi = languageCloudClientProvider.getSourceFileClient();

SourceFileRequest properties = new SourceFileRequest();
properties.setLanguage(new LanguageRequest("en-US"));
properties.setName("YOUR_TEXT_SOURCE_FILE");
properties.setRole(SourceFileRequest.RoleEnum.TRANSLATABLE);
properties.setType(SourceFileRequest.TypeEnum.NATIVE);
File file = new File("YOUR_TEXT_SOURCE_FILE_PATH");

SourceFile sourceFile = sourceFileApi.addSourceFile("YOUR_PROJECT_ID", properties, file);
```

#### 3. Start the project:
```java
projectApi.startProject("YOUR_PROJECT_ID");
```

#### 4. Get the project details:
```java
Project project = projectApi.getProject("YOUR_PROJECT_ID", "status,quote.totalAmount");
```
