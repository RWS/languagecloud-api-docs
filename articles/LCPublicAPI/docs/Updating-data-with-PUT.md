# Updating data with PUT

All update endpoints follow the rules listed in [JSON Merge Patch Semantics](https://tools.ietf.org/html/rfc7386).

### Pay special attention when updating array fields

The update overrides the entire array, not just the elements that are sent. See the following example:

| ORIGINAL | PATCH | RESULT |
|:---      | :---  |  :---  |
|`{"a" :[{"b": "c"}]}`| `{"a" :[1]}` | `{"a" :[1]}`|


If you don't send the "b" element from array "a", the element "b" will be removed from result after the update operation. 

If you send a new array element `[1]`, this element will be added into the result.

Updating an existing array element requires that you send the original array with a new value for the desired element.