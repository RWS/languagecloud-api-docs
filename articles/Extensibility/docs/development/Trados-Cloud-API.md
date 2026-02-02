# Trados Cloud Platform API

Communication to Trados Cloud Platform API is also authenticated and the process is described in the [Trados Cloud Platform API documentation](https://languagecloud.sdl.com/lc/api-docs).

## Credentials

When an app is registered, credentials (`clientId` and `clientSecret`) are sent to the app with the `REGISTERED` lifecycle event on the [App Lifecycle endpoint](../../api/Extensibility-API.v1-fv.html#/operations/Lifecycle).

An example payload:

```json
{
  "id": "REGISTERED",
  "timestamp": "2019-08-24T14:15:22Z",
  "data": {
    "clientCredentials": {
      "clientId": "<client id>",
      "clientSecret": "<client secret>"
    }
  }
}
```

Here `clientId` and `clientSecret` represent the credentials for the Trados Cloud Platform API and can be used for getting a token for communicating with the Trados Cloud Platform API, as described by the [Trados Cloud Platform API documentation](https://languagecloud.sdl.com/lc/api-docs/ZG9jOjExMDcyMQ-authentication).

When an app is installed on an account, a service user will be created in Trados and an event will be sent on the [App Lifecycle endpoint](../../api/Extensibility-API.v1-fv.html#/operations/Lifecycle) with event `id` being `INSTALLED`.

Account ID should always be used from the request authentication header token. This is built in in the provided blueprints.

## Scopes

Access to the Trados Cloud Platform API is not allowed implicitly from the app. In order for the Trados Cloud Platform API credentials to have the permissions to read or edit data in Trados, the desired scopes must be listed in the app's `scopes` property in the descriptor.

Scopes that can be viewed as a list of permissions that need to be granted to the service user (and are shown to and approved by the administrator who installs the app on the account).

For example, to request the permission to edit data on an account, the `TENANT` scope must be specified in the `scopes` in the descriptor. For read only access, `TENANT_READ` is enough. The scopes are cumulative, so if you specify `TENANT`, you don't have to specify `TENANT_READ`.