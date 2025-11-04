---
stoplight-id: b7cdff09ad767
---

# Updating the App

There might be times when you need to make changes to your app. Whether you want to fix bugs, correct flaws, or add new functionality, the changes should eventually reach your registered app instance. That's why RWS Trados supports app versioning.

To update the app you need to:
1. Increment the `version` field in the app's [descriptor](../../api/Extensibility-API.v1-fv.html#/operations/descriptor), as Trados relies on it to detect the newer versions.
2. Wait for Trados to detect the new version. It could take up to 2 minutes to detect it.
3. You should also receive an email notification informing you that there's a new app version available.
4. Check the new version on the app details page. If you don't see it, please contact our support team.
5. At this point you should be able to install or update to the latest version.

<!--
focus: false
-->
![Update](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/Update.gif?raw=true)

## Publishing a new version

For an app that is already published, you may also choose to publish the new version. 

To publish an update you need to:
1. Test that your new version works as expected.
2. Select your app from the **My Apps** tab and click the **Publish update** button. This could result in one of the following:
    1. The app will enter the **Approval Process**, if the new version's descriptor contains **major changes**. The following changes are considered major:
        - BaseURL
        - Scopes
        - Standard endpoints
        - Extensions
        - Configuration settings
    2. The app's new version will be instantly **published** if none of the above fields are affected by the changes.
3. Finally, the app consumers will be notified that there is a new version available to which they can upgrade.

<!--
focus: false
-->
![PublishUpdate](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/PublishUpdate.gif?raw=true)


