# API Clients (.NET and Java SDKs)

Both SDKs are auto-generated from the API contracts. Minor version bumps do not guarantee backward compatibility.

## .NET SDK

**Target:** .NET Standard 2.0 ([compatibility matrix](https://docs.microsoft.com/en-us/dotnet/standard/net-standard?tabs=net-standard-2-0#net-implementation-support))  
**Package:** [Rws.LanguageCloud.Sdk on NuGet](https://www.nuget.org/packages/Rws.LanguageCloud.Sdk)

### Initialization

```csharp
using Rws.LanguageCloud.Sdk;

ServiceCredentials credentials = new ServiceCredentials("CLIENT_ID", "CLIENT_SECRET", "TENANT_ID");
var provider = new LanguageCloudClientProvider("eu"); // default region is "eu"
var projectClient = provider.GetProjectClient(credentials);
```

Three factory methods per client:

| Method | Auth behavior |
|---|---|
| `GetProjectClient(credentials, handlers)` | Implicit auth via `ServiceCredentials` |
| `GetProjectClient(handlers)` | Auth via context scoping (`ApiClientContext.BeginScope`) |
| `GetProjectClientNoAuth(handlers)` | No implicit auth; provide a custom `DelegatingHandler` |

**Important:** Each call to `GetProjectClient` creates a new `HttpClient` instance. Reuse the same instance via Dependency Injection to avoid multiple token caches.

### Token Management

Token caching is automatic. Tokens are reused until expiry. Each application instance holds its own cache; restarts reset the cache.

### Error Handling

All exceptions inherit from `ApiClientException` and expose an `ApiErrorResponse`.

| Exception | Cause |
|---|---|
| `ModelDeserializationException` | Response deserialization failed |
| `ApiUnauthorizedException` | Identity not recognized |
| `ApiPermissionException` | No permission for the resource |
| `ApiForbiddenException` | No access to the resource |
| `ApiErrorException` | General API error |
| `ApiConnectionException` | Connection failure |
| `TaskCanceledException` | Request timeout |

```csharp
catch (ApiErrorException e) when (e.ApiError.ErrorCode == ErrorCodes.MaxSize)
{
    string summary = e.ApiError.Message;
    foreach (var detail in e.ApiError.Details) { /* ... */ }
}
```

### Basic Project Flow (.NET)

```csharp
// Create project
var project = await projectClient.CreateProjectAsync(new ProjectCreateRequest
{
    Name = "My Project",
    ProjectTemplate = new ObjectIdRequest { Id = "TEMPLATE_ID" }
});

// Add source file
var sourceFileClient = provider.GetSourceFileClient(credentials);
using (var stream = File.Open("file.txt", FileMode.Open))
{
    await sourceFileClient.AddSourceFileAsync(project.Id,
        new SourceFileRequest { Name = "file.txt", Role = SourceFileRequestRole.Translatable,
                                Type = SourceFileRequestType.Native, Language = "en-US" },
        new FileParameter(stream, "file.txt", "text/plain"));
}

// Start project
await projectClient.StartProjectAsync(project.Id);

// Get project (with field selection)
var details = await projectClient.GetProjectAsync(project.Id, "status,quote.totalAmount");
```

---

## Java SDK

**Target:** Java 11+  
**Based on:** [OpenFeign](https://spring.io/projects/spring-cloud-openfeign)  
**Package:** [lc-public-api-sdk on Maven Central](https://search.maven.org/artifact/com.rws.lt.lc.public-api/lc-public-api-sdk)

```xml
<dependency>
  <groupId>com.rws.lt.lc.public-api</groupId>
  <artifactId>lc-public-api-sdk</artifactId>
  <version>LATEST_VERSION</version>
</dependency>
```

Always use the latest version from Maven Central.

### Initialization

```java
ServiceCredentials credentials = new ServiceCredentials("CLIENT_ID", "CLIENT_SECRET", "TENANT_ID");

LanguageCloudClientProvider provider = LanguageCloudClientProvider.builder()
    .withRegionCode("eu")  // default is "eu"
    .withServiceCredentials(credentials)
    .build();

ProjectApi projectApi = provider.getProjectClient();
```

### Token Management

- Tokens are cached in a singleton cache shared across all `LanguageCloudClientProvider` instances in the JVM.
- Tokens are evicted `expiry - 1 minute` before they expire.
- No need to recreate `LanguageCloudClientProvider` or its clients — one instance per application is sufficient.

### Context Scoping (Multi-Tenant)

```java
LCContext.executeInScope(
    () -> projectApi.listProjects(new ProjectApi.ListProjectsQueryParams()),
    serviceCredentials1,
    "trace-id-1"
);
```

Allows making API calls on behalf of different tenants using the same client instance.

### Basic Project Flow (Java)

```java
// Create project
ProjectCreateRequest req = new ProjectCreateRequest();
req.setName("My Project");
req.setProjectTemplate(new ObjectIdRequest().id("TEMPLATE_ID"));
req.setLocation("LOCATION_ID");
req.setLanguageDirections(List.of(new LanguageDirectionRequest()
    .sourceLanguage(new SourceLanguageRequest("en-US"))
    .targetLanguage(new TargetLanguageRequest("fr-FR"))));

Project project = projectApi.createProject(req, new ProjectApi.CreateProjectQueryParams());

// Add source file
SourceFileApi sourceFileApi = provider.getSourceFileClient();
SourceFileRequest fileProps = new SourceFileRequest();
fileProps.setLanguage(new LanguageRequest("en-US"));
fileProps.setName("file.txt");
fileProps.setRole(SourceFileRequest.RoleEnum.TRANSLATABLE);
fileProps.setType(SourceFileRequest.TypeEnum.NATIVE);
sourceFileApi.addSourceFile(project.getId(), fileProps, new File("file.txt"));

// Start project
projectApi.startProject(project.getId());

// Get project
Project details = projectApi.getProject(project.getId(), "status,quote.totalAmount");
```

### v25.x.x Migration (Fat JAR → Light JAR)

Key dependency changes in v25.x.x:

| Old | New |
|---|---|
| JUnit 4 | JUnit 5 (Jupiter) |
| Apache HttpClient 4 (`org.apache.http`) | Apache HttpClient 5 (`org.apache.hc.core5.http`) |
| Commons Lang 2 (`org.apache.commons.lang`) | Commons Lang 3 (`org.apache.commons.lang3`) |
| OpenAPI Generator 6.5.0 | OpenAPI Generator 7.14.0 |

For most users: update the version in `pom.xml` and recompile. Run `mvn dependency:tree` to detect conflicts.
