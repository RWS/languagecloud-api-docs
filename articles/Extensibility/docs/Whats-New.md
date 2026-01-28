# What's New

## January 2026

- In early 2026, we will discontinue publishing extensibility documentation at [Trados Cloud Platform Extensibility Documentation](https://eu.cloud.trados.com/lc/extensibility-docs/16d216d6237ee-what-s-new).
    - Our extensibility documentation is currently available in two locations:
        - [Trados Cloud Platform Extensibility Documentation](https://eu.cloud.trados.com/lc/extensibility-docs/16d216d6237ee-what-s-new) - Will be discontinued in early 2026
        - [Trados Cloud Platform Extensibility](https://developers.rws.com/languagecloud-api-docs/articles/Extensibility/docs/Whats-New.html) - This will remain as the official documentation site.
    - We will communicate the exact discontinuation date once finalized.
- We've documented automatic tasks expiration time. See [Submit](../api/Extensibility-API.v1-fv.html#/operations/automatictasktypeexecutetask) and [Callback](../api/Extensibility-API.v1-fv.html#/operations/automatiktasktypecallback) endpoints.
- We've added a new documentation [page](../docs/development/Integrate-With-Trados-Cloud-Platform-API.md) on how to use the Public API SDK in your apps.
- We've expanded support for [UI custom elements](../docs/development/UI-App-custom-elements-locations.md) to additional locations: Customers and Vendors.

## July 2025

- We've expanded support for custom tabs to additional [locations](../docs/development/UI-App-custom-elements-locations.md). You can now use them in the following views:
    - tasks list
    - orders list
    - projects list
    - reports list

## April 2025

- To facilitate the management of large translation requests, batching support has been added for MT provider apps. This update includes the introduction of a new parameter, `extensions.configuration.segmentBatchSize`, which can be added to your [descriptor](../api/Extensibility-API.v1-fv.html#/operations/descriptor), along with a new error response featuring status code [413](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status/413) on the translation [endpoint](../api/Extensibility-API.v1-fv.html#/operations/MachineTranslationProviderTranslateBCM).
- A new option has been introduced on the app registration [page](../docs/appManagement/Registering.md), allowing users to designate their app for development purposes by selecting a checkbox.

## December 2024
- We have officially rebranded from RWS Language Cloud API to Trados Cloud Platform API. All references to our previous brand name will now reflect our new identity, Trados.

## November 2024
- This release introduces support for building apps that work across multiple regions. Existing apps that are already developed and in use will continue to function but will be restricted to the EU region until they are updated.
- To help you make the required changes for multi-region support, we've provided a new guide, which you can access [here](../docs/development/Multi-Region.md).
- Updated blueprints and sample projects are also available to get you started.

## October 2024
- With this release we deliver a new extension point designed to allow developers to extend and customize the UI elements of our platform. This extension point is being released as BETA. For more details see this [page](../docs/development/UI-App-development-guide.md).
- We unified the Preview documentation pages into a single comprehensive [page](../docs/development/Preview-App-development-guide.md). We have introduced a new version, known as V2, of our Preview APIs.
- We extended the information available under Verification Provider [page](../docs/development/Verification-App-development-guide.md). We have introduced a new version, known as V2, of our Verification  APIs.
- You can now add comments to [Submit Task Outcome](../api/Extensibility-API.v1-fv.html#/operations/automatiktasktypecallback) for the automatic task extensions.

## June 2024
- With this release, we have migrated from the Add-Ons concept to Apps. This significant first step sets the stage for expanding this concept to multiple areas that facilitate integrations.
- Registered Add-Ons are backward compatible with the new Apps and can be used as is.
- A major improvement is that an App can now declare the list of webhooks it needs in the descriptor and listen for webhook notifications.
- The migration guide from an Add-On to an App is available [here](../docs/development/Add-On-To-App-Migration.md).

## October 2023
- We added support for dropdown lists to the app configuration. You can now define a set of values in the descriptor's `configurations` section as an array of strings via the `options` field. The user will see these values in a dropdown menu in the edit configuration panel.


## August 2023
- With this release we introduced a folder identifier where the translation engines will be added. This can be used to filter the [engines](../api/Extensibility-API.v1-fv.html#/operations/GetMachineTranslationProviderEngines) by folder. 
- We also added recommendations on [best practices](../docs/development/Tehnical-Requirements-And-Best-Practices.md) for a secure application development.
- We made additional smaller improvements and corrections to our documentation.

## April 2023
- We added details for the `engineId`, `projectId`, `sourceFileId` and `targetFileId` parameters of the [Translate](../api/Extensibility-API.v1-fv.html#/operations/MachineTranslationProviderTranslateBCM) endpoint.
- We updated the [Registering the app](../docs/appManagement/Registering.md) page.
  

## February 2023
- We introduced requirements that become mandatory for all future apps, namely: acceptance of Terms & Conditions and the Privacy Policy, along with the provisioning of the app's release notes, documentation link and the developer's contact details, starting with descriptor version `1.3`.
- We published newer blueprints for both Java and .NET.
- We made available headers for developers to implement custom functionality based on the current version of the installed apps: `appVersion`, `extensionPointVersion` and `extensionId`.
- Added `projectId`, `sourceFileId` and `targetFileId` on the [translate](../api/Extensibility-API.v1-fv.html#/operations/MachineTranslationProviderTranslateBCM) request.

## January 2023
- We published new pages with our recommendations for implementing Dynamic Preview.

## December 2022
- We made available app samples for both .NET and Java in GitHub, to allow integrators to get familiar with our framework extension possibilities.
- We published a new page with [Technical Requirements And Best Practices](./development/Tehnical-Requirements-And-Best-Practices.md).

