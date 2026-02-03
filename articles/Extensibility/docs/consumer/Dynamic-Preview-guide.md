# Dynamic Preview
Dynamic Preview apps offer the ability to render previews dynamically based on selections the user makes in the preview page.

## Installing the App

To benefit from the app's functionality first you have to install it on your account. You can install an app by following these steps:

1. Navigate to **RWS AppStore** where you can find all the public apps.

    ![AccessRWSAppStore](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/DynamicPreview-AppStore-app.gif?raw=true)

2. Select the desired app.
3. Read the app's documentation by accessing the documentation link.
4. Click the **Install** button.
5. When finished, select **Complete**.

![RWSAppStore](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/InstallDynamicPreviewApp.gif?raw=true)

## Setting up the Preview

1. Under your Trados Enterprise account, set up a new FileType.
2. Select a file type which is supported by your app. In this case, we chose the XML 2: Any XML FileType
3. Follow the steps shown below to add the Dynamic Preview Type to your FileType Preview Settings.

![DynamicPreviewSetup](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/DynamicPreview-SetUp.gif?raw=true)

4. Create a project and add your file which you will be previewing to it.
5. Open the Online Editor and select the Preview Type as shown below:

![PreviewTypeSetup](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/DynamicPreview-SelectPreviewType.gif?raw=true)

6. In the rendered preview, change the dynamic page which is loaded as shown in the example below. Note: The mechanism for changing the content dynamically will depend on the app implementation and preview rendering.

![DynamicPreviewSetup](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/DynamicPreview-ChangePreviewPage.gif?raw=true)
