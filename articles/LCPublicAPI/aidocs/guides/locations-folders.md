# Locations and Folders

## Concepts

Trados Cloud Platform uses a hierarchical folder structure for organizing and controlling access to resources. Each resource is created in a folder (location). Access rights are inherited from parent folders.

- **Location** — a folder identified by a 24-character hex ID (e.g. `48b...5d0`).
- **Inheritance** — permissions propagate downward: a user in folder `A` can see resources in all descendant folders of `A`.

## Finding Your User's Location and Groups

```
GET /users/me?fields=location.name,location.path,groups
```

The `location.path` array lists parent folders bottom-up until `Root` (`hasParent: false`).

## Always Set the `location` Field When Creating Resources

If `location` is omitted, the API attempts to create the resource in the Root folder. If the service user lacks access to Root, the request fails with `403 Forbidden`.

## Location Strategies for List Endpoints

Many list endpoints accept `location` (folder ID or comma-separated list) and `locationStrategy` query parameters.

| `locationStrategy` value | Resources returned |
|---|---|
| `location` (default) | Resources in the specified folder(s) only. |
| `lineage` | Resources in the specified folder(s) and all descendant folders. |
| `bloodline` | Resources in the specified folder(s) and all ancestor folders up to Root. |
| `genealogy` | Resources in the specified folder(s) plus all descendants and all ancestors. |

When multiple folder IDs are supplied, results are unioned (duplicates removed).

## Example Account Hierarchy

```
Root (60b...fb0) — Project1
  Customers (fea...a0b) — Project2
    Customer1 (ed7...623)
      Customer3 (4f0...206) — Project3
      Customer4 (e73...4a8)
    Customer2 (48b...5d0)
      Customer5 (bbc...c21) — Project4
  Vendors (a16...29f)
    Vendor1 (b02...281)
    Vendor2 (d46...839)
```

### Query Results

| `location` | `locationStrategy` | Projects returned |
|---|---|---|
| `fea...a0b` (Customers) | `location` (default) | Project2 |
| `fea...a0b` (Customers) | `lineage` | Project2, Project3, Project4 |
| `4f0...206` (Customer3) | `bloodline` | Project1, Project2, Project3 |
| `fea...a0b` (Customers) | `genealogy` | Project1, Project2, Project3, Project4 |
| `fea...a0b,4f0...206` | `lineage` | Project2, Project3 (once), Project4 |
| _(none)_ | `lineage` | All projects (no filter applied) |

## Creating Resources in a Specific Folder

Pass the folder ID as the `location` field in the request body:

```json
{
  "name": "My Project",
  "location": "48b...5d0"
}
```

A resource created in `Customer2` is visible to users in `Customer2` and all ancestor folders (`Customers`, `Root`).
