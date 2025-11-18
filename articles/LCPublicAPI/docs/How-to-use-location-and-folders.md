# How to use location and folders

The Trados Cloud Platform API supports [folder-based](https://docs.rws.com/791595/984983/trados-enterprise/how-do-folder-structure-and-inheritance-help-you-get-organized-) access management to all resources. The users have access to resources based on the permissions associated with the group (role) they belong to. For information about creating a user you can check the [Service credentials](../docs/Service-credentials.md) page. 


### Concepts we use

Detailed information about specific concepts used in inheritance context can be found on the [
Concepts we use](https://docs.rws.com/791595/984976/trados-enterprise/concepts-we-use) page from the official Trados Cloud Platform Documentation Center.


### Setting a location for a user

The folders structure in Trados Cloud Platform API is hierarchical. For more information on how to organize folders and set up a location for a user, visit the [Customers](https://docs.rws.com/791595/707420/trados-enterprise/customers) page.


## User rights in folders

Depending on how the account was provisioned, configured and on the groups which the user belongs to, the rights for a user can be more restrictive or permissive.

Users can learn where they were created, the exact folder, and what groups they belong to, by executing a [Get My User](../api/Public-API.v1-fv.html#/operations/GetMyUser) call with the `fields` query parameters set to *"location.name,location.path,groups"*.

For example, let's assume that an account has the following hierarchy of folders (with associated unique identifiers simplified for readability):

- **Root** (60b...fb0)
  - **Customers** (fea...a0b)
     - **Customer1** (ed7...623)
        - **Customer3** (4f0...206)
        - **Customer4** (e73...4a8)
     - **Customer2** (48b...5d0)
        - **Customer5** (bbc...c21)
  - **Vendors** (a16...29f)
     - **Vendor1** (b02...281)
     - **Vendor2** (d46...839)

If a user is created in Customer5 and is assigned to the "Project Managers Customer5" group, performing the above request will receive the following response:
```json
{
    "id": "62b...d56",
    "location": {
        "id": "bbc...c21",
        "name": "Customer5",
        "path": [
           {
                "id": "48b...5d0",
                "location": "fea...a0b",
                "name": "Customer2",
                "hasParent": true
            },
            {
                "id": "fea...a0b",
                "location": "60b...fb0",
                "name": "Customers",
                "hasParent": true
            },
            {
                "id": "60b...fb0",
                "name": "Root",
                "hasParent": false
            }
        ]
    },
    "groups": [
        {
            "id": "60b...2be",
            "name": "Project Managers Customer5"
        }
    ]
}
```
In the above example `location.id` describes the exact folder where the resource is situated. 
The array under `location.path` presents a bottom-up hierarchical arrangement of all the parent folders leading up to `Root`, where the array ends, this being signaled by the `"hasParent": false` field.

### Creating resources in folders

The users' access to resources depends on the folder where they were created and on the groups they belong to. Detailed information about what actions can be executed with specific roles can be checked [here](https://docs.rws.com/en-US/trados-enterprise-%26-accelerate-791595/account-structure%2C-folders%2C-inheritance-796862).

When creating a resource, it is strongly recommended to send in the request the `location` field. When `location` is not set, the system will try to create the resource in the higher folder in the hierarchy, the Root folder. It might not have access to that folder and the request will fail with forbidden error. 


For example:

- If Customer2 tries to create a project with location values set to "48b...5d0":\
  **Where will the project be created?**
  - in Customer2 folder

- If Customer2 tries to create a project with no value set for location:\
  **Where will the project be created?**
  - In Root folder, if the user has access in Root
  - If the user does not have access in Root, the request will fail with forbidden error

- If Customer4 tries to create a project with location value set to "e73...4a8":\
  **Where will the project be created?**
  - in Customer4 folder

- If Customer4 tries to create a project with no value set for location:\
  **Where will the project be created?**
  - In Root folder, if the user has access in Root
  - If the user does not have access in Root, the request will fail with forbidden error

More examples of accessing resources based on their location are listed on the [Inheritance within the account](https://docs.rws.com/791595/797020/trados-enterprise/inheritance-within-the-account) page. 


### Retrieve resources using location strategy

List endpoints can have a 'location' query parameter that is used to filter items by location. `Location` is the value of the folder id. Some endpoints accept an array rather than a single location. Additionally, this parameter can be used together with 'locationStrategy' which can have the following values:
- *location*: all resources located strictly in the folders from the folder parameter (default value for `locationStrategy`) are returned 
- *lineage*: resources located in the folder specified by the folder parameter, as well as any of its subfolders, are returned 
- *bloodline*: resources located in the folder specified by the folder parameter, as well as any of its ancestor folders, are returned 
- *genealogy*: resources located in the folder specified by the folder parameter together with its subfolders and its ancestor folders

The `location` field can be an array of folder identifiers containing multiple identifiers separated by commas. In this case, the `locationStrategy` applies for all of them and the result will contain all resources that fulfill the strategy, but, if a resource is duplicated in response for two, or more location identifiers, it will be returned only once. 

For example, let's see how `location` and `locationStrategy` query parameters work on an account that has the hierarchy defined in the earlier example:

- **Root** (60b...fb0) - **Project1**
  - **Customers** (fea...a0b) - **Project2**
     - **Customer1** (ed7...623)
        - **Customer3** (4f0...206) - **Project3**
        - **Customer4** (e73...4a8)
     - **Customer2** (48b...5d0)
        - **Customer5** (bbc...c21) - **Project4**
  - **Vendors** (a16...29f)
     - **Vendor1** (b02...281)
     - **Vendor2** (d46...839)

If the list project endpoint is used with:
 
- `location` = "fea...a0b" (Customers folder identifier)
    <br>
    Project2 is listed because the default value for `locationStrategy` is "location".


- `locationStrategy` = "lineage"
    <br>
    All projects are listed because sending the `locationStrategy` without `location` does not filter anything.


- `location` =  "fea...a0b" (Customers folder identifier) AND `locationStrategy` = "location"
    <br>
    Project2 is listed because it is similar with the first case. 


- `location` =  "fea...a0b" (Customers folder identifier) AND `locationStrategy` = "lineage"
    <br>
    Project2, Project3 and Project4 are returned.


- `location` =  "4f0...206" (Customer3 folder identifier) AND `locationStrategy` = "bloodline"
    <br>
    Project1, Project2 and Project3 are returned.


- `location` =  "fea...a0b" (Customers folder identifier) AND `locationStrategy` = "genealogy"
    <br>
    Project1, Project2, Project3 and Project4 are returned.


- `location` = "fea...a0b,fea...0a0" (Customers and Customer3 folder identifiers) AND `locationStrategy` = "lineage"
    <br>
    Project2, Project3 (only once) and Project4 are returned.



