# .NET Blueprint

Our .NET blueprint uses .NET 6.0, it can be run out of the box and it can even be registered in Trados immediately, although it will not provide any functional extensions.

The only dependencies are on MongoDB and the NLog nugets.

## Getting the blueprint

The blueprint is available in our GitHub repository: [https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints/dotNetAppBlueprint](https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints/dotNetAppBlueprint)

## Solution structure

To explain the code structure for the blueprint we can have an overview look in the Solution Explorer:

![.Net Solution Structure](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/blueprints/DotNetAppSolutionStructure.PNG?raw=true)

The following areas are important for developers:
* **Controllers**: it covers the standard endpoints and also placeholders for the Extension specific controllers.
* **DAL**: it contains complete functionality for account management backed by MongoDB.
* **Exceptions**: it's used for returning errors to Trados.
* **Models**: it has the pre-built classes for all models from the contract.
* **Services** is where the main functionality can be concentrated. You can use it as a thin business layer.
* **appsettings.json** is where all your configurations go.
* **descriptor.json** is the file that describes the app functionality according to the contract.
* **Dockerfile**: it is used for debugging within the Docker containers.

## First steps

Rename the solution and the project files, and then rename the namespaces to make them your own.

Run it and ensure there are no problems before continuing with your customization.

Go through all the files and take note of placeholders - methods without implementation, or comments saying, for example, "*implementation needed*" . The blueprint is a placeholder with as much plumbing in place as possible, but it still needs filling with your details.

Depending on the extensions you are building, you may want to add one or more 'Service' classes that will have your business code.

Some files are there as an example and if you don't need them, feel free to remove them. For example, there are two extension files: the `AutomaticTaskController.cs` and the `TranslationController.cs`. Most apps will implement only one extension type, so you may want to keep one and remove the other.

### appsettings.json

The default configuration for ASP.NET Core. The blueprint provides a very minimalist file:

```json
{
  "Logging": {
    "LogLevel": {
      //"Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },

  "Authorization": {
    "JwksUri": "https://lc-api.sdl.com/public-api/v1/.well-known/jwks.json",
    "Issuer": "https://languagecloud.rws.com/"
  },

  "baseUrl": "TODO: replace with a proper URL",

  "AllowedHosts": "*",
  "documentationUrl": "docUrl",
  "MongoDb": {
    "Connection": "mongodb://localhost:27017",
    "Name": "lc-blueprint-app"
  }
}
```

The `Logging` section instructs ASP.NET on what logs to produce. Note that NLog will receive the filtered logs and then also apply its filters.

The `Authorization` section provides the settings required by the app to authorize the requests from Trados.

The `baseUrl` is used to populate the property with the same name from the descriptor.

The `AllowedHosts` is a CORS configuration. By setting it to `*` we allow Trados to call and render the response in the UI. This is a future-proof configuration.

The `documentationUrl` specifies the URL where to redirect for the full documentation. You need to specify a valid URL here. Alternatively you can return a full HTML page in the `Documentation()` action within the `StandardController` instead of using redirection.

The `MongoDb` provides the connection string for MongoDB and also the database name. The database will be automatically created and doesn't need to be provisioned upfront. If you decide to go with another database, you can remove it.

### descriptor.json

This file will be returned from the `/descriptor` endpoint as described in the API Contract. It is used to describe the functionality of the app, inform Trados of all the paths to the endpoints, provide names, descriptions, and also instruct what configuration settings are required from the user when it's installed.

### Database

The blueprint is using MongoDB as a database engine. This is not a requirement and it can be substituted for any database. There is the `IRepository` interface that can be implemented with another concrete class that supports another database engine.

![](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/blueprints/DotNetDalStructure.png?raw=true)

POCO classes in the Entities folder might need adjustments as these are tailored for MongoDB.

The next step would be to update the `Startup.cs` to change the service for `IRepository` to the new concrete class. Or if the Repository class is rewritten, no changes would be needed here.

The health checks also need to be updated against the new database engine.

### Authentication and Authorization

Most endpoints in the app need to be secured. The API Contract specifies which endpoints are secured and which are not. For example, `/descriptor` endpoint should not be secured as this is not sensitive information but it is valuable for manually invoking the endpoint and checking that the correct descriptor is returned.

The `[Authorize]` attribute is already placed on all the required standard endpoints (action methods, in the `StandardController.cs` file). All the infrastructure code is already in place, and no other configuration is required.

When implementing extension endpoints, since all extension endpoints need to be secured, you must make sure to place the `[Authorize]` attribute on all action methods (note that this is already done in the `AutomaticTaskController.cs` and the `TranslationController.cs`).

### Context

Since the apps can be used on multiple accounts it's important to understand for which account the current call is being executed to get either Service User credentials or configuration settings.

To get the current account you can use the `GetTenantId` extension method (from the Helpers folder) that is executed over the HttpContext object. This can be done in the Controller Action methods like this:

```csharp
string tenantId = this.HttpContext.GetTenantId();
```

If you need access to the identifier from other classes, you can either pass the identifier as a parameter in the request chain or access HttpContext through other mechanisms that are available in ASP.NET Core: [Access HttpContext in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/http-context?view=aspnetcore-6.0).

The blueprint provides access to Configuration data and Account Information out of the box. If you need more data to be stored, you can extend the Repository.

Access to account data is available by injecting the `IRepository` interface and using one of the available methods, for example: 
```csharp
Task<AccountInfoEntity> GetAccountInfoByTenantId(string tenantId);
```

This will provide access to both the `ConfigurationValues` as well as the `ClientCredentials`. The `ClientCredentials` type provides the `ClientId` and `ClientSecret` that are used for making calls to the  RWS Language Cloud API.

### Logs

The blueprint is configured to use out of the box the standard [Logging in .NET Core and ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-6.0) approach configured with NLog to log to console. It will write only Info level logs by default. This can be changed in the nlog.config by changing from `Info` to `Warn`:

```xml
<logger minLevel="${when:when='${environment:LOG_LEVEL}' != '':inner=${environment:LOG_LEVEL}:else=Info}" writeTo="coloredConsole" />
```

Note that you can also set the `LOG_LEVEL` environment variable to set to your desired minimum logging level. This works great when you need to change the logging level in a Docker container, you just send the environment settings when you start the container.

Moreover, logging to files can easily be enabled from `nlog.config` by uncommenting the `logFile` target:
```xml
<!--<logger minLevel="Debug" writeTo="logFile" />-->
```

### Health checks

Trados will make sure that the app is up and running by making requests to the `/health` endpoint. The blueprint provides a default implementation where it checks that MongoDB is available. Additional changes can be implemented. 

The blueprint implements the ASP.NET Core Health Check. For more details check: [Health checks in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/health-checks?view=aspnetcore-6.0).

### Error reporting

When you need to return an error to Trados, it's enough to raise an Exception of type AppException. The various constructor overloads allow for customization of the response. The plumbing in the blueprint will take care to transform the exception into an error payload according to the contract.

Make sure to follow the contract specifications to send error codes that Trados can interpret. You are not limited to, and can send any codes, but that would mean that special cases will not be treated.
