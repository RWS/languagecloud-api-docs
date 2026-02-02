# Add-on to App Migration

If you previously have developed an add-on, you have to migrate it to the app concept. Add-ons have in the descriptor the property `descriptorVersion` with value `1.3` or less. Apps start with `descriptorVersion` `1.4`.

## Changes

The most important changes: 

* Lifecycle events have been renamed for consistency, and the payload have been changed. But the blueprint code covers these and following it should get you started really fast.
* Auth0 `clientId` and `clientSecret` have been moved from install (tenant) scope to app scope. Where before you had a separate set of Auth0 credentials for each install, now you get one set when your app is registered in Trados. That means that you can get the token from Auth0 once (for the period of its validity), and make Trados Cloud Platform API requests for any tenant that has the app installed, by providing the tenant in the X-LC-TenantId header.
* We've introduced a new Lifecycle event `UPDATED` which will be used to update the app on various changes. Currently it can update the `clientId` and `clientSecret`. That is useful if credentials need to be cycled.

The Migration Blueprints cover how to update the add-on to support all these new features.

Management changes:
* Publishing doesn't require you to install the current app version.
* The current available app version will be published when you publish.
* When registering, you'll have an extra field where you select people from your account that should receive emails regarding managing your app.


## Upgrade Process

The process of migration should look like:

* Depending on if your add-on is Java or .NET, go to the appropriate blueprint page: [Java Migration Blueprint](blueprints/Java-Migration-Blueprint.md) or [.NET Migration Blueprint](blueprints/Dot-Net-Migration-Blueprint.md). This page will contain details on what changes must be done.
* Perform the changes in your code and deploy it to a test instance
* Test the changes by having an add-on installed on your account before the app deploy. After the deploy update your install to the new version and confirm it's functioning as previously.
* Deploy your "Production" instance
* If it was published to App Store, publish the new version

Because you might have installs with the old version, you'll have to maintain the code to handle requests for version 1.3 and 1.4 - for example the endpoint paths that were specified in the old descriptor should be still valid.

