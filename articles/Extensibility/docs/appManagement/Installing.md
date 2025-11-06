---
stoplight-id: hspobp79yp423
---


# Installing the App

After the app is successfully registered, you can proceed to install it. The installation is tenant-based, which means that all users in the tenant will be able to use the app.

To install the app you need to:
1. Find your app in the **My Apps** tab and select the **Install** button.
2. When prompted with a form containing placeholders for the account settings details, remember that these are the configuration settings exposed through the [descriptor](../../api/Extensibility-API.v1-fv.html#/operations/descriptor). All mandatory fields will be marked with '*'.
3. Pay attention if the app advertises any [scopes](../../docs/development/Authentication-Overview.md), you will be notified by the installation form.

<!--
focus: false
-->
![ScopesInstallForm](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/ScopesInstallv2.png?raw=true)

4. Fill in the fields and select **Complete**.
5. If the app supports validation of settings, it will be automatically performed at installation time via the [validation endpoint](../../api/Extensibility-API.v1-fv.html#/operations/ValidateConfigurationSettings).

<!--
focus: false
-->
![Install](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/InstallApp.gif?raw=true)

> [!NOTE]
> The configuration settings can be modified anytime by clicking the **Edit App Configuration** button.