# User Interface App Development Guide

UI extensions offer the possibility to add custom user interface elements and functionality. Custom [buttons and panels can be added to specific places](UI-App-custom-elements-locations.md) within the user interface.

> [!CAUTION]
> #### This feature is currently in BETA.
> Please note that in a future phase, we will introduce significant changes as we move towards the official release:
> * The current implementation utilizes the authorization token of the logged-in Trados user for the Trados Cloud Platform API and the app's own API calls. In a future update, a different authorization token will be introduced for these operation.
> * As a result, access to the Trados Cloud Platform API functionality of a UI extension app will be governed not only by the Trados user's permissions but also by the app's [scopes](App-Descriptor.md#scopes).
> * A UI extension's JavaScript file will be loaded in an isolated context, independent from Trados.
> * The communication model between App UI and Backend will change in the final version and will have to be redesigned.

A UI extension is defined in the app [descriptor](../../api/Extensibility-API.v1-fv.html#/operations/descriptor) in the `extensions` array.

```json
{
  ...
  "extensions": [
    {
      "extensionPointId": "lc.ui",
      "id": "SAMPLE_UI_EXTENSION_ID",
      "name": "SAMPLE_UI_EXTENSION_NAME",
      "description": "SAMPLE_UI_EXTENSION_DESCRIPTION",
      "extensionPointVersion": "1.0",
      "configuration": {
        "scriptPath": "/PATH/TO/JAVASCRIPT/FILE.JS",
        "endpoints": {}
      }
    }
  ]
  ...
}
```

The `extensionPointId` is always **"lc.ui"**.

The `configuration`'s `scriptPath` is the path of the JavaScript file which will be loaded in the Trados user interface. The path is relative to the `basePath` in the [descriptor](../../api/Extensibility-API.v1-fv.html#/operations/descriptor). This JavaScript file contains the code describing the custom elements that will be added to the user interface and their functionality.

## Prerequisites

**Node.js**

If you don't already have Node.js installed, you can download the most recent LTS (Long-Term Support) version of Node.js from [nodejs.org](https://nodejs.org/en/download).

### Dependencies

- [@trados/trados-ui-extensibility](https://www.npmjs.com/package/@trados/trados-ui-extensibility) v0.1.6
  - [GitHub repository](https://github.com/RWS/trados-ui-extensibility)
  - [GitHub wiki](https://github.com/RWS/trados-ui-extensibility/wiki)

### Development dependencies

- [ts-loader](https://www.npmjs.com/package/ts-loader)
- [webpack](https://npmjs.com/package/webpack)
- [webpack-cli](https://www.npmjs.com/package/webpack-cli)

## Getting started

> [!NOTE]
> Make sure you are familiar with Trados app development and testing presented in the [Getting Started with Blueprints](blueprints/Getting-Started.md) and [Testing](blueprints/Testing.md) articles.

1. Download the [.NET sample app which contains a UI extension](https://github.com/RWS/language-cloud-extensibility/tree/main/samples/dotnet/UISampleApp).
    - The sample can be run out of the box with the same requirements as for the blueprint, a local Mongo database. For different setups please see the [blueprint](blueprints/Dot-Net-Blueprint.md) and [testing](blueprints/Testing.md) articles as you'll need to adjust your configuration.
2. Open the sample app solution in your IDE of choice.
3. Follow the steps presented in the [Getting Started with Blueprints](blueprints/Getting-Started.md) and [Testing](blueprints/Testing.md) articles to get your app running, then [register](../appManagement/Registering.md) and [install](../appManagement/Installing.md) it.
4. Open Trados in a browser and go to the Projects section. Notice some custom elements were added by the sample app's UI extension.
5. To alter the UI extension, make your changes in the [Rws.LC.UISampleApp/Resources/frontend](https://github.com/RWS/language-cloud-extensibility/tree/main/samples/dotnet/UISampleApp/Rws.LC.UISampleApp/Resources/frontend) folder, then open a terminal from the `Rws.LC.UISampleApp/Resources/frontend` location.
6. Install the dependencies for your UI extension by running this command:
    ```
    npm install
    ```
7. Build the UI extension to output the Javascript file that will be loaded by Trados for your UI extension:
    ```
    npm run build
    ```

    You can also build the UI extension using development mode:
    
    ```
    npm run build-dev
    ```
      
    - The `build` (or `build-dev`) command will create a `my-ui-extension-script.js` file in `Rws.LC.UISampleApp/Resources/frontend/dist/`. This is the path you need to use in the [descriptor](../../api/Extensibility-API.v1-fv.html#/operations/descriptor) for your extension's configuration `scriptPath`, for example `Rws.LC.UISampleApp/Resources/frontend/dist/my-ui-extension-script.js`.

    - You can change the `my-ui-extension-script.js` file name by editing
      - the `module.exports`' `output.filename` property in `Rws.LC.UISampleApp/Resources/frontend/webpack.config.js` and
      - the extension's configuration `scriptPath` field.
      > [!NOTE]
      > If your app is already registered, after changing the extension's configuration `scriptPath` field you need to [update](../appManagement/Updating.md) your app to a new version.

    - Once you have built your new JavaScript file, refresh the Trados browser tab to see your changes.

## Sample app UI code overview
Open the [sample app which contains a UI extension](https://github.com/RWS/language-cloud-extensibility/tree/main/samples/dotnet/UISampleApp/) in your IDE. Open the [index.ts](https://github.com/RWS/language-cloud-extensibility/blob/main/samples/dotnet/UISampleApp/Rws.LC.UISampleApp/Resources/frontend/index.ts) file.

```typescript
import {
    trados,
    ExtensionElement,
    ExtensibilityEventDetail
} from "@trados/trados-ui-extensibility";
```
The [`trados`](https://github.com/RWS/trados-ui-extensibility/wiki/Variable.trados) import is the main import in your UI extension and allows you to use the available extensibility functionality. The [`ExtensionElement`](https://github.com/RWS/trados-ui-extensibility/wiki/Type.ExtensionElement) and [`ExtensibilityEventDetail`](https://github.com/RWS/trados-ui-extensibility/wiki/Type.ExtensibilityEventDetail) imports are TypeScript types.

Your UI extension adds custom elements to the Trados UI. Define them in an array of type [`ExtensionElement`](https://github.com/RWS/trados-ui-extensibility/wiki/Type.ExtensionElement).
```typescript
const elements: ExtensionElement[] = [
  {
    elementId: "myCustomButton",
    location: "project-details-toolbar",
    text: "My Custom Button",
    type: "button",
    actions: [
      {
        eventType: "onclick",
        eventHandler: (detail: ExtensibilityEventDetail) => {
          console.log("My custom button was clicked", detail.project);
        },
        payload: ["project"]
      }
    ]
  }
];
```
Each custom element has an `elementId`, a `type`, and a `location`. Each element in your extension must have a unique `elementId`. The `type` and `location` properties can only have values described in [Custom elements and locations](UI-App-custom-elements-locations.md). Other properties depend on the custom element's `type`. For example, the `menu` property is only available for the `button` element type and indicates the button has a dropdown menu.

Custom elements can have an `actions` property, which is an array of objects describing the behavior of the custom element in the case of specific events. The supported values for an `action`'s `eventType` are:
* `onrender` for all element types and
* `onclick` which is specific to `button` elements.

An `action`'s `payload` property indicates the data portions available in the Trados UI that will be send inside the event detail to be consumed by the event handler function.

In the code snippet above, the `onclick` event is handled by the `eventHandler` function which has a single argument called `detail`. Since this `action`'s `payload` is an array containing the `project` data selector key, the `eventHandler`'s `detail` argument will also contain a `project` field representing the current project object in the Trados UI.

After you have defined the custom elements your UI extension will add to the Trados UI in the `elements` array, you must enable communication between your UI extension and Trados UI by calling the `trados.onReady` function.

```typescript
trados.onReady(elements, () => {
  console.log("Communication with Trados UI enabled");
});
```
The `onReady` function inside the `trados` object has two arguments: the `elements` array describing all custom elements your UI extension adds to the Trados UI, and a callback function that is called once your UI extension's script is loaded in the browser and communication with Trados UI is available.

### Calling your own app's API
In the sample app code, open the index.ts file and find the element with id `callAppApiButton`. The `actions` field has the `callAppApiButtonClicked` eventHandler. Go to this function's implementation in `handlers/buttonsHandlers.ts` and notice the `trados.callAppApi` function being called:

```typescript
trados.callAppApi({
  url: `api/greeting/`,
  method: "GET"
})
```

The object passed as argument has the `url` property set to `api/greeting` which is the route of the endpoint implemented in `GreetingController.cs` in the `Controllers` folder. The second property is the `method` set to `GET`. The argument object has two mandatory properties, `url` and `method`, and can have other properties depending on your use case, such as `params`, `formData`, `body`, `headers`.

The `callAppApi` function returns a `Promise`, so you can use `then`/`catch` to handle the API call's response.

### Calling the Trados Cloud Platform API
In the sample app code, open the index.ts file and find the element with id `callPublicApiButton`. The `actions` field is an array of two items, one handling the `onrender` event and the other handling the `onclick` event. Go to the `callPublicApiButtonClicked` function's implementation in `handlers/buttonsHandlers.ts` and notice the `tradosProjectTemplateApi` function being called:

```typescript
tradosProjectTemplateApi()
  .getProjectTemplate({
    projectTemplateId: projectTemplateId,
    ...trados.getRegistrationResult()
  })
```

Each Trados Cloud Platform API needs to be imported separately from `@trados/trados-ui-extensibility` and is represented by a function. In this example, the `tradosProjectTemplateApi` function is imported and called to initialize the API. The next function call, `getProjectTemplate`, is the call to a specific endpoint from the `tradosProjectTemplateApi`.

The `projectTemplateId` is the mandatory field needed for the `getProjectTemplate` API endpoint call. Notice the `...trados.getRegistrationResult()` passed inside the argument. This extends the argument object with additional mandatory fields like the account identifier and authorization token.

For each Trados Cloud Platform API, all endpoint functions function return a `Promise`, so you can use `then`/`catch` to handle the API call's response.

### Using data available in the Trados UI
In the sample app code, open the index.ts file and find the element with id `myGetUiDataButton`. The `actions` field has the `myGetUiDataButtonClicked` eventHandler. Go to this function's implementation in `handlers/buttonsHandlers.ts` and notice the `trados.getLocalData` function being called:

```typescript
trados.getLocalData(trados.contexts.projects, trados.dataSelectors.selectedProjects)
```

The `getLocalData` function provides access to portions of data currently available in the Trados UI.

The first argument is the `trados.contexts.projects`. This indicates in which main section of the application the needed data resides.

The second argument is the data portion selector, in this example `trados.dataSelectors.selectedProjects`. This will provide the array of `Project` objects selected by the user in the Projects list view.

The `getLocalData` function returns a `Promise`, so you can use `then`/`catch` to handle the success or failure of the data retrieval.

### Changing a custom element
In the sample app code, open the index.ts file and find the element with id `myDropdownButton`. Notice that it has a `menu` property which is an array describing the dropdown menu options of the button. Besides the `icon` and `text` properties, each menu option has a `value` set to an arbitrary string.
Scroll down to the button's `actions` property and notice the `onclick` `eventHandler` function. It contains a `switch` statement parsing the `value` received from the `onclick` event's detail object. When a user clicks a dropdown menu option, its `value` is passed to the `eventHandler`. Every dropdown menu option in `myDropdownButton` updates properties of another custom element in the UI extension, `myTargetButton`. Notice the `trados.updateELement` function being called:

```typescript
trados.updateElement("myTargetButton", { disabled: true })
```

The first argument is the `id` property of the custom element that will be updated.

The second argument is an object containing the properties to update and their new values.

The `id`, `type` and `location` of a custom element can not be changed. Properties that can be changed depend on the custom element's type:
* custom elements with type `button` can have these properties changed: `disabled`, `hidden`, `icon`, `text`, `menuItems`. For each object in `menuItems` you can also change `disabled`, `hidden`, `icon`, `text`. When setting the `icon` property of a button or dropdown menu option, use string values from [Font Awesome](https://fontawesome.com/icons).
* custom elements with type `panel`, `sidebarBox`, `tab` can only have their `text` property changes. To change the content, see **Adding content to a panel, sidebarBox or tab**.

The `updateElement` function returns a `Promise`, so you can use `then`/`catch` to handle the success or failure of the update.

### Navigating inside Trados UI
In the sample app code, open the index.ts file and find the element with id `myNavigateButton`. The `actions` field has the `myNavigateButtonClicked` eventHandler. Go to this function's implementation in `handlers/buttonsHandlers.ts` and notice the `trados.navigate` function being called:

```typescript
trados.navigate(projectTemplatePath, trados.navigationTypes.route)
```

The first argument is the path to which the application will navigate. Note this is not a URL, but only the portion after `/lc/{myAccount}/` in the Trados URL. In the example, it's `resources/project-templates/${projectTemplateId}`.

The second argument is optional and indicates the type of routing navigation will use, either `route` or `load`. The default is `route` and will cause Trados UI to navigate to the desired path without a page load. The `load` navigation type will cause the Trados UI to reload to the new path.

### Adding content to a panel, sidebarBox or tab
In the sample app code, open the index.ts file and find the element with id `myCustomPanel`. The `actions` field has the `myCustomPanelRendered` eventHandler. Go to this function's implementation in `handlers/panelsHandlers.ts` and notice this code line:

```typescript
const panelContentWrapper = document.getElementById(detail.domElementId);
```

The `onrender` event's handler is passed the `detail` argument which contains the `domElementId` property. This is the DOM element to which you can add HTML content using JavaScript.

Note that adding `script` tags is not allowed and scripts from sources that are not white-listed in Trados are blocked. Adding `script` tags that are served from the same source as your app is also not allowed. Only the script file set in your app's descriptor will be loaded by Trados.


### Notes

> [!NOTE]
> #### Custom elements display order
> Within a single UI extension: custom elements in your extension that have the same `location` are displayed in the same order in which they are present in your `ExtensionElement`s array.
> 
> With multiple UI extensions: the display order is determined by the order in which each UI extension's script file is loaded in the Trados UI.


> [!NOTE]
> #### Unexpected re-renders
> A custom element's `onrender` event can be triggered multiple times depending on state changes in the Trados UI and depending on user's interactions with Trados UI. Subsequently, the corresponding `eventHandler` gets executed multiple times. You can add logic specific to you use-case to protect your UI extension against unneeded execution of `onrender` `eventHandler`.