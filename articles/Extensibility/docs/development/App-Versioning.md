---
stoplight-id: 8qooshkz6t5ps
---


# App Versioning

This article explains how the app versions work and how to use multiple versions of your app.

## Versions in Trados

When registering the app, the descriptor is saved in Trados as the initial version. The [descriptor](../../App-API.v1.json/paths/~1descriptor/get) includes a `version` field, which indicates the app's version. This version number should be incremented each time changes are made to the descriptor (such as endpoints or naming) to ensure Trados detects the new version. Newly detected versions are added alongside existing ones. This enables the installed instances to be associated with a particular version of the app. 

Throughout an app's lifespan, it can be installed in various versions across different tenants. For instance, one tenant might install version 1.0.1, another 1.0.2, and a third 1.0.3.  Although they expect to use the app at these particular versions, if no special actions are taken by the developer, they will probably all be using the same instance, which probably has a single implementation and does not take into consideration the expected version.

## Versioning Pitfall

To delve deeper into the issue highlighted above, consider the following scenario:

Your app has a public version installed across multiple tenants. Eventually, you opt to modify an extension's functionality. Upon deploying these changes, integrations will utilize the updated instance, thereby adopting the newly implemented business logic. However, this may not align with your intentions, or worse, it could introduce errors for tenants who have installed the older version and expect it to maintain its previous behavior.

## Versioning Your App

To ensure that new behavior only affects new installations and tenants updating to the latest version, you can version the extension endpoints. For example, suppose your app implements an Automatic Task Extension with a [submit](../../App-API.v1.json/paths/~1lc.automatictask.submit/post) endpoint like `{baseUrl}/v1/submit`, as specified in the contract. To prevent older versions from accessing the new functionality, create a new set of endpoints labeled with a new version, such as `{baseUrl}/v2/submit`, exclusively available in the updated descriptor version. Consequently, older versions won't recognize the existence of the v2 endpoint and will continue to use the v1 endpoint. Ensure that the v1 endpoint remains accessible at the same path defined in the older descriptor.

For more details on version updates, refer to this dedicated [guide](../appManagement/Updating.md).

## Versioning Headers

An alternative option to handle different business logic based on the installed version is to utilize the provided HTTP headers. These headers (`appVersion`, `extensionPointVersion`, `extensionId`) allow developers to implement custom functionality based on the actual version of the installed apps across different customers.
