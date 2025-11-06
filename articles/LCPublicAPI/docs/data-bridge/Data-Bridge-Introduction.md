---
stoplight-id: 6xca951byllum
---

# Trados Data Bridge

Trados Data Bridge - technically known as the Data API - gives you secure, read-only access to your Trados Cloud data. It’s designed for reporting, analytics, and business intelligence applications, allowing external tools to connect directly without manual exports or custom connectors.

## Overview

The Data API provides structured, near real-time access to analytical data about your translation projects, tasks, costs, leverage, and evaluation metrics.
Use Data Bridge to:
Power dashboards in your existing analytics environment
Combine localization metrics with data from financial systems, CRMs, or web analytics
Uncover trends and measure the business impact of your localization strategy
By connecting directly to Trados data, teams can stop relying on static reports or siloed dashboards and instead build a single, holistic view of performance across the enterprise.

## Key Features

- **Read-only access to analytical data** to safely explore data without risking changes
- **OData v4 query capabilities** for flexible data filtering and sorting
- **Multiple data sets** including projects, tasks, costs, leverage, and evaluation metrics
- **Fast integration** no custom connectors required, works with most BI and analytics platforms out of the box

## Data Sets Available

See the consolidated overview of all datasets: [Data Sets](Data-Sets.md).

## Base API URL

Trados Cloud Platform operates in multiple regions, and it's essential to know in which region your Trados is located to use the Data API.

To see the host on different regions, check the API base URL in the contract.


## Authentication & Authorization
To start working with the Trados Data Bridge API, you first need to authenticate. 
The Data Bridge API uses the same authentication mechanism as the Public API.

Follow the instructions under the [Service users and custom applications](../Service-users-and-custom-applications.md) and the [Service Credentials](../Service-credentials.md) pages to create a service user and an application, and then authenticate, following the [Authentication](../Authentication.md) page, by using the application's `client_id` and `client_secret`.


Before running requests, set `{{lc_tenant}}` to your account ID (for example, `LC-00000000000000000`).


![image](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicDataAPI/SetLCTenant.png?raw=true)

</br>

## Rate Limits and Daily Quotas

Data Bridge API is governed by the same rate limits as Public API [API rate limits](../API-rate-limits.md)

In addition, Data Bridge enforces a daily data transfer quota:
- Quota is measured by data volume retrieved (not request count)
- Europe region: quota resets at midnight UTC
- Canada region: quota resets at midnight EST
- Requests that exceed the quota return HTTP 429 (Too Many Requests) until the reset time


## Postman Collection

Use the provided [Postman](../../docs/data-bridge/Trados-Data-Bridge-APIs-for-Postman.md) collection to quickly explore and test the Trados Data Bridge API endpoints.

## Data Availability

Data availability varies by data set:
- Most data becomes available after the **Analysis workflow task** completes
- Revenue data requires **Quote Generation task** completion
- Some metrics are updated in real-time as workflow tasks complete

## Advanced Query Options

For comprehensive OData query syntax reference and additional examples, see the [OData Query Guide](OData-Query-Guide.md) and [Microsoft OData Query Options Overview](https://learn.microsoft.com/en-us/odata/concepts/queryoptions-overview).

## API Reference

For detailed endpoint documentation, parameters, and response schemas, see the [Trados Data Bridge API Reference](../../api/Data-Bridge-API.v1-fv.html).