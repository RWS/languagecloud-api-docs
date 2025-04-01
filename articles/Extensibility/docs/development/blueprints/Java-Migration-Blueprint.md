# Java Migration Blueprint

This blueprint should be used exclusively to upgrade your existing Java add-on to an app while maintaining the compatibility with the old add-on installs.

The migration blueprint can be found [here](https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints/javaAppMigrationBlueprint).

There are a couple of main points to consider when doing the upgrade:

## Descriptor Changes

### Descriptor Version

First and foremost you'll need to change the `descriptorVersion` field to `1.4` in the descriptor JSON. This is the version that tells Trados Enterprise that your add-on has became an app and needs to be handled accordingly.

> In addition to `descriptorVersion`, the `version` field also needs to be updated to signal Trados Enterprise that there's a new descriptor available, as per usual.

### App Lifecycle Endpoint

The old `addonLifecycle` standard endpoint needs to be replaced with the `appLifecycle` [endpoint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/resources/descriptor.json#L55) but at the same time  the old [route](https://github.com/RWS/language-cloud-extensibility/blob/app_updates/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/web/LifecycleController.java#L22) must be kept along the new route for backwards compatibility.

## New Lifecycle Events

Some lifecycle events have been renamed while others have been added.

### INSTALLED

The `ACTIVATED` event is now called `INSTALLED`. To ensure backwards compatibility with the old form, the migration blueprint knows to handle [both](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/transfer/lifecycle/AppLifecycleEvent.java#L19-L20).

### UNINSTALLED

Similarly to the `ACTIVATED` event, the `DEACTIVATED` event is now called `UNINSTALLED`. Once again, the migration blueprint supports [both](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/transfer/lifecycle/AppLifecycleEvent.java#L24-L25).

### UPDATED

To explain the purpose of the `UPDATED` event we have to reflect on the `REGISTERED` changes. 

Previously, Trados Enterprise was providing different pairs of credentials for each tenant that was installing the add-on. An app is now provided with a single pair of credentials just once, at registration.

Since, your app has already been registered as an add-on, the `REGISTERED` event will no longer be sent so Trados Enterprise will provide the credentials in the same manner but via the new `UPDATED` event.

The `UPDATED` event is sent by Trados Enterprise when the `descriptorVersion: 1.4` is detected. When this event is invoked, the app(former add-on) needs to save the received pair of credentials(clientId/clientSecret) per registration and discard the old credentials saved per tenant installs.

## Trados Cloud Platform API Authentication

If your add-on was integrating with Trados Cloud Platform API, the credentials used to authenticate came from the tenant installation(`accountSettings` collection).

With the new approach the credentials should now be retrieved from the app registration(`appRegistration` collection). To access the registration credentials you can call the `com.rws.lt.lc.blueprint.persistence.findFirst` [method](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/persistence/AppRegistrationRepository.java#L9).

For eg:
```java
AppRegistration entity = appRegistrationRepository.findFirst();
ClientCredentials clientCredentials = entity.getClientCredentials();
```

For more details see the [Trados Cloud Platform API guide](../Language-Cloud-API.md#Credentials).

## Summary

To help you quickly implement the migration changes we gathered below a list of files that you need to look into:

- [descriptor.json](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/resources/descriptor.json)
- [LifecycleController.java](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/web/LifecycleController.java)
- [UpdatedEvent.java](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/transfer/lifecycle/UpdatedEvent.java)
- [AppLifecycleEvent.java](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/transfer/lifecycle/AppLifecycleEvent.java)
- [AccountSettingsService.java](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/service/AccountSettingsService.java)
- [AccountSettingsAtomicRepository.java](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/persistence/AccountSettingsAtomicRepository.java)
- [AccountSettingsAtomicRepositoryImpl.java](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/persistence/AccountSettingsAtomicRepositoryImpl.java)
- [AccountSettingsRepository.java](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppMigrationBlueprint/src/main/java/com/rws/lt/lc/blueprint/persistence/AccountSettingsRepository.java)
