# /security/partner/securityAlerts

Create new navigation property to securityAlerts for security

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/partner-security-partnersecurityalert?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/partner/securityAlerts`, `GET/PATCH/DELETE /security/partner/securityAlerts/{partnerSecurityAlert-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/security/partner/security-alerts"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `activity_logs` | `activityLogs` | `list(object({       odata_type = optional(string, "#microsoft.graph.partner.security.activityLog")       statusFrom = optional(string)       statusTo = optional(string)       updatedBy = optional(string)       updatedDateTime = optional(string)     }))` | no | no |
| `additional_details` | `additionalDetails` | `any` | no | no |
| `affected_resources` | `affectedResources` | `list(object({       odata_type = optional(string, "#microsoft.graph.partner.security.affectedResource")       resourceId = optional(string)       resourceType = optional(string)     }))` | no | no |
| `alert_type` | `alertType` | `string` | no | no |
| `catalog_offer_id` | `catalogOfferId` | `string` | no | no |
| `confidence_level` | `confidenceLevel` | `string` | no | no |
| `customer_tenant_id` | `customerTenantId` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `detected_date_time` | `detectedDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `first_observed_date_time` | `firstObservedDateTime` | `string` | no | no |
| `is_test` | `isTest` | `bool` | no | no |
| `last_observed_date_time` | `lastObservedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resolved_by` | `resolvedBy` | `string` | no | no |
| `resolved_on_date_time` | `resolvedOnDateTime` | `string` | no | no |
| `resolved_reason` | `resolvedReason` | `any` | no | no |
| `severity` | `severity` | `string` | no | no |
| `status` | `status` | `string` | no | no |
| `subscription_id` | `subscriptionId` | `string` | no | no |
| `value_added_reseller_tenant_id` | `valueAddedResellerTenantId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- additionalDetails: polymorphic schema; accepts an untyped value
- resolvedReason: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
