# Concepts

Trados apps offer a way to extend the Trados functionality.

## Apps

An app is a Rest API service, hosted by the developer, that is registered with Trados and will be invoked in the flows it is registered to handle. For example, an app can implement a new Machine Translation engine and register it with Trados. The new machine translation option will be available to whoever installs the app on their account.

Apps can be either private or published to the store where they can be freely installed on other accounts.

## Extensions

An app can have many extensions or none at all. An extension is an atomic functionality design to provide functionality defined by an Extension Point.  For instance, an app might include a Machine Translation Extension, which lets it translate text using a service not built into Trados.

Imagine the app as a box, with each extension as a piece that enhances it. You're not restricted to just one Machine Translation extension in the app. You can add as many extensions as you want, maybe different translation services. Also, it's fine to mix different types of extensions in one app.

## Extension Points

Trados defines Extension Points that can be implemented in apps. For example, Machine Translation is an Extension Point. The actual implementation in an app is called an Extension.