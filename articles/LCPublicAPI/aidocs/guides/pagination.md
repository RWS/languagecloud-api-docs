# Pagination and Sorting

Applies to all `GET` list endpoints that return a collection with a total count.

## Query Parameters

| Parameter | Type | Description |
|---|---|---|
| `top` | integer | Maximum number of items to return. |
| `skip` | integer | Number of items to skip before returning results. |
| `sort` | string | Comma-separated list of field names with optional `+` (ascending) or `-` (descending) prefix. Default is ascending if no operator is given. |

## Rules

- `top` and `skip` are combinable for page-by-page iteration.
- The total count field in the response always returns the full dataset count, regardless of `top`/`skip`.
- Sorting operates only on first-level (non-nested) fields of naturally comparable types: strings, numbers, dates.

## Examples

```
GET /projects?top=10
GET /projects?skip=100
GET /projects?top=10&skip=20
GET /projects?sort=-dueBy,name
```

The last example sorts by `dueBy` descending, then by `name` ascending.
