# Field Selection

All endpoints returning a resource representation support the `fields` query parameter for selecting which properties to include in the response.

## Syntax

- Comma-separated list of property names.
- Nested properties use dot notation: `propertyname.subpropertyname`.

## Rules

| Condition | Result |
|---|---|
| Field marked **required** | Always returned regardless of `fields` value. |
| `fields` not specified, field is non-null | Default fields returned. |
| `fields` specified, field is non-null | Only requested fields returned. |
| Rules apply recursively to nested levels. | |

## Examples

```
GET /projects/101
```
Returns: project `id`, `name`, `languageDirections` (defaults).

```
GET /projects/101?fields=customer
```
Returns: project `id`; customer `id`, `name`, `keyContact`, `location`.

```
GET /projects/101?fields=customer.keyContact,customer.name
```
Returns: project `id`; customer `name`, `keyContact` only.

```
GET /projects/101?fields=status,quote.totalAmount
```
Returns: project `id`, `status`, `quote.totalAmount`.

```
GET /users/me?fields=location.name,location.path,groups
```
Returns the user's folder location and group memberships.
