# Testing

This guide explains the ways we can test the app from our local environment. This will help with solving the potential bugs or issues before deploying the app.

Prerequisites:
1. Ngrok
2. MongoDB

## Ngrok

Ngrok exposes local servers to the public internet over secure tunnels. The app endpoints need to be public for Trados to find them.

You can find a quick guide on how to install and set up Ngrok [here](https://ngrok.com/download).

### Usage

1. Find the **port** on which the app runs in the configuration files:
    - `launchSettings.json` for the .NET blueprint

      ```json
      {
        ...
        "Rws.LC.AppBlueprint": {
          ...
          "applicationUrl": "http://localhost:5000"
        }
      }
      ```

    - `application.yml` for the Java blueprint

      ```yml
      ...
      server:
        port: 5000
      ...
      ```

2. Open a Command-line tool (for example `cmd`, `PowerShell`), navigate to your Ngrok location, and run this command for your port:
    ```
    ngrok http 5000
    ```

    ![RunNgrok](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/RunNgrok.gif?raw=true)

### Configuration

1. After having started a new session, you can find the exposed URLs in the Command-line. 

2. Copy the URL that uses **https**. For example:

    ![NgrokRunning](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/ngrokCmd2.png?raw=true)

3. Locate the `baseUrl` setting in the configuration files and replace it with the copied URL:
    - `appsettings.json` for the .NET blueprint
    - `application.yml` for the Java blueprint

### Testing

1. Although you could access the descriptor URL from a browser, we recommend using a testing client like [Postman](https://www.postman.com/) to perform the `GET` request to your descriptor URL, namely `https://<ngrokURL>/<descriptorPath>`. For example:
    ```
    GET https://47b6-78-96-152-25.ngrok.io/v1/descriptor
    ```

    ![GETdescriptor](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/GetDescriptor.gif?raw=true)

2. If you have problems accessing the URL, you can try running Ngrok using one of these alternative commands:
    ```
    ngrok http 5000 -host-header="localhost:5000"
    ```
    -
    ```
    ngrok http https://localhost:5000 -host-header="localhost:5000"
    ```

3. Make sure the descriptor response contains the correct value for the `baseUrl` field.

4. [Register](../../appManagement/Registering.md) the app in Trados using the URL provided by Ngrok. 

> You can restart the app application anytime while running a Ngrok session, without having to start a new session.

## MongoDB

We recommend using MongoDB as it is free and fairly easy to use. For testing purposes, the [community version](https://www.mongodb.com/try/download/community) should be enough.

The installation package should also include the **MongoDB Compass Community** application which is the user interface for your database. Here we can see the collections with the documents inserted by the app at runtime.

For example:

![MongoCompass](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/MongoCompass.gif?raw=true)

You can edit the Mongo settings in the configuration files of the blueprints:
  - `appsettings.json` for the .NET blueprint

    ```json
    {
      ...
      "MongoDb": {
        "Connection": "mongodb://localhost:27017",
        "Name": "lc-local-appblueprint"
      }
    }
    ```

  - `application.yml` for the Java blueprint
    ```yml
    ...
    spring:
      ...
      data:
        mongodb:
          authentication-database: admin
          database: lc-blueprint-app
          uri: mongodb://localhost:27017
          ssl-enabled: false
          auto-index-creation: false
    ...
    ```

<!-- theme: warning -->
> If you decide to use a different database, you should also modify your code accordingly.

If you plan to package your app into a Docker container, here is a dedicated article for [Testing with Docker](./Testing-with-Docker.md).