# Java Samples

We create Java samples to demonstrate basic implementations of specific extensions. They serve as examples for common tasks related to that extension. These samples are developed using the provided [Java Blueprint](../blueprints/Java-Blueprint.md).

For testing please see the guidelines from the Blueprints section: [Testing](../blueprints/Testing.md) and [Testing with Docker](../blueprints/Testing-with-Docker.md).

## Machine Translation

You can find the sample in our GitHub repository [here](https://github.com/RWS/language-cloud-extensibility/tree/main/samples/java/mtSampleApp).

It provides an implementation for the Google Machine Translation. But you can run it using a built-in mock, so there is no need to create a Google account to test it out. For enabling the mock please update the application.yml:
```yml
mockExtension:
  enabled: true # will enable the mock instead true google integration

```

The sample can be run out of the box with the same requirements as for the blueprint, a local Mongo database. For different setups please see the blueprint and testing articles as you'll need to adjust your configuration.
