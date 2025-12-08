# .NET Client

.NET Client is a collection of API clients structured in accordance with the API documentation, meaning each section will have its own client. 

It is built on .NET Standard 2.0. For compatibility information, see the [Microsoft implementation support page](https://docs.microsoft.com/en-us/dotnet/standard/net-standard?tabs=net-standard-2-0#net-implementation-support).

> [!NOTE]
>  The .NET Client library is auto-generated from the current API contracts, so any updates to the contract will reflect as changes in the SDK client. Minor version increases do not guarantee backwards compatibility.

## Installation

You can add the .NET Client library to your project from [Rws.LanguageCloud.Sdk NuGet](https://www.nuget.org/packages/Rws.LanguageCloud.Sdk).

## Usage

We will take the project creation flow as an example to show how the API clients can be used.

#### 1. Add the `using` statement:

```csharp
using Rws.LanguageCloud.Sdk;
```
#### 2. Get a new Project client:

First step is to get an instance of `LanguageCloudClientProvider`. The constructor has 2 optional parameters `region` and `baseUrl`. When using the constructor with no parameters, the provider will be instantiated for the `eu` region. Any clients created by this instance will be calling on the EU region. If you need to specify a different region, instantiate it with the `region` specified. Region is specified by it's code, ex: `eu`, `ca`, etc, 

The second optional parameter `baseUrl` is used if you want to test the client with a mock server.

You can request a new API client from the `LanguageCloudClientProvider` instance. There are 3 methods exposed for each client:

  - ```csharp 
    GetProjectClient (ServiceCredentials credentials, params DelegatingHandler[] handlers)
  This method accepts a `ServiceCredentials` object which will be used to perform authentication using an implicit authentication handler. Custom handlers are also accepted.

  - ```csharp 
    GetProjectClientNoAuth (params DelegatingHandler[] handlers) 
  This method accepts custom handlers and does not perform any authentication implicitly. You must handle authentication in a custom handler when using this method.

  - ```csharp 
    GetProjectClient (params DelegatingHandler[] handlers)`
  This method accepts custom handlers and can be used to authenticate using scoping/context.

> [!WARNING]
>  On each call to GetProjectClient or GetProjectClientNoAuth a new instance is created. That means a new HttpClient for each one. You should avoid having more than one instance - and should share that using Dependency Injection or other mechanisms.

In this example we will use the credentials options to get a new Project Client and we won't supply any additional handlers:

```csharp

 // define credentials
ServiceCredentials credentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");

// instantiate the provider
var clientProvider = new LanguageCloudClientProvider("eu");

// instantiate the client
var projectClient = clientProvider.GetProjectClient(credentials);
```

Since each client exposes its available operations according to the API documentation, you can find the GetProject operation in the Project client.

#### 3. Create a new project:

```csharp
var projectCreateRequest = new ProjectCreateRequest
{
    Name = "YOUR_PROJECT_NAME",
    DueBy = DateTime.Now.AddDays(7),
    ProjectTemplate = new ObjectIdRequest
    {
        Id = "YOUR_PROJECT_TEMPLATE_ID"
    }
};

var projectCreateResponse = await projectClient.CreateProjectAsync(projectCreateRequest);
```


#### 4. Attach a source file to the project via the SourceFiles client:

Projects that do not contain source files cannot be started.

First, `GET` the SourceFiles client:

```csharp
 // define credentials
ServiceCredentials credentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");

// instantiate the provider
var clientProvider = new LanguageCloudClientProvider("eu");

// instantiate the client
var sourceFileClient = clientProvider.GetSourceFileClient(credentials);
```
Then, attach a source file to the project:

```csharp
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

    await sourceFileClient.AddSourceFileAsync("YOUR_PROJECT_ID", properties ,file);
}
```

#### 5. Start the project:

```csharp
await projectClient.StartProjectAsync("YOUR_PROJECT_ID");
```

#### 6. `GET` the project details using the Project client:
```csharp
var myProject = await projectClient.GetProjectAsync("YOUR_PROJECT_ID");
```

#### 7. (Optional) Supply the `fields` parameter and retrieve specific data about the project:

```csharp
var myProject = await projectClient.GetProjectAsync("YOUR_PROJECT_ID", "status,quote.totalAmount");
```

### Token management

When using `GetProjectClient` with `ServiceCredentials`, the client handles token management automatically:

- **Automatic token handling**: You do not need to fetch or manage auth tokens directly. The implicit authentication handler obtains a valid token based on the provided service credentials automatically.
- **Token caching**: Tokens are cached until expiration, ensuring efficient reuse without unnecessary Auth0 requests.
- **Single instance pattern**: To avoid creating multiple `HttpClient` instances (and thus multiple token caches), reuse the same client instance via Dependency Injection or similar mechanisms.

> [!NOTE]
> The [16 requests per day limit](../../../docs/Authentication.md#token-management) mentioned in the Authentication documentation refers to Auth0 token requests, not API calls. Since the .NET Client SDK caches tokens automatically, your application typically only makes one Auth0 token request per day (unless the application is restarted or multiple instances are running). See [Token caching behavior](../../../docs/Authentication.md#token-caching-behavior) for more details.

> [!WARNING]
> While the SDK handles token management, you still need to handle [API rate limits](../../../docs/API-rate-limits.md) and implement proper handling for HTTP 429 (Too Many Requests) responses. See the [Implementation recommendations](../../../docs/API-rate-limits.md#implementation-recommendations) for guidance.


## Error handling
The SDK may throw the following exceptions: 

Exception Type | Exception description 
---------|----------
**ModelDeserializationException** | Response could not be deserialized 
**ApiUnauthorizedException** | The user could not be identified 
**ApiPermissionException** | The user does not have permission to access this resource 
**ApiForbiddenException** | The user does not have access to the resource 
**ApiErrorException** | Something went wrong when performing the action 
**ApiConnectionException** | Something went wrong when connecting to the server 
**[TaskCanceledException](https://docs.microsoft.com/en-us/dotnet/api/system.threading.tasks.taskcanceledexception?view=netstandard-2.0)** | A timeout occurred. This exception is provided by Microsoft in System.Threading.Tasks namespace.

All these exceptions inherit from `ApiClientException` and provide an `ApiErrorResponse` object which contains details about the error that occurred. 
You may use this object in combination with the ErrorCode class to perform exception handling:

```csharp
try
{
    // your API Client interaction code
}
catch (ApiForbiddenException e)
{
    // handle exception...
}
catch (ApiUnauthorizedException e)
{
    // handle exception...
}
// we can limit what specific API Errors we want to handle:
catch (ApiErrorException e) where (e.ApiError.ErrorCode == ErrorCodes.MaxSize)
{
    // One of the fields in your call, has value higher then allowed
    // We get the summary message:
    string summary = e.ApiError.Message;

    // Next we can get the list of fields that failed validation:
    foreach (var detail in e.ApiError.Details)
    {
        // TODO
    }
}
```
Additionally, the `ApiErrorResponse.Details` object contains specific error data that may be useful. 


### Error Codes

The `ErrorCodes` static class provides a series of constant strings suitable to be used for error code validation. Please check the Rest API documentation for specific codes any endpoint may return and what that value means in the specific context.
