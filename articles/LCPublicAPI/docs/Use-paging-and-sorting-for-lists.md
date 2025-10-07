# Use paging and sorting for lists

When the outcome of a `GET` call is a list of items (item properties and total count), you can control the number of results displayed on a page as well as sort the results.

To control the number of results displayed on a page, do the following:

- To retrieve the full size of an entity, make a `GET` call to its corresponding endpoint. 

For example, make a `GET` call to the [`/projects`](../api/Public-API.v1-fv.html#/operations/ListProjects) endpoint. The result consists in a list of all the projects (and their details) as well as a project count. The project count field returns the same value even if you further apply the `top` or `skip` query parameters.

- To display only the first 10, 20, 30 (and so on) results in your list, use the `top` query parameter. 

For example, for the [`/projects`](../api/Public-API.v1-fv.html#/operations/ListProjects) endpoint, your query may look like this if you are interested in the first 10 projects: `/projects?top=10`

- To get to a particular set of retrieved results in your list, use the `skip` query parameter. 

For example, for the [`/projects`](../api/Public-API.v1-fv.html#/operations/ListProjects) endpoint, if you want to skip the first 100 results, your query will look like this: `/projects?skip=100`.

- To sort your list by certain properties, use the `sort` query parameter. 

The default sorting strategy is ascending. Add unary operators for ascending (+) and descending (-) sorting. If you do not add any operator, the default ascending strategy kicks in. 

For example, if you want to sort results by due date (-) and name (+), your query will look like this: `/projects?sort=-dueBy,name`.

Note that sorting can be performed only on first-level fields (not nested fields), for naturally comparable types like strings, numbers, and dates.

