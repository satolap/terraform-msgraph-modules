# /deviceManagement/reusablePolicySettings/{deviceManagementReusablePolicySetting-id}/referencingConfigurationPolicies

Create new navigation property to referencingConfigurationPolicies for deviceManagement

[Catalog](../../../../README.md) · [Device and app management](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/reusablePolicySettings/{deviceManagementReusablePolicySetting-id}/referencingConfigurationPolicies`, `GET/PATCH/DELETE /deviceManagement/reusablePolicySettings/{deviceManagementReusablePolicySetting-id}/referencingConfigurationPolicies/{deviceManagementConfigurationPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/by-path-2454c1a6ef13/referencing-configuration-policies"
  device_management_reusable_policy_setting_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `device_management_reusable_policy_setting_id` | URL parameter `deviceManagementReusablePolicySetting-id` | `string` | yes | no |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationPolicyAssignment")       source = optional(string)       sourceId = optional(string)       target = optional(any)     }))` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `creation_source` | `creationSource` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `disable_entra_group_policy_assignment` | `disableEntraGroupPolicyAssignment` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `platforms` | `platforms` | `string` | no | no |
| `priority_meta_data` | `priorityMetaData` | `any` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `setting_count` | `settingCount` | `number` | no | no |
| `settings` | `settings` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationSetting")       settingInstance = optional(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingInstance")       settingDefinitionId = optional(string)       settingInstanceTemplateReference = optional(any)     }))     }))` | no | no |
| `technologies` | `technologies` | `string` | no | no |
| `template_reference` | `templateReference` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignments[].target: polymorphic schema; accepts an untyped value
- priorityMetaData: polymorphic schema; accepts an untyped value
- settings[].settingInstance.settingInstanceTemplateReference: polymorphic schema; accepts an untyped value
- templateReference: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
