# Trados Cloud Platform SDK Samples for Java

## Console Application Sample

The console application sample is available for download on [GitHub](https://github.com/RWS/language-cloud-public-api-samples/tree/main/Java/PublicApi.Sample.Console.Java).

The sample contains 3 examples of how to instantiate and work with an API client provided by the Trados Cloud Platform SDK. You can either use the supplied provider, or handle the authentication on you own: 

#### 1. Instantiating a client using credentials

You can instantiate a client using the supplied `LanguageCloudClientProvider` class. This method requires you provide a `ServiceCredentials` object, which should contain your `clientID`, `clientSecret` and the `tenant`. *See the [Authentication](../../../docs/Authentication.md) page for more details.*

```java
import com.rws.lt.lc.publicapi.sdk.api.GroupApi;
import com.rws.lt.lc.publicapi.sdk.auth.ServiceCredentials;
import com.rws.lt.lc.publicapi.sdk.client.LanguageCloudClientProvider;
import com.rws.lt.lc.publicapi.sdk.model.ListGroupsResponse;
...

//instantiate the credentials
ServiceCredentials serviceCredentials = new ServiceCredentials("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_TENANT_ID");

// instantiate the LanguageCloudClientProvider
LanguageCloudClientProvider languageCloudClientProvider_clientIdClientSecret = new LanguageCloudClientProvider(serviceCredentials);

// instantiate the client
GroupApi groupApi = languageCloudClientProvider_clientIdClientSecret.getGroupClient();

// use the client
ListGroupsResponse groupsResponse = groupApi.listGroups(new GroupApi.ListGroupsQueryParams());
System.out.println("Groups:");
System.out.println(groupsResponse.getItems());
```

 *\*Using this method, a unique TraceID will be generated on each request.*

  <!-- theme: info -->

> #### Info
>
> Make sure you always keep your credentials safe.


#### 2. Instantiating a client using context scoping

This method allows you to make an API call with 2 different users, using the same client instance. 

We provide an `LCContext` which exposes some scoping options. You can use this to scope your API calls in different contexts. The sample contains an example with 2 different users:

```java
import com.rws.lt.lc.publicapi.sdk.api.UserApi;
import com.rws.lt.lc.publicapi.sdk.auth.ServiceCredentials;
import com.rws.lt.lc.publicapi.sdk.client.LanguageCloudClientProvider;
import com.rws.lt.lc.publicapi.sdk.context.LCContext;
import com.rws.lt.lc.publicapi.sdk.model.ListUsersResponse;

import java.util.HashMap;
...

// define credentials for your first user
ServiceCredentials credentials_1 = new ServiceCredentials("YOUR_CLIENT_ID_1", "YOUR_CLIENT_SECRET_1", "YOUR_TENANT_ID_1");

// define credentials for your second user
ServiceCredentials credentials_2 = new ServiceCredentials("YOUR_CLIENT_ID_2", "YOUR_CLIENT_SECRET_2", "YOUR_TENANT_ID_2");

// instantiate the LanguageCloudClientProvider
LanguageCloudClientProvider languageCloudClientProvider_contextAuth = new LanguageCloudClientProvider();

// instantiate the client without credentials
UserApi userApi = languageCloudClientProvider_contextAuth.getUserClient();

// create a context scope and use the client.You can also provide your own traceId
try (LCContext lcContext = LCContext.beginScope(credentials_1, "trace-id-1");) {
            ListUsersResponse usersResponse = userApi.listUsers(UserApi.ListUsersQueryParams());
            System.out.println("Users:");
            System.out.println(usersResponse.getItems());
        } catch (Exception e) {
            System.out.println("Error when retrieving users with credentials saved to context.");
        }

// create a context scope and use the client.You can also provide your own traceId
 try (LCContext lcContext = LCContext.beginScope(credentials_2, "trace-id-2");) {
            ListUsersResponse usersResponse = userApi.listUsers(UserApi.ListUsersQueryParams());
            System.out.println("Users:");
            System.out.println(usersResponse.getItems());
        } catch (Exception e) {
            System.out.println("Error when retrieving users with credentials saved to context.");
            e.printStackTrace();
        }
```

#### 3. Instantiating a client using custom authentication

If you would like to have complete control over the client authentication, you can use provide a CustomServiceAuthenticationHandler:

```java
import com.rws.lt.lc.publicapi.sdk.api.ProjectApi;
import com.rws.lt.lc.publicapi.sdk.auth.AuthenticationService;
import com.rws.lt.lc.publicapi.sdk.auth.CustomServiceAuthenticationHandler;
import com.rws.lt.lc.publicapi.sdk.auth.ServiceCredentials;
import com.rws.lt.lc.publicapi.sdk.client.LanguageCloudClientProvider;
import com.rws.lt.lc.publicapi.sdk.model.ListProjectsResponse;

import java.util.UUID;
...

AuthenticationService authenticationService = new AuthenticationService("grant_type", "audience", "url");

CustomServiceAuthenticationHandler customServiceAuthenticationHandler = new CustomServiceAuthenticationHandler(authenticationService) {
  @Override
  public ServiceCredentials getServiceCredentials() {
      return new ServiceCredentials("YOUR_CLIENT_ID_1", "YOUR_CLIENT_SECRET_1", "YOUR_TENANT_ID_1");
  }

  @Override
  public String getTraceId() {
      return UUID.randomUUID().toString();
  }
};

LanguageCloudClientProvider languageCloudCustomClientProvider = new LanguageCloudClientProvider(customServiceAuthenticationHandler, "baseUrl");

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

- *If you want to use the provided authentication mechanism, a custom handler can be created, which must inherit from `CustomServiceAuthenticationHandler`.* 

- *If you want to handle authentication and tracing on you own, you could implement your own `DelegatingHandler`.*

In our example, we've created the `CustomAuthenticationHandler` class, which inherits from `CustomServiceAuthenticationHandler`. The `CustomServiceAuthenticationHandler` class already provides us with an authentication mechanism. We've overwritten the `getServiceCredentials` and `getTraceId` methods and provided our own implementations, as these will be called by `CustomAuthenticationHandler`:

```java
// Provide you own implementation. A possible example can be:
@Override
public ServiceCredentials getServiceCredentials() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    User user = (User) authentication.getPrincipal();

    return repository.getServiceCredentialsById(user.getUserId());
}

// Provide you own implementation. A possible example can be:
@Override
public String getTraceId() {
    return UUID.randomUUID().toString();
}
```

We registered an instance of LanguageCloudClientProvider as a bean in `ConfigClass` class and created beans for all API clients exposed: 
```java
// the LanguageCloudClientProvider instance
@Bean 
public LanguageCloudClientProvider getPublicApiClient(CustomAuthenticationHandler customAuthenticationHandler) {
        return new LanguageCloudClientProvider(customAuthenticationHandler, BASE_URL);
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
// inject the client
  @Autowired
  private AccountApi accountApi;
  ...
	
  // make an API call using the client
  ListMyAccountsResponse listMyAccountsResponse = accountApi.listMyAccounts();
  ...
}
```


