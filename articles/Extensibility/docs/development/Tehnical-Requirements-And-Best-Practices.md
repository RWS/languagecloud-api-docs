# Technical Requirements And Best Practices

## Technical requirements for Apps

Most technical requirements are driven by the app's developer. For example, CPU/Memory requirements should be decided by the developer after taking into consideration the particular functionality of the app and its expected load. 

For reference, a typical machine translation app built on the .NET Core Blueprint, which adapts a third party translation engine, with 250,000 transactions per month, only requires very minimal hardware resources, with 0.1 CPU and 500 MB RAM.

But there are certain aspects that still need to be covered to ensure secure and resilient operations.

## Framework

Apps can be developed using any framework, but we provide two blueprints to help you get started: one for .NET Core 8 and the other for Java.

## Redundancy

A load balanced, two instance deployment is recommended to ensure there are no interruptions in operation in case of failures, or more importantly, no downtime when a new version is deployed (by using rolling deployments).

This recommended setup can be easily achieved if the application is deployed on a cloud platform.

## Security
All communication should be secured against interfering and eavesdropping. This includes the communication between the Trados platform and the App, and also between the app and the resources it uses: third party Machine Translation Engines, databases and other resources.

Trados uses two mechanisms to secure the apps communication:
- HTTPS support is mandatory, and Trados will not communicate with the app over an unsecured HTTP channel, or via a channel with expired or invalid certificates.
- The app can also validate that the caller is indeed Trados, by verifying the signature in each call with the [Public Key](https://languagecloud.sdl.com/lc/api-docs/8c6f7b35af0ea-list-public-keys) available from Trados on an HTTPS endpoint.

An additional security mechanism used by Trados is signing the request body. This provides an extra layer of validation, but it can also be used in case the application gets compromised, and an analysis is required to identify which messages are authentic and which aren't. For that, all incoming messages need to be logged or audited in some form.

By following these guidelines, app developers can ensure that their code is secure and resistant to attacks, protecting sensitive data and maintaining the confidentiality, integrity, and availability of their applications, while also staying aware of and addressing any potential vulnerabilities in their dependencies:

- Input Validation: Always validate user inputs to ensure they are within the expected range and format. This helps to prevent injection attacks such as SQL injection or Cross-Site Scripting (XSS). 
- Secure Configuration: Configure your app securely by avoiding default settings and keeping all passwords and sensitive information out of code.  
- Secure Coding Practices: Follow secure coding practices such as avoiding hardcoded passwords, using secure coding patterns and libraries, and avoiding dynamic code execution. 
- Access Control: Ensure that access controls are in place to prevent unauthorized access to sensitive data or functions within the application. 
- Error Handling: Implement proper error handling to prevent sensitive information from being exposed to attackers.
- Manage Vulnerable Dependencies: Keep track of the dependencies used in your application and regularly check for any known vulnerabilities in those dependencies. Update to the latest version of the dependency as soon as possible to reduce the risk of exploitation.

## Logging

Logging is required for tracking the flow of operations and for debugging any possible issues. Logging is already set up for both blueprints, but you need to adjust the template of the logs and their destinations.

Important components in the logs, already present in the blueprints, include:
- timestamp - this should have a timezone, to avoid any confusion of whether it's local time or UTC.
- trace id - each request sent from Trados contains a trace id which can be used to track a complete flow. This is also propagated in the code from the moment a request is performed until a response is returned.
- thread id
- host/node name - this depends on your infrastructure setup, and we recommend having it logged, especially if you have more than one instance running.
- account id
- message - an informative description of what is happening
- error and stack trace

Do not log sensitive information in the logs, like personal identification information, API keys, incoming authentication details or signatures.

## Metrics

Metrics help answer questions like:
- Usage - how many/how much?
- Hardware requirements - are the currently allocated resources enough? Do we need to scale up or can we scale down to save on running costs?

This is not a strict requirement, but it is strongly recommended to have some form of metrics set up. This should be set up in such a way to enable you to:
- Track the number of failed request/errors.
- Track the total number of transactions.
- Track the timing of the transactions/requests (this can be addressed by various metrics like `max`, `min`, `median`, `percentile`).
- Monitor CPU and Memory utilization. This should be used to correlate transactions with resource usage.

## Error Responses

It's important to follow the specification for the endpoints when it comes to returning error responses. Each endpoint defines a set of expected error responses and the error response model. Implementing the contract correctly allows Trados to parse the response correctly and, in some situations, to handle the error and make decisions on it.

Endpoints can have a set of predefined error codes that Trados can interpret. One such example would be the `invalidConfiguration`. Error responses can even pinpoint further the source of the problem, in the `details` array that might indicate, for example, the actual field with the incorrect value, along with a corresponding code, for example, `invalidValue` or `nullValue`.