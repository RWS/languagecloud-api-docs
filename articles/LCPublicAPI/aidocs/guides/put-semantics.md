# PUT update semantics

All update (`PUT`) endpoints follow JSON Merge Patch semantics (RFC 7386); arrays are replaced entirely.

## Array fields

An update overrides the entire array, not just the elements sent.

| ORIGINAL | PATCH | RESULT |
|:---|:---|:---|
| `{"a":[{"b":"c"}]}` | `{"a":[1]}` | `{"a":[1]}` |

- Elements not sent are removed from the result.
- A new element sent in the array is added to the result.
- To change one existing array element, send the original array with the new value for that element.

## Resource-specific consequences

| Resource | Behaviour |
|---|---|
| Termbase entry (`PUT /termbases/{termbaseId}/entries/{entryId}`) | Update replaces the entire entry structure; terms not sent are deleted. Resend unchanged terms as they currently are. |
| Termbase (`PUT /termbases/{termbaseId}`) | Fields can be updated only if the termbase was not created from a template or has no fields defined. A field sent without `id` is added to the termbase. |
| Project `customFields` | Sent through [UpdateProject](../reference/UpdateProject.md) with new values for the fields to change. |

See [termbases.md](./termbases.md) and [custom-fields.md](./custom-fields.md).
