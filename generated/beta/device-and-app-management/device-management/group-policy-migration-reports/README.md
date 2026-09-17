# /deviceManagement/groupPolicyMigrationReports

Create new navigation property to groupPolicyMigrationReports for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/groupPolicyMigrationReports`, `GET/PATCH/DELETE /deviceManagement/groupPolicyMigrationReports/{groupPolicyMigrationReport-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/group-policy-migration-reports"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `group_policy_created_date_time` | `groupPolicyCreatedDateTime` | `string` | no | no |
| `group_policy_last_modified_date_time` | `groupPolicyLastModifiedDateTime` | `string` | no | no |
| `group_policy_object_id` | `groupPolicyObjectId` | `string` | no | no |
| `group_policy_setting_mappings` | `groupPolicySettingMappings` | `list(object({       odata_type = optional(string, "#microsoft.graph.groupPolicySettingMapping")       admxSettingDefinitionId = optional(string)       childIdList = optional(list(string))       intuneSettingDefinitionId = optional(string)       intuneSettingUriList = optional(list(string))       isMdmSupported = optional(bool)       mdmCspName = optional(string)       mdmMinimumOSVersion = optional(number)       mdmSettingUri = optional(string)       mdmSupportedState = optional(string)       parentId = optional(string)       settingCategory = optional(string)       settingDisplayName = optional(string)       settingDisplayValue = optional(string)       settingDisplayValueType = optional(string)       settingName = optional(string)       settingScope = optional(string)       settingType = optional(string)       settingValue = optional(string)       settingValueDisplayUnits = optional(string)       settingValueType = optional(string)     }))` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `migration_readiness` | `migrationReadiness` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `ou_distinguished_name` | `ouDistinguishedName` | `string` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `supported_settings_count` | `supportedSettingsCount` | `number` | no | no |
| `supported_settings_percent` | `supportedSettingsPercent` | `number` | no | no |
| `targeted_in_active_directory` | `targetedInActiveDirectory` | `bool` | no | no |
| `total_settings_count` | `totalSettingsCount` | `number` | no | no |
| `unsupported_group_policy_extensions` | `unsupportedGroupPolicyExtensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.unsupportedGroupPolicyExtension")       extensionType = optional(string)       namespaceUrl = optional(string)       nodeName = optional(string)       settingScope = optional(string)     }))` | no | no |
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
