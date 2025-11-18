# Trados Cloud Platform API 

The Trados Cloud Platform API enables external applications to interact with Trados Cloud Platform.

## Product Configurations

This applies to all products that are based on Trados Cloud Platform. Note that, depending on the product and its configuration, certain features may not be available or the rate might be limited through the API. In general, when a certain feature is available in your specific product configuration, the corresponding endpoints will also be available in the API.

## Features Overview

At present, the API contains mainly capabilities that enable the creation, management and tracking of cloud translation projects.

Resources like termbases and translation memories can also be created using the Trados Cloud Platform API. Any other resources, such as pricing models need to be set up beforehand, using the user interface.

## Types of Integrations

At the moment the Trados Cloud Platform API can be called by custom (integration) applications on behalf of service users (non-human users). The ability to call the API on behalf of real end users will be supported at a later date.

## Creating Your First Project

Follow these steps to create your first project using the API:
### 1. Create a service user, an application and authenticate

Follow the instructions under the [Service users and custom applications](../docs/Service-users-and-custom-applications.md) and the [Service Credentials](../docs/Service-credentials.md) pages to create a service user and an application, and then authenticate, following the [Authentication](../docs/Authentication.md) page, by using the application's `client_id` and `client_secret`.

### 2. Create your first project

See [Create projects](../docs/Create-projects.md) and [Basic project creation flow](../docs/Basic-project-creation-flow.md) for a walk-through of the required steps to create a project.

