---
stoplight-id: 4x29bwcvq2f84
tags: [Development]
---

# Multi-Region

To fulfill the requirements of our customers, Trados Enterprise allows multi-region deployments of your app.

To enable multi-region on your app you must provide regional instances of your app and include their `regionalBaseUrls` in your [descriptor](../../api/Extensibility-API.v1-fv.html#/operations/descriptor).

> [!NOTE]
> Multi-Region is only supported on apps starting with `decriptorVersion: 1.4`

> [!WARNING]
> Please note that the responsibility for ensuring region-specific URLs lies with the developer. The URLs should accurately reflect the physical location of the instances.

Currently, the supported regions are Europe(`eu`) and Canada(`ca`). Depending on where your app is deployed you can choose either one or both of them. This will tell Trados what endpoints to invoke based on where the consumer tenant is living.

> [!WARNING]
> All instances, in all regions should provide the exact same descriptor.

## Installing an App with Multi-Region support

When a consumer installs an app, if `regionalBaseUrls` is present and same region as consumer's is available, that region will be used.

If your app does not provide the region where the consumer tenant belongs, the consumer will be notified before installing the app that the global region (`baseUrl`) will be used instead.

![RegionalInstall](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/RegionalInstallPopupNew.png?raw=true)

> [!WARNING]
> Once installed globally, if the app adds support for a new region, the consumers will have to reinstall it to change the region. 

The `INSTALLED` lifecycle event now includes the region information for the account where the app is installed so you can save it in the database and use it to identify to which regions calls should be made (for ex. which region/url to use for Public API). That is already implemented in the provided [Java](https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints/javaAppBlueprint) and [.NET](https://github.com/RWS/language-cloud-extensibility/tree/main/blueprints/dotNetAppBlueprint) blueprints.

## Base URL vs Multi-Region Base URLs

The `baseUrl` property from [descriptor](../../api/Extensibility-API.v1-fv.html#/operations/descriptor) remains mandatory even if you add the `regionalBaseUrls` property(which is optional).

> [!WARNING]
> The `baseUrl` in your app should stay fixed and not change based on region. When an App is registered, `baseUrl` from that initial descriptor is used for setting audience for all future authentication requests, independent of regions (it is possible to change it later, see [Changing Base URL](App-Descriptor.md#changing-base-url). 

Your "multi-region descriptor" should look something like this:
```json
{
  // baseUrl - also treated as global path  
  "baseUrl": "foo.com/app/v1"
  "regionalBaseUrls": {
    "eu": "eu.foo.com/app/v1",
    "ca": "ca.foo.com/app/v1"
  }
  //..
}
```

> [!NOTE]
> It is also acceptable to have the same URL in `baseUrl` as for one of regions in your `regionalBaseUrls` property.

The `baseUrl` is treated as a global region URL and is still used in the following scenarios even if `regionalBaseUrls` is also defined:

1. Health checks - the `/health` endpoint that is periodically invoked to check the health status of your app
2. Version checks - the `/descriptor` endpoint that is periodically invoked to check for new versions(by the `version` property). 
    > [!NOTE]
    > It is the developer's responsibility to keep the version of the regional instances in sync.
3. `UPDATED` lifecycle event - explained below in the [Special Case](#special-case) section.

The regional URLs from `regionalBaseUrl` are used in the following scenarios:

1. `REGISTERED`/`UNREGISTERED` lifecycle events - each regional URL is invoked and `baseUrl`. If `baseUrl` is same as one of the regional URLs, the events  will be sent only once for that URL, to avoid duplicating them.
2. Tenant-based requests(if install was done with a region and not a `baseUrl` - region was available at the time of install):
    1. `INSTALLED`/`UNINSTALLED` lifecycle events
    2. GET/Update/Validate configuration
    3. Webhooks - if your app supports webhooks they will be sent to your regional URLs
    4. Extension endpoints

### Examples

If your app offers only a `baseUrl` with no `regionalBaseUrls`, for ex:
```json
...
"baseUrl": "foo.com/app/v1"
...
```
When someone will try to install it, they will see a popup informing them that the app does not provide data residency in the same region as them and will ask them to confirm if they want to proceed with installation.

Let's see another example where only one region is specified:
```json
...
"baseUrl": "foo.com/app/v1",
"regionalBaseUrls": {
  "ca": "ca.foo.com/app/v1"
}
...
```
If a user in Canada region tries to install the App, the installation will go per usual. If a user in Europe, tries to install it, the confirmation popup will show up because Europe is not specified explicitly. 

For the case were all currently supported regions are specified:
```json
...
"baseUrl": "foo.com/app/v1"
"regionalBaseUrls": {
  "eu": "eu.foo.com/app/v1",
  "ca": "ca.foo.com/app/v1"
}
...
```
When someone installs the app from Canada region or from Europe region, the installation will proceed as usual with no popups. If in the future a new region is introduced, but the app is not updated, users in the new region will be able to install the app but they will be met with the confirmation popup.

`baseUrl` can be any valid url where calls will be processed as per documentation. Any of the following are valid:
```json
...
"baseUrl": "foo.com/app/v1"
"regionalBaseUrls": {
  "eu": "eu.foo.com/app/v1",
  "ca": "ca.foo.com/app/v1"
}
...
```
```json
...
"baseUrl": "eu.foo.com/app/v1"
"regionalBaseUrls": {
  "eu": "eu.foo.com/app/v1",
  "ca": "ca.foo.com/app/v1"
}
...
```
```json
...
"baseUrl": "ca.foo.com/app/v1"
"regionalBaseUrls": {
  "eu": "eu.foo.com/app/v1",
  "ca": "ca.foo.com/app/v1"
}
...
```

## Multi-Region on Fresh Apps

Registering a new app that comes from the start with `regionalBaseUrls` will trigger the [REGISTERED event](./Lifecycle.md#registered-event) notifications for each regional base URL as well as for `baseUrl` if not already present in the `regionalBaseUrls`. The same pair of credentials will be sent to each URL.

## Multi-Region on Existing Apps

If your app has been registered without the `regionalBaseUrls` property it means it was only available globally via the `baseUrl` property.

To add regional support you will have to include `regionalBaseUrls` in your descriptor. When Trados detects the new version it will sent the [REGISTERED event](./Lifecycle.md#registered-event) only to the regional URLs that have been added in that new version. 

The same pair of credentials that were initially sent to the `baseUrl` will also be sent to the regional URLs. It is necessary that all your app deployments know to handle the event and store the received credentials securely.

### Special Case

This section is for old add-ons(`decriptorVersion:1.3`) that have to be migrated to apps(`decriptorVersion:1.4`) and also want to support multi-region on the new version.

As described in the [migration guide](./Add-On-To-App-Migration.md) when a descriptor with `decriptorVersion:1.4` is detected, Trados will send the `UPDATED` event with a new pair of credentials. This event will be sent globally(only to the `baseUrl`) as before.

After the `UPDATED` event was successfully received by the app, Trados will also send the `REGISTERED` event for each of the regional base URLs with the same pair of credentials from the previously sent `UPDATED` event.

## Recommendations

To comply with data residency rules, make sure you provide instances for all supported regions, and your instances are physically in the specified region and there communication channel does not cross the region borders.

Don't hard code the regions in your code. Make sure your code is flexible and can handle any new region. That way you will future proof your app as we are adding new regions.

Decide on a primary region and set the `baseUrl` to that region url. That should simplify your deployment and configuration.
