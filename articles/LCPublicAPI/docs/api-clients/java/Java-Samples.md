# Trados Cloud Platform SDK Samples for Java

## Console Application Sample

The console application sample is available for download on [GitHub](https://github.com/RWS/language-cloud-public-api-samples/tree/main/Java/PublicApi.Sample.Console.Java).

The sample contains three examples of how to instantiate and work with an API client provided by the Trados Cloud Platform SDK. You can either use the supplied provider or handle the authentication yourself:

#### 1. Instantiating a client using service credentials

You can instantiate a client using the provided `LanguageCloudClientProvider.builder()` pattern.

This method requires you to provide a `ServiceCredentials` object containing your `clientID`, `clientSecret`, and `tenant`. *See the [Authentication](../../../docs/Authentication.md) page for more details.*

```java
import com.rws.lt.lc.publicapi.sdk.api.GroupApi;
import com.rws.lt.lc.publicapi.sdk.auth.ServiceCredentials;
import com.rws.lt.lc.publicapi.sdk.client.LanguageCloudClientProvider;
import com.rws.lt.lc.publicapi.sdk.model.Group;
import com.rws.lt.lc.publicapi.sdk.model.ListGroupsResponse;

import java.util.stream.Collectors;
...

//instantiate the credentials
ServiceCredentials serviceCredentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");

// instantiate the LanguageCloudClientProvider
LanguageCloudClientProvider languageCloudClientProvider = LanguageCloudClientProvider
    .builder()
    .withRegion("eu") // optional (default is "eu")
    .withServiceCredentials(serviceCredentials)
    .build();

// instantiate the client
GroupApi groupApi = languageCloudClientProvider.getGroupClient();

// use the client
ListGroupsResponse groupsResponse = groupApi.listGroups(new GroupApi.ListGroupsQueryParams());
System.out.println("Groups:");
System.out.println(
    groupsResponse.getItems().stream()
    .map(Group::getName)
    .collect(Collectors.joining("\n")));
```

*\*Using this method, a unique TraceID will be generated for each request.*

> [!NOTE]
> Make sure you always keep your credentials safe.


#### 2. Instantiating a client using context scoping

This method allows you to make API calls with multiple different service credentials using the same client instance.

We provide an `LCContext` which exposes scoping options. You can use this to scope your API calls in different contexts. The sample contains an example with two different service credentials:

```java
import com.rws.lt.lc.publicapi.sdk.api.UserApi;
import com.rws.lt.lc.publicapi.sdk.auth.ServiceCredentials;
import com.rws.lt.lc.publicapi.sdk.client.LanguageCloudClientProvider;
import com.rws.lt.lc.publicapi.sdk.context.ContextKeys;
import com.rws.lt.lc.publicapi.sdk.context.LCContext;
import com.rws.lt.lc.publicapi.sdk.model.ListUsersResponse;
import com.rws.lt.lc.publicapi.sdk.model.User;

import java.util.stream.Collectors;
...

// define credentials for your first user
ServiceCredentials credentials_1 = new ServiceCredentials("YOUR_CLIENT_ID_1", "YOUR_CLIENT_SECRET_1", "YOUR_TENANT_ID_1");

// define credentials for your second user
ServiceCredentials credentials_2 = new ServiceCredentials("YOUR_CLIENT_ID_2", "YOUR_CLIENT_SECRET_2", "YOUR_TENANT_ID_2");

// instantiate the LanguageCloudClientProvider
LanguageCloudClientProvider languageCloudClientProvider_contextAuth = LanguageCloudClientProvider
    .builder()
    .withRegion("eu") // optional (default is "eu")
    .build();

// instantiate the client without credentials
UserApi userApi = languageCloudClientProvider_contextAuth.getUserClient();


Runnable listUsersExecutable = () -> {
    ListUsersResponse usersResponse = userApi.listUsers(new UserApi.ListUsersQueryParams());
    System.out.println(LCContext.getFromLCContext(ContextKeys.TRACE_ID_KEY) + " >> Users for tenant " + LCContext.getFromLCContext(ContextKeys.TENANT_ID_KEY) + " are:");
    System.out.println(usersResponse.getItems().stream().map(User::getId).collect(Collectors.joining("\n")));
};

// create a context scope and execute inside with tenant 1
LCContext.executeInScope(listUsersExecutable, serviceCredentials1, "trace-id-1");

System.out.println("--------------------------------------------------");
// create a context scope and execute inside with tenant 2
LCContext.executeInScope(listUsersExecutable, serviceCredentials2, "trace-id-2");
```

#### 3. Instantiating a client with App service credentials

This method allows you to make an API call from an App for different tenants using the same client instance. See more at [Extensibility Docs](https://eu.cloud.trados.com/lc/extensibility-docs/937a747af31a0-concepts#apps).


We provide an `LCContext` which exposes scoping options. You can use this to scope your API calls in different contexts. The sample contains an example with an App installed in multiple tenants:

```java
import com.rws.lt.lc.publicapi.sdk.api.UserApi;
import com.rws.lt.lc.publicapi.sdk.auth.ServiceCredentials;
import com.rws.lt.lc.publicapi.sdk.client.LanguageCloudClientProvider;
import com.rws.lt.lc.publicapi.sdk.context.ContextKeys;
import com.rws.lt.lc.publicapi.sdk.context.LCContext;
import com.rws.lt.lc.publicapi.sdk.model.ListUsersResponse;
import com.rws.lt.lc.publicapi.sdk.model.User;

import java.util.stream.Collectors;
...

//instantiate the credentials
ServiceCredentials serviceCredentials = new ServiceCredentials("YOUR_CLIENT_ID_1", "YOUR_CLIENT_SECRET_1");

// instantiate the LanguageCloudClientProvider
LanguageCloudClientProvider languageCloudClientProvider_contextAuth = LanguageCloudClientProvider
        .builder()
        .withRegion("eu") // optional (default is "eu")
        .withServiceCredentials(serviceCredentials)
        .build();

// instantiate the client without credentials
UserApi userApi = languageCloudClientProvider_contextAuth.getUserClient();


Runnable listUsersExecutable = () -> {
    ListUsersResponse usersResponse = userApi.listUsers(new UserApi.ListUsersQueryParams());
    System.out.println(LCContext.getFromLCContext(ContextKeys.TRACE_ID_KEY) + " >> Users for tenant " + LCContext.getFromLCContext(ContextKeys.TENANT_ID_KEY) + " are:");
    System.out.println(usersResponse.getItems().stream().map(User::getId).collect(Collectors.joining("\n")));
};

// create a context scope and execute inside with tenant 1
LCContext.executeInScope(listUsersExecutable, TENANT_VALUE_1, "trace-id-1");

System.out.println("--------------------------------------------------");
// create a context scope and execute inside with tenant 2
LCContext.executeInScope(listUsersExecutable, TENANT_VALUE_2, "trace-id-2");
    
```
#### 4. Instantiating a client using custom authentication

If you want complete control over client authentication, you can provide a `CustomServiceAuthenticationHandler`:

```java
import com.rws.lt.lc.publicapi.sdk.api.ProjectApi;
import com.rws.lt.lc.publicapi.sdk.auth.AuthenticationService;
import com.rws.lt.lc.publicapi.sdk.auth.CustomServiceAuthenticationHandler;
import com.rws.lt.lc.publicapi.sdk.auth.ServiceCredentials;
import com.rws.lt.lc.publicapi.sdk.client.LanguageCloudClientProvider;
import com.rws.lt.lc.publicapi.sdk.model.ListProjectsResponse;

import java.util.List;
import java.util.UUID;
...

AuthenticationService authenticationService = AuthenticationService.getInstance();

CustomServiceAuthenticationHandler customServiceAuthenticationHandler = new CustomServiceAuthenticationHandler(authenticationService) {
    @Override
    public ServiceCredentials getServiceCredentials() {
        return new ServiceCredentials(CLIENT_ID, CLIENT_SECRET);
    }

    @Override
    public String getTraceId() {
        return UUID.randomUUID().toString();
    }

    @Override
    public String getTenantId() {
        return TENANT_VALUE;
    }
};

LanguageCloudClientProvider languageCloudCustomClientProvider = LanguageCloudClientProvider
    .builder()
    .withRegion("eu") // optional (default is "eu")
    .withRequestInterceptors(List.of(customServiceAuthenticationHandler))
    .build();

// instantiate the client
ProjectApi projectApi = languageCloudCustomClientProvider.getProjectClient();

// use the client
ListProjectsResponse projectsResponse = projectApi.listProjects(new ProjectApi.ListProjectsQueryParams());
System.out.println("Projects:");
System.out.println(projectsResponse.getItems());
```

<br></br>

## Web API Sample
The web API sample is available for download on [GitHub](https://github.com/RWS/language-cloud-public-api-samples/tree/main/Java/PublicApi.Sample.Web.Java).

The sample contains two examples of how to instantiate and work with an API client provided by the Trados Cloud Platform SDK for Java:

- *If you want to use the provided authentication mechanism, create a custom handler that inherits from `CustomServiceAuthenticationHandler`.*

In our example, we created the `CustomAuthenticationHandler` class, which inherits from `CustomServiceAuthenticationHandler`. The `CustomServiceAuthenticationHandler` class already provides an authentication mechanism.

We have overridden the `getServiceCredentials`, `getTraceId`, and `getTenantId` methods and provided our implementations, as these will be called by `CustomAuthenticationHandler`:

```java
// Provide your implementation. A possible example can be:
@Override
public ServiceCredentials getServiceCredentials() {
    return repository.getServiceCredentialsById(getCurrentUser().getUserId());
}

// serviceCredentials may or may not be bound to a tenant
@Override
public String getTenantId() {
  return repository.getServiceCredentialsById(getCurrentUser().getUserId()).getTenantId();
  // or
  // return repository.getTenantForUserId(getCurrentUser().getUserId());
}

@Override
public String getTraceId() {
    return UUID.randomUUID().toString();
}

private User getCurrentUser() {
  Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
  return (User) authentication.getPrincipal();
}
```

We registered an instance of `LanguageCloudClientProvider` as a bean in the `ConfigClass` class and created beans for all exposed API clients:
```java
// the LanguageCloudClientProvider instance
@Bean
public LanguageCloudClientProvider getPublicApiClient(CustomAuthenticationHandler customAuthenticationHandler) {
    return LanguageCloudClientProvider.builder()
            .withRegion("eu") // optional (default is "eu")
            .withRequestInterceptors(List.of(customAuthenticationHandler)).build();
}

//the AccountApi bean 
@Bean
public AccountApi getAccountApi(LanguageCloudClientProvider languageCloudClientProvider) {
    return languageCloudClientProvider.getAccountClient();
}
```

We can then use the registered client in the controller (or any other class resolved through Dependency Injection):

```java
@RestController
public class AccountController extends ResponseEntityExceptionHandler {

    @Autowired
    private AccountApi accountApi;

    @GetMapping("/getAccounts/{userId}")
    public List<Account> listAccounts(@PathVariable("userId") int userId) {
        User user = new User(userId);
        Authentication authentication = new UsernamePasswordAuthenticationToken(user, null);
        SecurityContext sc = SecurityContextHolder.getContext();
        sc.setAuthentication(authentication);

        ListMyAccountsResponse listMyAccountsResponse = accountApi.listMyAccounts();

        return listMyAccountsResponse.getItems();
    }
}
```


