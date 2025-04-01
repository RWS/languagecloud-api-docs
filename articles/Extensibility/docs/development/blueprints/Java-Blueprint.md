# Java Blueprint

Our Java blueprint is a Spring Boot web application built on Java 11, it can be run out of the box and it can even be registered in Trados immediately, although it will not provide any functional extensions.

## Getting the blueprint

The blueprint is available in our GitHub repository: [https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints/javaAppBlueprint](https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints/javaAppBlueprint)

## Project structure

To explain the code structure for the blueprint we can have an overview look at the Project tree:

![Java Project Structure](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/blueprints/JavaBPStructure.PNG?raw=true)

For a developer, the following areas may be of interest:
* **web**: this includes the controllers for standard endpoints and also placeholders for Extensions.
* **persistence**: it contains complete functionality for account management backed by MongoDB.
* **exception**: it's used for returning errors to Trados.
* **transfer**: it has the pre-built classes for all the models from the contract.
* **service**: this is where the main functionality can be concentrated. You can use it as a thin business layer.
* **resources/application.yml** is where all your configurations go.
* **resources/descriptor.json** is the file that describes the app functionality according to the contract.
* **docker/Dockerfile**: it is used for debugging in Docker containers.

## First steps

First, let's make the blueprint yours by renaming the files and the configuration settings. A quick tip would be to search by these keywords: `blueprint`, `rws`. Some of the renaming actions you may want to consider:
- Rename the main package `com.rws.lt.lc.blueprint`
- Update the `pom.xml`
    ```xml
    <groupId>com.rws.lt.lc.app.blueprint</groupId>
    <artifactId>lc-blueprint-app</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>
    <name>LC Blueprint App Service</name>
    ```
- Rename the main class `BlueprintApplication`
- Update the following places from `application.yml`
    ```yml
    application:
      name: lc.app.blueprint
    ...
    spring:
      application:
        name: lc-blueprint-app
      data:
        mongodb:
          ...
          database: lc-blueprint-app
    ```
- Update `Dockerfile` if you plan to use it

Run it and ensure there are no problems before you continue with your customization.

Go through all the files and take note of placeholders - methods without implementation, or *TODOs*. The blueprint is a placeholder with as much plumbing in place as possible, but it still needs filling with your details.

Depending on the extensions you are building, you might want to add one or more 'Service' classes that will have your business code.

Some files are placed there as examples, and if you don't need them, you can remove them. For example, there is the `AutomaticTaskController.java` for the `lc.automatictask` extension or `TranslateController.java` and `TranslationEnginesController.java` for the `lc.mtprovider` extension. Most apps will implement only one extension type, so you might want to keep one and remove the other.

### application.yml

This is the default configuration for Spring Boot. The blueprint provides a rather simple file with various sections. The ones of interest are:

```yml
...
# TODO: replace with a real URL
baseUrl: "replace-me"
...
spring:
  ...
  data:
    mongodb:
      authentication-database: admin
      database: lc-blueprint-app
      uri: mongodb://localhost:27017
      ssl-enabled: false
      auto-index-creation: false
...
# Logging
logging:
  level:
    com.rws: INFO
...
# TODO: replace with a real doc URL
documentation.url: "replace-me"

integration:
  public-api:
    basePublicApiV1Url: https://languagecloud.sdl.com/lc-api/public-api/v1
    retrievePublicKeyByIdUrl: ${integration.public-api.basePublicApiV1Url}/.well-known/jwks.json/{kid}
```

The `baseUrl` above is used to populate the property with the same name from the descriptor.

The `spring.data.mongodb` provides the connection string for MongoDB and also the database name. The database will be created automatically and doesn't need to be provisioned upfront. If you decide to go with another database, you can remove it.

The `logging` section sets the minimum log level for Lombok.

The `documentation.url` specifies the address where to redirect for a full documentation set. You need to specify a valid URL here. Alternatively, you can return a full HTML page in the `getDocumentation()` action in the `DocumentationController` instead of using redirection.

The `integration.public-api` section provides the settings required by the app to authorize the requests from Trados.

### descriptor.json

This file will be returned from the `/descriptor` endpoint as described in the API Contract. It is used to describe the functionality of the app, inform Trados of all the paths to the endpoints, provide names and descriptions, and also instruct which configuration settings are required from the user during the installation.

### Database

The blueprint is using MongoDB as its database engine. This is not a requirement, and it can be substituted for any database. There is the `AccountSettingsRepository` interface that extends the `CrudRepository` from Spring. The interface methods can be replaced or implemented in a concrete class.

![JavaPersistence](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/blueprints/JavaBPPersistence.PNG?raw=true)

POJO classes in the `domain` package might need adjustments as these are tailored for MongoDB.

The next step would be to replace the `MongoConfiguration.java`class with a configuration class for your database.

### Authentication and Authorization

Most endpoints in the app need to be secured. The API Contract specifies which endpoints are secured and which are not. For example, the `/descriptor` endpoint should not be secured, as this is not sensitive information, but it is valuable for manually invoking the endpoint and checking that the correct descriptor is returned.

By default, all the endpoints in the blueprint are secured except for the ones annotated with `@GenericAuthorization`. These endpoints are: `/descriptor`, `/health` and `/documentation`.
All the infrastructure code is already in place, and no other configuration is required.

When implementing extension endpoints, since all extension endpoints need to be secured, you must **NOT** annotate the action methods with `@GenericAuthorization`. You can check `AutomaticTaskController.java`, `TranslateController.java`, or `TranslationEnginesController.java` as references.

### Context

Since the apps can be used on multiple accounts it's important to understand for which account the current call is being executed, to get either Service User credentials or configuration settings.

To get the current account, you can use the `getActiveAccountId()` method (from the `RequestLocalContext.java`) that retrieves the value from the context object which is a `ThreadLocal` map. This can be done anywhere in the code as long as you are in an HTTP context:

```java
String tenantId = RequestLocalContext.getActiveAccountId();
```

The blueprint provides access to Configuration data and Account Information out of the box. If you need more data to be stored, you can extend the Repository.

Access to account data is available by injecting the `AccountSettingsRepository` interface and using one of the available methods, for example:
```java
AccountSettings entity = accountSettingsRepository.findAccountSettings(tenantId);
```

This will provide access to the `configurations` as well as to the `clientCredentials`. The `clientCredentials` type provides the `clientId` and `clientSecret` that are used for making calls to the Trados Cloud Platform API.

### Logs

The blueprint is configured to use the Lombok logging approach out of the box. It will write only INFO level logs by default. This can be changed in the `logback.xml` by changing from `INFO` to `WARN`:

```xml
<root level="INFO">
    <appender-ref ref="CONSOLE" />
</root>
```

You can enable the `LOGGER` anywhere in the code by annotating the classes with the `@Slf4j` [annotation](https://projectlombok.org/api/lombok/extern/slf4j/Slf4j.html) from Lombok. Example of logging:

```java
LOGGER.info("getDescriptor >>");
```

Among other useful details, the logs will include by default the **tenantId** and the **traceId** which can be helpful when debugging.

Note that you can also set the `logging.level.com.rws` environment variable to your desired minimum logging level. This works great when you need to change the logging level in a Docker container, as you just send the environment settings when you start the container.

### Health checks

Trados will make sure that the app is up and running by making requests to the `/health` endpoint. The blueprint provides a default implementation that relies on the Spring [HealthEndpoint](https://docs.spring.io/spring-boot/docs/current/api/org/springframework/boot/actuate/health/HealthEndpoint.html). Additional changes can be implemented.

### Error reporting

When you need to return an error to Trados, it's enough to raise an Exception of type AppException. The various constructor overloads allow for customization of the response. The plumbing in the blueprint will take care to transform the exception into an error payload according to the contract.

Make sure to follow the contract specifications to send error codes that Trados can interpret. You are not limited to these, and you can send any codes, but that would mean that special cases will not be addressed.
