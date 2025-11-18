---
stoplight-id: 26wchvrjmv96s
---

# OData Query Guide for Data Bridge APIs

The Trados Data Bridge API supports OData v4 query capabilities that allow you to filter, select, expand, and sort data efficiently.

For comprehensive OData query syntax reference and additional examples, see the [Microsoft OData Query Options Overview](https://learn.microsoft.com/en-us/odata/concepts/queryoptions-overview)

## Query Parameters Overview

| Parameter | Description | Example |
|-----------|-------------|---------|
| `$filter` | Filter results based on conditions | `$filter=revenue gt 1000` |
| `$select` | Choose specific fields to return | `$select=projectId,projectStatus,revenue` |
| `$expand` | Include related entity data | `$expand=project,customer` |
| `$orderby` | Sort results | `$orderby=projectCreationDate desc` |
| `$top` | Limit number of results | `$top=50` |
| `$skip` | Skip a number of results | `$skip=100` |

## Filtering with $filter

### Comparison Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `eq` | Equal to | `$filter=projectStatus eq 'completed'` |
| `ne` | Not equal to | `$filter=revenue ne 0` |
| `gt` | Greater than | `$filter=wordCount gt 1000` |
| `ge` | Greater than or equal | `$filter=revenue ge 500` |
| `lt` | Less than | `$filter=actualDuration lt 24` |
| `le` | Less than or equal | `$filter=wordCount le 5000` |

### Logical Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `and` | Logical AND | `$filter=revenue gt 1000 and projectStatus eq 'completed'` |
| `or` | Logical OR | `$filter=projectStatus eq 'completed' or projectStatus eq 'in_progress'` |
| `not` | Logical NOT | `$filter=not (projectStatus eq 'in_progress')` |

### String Functions

| Function | Description | Example |
|----------|-------------|---------|
| `contains` | Contains substring | `$filter=contains(projectName,'Marketing')` |
| `startswith` | Starts with substring | `$filter=startswith(customerName,'ABC')` |
| `endswith` | Ends with substring | `$filter=endswith(fileName,'.docx')` |

### Date Functions

| Function | Description | Example |
|----------|-------------|---------|
| `year` | Extract year | `$filter=year(projectCreationDate) eq 2024` |
| `month` | Extract month | `$filter=month(approveDate) eq 3` |
| `day` | Extract day | `$filter=day(completionDate) eq 15` |

## Pagination

### Result Limits
The Data API has the following result limits:
- **Default page size**: 500 records
- **Maximum page size**: 5,000 records
- Use `$top` parameter to specify the number of records to return (up to 5,000)
- Use `$skip` parameter to implement pagination for large result sets

### Basic Pagination
```
$top=50&$skip=100
```

### Pagination with Filters
```
$filter=revenue gt 1000&$top=25&$skip=0&$orderby=revenue desc
```

### Maximum Results Example
```
$top=5000&$skip=0
```

## Best Practices

### Use Specific Filters
- Always filter data to reduce response size
- Use date ranges for time-based queries
- Filter by status or other categorical fields

### Select Only Required Fields
- Use `$select` to minimize response payload
- Only expand related entities when necessary

### Implement Pagination
- Use `$top` and `$skip` for large result sets
- Default page size: 500 records (when no `$top` is specified)
- Maximum page size: 5,000 records
- Typical page sizes: 25, 50, 100, 500, or 1000 records

### Optimize Performance
- Combine filters to reduce server processing
- Use indexes fields (like IDs and dates) in filters
- Avoid complex string operations on large datasets

