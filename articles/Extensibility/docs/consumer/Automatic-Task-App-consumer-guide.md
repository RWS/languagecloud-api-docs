---
tags: [Consumer]
stoplight-id: xmvf6rjkuqma6
---


# Automatic Task

Automatic Task apps offer the possibility to add custom functionality within a project's workflow.

Examples of automatic tasks:
- send notifications about the project
- update project details
- copy the project files to a shared location

## Installing the App

To benefit from the app's functionality, you first have to install it on your account. You can install an app by following these steps:

1. Navigate to **RWS AppStore** where you can find all the public apps. 

    ![AccessRWSAppStore](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/AccessRWSAppStore-app.gif?raw=true)

2. Select the desired app.
3. Read the app's documentation by accessing the documentation link.
4. Some Automatic Task apps might also require access to your account resources. The installation window will advertise the requested permissions.

    ![ScopesInstallForm](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/ScopesInstallv2.png?raw=true)

4. Click the **Install** button and fill in the configuration settings. Only the settings marked with '*' are required.
5. After you have filled in the settings and acknowledged the requested access click **Complete**.

    ![RWSAppStore](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/InstallATApp.gif?raw=true)


Some apps also support validation of the configured settings. The first validation is automatically performed at installation time. If the provided settings are invalid, you will be prompted with an error message letting you know that the settings are incorrect.

> The configuration settings can be modified at any time by clicking the **Edit App Configuration** button.

## Using the Automatic Task App

Once you have the app installed on your account, anyone from the account will be able to use it. However, only the account admins have the rights to manage the apps.

An app of this type could expose one or more automated tasks that are available to integrate within your workflow templates.

### Creating a New Workflow Template

To use the app's automatic task(s) within your projects, first, you will need a **Workflow Template** with the task(s) provided by the app. To create a template, follow these steps:
1. Navigate to **Resources** -> **Workflows** -> **Workflow Templates** and click **New Workflow Template**.
2. Fill in the required fields and start building your custom workflow template.
3. Add the app's automatic task.

    ![AutomaticTaskWFT](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/consumer/ConsumerAppTaskWFT.gif?raw=true)

4. Configure the task.

    ![AutomaticTaskConfigs](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/consumer/ConsumerAppTaskConfiguration.gif?raw=true)

5. Click **Save configurations** and complete your template.
6. When finished, click **Save & Activate**.

> The above illustrations are based on a template draft. You may need to create the new template from scratch.

### Creating a New Workflow

The workflow template created at the previous step must be assigned to a **Workflow**. To create a new one, follow these steps:
1. Navigate to **Resources** > **Workflows** > **Workflows** and click **New Workflow**.
2. Fill in the required fields.
3. Select your newly created template from the dropdown list.
4. Check the tasks in the workflow and configure them.
5. Click **Create**.

![AutomaticTaskWF](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/consumer/ConsumerAppTaskWF.gif?raw=true)

### Using the App's Automatic Task within a Project

To create a **Project** with the new resources, you can either have them in a **Project Template** or select them at the project creation time. In this example we will go with the first option:

![AutomaticTaskProject](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/consumer/ConsumerCreateATAppProject.gif?raw=true)

After creating the project, you can track the progress in the **Task History** tab. Here you can check the app's task status. Depending on the complexity of the task it may take some time to finish.

![AutomaticTaskProjectHistory](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/consumer/ConsumerATTaskHistory-app.png?raw=true)

> The app task illustrated above is just a mockup task that does not have a real purpose.