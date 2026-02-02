# App Descriptor

A descriptor defines what the app does. The very first interaction between Trados and an app is requesting the descriptor.

The app developer must accurately fill in all the details within the descriptor, specifying the app's functionalities, and then register the app by submitting a URL linking to the descriptor

## Basic Information

The descriptor model defines attributes that provide basic information like `name`, `description`, `releaseNotes`. The [model](../../api/Extensibility-API.v1-fv.html#/operations/descriptor) provides documentation for all the fields.

## Version

The `version` field is used by Trados to detect newer versions of the app's descriptor. You should increase the version every time you make a change in the descriptor, otherwise, your changes won't reach the registered instance from Trados.

The version is periodically checked by Trados by performing GET descriptor requests. 

## Base URL

`baseUrl` defines the base for any endpoint defined in the descriptor. All calls from Trados will be made by concatenating `baseUrl` and the path defined for an endpoint in the descriptor.

For example, if we have in the descriptor:

```json
{
  "baseUrl": "https://foo.com",
  "standardEndpoints": {
    "health": "/health"
  }
}
```

Trados will make scheduled GET requests to `https://foo.com/health` to check the health.

### Changing Base URL
For various reasons you might want to change the host of your App and that can be done from Trados management UI. 

When updating the host, you also have to update `baseUrl` to match the new host.

You must still support old host as all previous installs will be calling on the `baseUrl` at the installed version. In order to be able to decomission the old host, you must make sure all consumers updated their installs to latest version.

> [!WARNING]
> Because request authentication is based on Audience matching 'baseUrl', you must ensure that your authentication code can accept both old and new `baseUrl`. See [Request Authentication](Request-Authentication.md). 

## Standard Endpoints

An app must implement a set of standard endpoints that are defined in the descriptor schema under `standardEndpoints`. Not all endpoints are required, as you can see in the descriptor schema.

All endpoint paths need to start with the leading character `/` and are relative to `baseUrl`. 

Standard endpoints are defined under the `Standard` tag. The actual path should be replaced with the one you defined in the descriptor. The expected Request and Responses are defined and should be used as reference.

### Lifecycle Endpoint

Additionally, in the `standardEnpoints` section we can find the lifecycle endpoint. This endpoint needs to handle different events sent by Trados (similar to webhooks). For instance, when the app is being installed on a certain account, Trados will send an `INSTALLED` event along with some data for that account. The app should react and save the received data.
- `appLifecycle` - is used for all types of events: `REGISTERED`, `UNREGISTERED`, `INSTALLED`, and `UNINSTALLED`. See the contract [here](../../api/Extensibility-API.v1-fv.html#/operations/Lifecycle).

> [!NOTE]
> If your app is built from our blueprints, you shouldn't have to change anything, as these endpoints work out of the box.

## Extensions

The list of provided extensions is described under `extensions`. An app can provide none, one, or more extensions.

Any extension will have the generic set of properties:
- `extensionPointId` that specifies what extension point it extends. Can be only a value specified in the descriptor contract (ex: `lc.mtprovider`).
- `extensionPointVersion` defines the version of the extension point it extends. The allowed value is defined in the descriptor contract (ex: `1.0`).
- `name` is defined by the developer, to provide a friendly name for the extension. This is useful when the app provides multiple extensions.
- `description` will have a summary describing the extension.
- `configuration` defines the extension and the structure depends on the type of the extension that is implemented.
```json
{
  ...
  "extensions": [
    {
      "extensionPointId": "<extension-point-id>",
      "extensionPointVersion": "1.0",
      "id": "myAwesomeExtension",
      "name": "My Awesome Extension",
      "description": "An awesome extension that makes magic",
      "configuration": { ... }
    }
  ]
  ...
}
```

Read more on how to define the extensions for your app in our development guides:
1. Automatic Task [guide](./Automatic-Task-App-development-guide.md).
2. Machine Translation [guide](./MT-App-development-guide.md).
3. Preview [guide](./Preview-App-development-guide.md).

## Configuration

An app can request configuration details at installation time (and it can be edited later).

> [!NOTE]
> On an update, new configuration settings can be added, and the user will be requested to enter the newer configuration values.

Configurations are app scoped. If you need to assign configuration values for individual extensions within the app, use clear and explicit naming conventions so users understand what information to input into each field. Additionally, tooltips can be provided by setting the description attribute.

Configuration settings can be `string`, `number`, `integer`, `boolean`, `datetime` or `secret`. Additionally, the `string` dataType supports an array of options that will be displayed in a picklist form(for ex: `"options": [ "option1", "option2" ]`).

- for `boolean` a checkbox will be rendered. 
- `datetime` will render a date time pick control.
- `secret` is used for passwords and secrets, the characters being hidden.

Example:
```json
{
  ...
  "configuration": [
    {
      "name": "Third party token",
      "id": "thirdPartyToken",
      "description": "The token used to authenticate to third party API",
      "dataType": "string"
    }
  ]
  ...
}
```

> [!NOTE]
> Note that in the example the `optional` and `defaultValue` properties have not been specified, so these will be set to their default values, as specified in the contract ( false for `optional` and undefined for `defaultValue`).

Moreover, you have the option to define a list of choices using the `options` field. When this field is filled, the values will be presented in a dropdown menu. It's important to note that the only acceptable `dataType` in this scenario is `string`.

## Scopes


Scopes within the app define the extent of access requested to the tenant's data. Depending on the actions carried out by the app, it may require read-only privileges, read/write permissions, or even access to secure projects. The permissible values for scopes are listed under the `scopes` section.

The scopes advised in the descriptor will be presented to the consumers during installation. They can then decide whether to proceed with the installation and grant access to the app.

Once access is granted, the app will be able to perform authorized requests to the Trados Cloud Platform API.

> [!NOTE]
> If the app doesn't make requests to Trados Cloud Platform API, no scopes should be specified.

## Webhooks

Webhooks can be registered automatically when declared in the descriptor. See [Webhooks](Webhooks.md) page for more details.