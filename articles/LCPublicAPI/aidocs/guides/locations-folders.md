# Locations, folders and inheritance

Resources live in a hierarchical folder tree; access depends on the folder and the user's groups, and list endpoints filter by `location` and `locationStrategy`.

## Model

- Folder-based access management applies to all resources. Users access resources according to the permissions of the groups (roles) they belong to.
- The hierarchy starts at **Root**; `hasParent: false` marks Root.
- Resources are stored in a **location** (folder). Webhooks and other resources follow inheritance rules.

## Finding the user's location

[GetMyUser](../reference/GetMyUser.md) with `fields=location.name,location.path,groups`:

```json
{
    "id": "62b...d56",
    "location": {
        "id": "bbc...c21",
        "name": "Customer5",
        "path": [
            { "id": "48b...5d0", "location": "fea...a0b", "name": "Customer2", "hasParent": true },
            { "id": "fea...a0b", "location": "60b...fb0", "name": "Customers", "hasParent": true },
            { "id": "60b...fb0", "name": "Root", "hasParent": false }
        ]
    },
    "groups": [ { "id": "60b...2be", "name": "Project Managers Customer5" } ]
}
```

- `location.id` = exact folder of the resource.
- `location.path` = bottom-up list of parent folders up to Root (last entry has `hasParent: false`).

## Creating resources: the `location` field

Always send `location` (folder ID) when creating a resource.

| `location` in create request | Result |
|---|---|
| Set to a folder ID | Created in that folder |
| Not set | System tries Root. Succeeds if user has access to Root; otherwise fails with **forbidden** |

Examples: a Customer2 user creating a project with `location` = Customer2 ID creates it in Customer2; without `location`, it goes to Root (or fails with forbidden). Same logic for Customer4.

## Listing: `location` and `locationStrategy`

List endpoints may accept `location` (folder ID; some endpoints accept an array, comma-separated, results de-duplicated) and `locationStrategy`:

| `locationStrategy` | Returns resources located in |
|---|---|
| `location` (default) | Exactly the given folder(s) |
| `lineage` | The folder and all its subfolders |
| `bloodline` | The folder and all its ancestor folders |
| `genealogy` | The folder, its subfolders and its ancestors |

`locationStrategy` without `location` filters nothing.

Example hierarchy: Root (Project1) > Customers (Project2) > Customer1 > {Customer3 (Project3), Customer4}; Customers > Customer2 > Customer5 (Project4); Root > Vendors > {Vendor1, Vendor2}.

| `location` | `locationStrategy` | Projects returned |
|---|---|---|
| Customers | (default) / `location` | Project2 |
| Customers | `lineage` | Project2, Project3, Project4 |
| Customer3 | `bloodline` | Project1, Project2, Project3 |
| Customers | `genealogy` | Project1, Project2, Project3, Project4 |
| Customers, Customer3 | `lineage` | Project2, Project3 (once), Project4 |

## Related

- Creating projects in a location: [projects.md](./projects.md)
- Service user location and groups: [auth.md](./auth.md)
- Webhook visibility by folder: [webhooks.md](./webhooks.md)
