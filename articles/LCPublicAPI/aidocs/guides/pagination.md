# Paging and sorting

List (`GET` collection) endpoints return items plus a total count and accept `top`, `skip` and `sort` query parameters.

## Parameters

| Parameter | Purpose | Example |
|---|---|---|
| `top` | Number of results to return (first N) | `/projects?top=10` |
| `skip` | Number of results to skip | `/projects?skip=100` |
| `sort` | Sort by one or more properties | `/projects?sort=-dueBy,name` |

## Behaviour

- A list response contains the items and a total count (`itemCount`). The count is the same regardless of `top` and `skip`.
- Combine `top` and `skip` for paging through results.
- `sort`: comma-separated properties; prefix `+` for ascending, `-` for descending. Without an operator the default is ascending. Example: `-dueBy,name` = `dueBy` descending, then `name` ascending.
- Sorting works only on first-level fields (not nested fields) of naturally comparable types: strings, numbers, dates.

Example list call: [ListProjects](../reference/ListProjects.md).

## Data Bridge

Data Bridge uses OData `$top`, `$skip`, `$orderby` with different limits. See [data-bridge.md](./data-bridge.md).
