# Trados Data Bridge APIs for Postman

We provide a [Postman](https://www.postman.com/) collection for quick and easy usage of our RESTful APIs.

## Installation

You can download the Postman collection from [here](https://github.com/sdl/language-cloud-public-api-postman/blob/develop/postmanDataCollection.json?raw=true).

You have 3 setup options:
- Copy the collection URL from above and import it into Postman using `Import > Link`.
- Copy the entire file content and import it into Postman using `Import > Raw Text`.
- Save it as a `JSON` file on your computer and import it into Postman using `Import > File`.


![image](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/SetLCAccountToken.png?raw=true)

</br>

## Configuration

The imported collection is already set up for you to get started as fast as possible. 

We make use of collection level variables and an inherited authentication mechanism.

For example, authentication is already set up to use the Bearer Token scheme and will use the token value provided by `{{lc-access-token}}` variable. This token is populated with the correct value, each time you `Obtain a client credentials access token`, via the Tests tab.

One thing you need to do before proceeding is to fill in the `{{lc_tenant}}` variable with your own tenant ID. Prepend the ID with LC- so the final value looks like this `LC-00000000000000000`.

Don't forget to save the collection!


![image](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/SetLCTenant.png?raw=true)


</br>

## Authentication
To start working with the Trados Data Bridge API, you first need to authenticate. 

You can find the authentication call under the `Authentication (Start Here)` folder. Fill in your `client_id` and `client_secret` and perform the request.

If the authentication is successful, the token will be extracted automatically from the response and saved to the `{{lc-access-token}}` variable.


![image](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/AuthorizationWithClientCredentials.png?raw=true)


</br>

## Usage

After you have authenticated successfully, you can start interacting with the RWS Language Cloud Data API.

For example, we can get information about a project by using the **List Task Status Project Dimension** request from the **Task Status** folder.

Simply fill in your value `projectId eq 'stringValue'` from your $filter parameter section and click SEND. Optionally, you can specify additional OData querys like  
`projectTemplateName eq 'stringValue' and projectShortId eq numericValue`.  
For more options see below table
| Operators| Description| Example |
|----------|------------|---------|
| Comparison operators| Use the `eq, ne, gt, ge, lt, le` operators to compare a property and a value.  |`$filter=revenue eq 100000`|
| Logical operators|Use `and, or` to create more complex expressions.|`$filter=revenue lt 100000 and revenue gt 2000`|
| Grouping operators|Use parentheses: `()`, to specify the precedence to evaluate a complex expression.|`$filter=(projectShortId lt 16867 and projectShortId gt 16800) and projectStatus eq 'completed'`|
| Expand operator|The `expand` system query option specifies the related resources to be included. Each expandItem is evaluated relative to the entity containing the navigation or stream property being expanded.|`$expand=project`|

![image](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/WorkingWithFilterParameter.png?raw=true)


![image](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/WorkingWithExpandParameter.png?raw=true)

> [!WARNING]
> Make sure you are not sending any query parameters with default Postman values. If you are sending any parameters, make sure you are sending valid data or else you will get an API Error. 

