# Integration with Trados Cloud Platform API

Trados Cloud Extensibility supports extensive customizations. Using the Trados Cloud Platform API (the Public API) makes those customizations even more powerful.

This page explains how to use the API.

You can find the API documentation and contract here: [Trados Cloud Platform API](https://eu.cloud.trados.com/lc/api-docs/introduction)

The .NET blueprint currently includes examples. Java examples will be added in a future update.

## Prerequisites

To access the API, an app must declare a `scopes` value in its descriptor: `TENANT` or `TENANT_READ`.

- `TENANT` — requests read and write permissions.
- `TENANT_READ` — requests read-only permissions.

## .NET blueprint

The .NET blueprint uses the Rws.LanguageCloud.Sdk NuGet package. Update it to the latest available version.

Some infrastructure code has been introduced to simplify using the SDK, particularly because apps are expected to run in a multi-tenant environment and support multi-region deployments (or at least tenants in different regions).

No additional setup is required to start using the SDK.

There are two main scenarios to consider when using the SDK:

- In the context of an HTTP request — when handling an incoming request and the code has the current tenant context available.
- In background jobs — when processing queued work where no tenant context is present and you must create one explicitly.

The next sections cover each case.

### HTTP context

Inject `LanguageCloudClientFactory` into the class where you need it.

For example, you can get project details:

```csharp
    var tenantId = HttpContext.User?.GetTenantId();

    // Just as an example we'll try to make a Public API call
    var accountInfo = await _repository.GetAccountInfoByTenantId(tenantId).ConfigureAwait(false);
    string region = accountInfo.Region;

    // getting project details as an example of using the LC SDK, with implicit tenant from the current Http Context
    var projectDetails = await _languageCloudClientFactory.Region(region).ProjectClient.GetProjectAsync(automaticTaskRequest.ProjectId);

```

The `HttpContext` is available inside controllers. To access it from other classes, use `IHttpContextAccessor` or pass `tenantId` and `region` through method calls.

To use the factory, first identify the tenant's region. This value is stored in the account information when the app is installed.

Note: Region may be missing for accounts where the app was registered with `descriptorVersion` < 1.4. In that case, default the region to `eu`.

The factory exposes different clients for the various APIs.

### Background jobs

See the previous section for related details.

Background jobs will usually have the `tenantId` stored, and often the `region` as well. If the region isn't stored, retrieve it from `AccountInfo` in the repository.

Assuming you have these details, you can make a scoped call with the SDK:

```csharp
    using (Context.BeginScope(tenantId))
    {
        // getting project details as an example of using the LC SDK
        var projectDetailsForExplicitTenant = await _languageCloudClientFactory.Region(region).ProjectClient.GetProjectAsync(automaticTaskRequest.ProjectId);
    }
```

### Extending the factory with more clients

The blueprint includes two implemented clients as examples: `AccountClient` and `ProjectClient`. To use additional clients, add them to `RegionClientContainerFactory`.
