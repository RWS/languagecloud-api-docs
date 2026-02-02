# Validating Account Settings

As we have already seen, most apps require some configuration settings in order to serve their purpose. For example, the machine translation apps such as Google and DeepL may need some credentials to communicate with the 3rd party MT provider.

## Validations

There are a couple of places where the settings are validated automatically or where you can perform the validation yourself.

### Installation

The first validation is done when installing the app. If the settings are correct, the installation will complete without any warning messages. Otherwise, if you provide incorrect settings, a warning message will notify you and the invalid field(s) will be highlighted in red (if the app provides such granular information).
The installation completes eventually, but your instance will be marked as *Not configured* and you won't be able to use it.

<!--
focus: false
-->
![InstallWrongConfigs](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/InstallWrongConfigs.gif?raw=true)

### Edit Configuration

Once the app has been installed you can edit the settings at any time from the **Edit App configuration** window. Clicking the **Save** button will also trigger the validation of the newer settings.

<!--
focus: false
-->
![SaveWrongConfigs](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/SaveWrongConfigs.gif?raw=true)

Another option is to perform the validation on demand by clicking the **Validate saved configuration** button. As the name suggests, **the validation is done against the saved settings**. This means that you would first have to save the settings before clicking the validation button.

<!--
focus: false
-->
![ValidateWrongConfigs](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/ValidateWrongConfigs.gif?raw=true)

### Automatic Validation

Some settings, especially credentials may expire after a while. The purpose of the automatic validation is to detect the instances with expired settings and mark them accordingly. A background job runs daily and checks all the installed instances. When a validation fails, that particular instance will be marked as *Not configured*, making it unusable anymore.

![NotConfigured](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/app-management/NotConfigured.PNG?raw=true)

Therefore, if your app has suddenly stopped working, it might be due to expired settings. To fix this state, you can provide new settings by using the **Edit App configuration** functionality.
