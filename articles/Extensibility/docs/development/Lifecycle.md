# Lifecycle

Communication between Trados and an app service involves several lifecycles. Some examples include: registration, installation, publishing, and more.

The very basic flow of when an app is first registered by a developer and installed (optional, but recommended, step for developers) looks like this:

<!--
focus: false
-->
![Lifecycle](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/Lifecycle.png?raw=true)

A summary of all standard endpoints and their role in the lifecycle of an app:


- `GET /descriptor` is the very first endpoint that will be invoked when the app owner tries to register it in Trados.
- `POST /app-lifecycle` will be the next in order, with an identifier of `REGISTERED`.
- `POST /app-lifecycle` will be again invoked with id `INSTALLED`.
- `GET /configuration` will be invoked to get the list of configuration settings (including default values, current values) that need to be provided by the administrator who installed the app on their tenantId.
- `POST /configuration` will set the configuration values for the tenantId. Note: not all the settings can be sent in a single request. There may be multiple requests that are setting different configuration values. The app should keep these settings safe.
- Also note that this endpoint can be called any time after uninstall if the administrator decides to change any of the settings.

## Lifecyle Events

The lifecycle events are handled by the [lifecycle endpoint](./App-Descriptor.md#lifecycle-endpoint).

### Registered Event

The lifecycle for registering the app in Trados:

- `POST /app-lifecycle` with id `REGISTERED` will notify the app service that it has been registered. From that moment on, administrators can install the app on their accounts, share it or publish. The payload will contain the `clientId` and `clientSecret` which can be used for authenticating with RWS Language Cloud API. That data should be stored securely in the app database.

### Installed Event

The lifecycle for installing of the app in an account:

- `POST /app-lifecycle` with id `INSTALLED` is sent when the app is installed on an account. Only tenant identifier should be stored securely in the app database for keeping track of installed accounts.

### Uninstalled Event

The lifecycle for uninstalling of the app from an account:

- `POST /app-lifecycle` will notify the app service, by providing the id `UNINSTALLED`. The app should delete any account-related data.

### Unregistered Event

The lifecycle for unregistering an app from Trados:

- `POST /app-lifecycle` will be invoked with id `UNREGISTERED`. If there are accounts that haven't been previously uninstalled, they should be considered so, and all the related data be deleted.

### Updated Event

A special lifecycle event has been introduced to help with the upgrade from 1.3 to 1.4 descriptor versions (from add-ons to apps). Also it will be used in the future for refreshing `clientId` and `clientSecret`:

- `POST /app-lifecycle` will provide credentials update when has the id `UPDATED`. The payload is similar to `REGISTERED` event.

## Other Endpoints

There are also endpoints that can be called at any point in time:

- `GET /descriptor` - can be called before registration, during registration, after registration, on scheduled intervals, and so on.
- `GET /health` - will be called during and after registration. It is scheduled to be checked periodically.
- `GET /documentation` - can be called at any time.

Additionally, there are also the Extension endpoints which are invoked in the business lifecycle.
