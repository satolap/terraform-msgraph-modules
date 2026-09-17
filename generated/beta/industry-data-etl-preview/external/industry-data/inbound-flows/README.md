# /external/industryData/inboundFlows

Create inboundApiFlow

[Catalog](../../../../README.md) · [Industry data ETL (preview)](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/industrydata-inboundflow?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /external/industryData/inboundFlows`, `GET/PATCH/DELETE /external/industryData/inboundFlows/{inboundFlow-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./industry-data-etl-preview/external/industry-data/inbound-flows"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `data_connector` | `dataConnector` | `object({       odata_type = optional(string, "#microsoft.graph.industryData.industryDataConnector")       displayName = optional(string)       sourceSystem = optional(object({       odata_type = optional(string, "#microsoft.graph.industryData.sourceSystemDefinition")       displayName = optional(string)       userMatchingSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.industryData.userMatchingSetting")       matchTarget = optional(any)       priorityOrder = optional(number)       roleGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.industryData.roleGroup")       displayName = optional(string)       roles = optional(any)     }))       sourceIdentifier = optional(object({       odata_type = optional(string, "#microsoft.graph.industryData.identifierTypeReferenceValue")       code = optional(string)       value = optional(any)     }))     })))       vendor = optional(string)     }))     })` | no | no |
| `data_domain` | `dataDomain` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `effective_date_time` | `effectiveDateTime` | `string` | no | no |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `readiness_status` | `readinessStatus` | `string` | no | no |
| `year` | `year` | `object({       odata_type = optional(string, "#microsoft.graph.industryData.yearTimePeriodDefinition")       displayName = optional(string)       endDate = optional(string)       startDate = optional(string)       year = optional(object({       odata_type = optional(string, "#microsoft.graph.industryData.yearReferenceValue")       code = optional(string)       value = optional(object({       odata_type = optional(string, "#microsoft.graph.industryData.referenceDefinition")       code = optional(string)       displayName = optional(string)       isDisabled = optional(bool)       referenceType = optional(string)       sortIndex = optional(number)     }))     }))     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- dataConnector.sourceSystem.userMatchingSettings[].matchTarget: polymorphic schema; accepts an untyped value
- dataConnector.sourceSystem.userMatchingSettings[].roleGroup.roles: nested schema exceeds depth limit; accepts an untyped value
- dataConnector.sourceSystem.userMatchingSettings[].sourceIdentifier.value: nested schema exceeds depth limit; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
