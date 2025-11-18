---
stoplight-id: f0cb88dbb2089
---

# Approvals and Support Communication

## Approval Process

All apps have to go through the **Approval Process** in order to achieve certain results. The **Approval Process** is our way of validating that your apps comply with the RWS Trados policies. We have a dedicated **RWS Support** team responsible for the apps validations. The support team has full rights over the registered apps.

After having registered your app in Trados, you will gain access to the comments panel within the app's details page. Here you can leave comments or questions for our **RWS Support** team. The replies received from the Support team members will be displayed in the same panel.

<!--
focus: false
-->
![Comment](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/Comment.gif?raw=true)

> [!NOTE]
> This is not a live chat, and you should refresh to check for replies. However, you don't need to keep an eye on it always, as we have email notifications in place for both roles: the developer and the support team member.

The comments panel is also used to track the **approval requests**. These requests can only be triggered by the app's developer in one of the following scenarios:
1. **Publish the app**. See more details [here](./Publishing.md).
2. **Publish a new version** with major changes. Find more details [here](./Updating.md).
3. **Unpublish the app** when installed instances exist publicly. Find more details [here](./Retiring.md).

Opening a request triggers the following:
1. The app will be marked with the *Pending approval* status.
2. The comments log will be updated with the requested change (Publish/Update/Unpublish) along with the associated comment.
3. The support team will be notified to begin the review of your request.

During the review phase, our support team will install and test the app. They can also ask for changes via the comments panel. For instance, your app might not have a suitable name or description before going public so they might advise you to change it.

After the support team is happy with your request, most likely they are going to approve it. However, they can also reject the request.

As a developer, you can cancel the request at any time.

The **Approval Process** ends with one of the following:
1. The request is **approved** or **rejected** by the RWS Support team.
2. The request is **canceled** by the developer.

> [!NOTE]
> During the Approval Process you can still use your app as usual.

## App Suspended

The support team can also **suspend** an app if they notice a weird behavior. An example would be the case when your app generates a large amount of errors.

<!--
focus: false
-->
![Suspended](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/Suspended.gif?raw=true)

Suspending an app will result in:
1. Withdrawal from the **RWS AppStore** , if it was published.
2. Preventing the public consumers from using the app anymore. The developer and support users can still install and use it in order to debug the issues.

While the app is suspended, the developer can communicate with the support team in order to sort out the issues. When the problem is fixed, the app is going to be unsuspended by the support team and it will be again publicly available to consumers.

