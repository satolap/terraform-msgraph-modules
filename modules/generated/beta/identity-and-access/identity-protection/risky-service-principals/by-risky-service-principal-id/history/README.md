# /identityProtection/riskyServicePrincipals/{riskyServicePrincipal-id}/history

Create new navigation property to history for identityProtection

[Catalog](../../../../../README.md) · [Identity and access](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityProtection/riskyServicePrincipals/{riskyServicePrincipal-id}/history`, `GET/PATCH/DELETE /identityProtection/riskyServicePrincipals/{riskyServicePrincipal-id}/history/{riskyServicePrincipalHistoryItem-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-protection/risky-service-principals/by-risky-service-principal-id/history"
  risky_service_principal_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `risky_service_principal_id` | URL parameter `riskyServicePrincipal-id` | `string` | yes | no |
| `account_enabled` | `accountEnabled` | `bool` | no | no |
| `activity` | `activity` | `any` | no | no |
| `app_id` | `appId` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `history` | `history` | `list(object({       odata_type = optional(string, "#microsoft.graph.riskyServicePrincipalHistoryItem")       accountEnabled = optional(bool)       activity = optional(any)       appId = optional(string)       displayName = optional(string)       history = optional(any)       initiatedBy = optional(string)       isEnabled = optional(bool)       isProcessing = optional(bool)       riskDetail = optional(any)       riskLastUpdatedDateTime = optional(string)       riskLevel = optional(any)       riskState = optional(any)       servicePrincipalId = optional(string)       servicePrincipalType = optional(string)     }))` | no | no |
| `initiated_by` | `initiatedBy` | `string` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `is_processing` | `isProcessing` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `risk_detail` | `riskDetail` | `any` | no | no |
| `risk_last_updated_date_time` | `riskLastUpdatedDateTime` | `string` | no | no |
| `risk_level` | `riskLevel` | `any` | no | no |
| `risk_state` | `riskState` | `any` | no | no |
| `service_principal_id` | `servicePrincipalId` | `string` | no | no |
| `service_principal_type` | `servicePrincipalType` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- activity: polymorphic schema; accepts an untyped value
- history[].activity: polymorphic schema; accepts an untyped value
- history[].history[]: recursive schema; accepts an untyped value
- history[].riskDetail: polymorphic schema; accepts an untyped value
- history[].riskLevel: polymorphic schema; accepts an untyped value
- history[].riskState: polymorphic schema; accepts an untyped value
- riskDetail: polymorphic schema; accepts an untyped value
- riskLevel: polymorphic schema; accepts an untyped value
- riskState: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
