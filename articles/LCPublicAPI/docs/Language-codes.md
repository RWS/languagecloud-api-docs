# Language Codes

When getting a response that contains language codes, the case of the language code is not guaranteed and should be treated as case insensitive.

For example the Trados Cloud Platform API can return the same language code but with different casing on different endpoints:

- en-US
- en-us
- EN-US

All 3 variants are equivalent.

When making a request to the Trados Cloud Platform API, you should still ensure the correct casing of language codes, to avoid any unexpected situations.