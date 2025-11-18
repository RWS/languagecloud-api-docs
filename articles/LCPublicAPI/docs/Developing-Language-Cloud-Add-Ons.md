TODO: Needs removing 

# Developing Trados Cloud Platform Add-Ons

## Design Notes
The developer can choose any development environment, programming language or hosting options, as long as the required set of APIs are implemented according to specification. Blueprints and samples, for getting to speed, are provided.

When using the provided blueprint - either Java or .Net, some concerns will be already covered in the blueprint, like:

- logging
- health check
- authorization
- default handling of account and add-on lifecycle events
- Sample Dockerfile for containerizing the application

## Terminology
The 3 big concepts that need to be clearly separated:

- **Add-On** - a REST API service implementing the API for Language Cloud Add-Ons
- **Extension Point** - a functionality from RWS Language Cloud that can be implemented by Add-On Services
- **Extension** - a new functionality for a given Extension Point, provided by an Add-On Service. An Add-On Service can implement multiple extensions for the same Extension Point, ex. offer 3 translation engines for the MT extension point.


Add-On Descriptor
The Add-On Descriptor is a JSON formatted document that describes an Add-On. The Stoplight documentation can be found at https://language-cloud-public-api-proposal.docs.stoplight.io/lc/api-docs/extensibility-api/models/addondescriptor. Fields are documented to explain their usage.

The less documented feature is how to define extension endpoints. This is done under the configuration → endpoints element of an extension (in extensions). The path for each endpoint is defined for the property which is the name in the stoplight for that endpoint. Ex:



	"configuration":{
			"endpoints":{
					"sdl.lc.extensionpoint.machinetranslationprovider.translate":"/translate",
					"sdl.lc.extensionpoint.machinetranslationprovider.engines":"/translation-engines"
			}
	}

**baseUrl** property in the descriptor sets the base path for all endpoints defined. All other URLs are relative to this. 

The descriptor should be accessible at an URL that starts with baseUrl, as it will be called on at scheduled intervals to check for updates.

## Endpoints
When thinking about the endpoints that need to be implemented by the Add-On service, they are split into two:

- Standard endpoints
- Extension endpoints

**Standard endpoints** are required to be implemented by all Add-On Services. These are operations that will be called on by the Add-On Management Service. Not all of them are required but it's recommended to provide them. Check in the Stoplight which are required (can be found in the documentation for the AddOnDescriptor model).

**Extension endpoints** are implemented depending on the Extension Points supported by the Service.

The list of standard endpoints and Extension endpoints (grouped by extension) can be found in [Stoplight](https://language-cloud-public-api-proposal.docs.stoplight.io/lc/api-docs/extensibility-api/).



In the previous image, which captures the endpoints for an Add-On from the Stoplight, are visible the list of standard endpoints, as well as the two endpoints under the "Machine Translation Provider" Extension Point. If the Add-On service is providing an Extension for that Extension Point, it must implement both endpoints (Translate and Get Translation Engines). 

The path for each extension endpoint is described in the Stoplight content and has the format of a namespace. Please see Stoplight for more details on each Extension Point.

## Add-On Lifecycle
This section attempts to explain what is the order of the endpoints that should be expected to be invoked in the lifecycle of the Add-On Service.

An ordinary Add-On registration and activation lifecycle should look like that:



- **GET /descriptor** is the very first endpoint that will be executed when the add-on owner tries to register it in Language Cloud.
- **POST /addon-lifecycle** will be the next in order, with an identifier of "REGISTER", meaning that the Add-On has been registered. From that moment on, administrators can activate the Add-On on their accounts.
- **POST /addon-lifecycle** will be again invoked when the Add-On is activated on an account. This time the payload will provide a "tenantId" (Account ID), and "publicKey" which will be used for validating future request. That data should be stored in the Add-On system.
- **GET /configuration** - will be invoked to get the list of configuration settings (including default values, current values) that need to be provided by the administrator that activated the Add-On on their tenantId.
- **POST /configuration** - will set the configuration values for the tenantId. Note: not all settings can be sent in a single request. There might be multiple requests setting different config values. The Add-On should keep these settings safe.
Also note that this endpoint can be called any time after activation if the administrator decides to change any of the settings.

The lifecycle for de-activation of the Add-On from an account:

- **POST /account-lifecyle** will notify the Add-On Service, by providing the identifier "DEACTIVATED". The tenantId, in this case will be provided in the header "X-LC-Tenant" which is standard for all request that are related to an account. The Add-On should delete any account related data.

The lifecycle for un-registering an Add-On from RWS Language Cloud:

- **POST /addon-lifecycle** will be invoked with identifier "UNREGISTERED". If there are accounts that haven't been previously deactivated, they should be considered so, and all related data be deleted.

There are also endpoints that can be called at any point in time:

- **GET /descriptor** - can be called before registration, during registration, after registration, on scheduled intervals, etc.
- **GET /health** - will be called during and after registration. It is scheduled to be checked periodically.
- **GET /documentation** - can be called at any time.

Of course there are also the Extension endpoints which are invoked in the business life-cycle.

## Understanding the incoming request
There are two types of endpoint invocations:

Related to the Add-On - ex: registering, health checks, documentation, does not know and doesn't make sense to be related to a tenant
Related to an account (tenant) - operations that only make sense in relation with a tenant: activating, getting/setting configurations, extensions
Only the endpoints relating to an account are authenticated, as the authentication is account-bounded. The only exception is "activating" which will receive the public key for signature validation, which needs to be saved for that account. 

Two headers are defined in the Stoplight that need to be handled:

TR_ID - represent the trace identifier that is sent from the RWS Language Cloud, and should be propagated through all the stacks and added to the logs. When making requests to RWS Language Cloud in the context of an extension, the same TR_ID should be used (if it's a synchronous operation)
X-LC-Tenant - provided only for the endpoints which are related to an account. Provides the tenant ID (account ID) to which the request is related.
Implementing extensions
Extensions Points are defined in Stoplight, and are defined by a number of endpoints that together support an extension. For example the Extension Point "Machine Translation Provider" has two endpoints defined:

/sdl.lc.extensionpoint.machinetranslationprovider.translate
/sdl.lc.extensionpoint.machinetranslationprovider.engines
Implementing these endpoints, will allow for the Add-On to provide the extension that implements support for "Machine Translation Provider" Extension Point. 

Note: the path for these endpoints does not necessary have to be the same as defined in the Stoplight. The path is configurable from the descriptor, and can be set to any path, under the base path that is also defined in the descriptor.

Multiple Extensions can be implemented that support the same Extension Point. All that's needed is to define a set of endpoints for each Extension. Meaning, if you want to implement Extension Point "Machine Translation Provider", by providing 3 machine translation options, you'll need to create 3 sets of endpoints, which is 6 endpoints. In the descriptor, for each extension, you'll define which endpoints are used.

## Asynchronous endpoints
Some extensions will require you to implement asynchronous endpoints. An example is the Automatic Task Extension: https://language-cloud-public-api-proposal.docs.stoplight.io/lc/api-docs/extensibility-api/automatic-task-type-provider/automatictasktypeexecutetask

In this case the '/lc.automatictask.submit' endpoint will need to accept a task, execute it on a separate thread and then call the provided callback url with the result. The sequence diagram below explains this flow:



## Multitenancy
Unless an Add-On is developed to be used only in Developers Account, Multitenancy must be supported. Primarily that means ensuring that data from one account does not transpire to another account. Sharing data between two accounts should be avoided.

Requests that are account specific contain the header X-LC-Tenant, with the account ID. It can be used to store the data, compartmentalized by account, and also to filter the requested data.

## Security
The Add-On Service should provide all endpoints with HTTPS support, with a minimum version of TLS 1.2. The scope of this is to protected client information from eavesdropping.

Any stored data should be kept safe and used only for fulfilling the advertised actions. Data should be compartmentalized per tenant.

### Signature Validation
The blueprints will provide mechanisms to simplify signature validation.

Headers that are required for signature validation:

- **X-LC-Transmission-Time** - the transmission time in ISO-8601 format
- **X-LC-Tenant** - the account ID
- **X-LC-Signature-Algo** - the algorithm for signature generation. Currently the only valid value is SHA256withRSA .
- **X-LC-Signature** - the signature that needs to be validated

Steps for signature validation:

1. Get the previously stored public key for the given account ID (X-LC-Tenant).
2. Generate a CRC32 checksum of the message body.
3. <path> part is composed of the request URL minus basePath, as defined in the descriptor. <part> must begin with a slash "/". (All paths in Descriptor must start with a slash).
4. Generate the concatenation <X-LC-Transmission-Time>|<X-LC-Tenant>|<path>|<CRC32>, where the <value> - represents the value from the header, or calculated. | - is an actual character used for separating the values, and should be included in the final string.
5. Validating the signature is done by verifying the signature using the public key and generated concatenation using the algorithm from X-LC-Signature-Algo.

## Health Checks
The health endpoint will be invoked regularly to ensure the health of the Add-On Service. The only expected response is a HTTP code 200, any other code will be considered as a service failure. Any content will be ignored.

## Versioning
Add-Ons should be designed with versioning in mind. Versioning is applied to the descriptor, allowing changing features in the Add-On without impacting users that might be using an older version of the Add-On.

Things to consider:

- Multiple versions of the Add-On can point to the same endpoints only if the changes are compatible. 
- If there are breaking changes in a new version of the Add-On (changes in the endpoint, changes in the models, changes in behaviour), new endpoints should be created for the new version. 
- Version number is set in the descriptor field "version". It should follow * * Semantic Versioning principles, and should consist of no more then 4 numeric groups separated by dots, ex.: "1.0", "1.3.5".

In order for new changes in the descriptor to be detected, the descriptor must have it's version incremented. Changes in the descriptor will not be automatically detected if the version is the same as the last one.

### Retiring older versions
When an older version of the Add-On needs to be retired the following steps need to be taken:

While deploying a new version with a new version number in the descriptor, the "minimumVersion" field should also be set to the minimum version that is still supported. It can also be set to the version that is being deployed - meaning that only this version will be supported.
After deploying and getting the new version Published, a grace period of 30 days will be given to the users to update to the new version. In that period the older versions MUST be supported (the endpoints should be up, the functionality unchanged, etc.)
After 30 days the old functionality can be decommissioned.