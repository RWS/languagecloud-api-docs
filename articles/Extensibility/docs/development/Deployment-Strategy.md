# Deployment Strategy

In this guide, we will outline the recommended deployment strategy, the main ideas behind it, and how you can apply it.

The proposed strategy involves hosting at least 2 instances of your app:
- The **preview** instance
- The **live** instance

## The Preview Instance

The preview instance is designated for testing and experimenting with new things, such as extensions, configurations, etc.

This instance **must not be published**. If needed, for testing purposes, it can be [shared](../appManagement/Sharing.md) with other tenants.

We suggest using a distinctive **development name** and **description** to differentiate it from the live instance. For example:



![RegisterPreview](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/RegisterPreview.gif?raw=true)

> Make sure you use a **descriptor URL** different from the one you need for the live instance. You cannot register two apps with the same descriptor URL.

## The Live Instance

The live instance is the one you'll be using for production purposes. It might already be installed and used on a particular account, or shared with other accounts, or it may be the instance that is currently being [published](../appManagement/Publishing.md).

Registration example:

![RegisterLive](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/RegisterLive.gif?raw=true)

Finally, here is a comparison between the 2 instances:

![PreviewLiveComparison](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/PreviewLiveComparison.PNG?raw=true)

