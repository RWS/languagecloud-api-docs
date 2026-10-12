# Language codes

Language codes in responses are case-insensitive; send correctly cased codes in requests.

- Responses can return the same code with different casing on different endpoints, e.g. `en-US`, `en-us`, `EN-US`. All are equivalent; compare case-insensitively.
- In requests, use the correct casing (e.g. `en-US`) to avoid unexpected behaviour.
- Valid codes: [ListLanguages](../reference/ListLanguages.md).

## Related

- Language directions in projects: [projects.md](./projects.md)
