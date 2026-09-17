# /users/{user-id}/managedDevices/{managedDevice-id}/securityBaselineStates/{securityBaselineState-id}/settingStates

Create new navigation property to settingStates for users

[Catalog](../../../../README.md) · [Device and app management](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/managedDevices/{managedDevice-id}/securityBaselineStates/{securityBaselineState-id}/settingStates`, `GET/PATCH/DELETE /users/{user-id}/managedDevices/{managedDevice-id}/securityBaselineStates/{securityBaselineState-id}/settingStates/{securityBaselineSettingState-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/users/by-path-758055223dfb/setting-states"
  user_id = "parent-object-id"
  managed_device_id = "parent-object-id"
  security_baseline_state_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `managed_device_id` | URL parameter `managedDevice-id` | `string` | yes | no |
| `security_baseline_state_id` | URL parameter `securityBaselineState-id` | `string` | yes | no |
| `contributing_policies` | `contributingPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.securityBaselineContributingPolicy")       displayName = optional(string)       sourceId = optional(string)       sourceType = optional(string)     }))` | no | no |
| `error_code` | `errorCode` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `setting_category_id` | `settingCategoryId` | `string` | no | no |
| `setting_category_name` | `settingCategoryName` | `string` | no | no |
| `setting_id` | `settingId` | `string` | no | no |
| `setting_name` | `settingName` | `string` | no | no |
| `source_policies` | `sourcePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.settingSource")       displayName = optional(string)       id = optional(string)       sourceType = optional(string)     }))` | no | no |
| `state` | `state` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
