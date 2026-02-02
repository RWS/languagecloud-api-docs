# Retiring the App

Before retiring an app, you must first go through the following steps:
1. Unpublish the app
2. Unregister the app

## Unpublish the App

First, if your app is published, you will need to withdraw it from the **RWS AppStore**. To unpublish the app you need to:
1. Select your app from the **My Apps** tab and click the **Unpublish** button.
2. A comment box will appear, where you can leave a message for the RWS Support team (optional). You are also warned that unpublishing the app will cause all the public consumers to lose their installed instances (except for the developer's instance and the shared ones).
3. If you choose to continue, the app will either:
    - Enter the **Approval Process**, because there were public installations found. In this case, all the consumers will be notified and advised to uninstall the app. Usually, there is a grace period of **30 days**. When the grace period ends, if there are still any active instances, they will be automatically removed when the support team approves the request.
    - Become **private** instantly, because there were no public installations found.

<!--
focus: false
-->
![Unpublish](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/Unpublish.gif?raw=true)

## Unregister the App

After the app becomes private, the only active instances left should be the developer's one and the shared ones (if the app had been previously shared). You can either uninstall them manually or unregister the app directly. The second option will automatically uninstall the instances left, before removing the app.

> [!NOTE]
> An app can only be deleted when there are no other installed instances.

To unregister the app, you need to:
1. Select your app from the **My Apps** tab and click the **Delete** button.
2. You will be asked if you want to automatically uninstall the shared instances.
3. If you choose to do so, Trados will attempt to remove the remaining instances (if any are found) and eventually delete the app definitively. This is done asynchronously, so you will need to refresh the page to see the changes.
    - If the unregister process fails due to app communication errors, the app will be marked with the *Delete failed* status and you will have the possibility to force the deletion.
    - The **Force Delete** button will tell Trados to ignore the communication errors and proceed with the app removal.

<!--
focus: false
-->
![Unregister](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/Unregister.gif?raw=true)

**Force deleting example**

<!--
focus: false
-->
![Unregister](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/ForceUnregister.gif?raw=true)