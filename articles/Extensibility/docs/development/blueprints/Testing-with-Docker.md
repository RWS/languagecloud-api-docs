# Testing with Docker

This guide is mainly aimed at developers who want to deploy the app within a Docker container. Throughout the guide, we will see how we can run and test the app behavior when containerized.

Before continuing here, we recommend reading the [basic testing guide](./Testing.md).

The only additional prerequisite to Ngrok and MongoDB (which we mention in the basic guide) is [Docker Desktop](https://www.docker.com/products/docker-desktop). You can find a setup guide [here](https://docs.docker.com/get-docker/).

> [!NOTE]
> Please note that Docker Desktop is no longer free for large businesses.

## Docker files

Each of our blueprints include a `Dockerfile`:
- [.NET blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/dotNetAppBlueprint/Rws.LC.AppBlueprint/Dockerfile)
- [Java blueprint](https://github.com/RWS/language-cloud-extensibility/blob/main/blueprints/javaAppBlueprint/src/main/docker/Dockerfile)

The `Dockerfile` contains instructions based on which Docker will build the images. No changes should be required to these files.

## Configuring Mongo

Before proceeding to run the app from a Docker container, there are a few configuration changes needed for MongoDB.

Because a Linux Docker container can be considered as a VM, and communicating from your container to your host machine cannot be done through localhost, you need to allow MongoDB connections on your machine IP, so that the application from your container can connect to it from an "external" machine. 

> [!WARNING]
> This might open your database to access from outside your machine if your firewall is not configured correctly or installed.

To configure your MongoDB follow these steps:

1. Open CLI and run this command:
    ```
    ipconfig
    ```
2. Copy the `IPv4 Address` IP address. Note - your IP can change depending on your network settings, and you might need to update it from time to time.
3. Go to your MongoDB `/bin` location (usually 'C:/Program Files/MongoDB/Server/\<version\>/bin'), open `mongod.cfg` as Administrator and add the copied address to the `bindIp` configuration setting. For example:
    ```conf
    ...
    net:
      port: 27017
      bindIp: 127.0.0.1, <copiedIPAddress>
    ...
    ```
4. Save `mongod.cfg`
5. From **Task Manager** navigate to the **Services** tab and search for 'MongoDB'. Right click and select **Restart**. This is needed so that the previous changes take effect. 
6. Using the same IP address, edit the blueprint's Mongo configuration settings, as follows:
    - `appsettings.json` for the .NET blueprint
      ```json
      {
      ...
        "MongoDb": {
          "Connection": "mongodb://<copiedIPAddress>:27017",
          "Name": "lc-blueprint-app"
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
            ...
            uri: mongodb://<copiedIPAddress>:27017
            ...
      ...
      ```

## Running apps in containers

There may be many ways of running applications in Docker containers. Below is a suggestion for each of our blueprints (.NET and Java). 

### .NET blueprint

The .NET blueprint comes with Visual Studio Docker Support enabled. See `Rws.LC.AppBlueprint.csproj`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    ...
    <DockerDefaultTargetOS>Linux</DockerDefaultTargetOS>
  </PropertyGroup>
  ...
</Project>
```

To run the solution from a container, follow these steps:

1. Open **Docker Desktop**.
2. From Visual Studio, select the **Docker** option from the **Run** dropdown menu.

    ![VSDocker](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/VSDocker.gif?raw=true)

3. When running it for the first time, it may take a while to create the image.
4. Once it's done, the **Containers** window will open. Here you can see the details and the logs of your running containers.

    ![VSContainer](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/VSContainerRun.PNG?raw=true)

5. You can also check the container logs in **Docker Desktop**.

    ![DockerContainer](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/Container.gif?raw=true)

6. Check that the application is running correctly by performing a `GET` request to your descriptor endpoint. For example:
    ```
    GET http://localhost:5000/v1/descriptor
    ```


### Java blueprint

For the Java blueprint, we are going to explicitly create a Docker image and run it with **Docker Desktop**. To achieve this, you need to:

1. Run the Maven `package` command, so you generate the `.jar` file for the blueprint project.
2. Make sure that the `.jar` file was generated in the `/target` folder. By default, it is called `lc-blueprint-app-1.0-SNAPSHOT.jar`.
3. Copy the `.jar` file into the same directory with the `Dockerfile` > `/src/main/docker`.
4. Build the Docker image by using the [build](https://docs.docker.com/engine/reference/commandline/build/) command:

    ```
    docker build --tag <image_name> <blueprint_location>/lc-blueprint-app-public/src/main/docker
    ```

5. Open **Docker Desktop** and search for the image by the `<image_name>` you previously set (**java_bp** in this example).
6. Click **RUN** and bind the exposed ports to localhost, as follows:

    ![RunJavaImage](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/testingTools/JavaImage.gif?raw=true)

7. Check that the application is running correctly by performing a `GET` request to your descriptor endpoint. For example:
    ```
    GET http://localhost:5000/v1/descriptor
    ```
