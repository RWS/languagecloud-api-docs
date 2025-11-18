# Service Credentials

Before service users can authenticate with the Trados Cloud Platform API, they need to get their client credentials from a Trados Cloud Platform administrator. Service users can then use their client credentials to authenticate with the API via an Auth0 access token.

## Step 1: Trados Cloud Platform administrators add service users to the Trados Cloud Platform account.

1. Log in to the Trados UI as a human **Administrator** user type or contact the administrator to perform the operations in this section. 
2. Go to the **Users** view and select the **Service Users** sub-tab.
3. Select **New Service User** and enter the following information:
    - **Name** – Enter a unique name for your service user.
    - **Location** – Select a location (the **Root** folder or any of its children) for your service user. A location is a folder in your account hierarchy where resources are stored and managed.
    - **Groups** – Select one or more groups (from the same **Location** as the one selected above) where you want to include your service user. Each group corresponds to a predefined role, and each predefined role has a set of permissions. Resource access is influenced by the role you choose.
    - (Optional) **Description** – Enter any other relevant details.
4. Select **Create**.

## Step 2: Trados Cloud Platform administrators add additional notification options for service users 

1. Log in to the Trados UI as a human **Administrator** user type or contact the administrator to perform the operations in this section. 
2. Go to the **Users** view and select the **Service Users** sub-tab.
3. Select the service user to be edited
4. **Additional users to notify** - Add existing users to be notified of actions via email.
4. Select **Save**.

## Step 3: Trados Cloud Platform administrators create a custom application, assign the service user to it, and retrieve the client credentials from within this application.
 
1. Log in to the Trados UI as a human **Administrator** user type or contact the administrator to perform the operations in this section.
2. Expand the account menu on the top right-hand corner and select **Integrations**.
3. Select the **Applications** sub-tab.
4. Select **New Application** and enter the following information:
    - **Name** – Enter a unique name for your custom application.
    - (Optional) **URL** – Enter your custom application URL.
    - (Optional) **Description** – Enter any other relevant details.
    - **Service User** – Select a service user from the dropdown menu. 
5. Select **Add**.
6. Back in the **Applications** sub-tab, select the check box corresponding to your application.
7. Select **Edit**.
8. On the **Overall Information** page you can change any of the following, if necessary: name, URL, description.
9. On the **Webhooks** page you can:
    - Enter a default callback URL for your application Webhooks (all Webhooks defined in Trados Cloud Platform).
    - Enter a value for **Webhook URL** (this is your Webhook endpoint URL which you expose and which Trados Cloud Platform calls), select one or more event types, and hit Enter. You can create a separate webhook for every event you are interested in or combine notifications for multiple event types to one webhook. If you delete your application, all its associated webhooks are also deleted.
10. Finally, from the **API Access** page you can retrieve your **Client ID** and **Client Secret**.

> [!NOTE]
> Although you have the option to change the **Service User** later on, it is not recommended. Due to the caching layers, changes from one **Service User** to another can take between 10 to 20 minutes to fully take effect. During this period, calls made with this **Application**'s credentials may randomly use either the new or the old **Service User.** If you can't stop your services to wait for the cache to expire, it's recommended to create a new **Application** with the new **Service User** and delete the old one.