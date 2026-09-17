# /deviceManagement/groupPolicyMigrationReports/{groupPolicyMigrationReport-id}/groupPolicySettingMappings

Create new navigation property to groupPolicySettingMappings for deviceManagement

[Catalog](../../../../README.md) · [Device and app management](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/groupPolicyMigrationReports/{groupPolicyMigrationReport-id}/groupPolicySettingMappings`, `GET/PATCH/DELETE /deviceManagement/groupPolicyMigrationReports/{groupPolicyMigrationReport-id}/groupPolicySettingMappings/{groupPolicySettingMapping-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/by-path-d87f702ce969/group-policy-setting-mappings"
  group_policy_migration_report_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_policy_migration_report_id` | URL parameter `groupPolicyMigrationReport-id` | `string` | yes | no |
| `admx_setting_definition_id` | `admxSettingDefinitionId` | `string` | no | no |
| `child_id_list` | `childIdList` | `list(string)` | no | no |
| `intune_setting_definition_id` | `intuneSettingDefinitionId` | `string` | no | no |
| `intune_setting_uri_list` | `intuneSettingUriList` | `list(string)` | no | no |
| `is_mdm_supported` | `isMdmSupported` | `bool` | no | no |
| `mdm_csp_name` | `mdmCspName` | `string` | no | no |
| `mdm_minimum_os_version` | `mdmMinimumOSVersion` | `number` | no | no |
| `mdm_setting_uri` | `mdmSettingUri` | `string` | no | no |
| `mdm_supported_state` | `mdmSupportedState` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `parent_id` | `parentId` | `string` | no | no |
| `setting_category` | `settingCategory` | `string` | no | no |
| `setting_display_name` | `settingDisplayName` | `string` | no | no |
| `setting_display_value` | `settingDisplayValue` | `string` | no | no |
| `setting_display_value_type` | `settingDisplayValueType` | `string` | no | no |
| `setting_name` | `settingName` | `string` | no | no |
| `setting_scope` | `settingScope` | `string` | no | no |
| `setting_type` | `settingType` | `string` | no | no |
| `setting_value` | `settingValue` | `string` | no | no |
| `setting_value_display_units` | `settingValueDisplayUnits` | `string` | no | no |
| `setting_value_type` | `settingValueType` | `string` | no | no |
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
