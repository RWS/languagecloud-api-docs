---
stoplight-id: 7295d1d88211f
---

# Registering the App

Registration is the first step in integrating your app into the Trados platform.

To register a new app, you need to:
1. After you log in, navigate to the **RWS AppStore** from the user icon menu.

<!--
focus: false
-->
![AccessRWSAppStore](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/AccessRWSAppStore-app.gif?raw=true)

2. Go to **My Apps** tab, select **New App** and provide the following details:
    - the *Development Name* and *Development Description*, which will only be visible to the developer tenant (do not confuse them with the name and the description of the app descriptor)
    - the *App Descriptor URL* is the app's [descriptor](../../App-API.v1.json/paths/~1descriptor/get) address. This must be a secure URL.
    - the *Development App* checkbox represents whether your app is intended for development and testing purposes. Development apps cannot be published. 
3. After filling in these fields, finish the registration by clicking the **Register** button.

<!--
focus: false
-->
![Register](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/RegisterAppDevCheckbox.gif?raw=true)

Common issues that may occur during registration include:


Issue | Fix suggestion 
---------|-----------
Invalid Descriptor URL | Make sure the provided URL is formed correctly and it points to your descriptor endpoint. 
 Incorrect `BaseUrl` | If you are using one of our blueprints, check the blueprint guides ([.NET](../development/blueprints/Dot-Net-Blueprint.md#appsettingsjson) or [Java](../development/blueprints/Java-Blueprint.md#applicationyml)) on how to set up the `BaseUrl` field.
 Already registered | This would normally occur if you already registered your app. If so, you can [unregister](./Retiring.md) the old version and perform the registration once again.
 Descriptor does not comply with the [contract](../../App-API.v1.json/paths/~1descriptor/get) | Make sure the required fields are returned and the allowed values correspond to the ones from the contract.