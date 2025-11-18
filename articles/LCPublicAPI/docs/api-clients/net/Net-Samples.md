# Trados Cloud Platform SDK Samples for .NET
</br>

## Console Application Sample

The console application sample is available for download on [GitHub](https://github.com/RWS/language-cloud-public-api-samples/tree/main/.Net/PublicApi.Sample.Console).

It contains 3 examples of how to instantiate and work with an API client provided by the Trados Cloud Platform SDK. You can either use the supplied provider, or handle the client instantiation on you own: 

### Instantiating a client using credentials

You can instantiate a client using the supplied `LanguageCloudClientProvider` class. This method requires you provide a `ServiceCredentials` object, which contains your `clientID`, `clientSecret` and the `tenant`. *See the [Authentication](../../../docs/Authentication.md) page for more details.*

```csharp
using Rws.LanguageCloud.Sdk;

...

// define credentials
ServiceCredentials credentials = new ServiceCredentials("client-id", "client-secret", "tenant");

// instantiate the provider
var clientProvider = new LanguageCloudClientProvider("eu");

// Instantiate the client
var projectClient = clientProvider.GetProjectClient(credentials);

// use the client
var projectsResponse = await projectClient.ListProjectsAsync();
```

 *\*Using this method, a unique TraceId will be generated on each request.*

> [!NOTE]
> Make sure you always keep your credentials safe.


### Instantiating a client using context scoping

This method allows you to make an API call with 2 different users, using the same client instance. 

We provide an `ApiClientContext` which exposes some scoping options. You can use this to scope your API calls in different contexts. The sample contains an example with 2 different users:

```csharp
using Rws.LanguageCloud.Sdk;
using Sdl.ApiClientSdk.Core;
...

// define credentials for your first user
ServiceCredentials credentials_1 = new ServiceCredentials("client-id-1", "client-secret-1", "tenant-1");

// define credentials for your second user
ServiceCredentials credentials_2 = new ServiceCredentials("client-id-2", "client-secret-2", "tenant-2");

// instantiate the provider
var clientProvider = new LanguageCloudClientProvider("eu");

// instantiate the client without credentials
var client = clientProvider.GetProjectClient();

// create a context scope and use the client. You can also provide your own traceId
using (ApiClientContext.BeginScope(new LCContext(credentials_1, "trace-id-1")))
{
    // the client will use the credentials_1 and "trace-id-1" defined in the scope
    var projectsResponse = await projectClient.ListProjectsAsync();
}

// create a context scope and use the client. You can also provide your own traceId
using (ApiClientContext.BeginScope(new LCContext(credentials_2, "trace-id-2")))
{
    // the client will use the credentials_2 and "trace-id-2" defined in the scope
    var projectsResponse = await projectClient.ListProjectsAsync();
}
```

### Instantiating a client using a custom handler

If you would like to control the authentication process, you should use the method which does not perform any authentication implicitly. You can provide your own authentication implementation via a custom handler:

```csharp
// define credentials
ServiceCredentials credentials = new ServiceCredentials("client-id", "client-secret", "tenant");

// get an authentication handler
ServiceAuthenticationHandler handler = new ServiceAuthenticationHandler(credentials);

// instantiate the provider
var clientProvider = new LanguageCloudClientProvider("eu");

// get a client with the custom handler
var client = clientProvider.GetProjectClientNoAuth(handler);

// use the client
var projectsResponse = await projectClient.ListProjectsAsync();

```
<br></br>

## Web API Dependency Injection Sample
The web API sample is available for download on [GitHub](https://github.com/RWS/language-cloud-public-api-samples/tree/main/.Net/PublicApi.WebApiSample).

It contains an example of how to instantiate and work with an API client provided by the Trados Cloud Platform SDK for ASP .Net.

> [!NOTE]
> If you want to use the provided authentication mechanism, a custom handler can be created, which must inherit from `LCCustomAuthenticationHandler`.

> [!NOTE]
> If you want to handle authentication and tracing on you own, you could implement your own `DelegatingHandler`.

In our example, we've created the `LcHandler` class, which inherits from `LCCustomAuthenticationHandler`. The `LCCustomAuthenticationHandler` class already provides us with an authentication mechanism. We've overwritten the `GetServiceCredentials` and `GetTraceId` methods and provided our own implementations, as these will be called by `LCCustomAuthenticationHandler`:

```csharp
// Provide you own implementation. A possible example can be:
protected override ServiceCredentials GetServiceCredentials()
{
    int accountId = int.Parse(context.HttpContext.User.Claims.Single(x => x.Type.Equals("aid")).Value);
    ServiceCredentials credentials = repository.GetServiceCredentialsById(accountId);

    return credentials;
}

...
	
// Provide you own implementation. A possible example can be:
protected override string GetTraceId()
{
    return DateTimeOffset.UtcNow.ToString();
}
```

We'll need a bit of custom magic to make sure dependency injection works correctly for multi-region. We'll create a custom Factory to provide our clients. An example implementation would be a factory class to provide a per region factory. We'll make sure to have all instances initialized only once, to avoid problems:
```csharp

    class RegionClientContainerFactory
    {
        LanguageCloudClientProvider _languageCloudClientProvider;
        IServiceProvider _serviceProvider;

        private IAccountClient _accountClient;


        public RegionClientContainerFactory(string region, IServiceProvider serviceProvider)
        {
            _languageCloudClientProvider = new LanguageCloudClientProvider(region);
            _serviceProvider = serviceProvider;
        }

        public IAccountClient AccountClient {
            get
            {
                // get custom authentication handler
                LcHandler handler = _serviceProvider.GetRequiredService<LcHandler>();

                // ensure account client is instantiated only once
                return _accountClient ??= _languageCloudClientProvider.GetAccountClient(handler);
            }
        }
    }

    class LanguageCloudClientFactory
    {
        private object _lock = new object();
        private IServiceProvider _serviceProvider;

        ConcurrentDictionary<string, RegionClientContainerFactory> _regionClientContainerFactories = new ConcurrentDictionary<string, RegionClientContainerFactory>();

        LanguageCloudClientFactory(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        public RegionClientContainerFactory Region(string region)
        {
            if (!_regionClientContainerFactories.TryGetValue(region, out RegionClientContainerFactory regionClientContainerFactory))
            {
                lock (_lock)
                {
                    if (!_regionClientContainerFactories.TryGetValue(region, out regionClientContainerFactory))
                    {
                        regionClientContainerFactory = new RegionClientContainerFactory(region, _serviceProvider);
                        _regionClientContainerFactories.TryAdd(region, regionClientContainerFactory);
                    }
                }
            }

            return regionClientContainerFactory;
        }
    }

```

We register our handler `LcHandler` as a transient service and a Factory class with factory, in the `Startup` class:

```csharp
// handlers must always be transient
services.AddTransient<LcHandler>();

// register a client
services.AddSingleton(provider => new LanguageCloudClientFactory(provider.GetService<LcHandler>());
```

We can then use the registered client in the controller (or any other class resolved through Dependency Injection):

```csharp
public class LanguageCloudApiSampleController : ControllerBase 
{
    LanguageCloudClientFactory _factory;

    // inject the client via constructor
    public LanguageCloudApiSampleController(LanguageCloudClientFactory clientFactory)
    {
        this._factory = clientFactory;
    }

    ...
      
    // make an API call using a client and the user identity from HttpContext
    var accountClient = _factory.Region("eu").AccountClient;
    var accounts = await accountClient.ListMyAccountsAsync();

    ...
}
```


