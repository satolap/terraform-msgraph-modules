# /users/{user-id}/managedDevices/{managedDevice-id}/deviceConfigurationStates

Create new navigation property to deviceConfigurationStates for users

[Catalog](../../../../../../README.md) · [Device and app management](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/managedDevices/{managedDevice-id}/deviceConfigurationStates`, `GET/PATCH/DELETE /users/{user-id}/managedDevices/{managedDevice-id}/deviceConfigurationStates/{deviceConfigurationState-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/users/by-user-id/managed-devices/by-managed-device-id/device-configuration-states"
  user_id = "parent-object-id"
  managed_device_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `managed_device_id` | URL parameter `managedDevice-id` | `string` | yes | no |
| `display_name` | `displayName` | `string` | no | no |
| `graph_version` | `version` | `number` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `platform_type` | `platformType` | `string` | no | no |
| `setting_count` | `settingCount` | `number` | no | no |
| `setting_states` | `settingStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationSettingState")       currentValue = optional(string)       errorCode = optional(number)       errorDescription = optional(string)       instanceDisplayName = optional(string)       setting = optional(string)       settingName = optional(string)       sources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingSource")       displayName = optional(string)       id = optional(string)       sourceType = optional(string)     })))       state = optional(string)       userEmail = optional(string)       userId = optional(string)       userName = optional(string)       userPrincipalName = optional(string)     }))` | no | no |
| `state` | `state` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
