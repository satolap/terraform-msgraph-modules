# /riskyUsers/{riskyUser-id}/history

Create new navigation property to history for riskyUsers

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/riskyuserhistoryitem?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /riskyUsers/{riskyUser-id}/history`, `GET/PATCH/DELETE /riskyUsers/{riskyUser-id}/history/{riskyUserHistoryItem-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/risky-users/by-risky-user-id/history"
  risky_user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `risky_user_id` | URL parameter `riskyUser-id` | `string` | yes | no |
| `activity` | `activity` | `any` | no | no |
| `history` | `history` | `list(object({       odata_type = optional(string, "#microsoft.graph.riskyUserHistoryItem")       activity = optional(any)       history = optional(any)       initiatedBy = optional(string)       isDeleted = optional(bool)       isProcessing = optional(bool)       riskDetail = optional(any)       riskLastUpdatedDateTime = optional(string)       riskLevel = optional(any)       riskState = optional(any)       userDisplayName = optional(string)       userId = optional(string)       userPrincipalName = optional(string)     }))` | no | no |
| `initiated_by` | `initiatedBy` | `string` | no | no |
| `is_deleted` | `isDeleted` | `bool` | no | no |
| `is_processing` | `isProcessing` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `risk_detail` | `riskDetail` | `any` | no | no |
| `risk_last_updated_date_time` | `riskLastUpdatedDateTime` | `string` | no | no |
| `risk_level` | `riskLevel` | `any` | no | no |
| `risk_state` | `riskState` | `any` | no | no |
| `user_display_name` | `userDisplayName` | `string` | no | no |
| `user_id` | `userId` | `string` | no | no |
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
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
