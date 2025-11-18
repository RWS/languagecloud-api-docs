---
tags: [Consumer]
stoplight-id: aq5ppczlrfiwc
---


# Machine Translation

Machine Translation apps offer the possibility to use external machine translation providers within the Trados platform.

## Installing the App

To benefit from the app's functionality first you have to install it on your account. You can install an app by following these steps:

1. Navigate to **RWS AppStore** where you can find all the public apps.

    ![AccessRWSAppStore](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/AccessRWSAppStore-app.gif?raw=true)

2. Select the desired app.
3. Read the app's documentation by accessing the documentation link.
4. Click the **Install** button and fill in the configuration settings. Only the settings marked with '*' are required.
5. When you are done, click **Complete**.

    ![RWSAppStore](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/InstallMTApp.gif?raw=true)


Some apps also support validation of the configured settings. The first validation is automatically performed at installation time. If the provided settings are invalid, you will be prompted with an error message letting you know that the settings are incorrect.

> The configuration settings can be modified at any time by clicking the **Edit App Configuration** button.

## Using the Machine Translation App

Once you have the app installed on your account, anyone from the account will be able to use it. However, only the account administrators have the permissions to manage the apps.

### Creating a new Translation Engine

To use the MT app within your projects, you will need a Translation Engine with the engines provided by the app. To create one follow these steps:
1. Navigate to **Resources** -> expand **Linguistic Resources** -> **Translation Engines** and click **New Translation Engine**.
2. Fill in the required fields.
3. Select the desired language pair(s).
4. Under the Machine Translation section click **Add Machine Translation Model**.
5. The app should provide the supported models for the requested language pair(s).
6. Select the models and click **Create**.

![MTEngines](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/consumer/ConsumerAppMTEngines.gif?raw=true)

### Creating a new Workflow

You will need a workflow that contains the **Machine Translation** step and has at least one of your Translation Engine's language pairs. To create a new one follow these steps:
1. Navigate to **Resources** > **Workflows** > **Workflows** and click **New Workflow**.
2. Fill in the required fields.
3. Select the language pair(s).
4. Select a template with Machine Translation steps (for example, one could be **Simple Translation**).
5. Check the tasks in the workflow and configure them.
6. Click **Create**.

![MTWorkflow](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/DevMTWF.png?raw=true)

### Translating with the MT App

To create a **Project** with the new resources you can either have them in a **Project Template** or select them at the project creation time. In this example we'll go with the first option:

![MTProject](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/consumer/ConsumerCreateMTAppProject.gif?raw=true)

> The project language pair also has to match the ones from the engine and the workflow.

Once the project reaches the **Translation** step, you can open it in **Online Editor** and check the translated segments from the MT app. You also have the possibility to search for Lookups in order to receive alternative translations.

![OEtranslations](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/MTAppOELookup.gif?raw=true)

> The translations illustrated above are just some demonstrative mock-ups.