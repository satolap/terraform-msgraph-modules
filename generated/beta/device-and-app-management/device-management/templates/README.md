# /deviceManagement/templates

Create new navigation property to templates for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceintent-devicemanagementtemplate?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/templates`, `GET/PATCH/DELETE /deviceManagement/templates/{deviceManagementTemplate-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/templates"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `categories` | `categories` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTemplateSettingCategory")       displayName = optional(string)       hasRequiredSetting = optional(bool)       recommendedSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementSettingInstance")       definitionId = optional(string)       valueJson = optional(string)     })))       settingDefinitions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementSettingDefinition")       constraints = optional(any)       dependencies = optional(any)       description = optional(string)       displayName = optional(string)       documentationUrl = optional(string)       headerSubtitle = optional(string)       headerTitle = optional(string)       isTopLevel = optional(bool)       keywords = optional(list(string))       placeholderText = optional(string)       valueType = optional(string)     })))     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `intent_count` | `intentCount` | `number` | no | no |
| `is_deprecated` | `isDeprecated` | `bool` | no | no |
| `migratable_to` | `migratableTo` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTemplate")       categories = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTemplateSettingCategory")       displayName = optional(string)       hasRequiredSetting = optional(bool)       recommendedSettings = optional(any)       settingDefinitions = optional(any)     })))       description = optional(string)       displayName = optional(string)       intentCount = optional(number)       isDeprecated = optional(bool)       migratableTo = optional(any)       platformType = optional(string)       publishedDateTime = optional(string)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementSettingInstance")       definitionId = optional(string)       valueJson = optional(string)     })))       templateSubtype = optional(string)       templateType = optional(string)       versionInfo = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `platform_type` | `platformType` | `string` | no | no |
| `published_date_time` | `publishedDateTime` | `string` | no | no |
| `settings` | `settings` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementSettingInstance")       definitionId = optional(string)       valueJson = optional(string)     }))` | no | no |
| `template_subtype` | `templateSubtype` | `string` | no | no |
| `template_type` | `templateType` | `string` | no | no |
| `version_info` | `versionInfo` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- categories[].settingDefinitions[].constraints[]: nested schema exceeds depth limit; accepts an untyped value
- categories[].settingDefinitions[].dependencies[]: nested schema exceeds depth limit; accepts an untyped value
- migratableTo[].categories[].recommendedSettings[]: nested schema exceeds depth limit; accepts an untyped value
- migratableTo[].categories[].settingDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- migratableTo[].migratableTo[]: recursive schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
