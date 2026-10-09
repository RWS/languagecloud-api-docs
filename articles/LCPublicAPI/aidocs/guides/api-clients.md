# API clients: Java SDK, .NET SDK, samples and Postman

Installation, client initialization, authentication options, error handling and Postman setup for the Trados Cloud Platform SDKs.

Both SDKs are auto-generated from the API contracts: contract changes appear as SDK changes, and minor version increases do not guarantee backwards compatibility. Neither SDK handles HTTP 429 for you; implement it per [rate-limits.md](./rate-limits.md).

## Java SDK

| Item | Value |
|---|---|
| Java version | 11 and above |
| HTTP stack | OpenFeign |
| Maven | `com.rws.lt.lc.public-api:lc-public-api-sdk` (docs example version `24.0.9`; use the latest on Maven Central) |
| Default region | `eu` |

```xml
<dependency>
  <groupId>com.rws.lt.lc.public-api</groupId>
  <artifactId>lc-public-api-sdk</artifactId>
  <version>24.0.9</version>
</dependency>
```

### Initialize with service credentials

```java
ServiceCredentials serviceCredentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");

LanguageCloudClientProvider languageCloudClientProvider = LanguageCloudClientProvider.builder()
        .withRegionCode("ca") // default is "eu"
        .withServiceCredentials(serviceCredentials)
        .build();

ProjectApi projectApi = languageCloudClientProvider.getProjectClient();
```

Samples also use `.withRegion("eu")`. A unique trace ID is generated per request in this mode. Clients are created per API area (`getProjectClient()`, `getSourceFileClient()`, `getGroupClient()`, `getUserClient()`, `getAccountClient()`). Regions: [multi-region.md](./multi-region.md).

### Token management

- Tokens are obtained automatically from the service credentials.
- Cached until expiry minus 1 minute, then regenerated.
- The token cache is a singleton: one cache per application regardless of provider instances. One provider (and one client per API) per application is sufficient.
- The 16 token requests per day limit applies to Auth0 token requests, not API calls ([auth.md](./auth.md)); typically one per day unless the application restarts.

### Authentication modes

| Mode | How |
|---|---|
| Service credentials | `LanguageCloudClientProvider.builder().withServiceCredentials(...)` |
| Context scoping (multiple credentials, one client) | Build provider without credentials; `LCContext.executeInScope(runnable, serviceCredentials, "trace-id")`; read `LCContext.getFromLCContext(ContextKeys.TRACE_ID_KEY)` / `ContextKeys.TENANT_ID_KEY` |
| App service credentials (one app, many tenants) | Provider built with `ServiceCredentials(clientId, clientSecret)` (no tenant); `LCContext.executeInScope(runnable, TENANT_VALUE, "trace-id")` |
| Custom authentication | Subclass `CustomServiceAuthenticationHandler(AuthenticationService.getInstance())`, override `getServiceCredentials()`, `getTraceId()`, `getTenantId()`; register via `.withRequestInterceptors(List.of(handler))` |

### Project flow

```java
// 1. create (fields query param populates projectPlan.taskConfigurations)
ProjectCreateRequest projectCreateRequest = new ProjectCreateRequest();
projectCreateRequest.setName("YOUR_PROJECT_NAME");
projectCreateRequest.setDueBy(DateTime.parse("2025-01-01T00:00:00.000Z"));
projectCreateRequest.setProjectTemplate(new ObjectIdRequest().id("YOUR_PROJECT_TEMPLATE_ID"));
projectCreateRequest.setLocation("YOUR_PROJECT_LOCATION");
projectCreateRequest.setLanguageDirections(List.of(new LanguageDirectionRequest()
        .sourceLanguage(new SourceLanguageRequest("YOUR_SOURCE_LANGUAGE"))
        .targetLanguage(new TargetLanguageRequest("YOUR_TARGET_LANGUAGE"))));
ProjectApi.CreateProjectQueryParams queryParams = new ProjectApi.CreateProjectQueryParams();
queryParams.fields("projectPlan.taskConfigurations");
Project created = projectApi.createProject(projectCreateRequest, queryParams);

// 2. add source file (a project without source files cannot be started)
SourceFileApi sourceFileApi = languageCloudClientProvider.getSourceFileClient();
SourceFileRequest properties = new SourceFileRequest();
properties.setLanguage(new LanguageRequest("en-US"));
properties.setName("YOUR_TEXT_SOURCE_FILE");
properties.setRole(SourceFileRequest.RoleEnum.TRANSLATABLE);
properties.setType(SourceFileRequest.TypeEnum.NATIVE);
SourceFile sourceFile = sourceFileApi.addSourceFile("YOUR_PROJECT_ID", properties, new File("YOUR_TEXT_SOURCE_FILE_PATH"));

// 3. start
projectApi.startProject("YOUR_PROJECT_ID");

// 4. get with fields
Project project = projectApi.getProject("YOUR_PROJECT_ID", "status,quote.totalAmount");
```

List calls take a query-params object, e.g. `groupApi.listGroups(new GroupApi.ListGroupsQueryParams())`.

### Upgrade to 25.x.x

| Change | Detail |
|---|---|
| Packaging | Fat JAR -> light JAR (Maven Shade plugin removed) |
| OpenAPI Generator | 6.5.0 -> 7.14.0 (adds `@javax.annotation.Nullable`/`@Nonnull`, bean validation, new collection helper method naming, enum handling) |
| `LCContext.executeInScope()` | New methods for tenant/trace context |

| Library | Previous | New |
|---|---|---|
| Feign | 10.11 | 13.6 |
| Jackson | 2.10.3 | 2.19.1 |
| Apache HttpClient | 4.5.8 | 5.5 |
| Commons Lang | 2.6 | 3.18.0 |
| JUnit | 4.13 | 5.13.2 |
| Mockito | 3.12.1 | 5.18.0 |

Migration: update SDK version, build, fix compile issues from generated-code changes. Import changes: `org.apache.http` -> `org.apache.hc.core5.http`; `org.apache.commons.lang` -> `org.apache.commons.lang3`. Troubleshooting: `mvn dependency:tree` for conflicts; `ClassNotFoundException: feign.Client` -> check Feign dependencies; `NoClassDefFoundError` for HTTP client classes -> update imports.

## .NET SDK

| Item | Value |
|---|---|
| Package | NuGet `Rws.LanguageCloud.Sdk` |
| Target | .NET Standard 2.0 |
| Namespace | `Rws.LanguageCloud.Sdk` |
| Provider | `new LanguageCloudClientProvider(region, baseUrl)` — both optional; default region `eu`; `baseUrl` is for mock servers |

Client factory overloads (shown for Project; same for every client):

| Method | Behaviour |
|---|---|
| `GetProjectClient(ServiceCredentials credentials, params DelegatingHandler[] handlers)` | Implicit authentication handler using the credentials; custom handlers accepted |
| `GetProjectClientNoAuth(params DelegatingHandler[] handlers)` | No implicit authentication; a custom handler must authenticate |
| `GetProjectClient(params DelegatingHandler[] handlers)` | Authenticate through scoping/context |

Each `GetXClient` call creates a new `HttpClient`; share one instance (dependency injection or similar).

```csharp
ServiceCredentials credentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");
var clientProvider = new LanguageCloudClientProvider("eu");
var projectClient = clientProvider.GetProjectClient(credentials);

var projectCreateRequest = new ProjectCreateRequest
{
    Name = "YOUR_PROJECT_NAME",
    DueBy = DateTime.Now.AddDays(7),
    ProjectTemplate = new ObjectIdRequest { Id = "YOUR_PROJECT_TEMPLATE_ID" }
};
var projectCreateResponse = await projectClient.CreateProjectAsync(projectCreateRequest);

var sourceFileClient = clientProvider.GetSourceFileClient(credentials);
using (FileStream SourceStream = File.Open("YOUR_TEXT_SOURCE_FILE", FileMode.Open))
{
    FileParameter file = new FileParameter(SourceStream, "YOUR_TEXT_SOURCE_FILE", "text/plain");
    SourceFileRequest properties = new SourceFileRequest
    {
        Name = "YOUR_TEXT_SOURCE_FILE",
        Role = SourceFileRequestRole.Translatable,
        Type = SourceFileRequestType.Native,
        Language = "en-US",
    };
    await sourceFileClient.AddSourceFileAsync("YOUR_PROJECT_ID", properties, file);
}

await projectClient.StartProjectAsync("YOUR_PROJECT_ID");
var myProject = await projectClient.GetProjectAsync("YOUR_PROJECT_ID", "status,quote.totalAmount");
```

### Authentication modes

| Mode | How |
|---|---|
| Credentials | `GetProjectClient(credentials)`; unique trace ID per request |
| Context scoping | `GetProjectClient()` without credentials; `using (ApiClientContext.BeginScope(new LCContext(credentials_1, "trace-id-1"))) { ... }` (namespace `Sdl.ApiClientSdk.Core`) |
| Custom handler | `new ServiceAuthenticationHandler(credentials)` with `GetProjectClientNoAuth(handler)`; or subclass `LCCustomAuthenticationHandler` and override `GetServiceCredentials()` and `GetTraceId()` |

Token handling with `ServiceCredentials`: automatic; cached until expiry; reuse one client instance to avoid multiple `HttpClient` instances and token caches. Typically one Auth0 token request per day unless the application restarts or multiple instances run.

### Exceptions

All inherit from `ApiClientException` and expose an `ApiErrorResponse` (`Message`, `ErrorCode`, `Details`).

| Exception | Meaning |
|---|---|
| `ModelDeserializationException` | Response could not be deserialized |
| `ApiUnauthorizedException` | User could not be identified |
| `ApiPermissionException` | User does not have permission to access the resource |
| `ApiForbiddenException` | User does not have access to the resource |
| `ApiErrorException` | Something went wrong when performing the action |
| `ApiConnectionException` | Something went wrong when connecting to the server |
| `TaskCanceledException` | Timeout (`System.Threading.Tasks`) |

```csharp
catch (ApiErrorException e) when (e.ApiError.ErrorCode == ErrorCodes.MaxSize)
{
    string summary = e.ApiError.Message;
    foreach (var detail in e.ApiError.Details) { }
}
```

The `ErrorCodes` static class holds constant error code strings. Per-endpoint codes are in the REST API reference. Error body format: [errors.md](./errors.md).

### Dependency injection (web API sample)

- `LcHandler` inherits `LCCustomAuthenticationHandler` and overrides `GetServiceCredentials()` and `GetTraceId()`; register it with `services.AddTransient<LcHandler>()` (handlers must always be transient).
- For multi-region DI, a `LanguageCloudClientFactory` keeps one `RegionClientContainerFactory` per region in a `ConcurrentDictionary`, each owning one `LanguageCloudClientProvider(region)`, and creates each client once with `GetAccountClient(handler)`. Register as singleton; use `_factory.Region("eu").AccountClient`.

## Java web API sample

- `CustomAuthenticationHandler` extends `CustomServiceAuthenticationHandler`; overrides `getServiceCredentials()`, `getTenantId()`, `getTraceId()`.
- `ConfigClass` registers `LanguageCloudClientProvider.builder().withRegion("eu").withRequestInterceptors(List.of(customAuthenticationHandler)).build()` as a bean, plus a bean per API client (e.g. `languageCloudClientProvider.getAccountClient()`).
- Controllers inject the client (e.g. `AccountApi`).

Sample repositories: `https://github.com/RWS/language-cloud-public-api-samples` (Java: `PublicApi.Sample.Console.Java`, `PublicApi.Sample.Web.Java`; .NET: `PublicApi.Sample.Console`, `PublicApi.WebApiSample`).

## Postman

| Item | Value |
|---|---|
| Public API collection | `https://github.com/sdl/language-cloud-public-api-postman/blob/develop/postmanCollection.json?raw=true` |
| Data Bridge collection | `postmanDataCollection.json` in the same repository ([data-bridge.md](./data-bridge.md)) |
| Multi-region environments | `Trados EU.postman_environment.json`, `Trados CA.postman_environment.json` |
| Import | `Import > Link`, `Raw Text` or `File` |
| Token variable | `{{lc-access-token}}`, set by the `Obtain a client credentials access token` request (folder `Authentication (Start Here)`) |
| Tenant variable | `{{lc_tenant}}`, prefix the ID with `LC-` (e.g. `LC-00000000000000000`) |

- Authentication is inherited Bearer using `{{lc-access-token}}`.
- Environment-level variables (e.g. `baseUrl`) override collection variables when an environment is selected.
- Do not send query parameters with Postman default values; invalid data returns an API error.
- Tenant and credential setup: [auth.md](./auth.md).
