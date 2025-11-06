# Use fields in your requests

All the endpoints that return a resource representation allow the `fields` query parameter. Fields are used to specify the property values you want returned for your entities. 

When you make a call using the `fields` query parameter, make sure that you:
- Separate the fields by commas.
- Query by `properties` and/or `subproperties`. Write `subproperties` in the following format: `propertyname.subpropertyname`.
- Familiarize yourself with the elements that get returned:
	- 	The fields marked as â€ś**required**â€ť are always returned.
	- 	If fields are not customized for a given level and the requested field is non null then the default fields will be returned.
	- 	If fields are customized for a given level and the requested field is non null, the fields you requested will be returned.
	- 	The rules above are applied at nested level as well.

Letâ€™s look at an example to understand how the `fields` parameter can be used. 
We will perform a `GET` request to the [`/projects/projectId`](../api/Public-API.v1-fv.html#/operations/GetProject) endpoint and we will consider that in our example the `projectId`= 101.

#### 1. Fields consist of properties and subproperties. Here are some examples:
- `Properties`: `id`; `name`; `customer`; `createdBy` and so on
- `Subproperties`: `customer.name`; `customer.keyContact`; `customer.location`; `createdBy.email` and so on

#### 2. You can make calls in several ways:
- No field customization

Request: `GET/projects/101`

Response: the project **identifier**, the project **name**, the project **language directions**

<!--
focus: false
-->
![No Fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/GetProjectEmptyFields.gif?raw=true)

* Field customization (no nesting)

Request: `GET/projects/101?fields=customer`

Response: the project **identifier**; the customer **identifier**; the customer **name**; the customerâ€™s **key contact**; the customer **location**

<!--
focus: false
-->
![Root Fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/GetProjectRootField.gif?raw=true)

* Field customization (nesting)

Request: `GET/projects/101?fields=customer.keyContact,customer.name`

Response: the project **identifier**; the customer **name**; the customerâ€™s **key contact**

<!--
focus: false
-->
![Nested Fields](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/GetProjectNestedFields.gif?raw=true)

