# PUT Semantics (JSON Merge Patch)

All update (`PUT`) endpoints follow [JSON Merge Patch semantics (RFC 7396)](https://tools.ietf.org/html/rfc7386).

## Array Field Behavior

**Sending an array in a PUT request replaces the entire array**, not individual elements.

| Original | Patch sent | Result |
|---|---|---|
| `{"a":[{"b":"c"}]}` | `{"a":[1]}` | `{"a":[1]}` |

If you omit element `"b"` from array `"a"`, it is removed. To keep existing elements, include them in full in the request body. To update a single element, send the entire array with the updated value for that element.
