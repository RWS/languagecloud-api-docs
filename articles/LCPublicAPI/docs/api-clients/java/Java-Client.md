# Java Client

This client library is targeting Java 11 and above and it represents a collection of API clients structured in accordance with the API documentation, meaning each section will have its own client. 

The generated Java clients are based on [OpenFeign](https://spring.io/projects/spring-cloud-openfeign).

<!-- theme: info -->
>  The Java Client library is auto-generated from the current API contracts, so any updates to the contract will reflect as changes in the SDK client. Minor version increases do not guarantee backwards compatibility.

## Installation
You can add this library to your project as a [Maven](https://search.maven.org/artifact/com.rws.lt.lc.public-api/lc-public-api-sdk/1.1.0/jar) dependency.

Include the client library in the `pom.xml`:

```java
<dependency>
  <groupId>com.rws.lt.lc.public-api</groupId>
  <artifactId>lc-public-api-sdk</artifactId>
  <version>1.1.0</version>
</dependency>
```
> Make sure to always reference the latest available version. Check the [Maven Central Repository](https://search.maven.org/artifact/com.rws.lt.lc.public-api/lc-public-api-sdk) for more info.


## Usage
We will take the project creation flow as an example to show how the API clients can be used.

The API client can be initialized as required, based on the endpoints you are targeting. 
The authorization parameter is not required when calling client methods, if you previously added authorization when you instantiated the client.

For example, if you need to make use of the Project features, you may instantiate a Project client, as follows:

```java

// define credentials
ServiceCredentials serviceCredentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");

// instantiate the LanguageCloudClientProvider
LanguageCloudClientProvider languageCloudClientProvider = new LanguageCloudClientProvider(serviceCredentials);

// instantiate the client
ProjectApi projectApi = languageCloudClientProvider.getProjectClient();
```

#### 1. Create a new project:

```java
ProjectCreateRequest projectCreateRequest = new ProjectCreateRequest();
projectCreateRequest.setName("YOUR_PROJECT_NAME");
projectCreateRequest.setDueBy(DateTime.parse("2025-01-01T00:00:00.000Z"));
projectCreateRequest.setProjectTemplate(new ObjectIdRequest().id("YOUR_PROJECT_TEMPLATE_ID"));
 
Project projectCreateResponse = projectApi.createProject(projectCreateRequest, new HashMap<>());
```

#### 2. Attach a source file to the project:

Projects that do not contain source files cannot be started.

```java
SourceFileApi sourceFileApi = languageCloudClientProvider.getSourceFileClient();
 
SourceFileRequest properties = new SourceFileRequest();
properties.setLanguage("en-US");
properties.setName("YOUR_TEXT_SOURCE_FILE");
properties.setRole(SourceFileRequest.RoleEnum.TRANSLATABLE);
properties.setType(SourceFileRequest.TypeEnum.NATIVE);
File file =  new File("YOUR_TEXT_SOURCE_FILE_PATH");
 
SourceFile sourceFile = sourceFileApi.addSourceFile("YOUR_PROJECT_ID", file, properties);

```

#### 3. Start the project:
```java
projectApi.startProject("YOUR_PROJECT_ID");
```

#### 4. Get the project details:
```java
Project project = projectApi.getProject("YOUR_PROJECT_ID", "status,quote.totalAmount");
```
