# API lifecycle: breaking changes and endpoint retirement

Definition of breaking changes, endpoint deprecation and sunset signalling, and notice periods.

Releases are continuous (new functionality, fixes, performance improvements).

## Breaking changes

| Breaking | Not breaking |
|---|---|
| Changing the type of a field | Adding new endpoints |
| Modifying a field name | Adding optional request fields |
| Marking an existing field as required with no default value | Adding new fields in responses |
| Introducing a new validation | Adding a new required field with a default value |
| Enforcing validations | Changing error message descriptions |
| Removing or renaming enum values | Adding enum values |
| Removing fields from response | |

## Endpoint retirement

Two phases: deprecation, then sunset.

| Phase | Signal |
|---|---|
| Deprecation | IETF `Deprecation` HTTP response header (draft-dalal-deprecation-header) |
| Sunset | New `Sunset` header carrying the sunset date; the endpoint remains functional until sunset, after which it does not return the expected response |

`Deprecation` header values:

| Value | Meaning |
|---|---|
| Date in the future | Date when the endpoint will be marked deprecated |
| Date in the past | Date when the endpoint was marked deprecated |
| `true` | Endpoint is deprecated |

Deprecation period: 6 months.

## Notice

- Breaking changes are announced 6 months in advance.
- Exception: breaking changes may be introduced for critical bugs or security vulnerabilities.
- Announcements: the What's new and What's deprecated pages of the API docs, the developers GitHub page, and the Language Developers Blog and Trados Blog.

## Related

- Response headers: [headers.md](./headers.md)
- Reporting issues: [errors.md](./errors.md)
