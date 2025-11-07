# Translation Memory advanced configuration

The Trados Cloud Platform API provides advanced settings for Translation Memory (TM) operations, including powerful filter expressions and field update options. These features give you fine-grained control over which translation units match and how Translation Memory fields are updated.

See also: [Configuring advanced project settings](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/configuring-advanced-project-settings-1177196) and [Configuring advanced project template settings](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/configuring-advanced-project-template-settings-1189020).

## Applicable API endpoints

The TM advanced configuration options in this document apply to the following API endpoints.

Project endpoints:
- [Get Project](../../api/Public-API.v1-fv.html#/operations/GetProject) - Retrieve project details, including Translation Memory settings
- [Update Project](../../api/Public-API.v1-fv.html#/operations/UpdateProject) - Update project configuration, including Translation Memory settings

Project template endpoints:
- [Get Project Template](../../api/Public-API.v1-fv.html#/operations/GetProjectTemplate) - Retrieve project template details, including Translation Memory settings
- [Update Project Template](../../api/Public-API.v1-fv.html#/operations/UpdateProjectTemplate) - Update project template configuration, including Translation Memory settings

## Translation Memory filters

Translation Memory filters let you apply complex criteria during TM operations. Filters can reference system and custom fields, and support multiple data types and operators.

### Hard filter configuration

Hard filters enforce strict criteria that Translation Units (TUs) must meet to be considered matches. See the [official documentation](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/hard-filters-1162005).

A filter configuration contains:

- `expression`: A logical expression describing the criteria
- `fields`: An array of field definitions referenced by the expression

#### Filter expression syntax

Filter expressions are built from comparison expressions combined with logical operators.

Logical operators:
- `AND` - both conditions must be true
- `OR` - at least one condition must be true
- `NOT` - negates the following condition

Example:
```
(NOT "TU confirmation level" = "Not Translated" OR "Last modified on" > 2024-02-29T10:00:00.000Z) AND "Source segment length" >= 10
```

This expression selects TUs that are either not marked as "Not Translated" or that were modified after 2024-02-29T10:00:00Z, and that have a source segment length of at least 10 characters.

#### Filter expression grammar

Filter expressions are parsed with ANTLR4 (ANother Tool for Language Recognition). The grammar below specifies the formal syntax and operator precedence.

Understanding the grammar helps you:
- Construct complex expressions correctly
- Reason about operator precedence
- Validate expressions before sending them to the API
- Build tooling to generate or validate expressions

ANTLR4 grammar definition:

```
/**
 * ANTLR4 Grammar for Filter Expressions
 * 
 * This grammar defines the syntax for filtering translation units in the Trados Cloud Platform API.
 * 
 * Supported operators: =, !=, <, <=, >, >=, CONTAINS, DOES NOT CONTAIN, MATCHES, DOES NOT MATCH
 * 
 * Field names must be quoted strings.
 * Values can be quoted strings or unquoted numeric values.
 */
grammar FilterExpression;

// Root rule - top level expression that can contain logical operators
expression
    : orExpression EOF
    ;

// OR has lowest precedence - allows chaining: expr OR expr OR expr
orExpression
    : andExpression (OR andExpression)*
    ;

// AND has higher precedence than OR - allows chaining: expr AND expr AND expr
andExpression
    : notExpression (AND notExpression)*
    ;

// NOT has highest precedence among logical operators - optional negation
notExpression
    : NOT? primaryExpression
    ;

// Primary expressions include comparisons and parenthesized expressions
primaryExpression
    : comparison
    | LPAREN orExpression RPAREN
    ;

// Comparison expressions: MUST have all three components: field operator value
// This enforces the Field-Operator-Value triplet structure
comparison
    : field operator value
    ;

// Field names - must be quoted strings
field
    : QUOTED_STRING
    ;

// Operators - only the specific operators defined in the specification
operator
    : COMPARISON_OPERATOR
    ;

// Values can be quoted strings or unquoted numeric values
value
    : QUOTED_STRING
    | NUMERIC_VALUE
    ;

// Lexer rules

// Keywords and logical operators
AND     : 'AND' ;
OR      : 'OR' ;
NOT     : 'NOT' ;

// Parentheses
LPAREN  : '(' ;
RPAREN  : ')' ;

// Field names - quoted strings that represent field names
QUOTED_STRING
    : '"' (~["\\\r\n] | '\\\\' | '\\"')* '"'
    ;

// Numeric field values (integers only)  
NUMERIC_VALUE
    : '-'? [0-9]+
    ;

// Comparison operators - all supported operators
COMPARISON_OPERATOR
    : 'DOES NOT CONTAIN'
    | 'DOES NOT MATCH'
    | 'CONTAINS'
    | 'MATCHES'
    | '<='
    | '>='
    | '!='
    | '<'
    | '>'
    | '='
    ;

// Catch invalid identifiers to prevent ANTLR from accepting them
INVALID_IDENTIFIER
    : [a-zA-Z][a-zA-Z0-9_]*                                   // Invalid words like ORR, NOTT
    ;

// Whitespace (ignored) - MUST come before catch-all rule
WS  : [ \t\r\n]+ -> skip ;

// Catch-all rule for any invalid character (including Unicode)
// This MUST be the last lexer rule to catch anything not matched above
INVALID_CHARACTER
    : .                                                       // Any single character not matched by rules above
    ;
```

### System fields

The following system fields are available for filter expressions:

| Field name | Field type | Description |
|------------|------------|-------------|
| `Last modified on` | `dateTime` | When the TU was last modified |
| `Last modified by` | `singleString` | User who last modified the TU |
| `Last used on` | `dateTime` | When the TU was last used |
| `Last used by` | `singleString` | User who last used the TU |
| `Usage count` | `integer` | Number of times the TU has been used |
| `Created on` | `dateTime` | When the TU was created |
| `Created by` | `singleString` | User who created the TU |
| `TU confirmation level` | `singlePicklist` | Confirmation status of the TU |
| `Source segment` | `singleString` | Source text content |
| `Target segment` | `singleString` | Target text content |
| `Source segment length` | `integer` | Length of source text |
| `Target segment length` | `integer` | Length of target text |
| `Number of tags in source segment` | `integer` | Count of tags in source |
| `Number of tags in target segment` | `integer` | Count of tags in target |

### TU confirmation level values

See the [official documentation](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/translation-statuses-650851) for background information on translation statuses. The Trados Cloud Platform API accepts the following exact values for `TU confirmation level`:

- `Not Translated`
- `Draft`
- `Translated`
- `Translation Rejected`
- `Translation Approved`
- `Sign-off Rejected`
- `Signed Off`

### Filter operators

Supported operators depend on the field type:

| Operator | singleString | multipleString | singlePicklist | multiplePicklist | dateTime | integer |
|----------|:------------:|:--------------:|:--------------:|:----------------:|:--------:|:-------:|
| `=` | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| `<` | ✘ | ✘ | ✘ | ✘ | ✔ | ✔ |
| `<=` | ✘ | ✘ | ✘ | ✘ | ✔ | ✔ |
| `>` | ✘ | ✘ | ✘ | ✘ | ✔ | ✔ |
| `>=` | ✘ | ✘ | ✘ | ✘ | ✔ | ✔ |
| `!=` | ✔ | ✘ | ✔ | ✘ | ✔ | ✔ |
| `CONTAINS` | ✔ | ✔ | ✘ | ✔ | ✘ | ✘ |
| `DOES NOT CONTAIN` | ✔ | ✔ | ✘ | ✔ | ✘ | ✘ |
| `MATCHES` | ✔ | ✘ | ✘ | ✘ | ✘ | ✘ |
| `DOES NOT MATCH` | ✔ | ✘ | ✘ | ✘ | ✘ | ✘ |

### Filter field definition

Filter fields are represented differently in responses and requests.

Filter fields in API responses (GET endpoints)

When you retrieve TM settings using the GET endpoints (see [Applicable API endpoints](#applicable-api-endpoints)), the response includes full metadata for each referenced field:

- `fieldId`: Field identifier (system field name or custom field ID)
- `fieldTemplateId`: `system` for system fields, or the custom field template ID
- `fieldTemplateName`: Field template name
- `name`: Field name (for system fields this equals `fieldId`)
- `type`: Data type
- `allowedValues` (optional): Present for `singlePicklist` and `multiplePicklist` fields

Filter fields in API requests (PUT endpoints)

When you update filter configuration via PUT (see [Applicable API endpoints](#applicable-api-endpoints)), you do not need to include the `fields` array. The system resolves field metadata automatically from the field names used in the expression.

Supported field types:
- `singleString` - single text value
- `multipleString` - multiple unique text values
- `singlePicklist` - single selection from predefined options
- `multiplePicklist` - multiple unique selections from predefined options
- `dateTime` - date and time value
- `integer` - integer value

## Translation Memory field updates

See the [official documentation](https://docs.rws.com/en-US/trados-enterprise-accelerate-791595/fields-and-field-templates-706941) for details on fields and field templates.

Note: Custom field definitions and values appear in GET responses under `settings.translationMemorySettings.updateTranslationMemoryFields`. The response includes both field metadata and configured values.

### Field update configuration

Field update payloads and responses differ by endpoint.

Field updates in API requests (PUT endpoints)

When updating TM settings via PUT (see [Applicable API endpoints](#applicable-api-endpoints)), use a simple structure:

- `fieldId`: Field identifier (system field name or custom field ID)
- `values`: Array of values to apply (format depends on field type)

Field updates in API responses (GET endpoints)

When you retrieve TM settings via GET, the response includes full field metadata (see Filter field definition), plus:

- `values`: Array of currently assigned values. Types `singleString`, `singlePicklist`, `integer`, and `dateTime` contain exactly one value; `multipleString` and `multiplePicklist` may contain multiple values.

Example configurations

#### Updating TM settings (PUT request)

When updating a project or project template's TM settings via PUT (see [Applicable API endpoints](#applicable-api-endpoints)), provide only `fieldId` and `values` where applicable - the system will resolve metadata automatically.

```json
{
  "settings": {
    "translationMemorySettings": {
      "filters": {
        "hardFilter": {
          "expression": "(\"Created by\" CONTAINS \"API Integration\" OR \"TU confirmation level\" != \"Not Translated\") AND NOT (\"Text\" MATCHES \"exampleText\" AND \"Usage count\" >= 10)"
        }
      },
      "updateTranslationMemoryFields": [
        {
          "fieldId": "1e5b54da-9048-45f7-a5d8-c3878ac4c5b7",
          "values": [
            "11"
          ]
        },
        {
          "fieldId": "25c0dce2-11d0-44c0-837e-1f5030e2204d",
          "values": [
            "multiText1",
            " multiText2 "
          ]
        },
        {
          "fieldId": "55eb47bb-20bc-43e0-b1e1-9b373e5ca157",
          "values": [
            "1List"
          ]
        },
        {
          "fieldId": "bf6e413d-e617-4fcd-be13-e389af7ce7d4",
          "values": [
            "1Multi List",
            "2Multi List"
          ]
        },
        {
          "fieldId": "3e71fc28-a128-4c69-befd-eee38ce998e4",
          "values": [
            "singleText1"
          ]
        },
        {
          "fieldId": "6c6d9004-3a9e-4bde-97b4-62a6d2ec1a7f",
          "values": [
            "2025-10-29T12:00:00.000Z"
          ]
        }
      ]
    }
  }
}
```
> [!NOTE]
> In PUT requests you only specify `fieldId` and `values`; metadata is resolved automatically.

#### Retrieving TM settings (GET response)

When you retrieve project or project template settings via GET and include the query parameter `fields=settings.translationMemorySettings.filters.hardFilter.fields,settings.translationMemorySettings.updateTranslationMemoryFields`, the response will include full field metadata.

For details about the `fields` query parameter, see [Use fields in your requests](../Use-fields-in-your-requests.md).

Example response:

```json
{
  "id": "6895b4bf6b83b41210883f09",
  "settings": {
    "translationMemorySettings": {
      "filters": {
        "hardFilter": {
          "expression": "(\"Created by\" CONTAINS \"API Integration\" OR \"TU confirmation level\" != \"Not Translated\") AND NOT (\"Text\" MATCHES \"exampleText\" AND \"Usage count\" >= 10)",
          "fields": [
            {
              "fieldId": "Created by",
              "fieldTemplateId": "system",
              "name": "Created by",
              "type": "singleString"
            },
            {
              "fieldId": "TU confirmation level",
              "fieldTemplateId": "system",
              "name": "TU confirmation level",
              "type": "singlePicklist",
              "allowedValues": [
                {
                  "id": "translated",
                  "name": "Translated"
                },
                {
                  "id": "approvedTranslation",
                  "name": "Translation Approved"
                },
                {
                  "id": "approvedSignOff",
                  "name": "Signed Off"
                },
                {
                  "id": "draft",
                  "name": "Draft"
                },
                {
                  "id": "rejectedTranslation",
                  "name": "Translation Rejected"
                },
                {
                  "id": "rejectedSignOff",
                  "name": "Sign-off Rejected"
                },
                {
                  "id": "notTranslated",
                  "name": "Not Translated"
                }
              ]
            },
            {
              "fieldId": "3e71fc28-a128-4c69-befd-eee38ce998e4",
              "fieldTemplateId": "976cc1d2-c422-461d-a2d6-71bb52a4eba8",
              "fieldTemplateName": "Custom Field Template with Field Definitions",
              "name": "Text",
              "type": "singleString"
            },
            {
              "fieldId": "Usage count",
              "fieldTemplateId": "system",
              "name": "Usage count",
              "type": "integer"
            }
          ]
        }
      },
      "updateTranslationMemoryFields": [
        {
          "fieldId": "1e5b54da-9048-45f7-a5d8-c3878ac4c5b7",
          "fieldTemplateId": "976cc1d2-c422-461d-a2d6-71bb52a4eba8",
          "fieldTemplateName": "Custom Field Template with Field Definitions",
          "name": "Number",
          "values": [
            "11"
          ],
          "type": "integer"
        },
        {
          "fieldId": "25c0dce2-11d0-44c0-837e-1f5030e2204d",
          "fieldTemplateId": "976cc1d2-c422-461d-a2d6-71bb52a4eba8",
          "fieldTemplateName": "Custom Field Template with Field Definitions",
          "name": "MultiText",
          "values": [
            "multiText1",
            " multiText2 "
          ],
          "type": "multipleString"
        },
        {
          "fieldId": "55eb47bb-20bc-43e0-b1e1-9b373e5ca157",
          "fieldTemplateId": "976cc1d2-c422-461d-a2d6-71bb52a4eba8",
          "fieldTemplateName": "Custom Field Template with Field Definitions",
          "name": "List",
          "values": [
            "1List"
          ],
          "allowedValues": [
            {
              "id": "ab074228-0f8c-4ef3-8039-ad4d6442cade",
              "name": "1List"
            },
            {
              "id": "29f4b861-5d58-4921-b47c-19146f6d7431",
              "name": "2List"
            },
            {
              "id": "0f2d0324-0f11-46db-bb66-ad9cad21f176",
              "name": "3List"
            }
          ],
          "type": "singlePicklist"
        },
        {
          "fieldId": "bf6e413d-e617-4fcd-be13-e389af7ce7d4",
          "fieldTemplateId": "976cc1d2-c422-461d-a2d6-71bb52a4eba8",
          "fieldTemplateName": "Custom Field Template with Field Definitions",
          "name": "MultiList",
          "values": [
            "1Multi List",
            "2Multi List"
          ],
          "allowedValues": [
            {
              "id": "907a34ca-b072-4687-8af1-8ab41ac881c8",
              "name": "1Multi List"
            },
            {
              "id": "304e1ee1-3a71-4c7c-b123-e5811a812dfd",
              "name": "2Multi List"
            },
            {
              "id": "8225e4b7-a954-4503-88de-fe9f7ced77cb",
              "name": "3Multi List"
            }
          ],
          "type": "multiplePicklist"
        },
        {
          "fieldId": "3e71fc28-a128-4c69-befd-eee38ce998e4",
          "fieldTemplateId": "976cc1d2-c422-461d-a2d6-71bb52a4eba8",
          "fieldTemplateName": "Custom Field Template with Field Definitions",
          "name": "Text",
          "values": [
            "singleText1"
          ],
          "type": "singleString"
        },
        {
          "fieldId": "6c6d9004-3a9e-4bde-97b4-62a6d2ec1a7f",
          "fieldTemplateId": "976cc1d2-c422-461d-a2d6-71bb52a4eba8",
          "fieldTemplateName": "Custom Field Template with Field Definitions",
          "name": "DateTime",
          "values": [
            "2025-10-29T12:00:00.000Z"
          ],
          "type": "dateTime"
        }
      ]
    }
  }
}
```
> [!NOTE]
> In GET responses, the `fields` array is automatically populated by the system based on the field names used in the filter expression, including both system fields and custom fields. The response provides complete field metadata including `fieldTemplateId`, `fieldTemplateName`, `name`, `type`, and `allowedValues` (for picklist fields).

