# Trados Cloud Platform API Management Process
</br>

## Overview
By using continuous delivery, our team regularly updates the Trados Cloud Platform API with new functionality, bug fixes and performance improvements.

Find below the defined process (lifecycle policy) we use that enables us to maintain a set of stable APIs.

Every release is announced on the [What's new](../docs/Whats-New.md) page in our API Docs.

## What is a breaking change?
- Changing the type of a field
- Modifying a field name
- Marking an existing field as required with no default value
- Introducing a new validation
- Enforcing validations
- Removing or renaming enum values
- Removing fields from response   

## What isn't a breaking change?
- Adding new endpoints
- Adding optional request fields
- Adding new fields in responses
- Adding new field as required with default value
- Changing of error messages description
- Adding enum values   
    
## Endpoint retirement process
Retirement of an endpoint will happen in two phases: deprecation and sunset.

Deprecation will be marked accordingly with IETF's [deprecation http-response-header-field](https://datatracker.ietf.org/doc/draft-dalal-deprecation-header/) with:
- a date in the future: representing the date, when the endpoint will be marked as deprecated
- a date in the past: representing the date, when the endpoint was marked as deprecated
- true: simply signal to the clients, that the endpoint is deprecated

The deprecation period is six months.

Sunset marks the point in time where the endpoint will not return the expected response. The endpoint will still be functional until sunset.

Together with the deprecation header, a new sunset-header will be introduced to mark the date of the sunset.

## How will we communicate an eventual breaking change or endpoint retirement?
An eventual breaking change or an endpoint retirement will be announced:
- on the [What's new](../docs/Whats-New.md) page in our API Docs
- on the [What's deprecated](../docs/Whats-deprecated.md) page in our API Docs
- on the developers [GitHub](https://developers.rws.com/languagecloud-api-docs/index.html) page    
- on a new blog post in the [Language Developers Blog](https://community.rws.com/developers-more/developers/language-developers/b/language-developers-blog) and [Trados Blog](https://community.rws.com/product-groups/trados-portfolio/trados-live/b/blog)
    
Any breaking change will be announced six months in advance.
> [!NOTE]
> We may introduce breaking changes for critical bugs or security vulnerabilities.

## What is our process for testing changes before releasing them to the Trados Cloud Platform API?
All changes undergo comprehensive testing and validation, following our deployment chronology in both non-customer and customer facing environments.

As part of development, unit and contract tests are built as appropriate and undergo in-depth code review before being merged into master. 

As part of testing, once the changes are merged, they are tested according to our testing strategy, where testing scope and test coverage are identified. A test plan for the changes is created and  quality assurance engineers decide upon manual and automation testing percentage to ensure the feature is implemented according to the specifications. On top of this we make sure regressions are not introduced by running the automated tests we have in place, as part of the release pipeline. Before new code is deployed to an environment (either customer or non-customer facing), all smoke tests must pass. 
