# /deviceManagement/configurationPolicyTemplates

Create new navigation property to configurationPolicyTemplates for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/configurationPolicyTemplates`, `GET/PATCH/DELETE /deviceManagement/configurationPolicyTemplates/{deviceManagementConfigurationPolicyTemplate-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/configuration-policy-templates"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allow_unmanaged_settings` | `allowUnmanagedSettings` | `bool` | no | no |
| `base_id` | `baseId` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `disable_entra_group_policy_assignment` | `disableEntraGroupPolicyAssignment` | `bool` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `display_version` | `displayVersion` | `string` | no | no |
| `lifecycle_state` | `lifecycleState` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `platforms` | `platforms` | `string` | no | no |
| `setting_templates` | `settingTemplates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingTemplate")       settingDefinitions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingDefinition")       accessTypes = optional(string)       applicability = optional(any)       baseUri = optional(string)       categoryId = optional(string)       description = optional(string)       displayName = optional(string)       helpText = optional(string)       infoUrls = optional(list(string))       keywords = optional(list(string))       name = optional(string)       occurrence = optional(any)       offsetUri = optional(string)       referredSettingInformationList = optional(any)       riskLevel = optional(string)       rootDefinitionId = optional(string)       settingUsage = optional(string)       uxBehavior = optional(string)       version = optional(string)       visibility = optional(string)     })))       settingInstanceTemplate = optional(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingInstanceTemplate")       isRequired = optional(bool)       settingDefinitionId = optional(string)       settingInstanceTemplateId = optional(string)     }))     }))` | no | no |
| `technologies` | `technologies` | `string` | no | no |
| `template_family` | `templateFamily` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- settingTemplates[].settingDefinitions[].applicability: polymorphic schema; accepts an untyped value
- settingTemplates[].settingDefinitions[].occurrence: polymorphic schema; accepts an untyped value
- settingTemplates[].settingDefinitions[].referredSettingInformationList[]: nested schema exceeds depth limit; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
