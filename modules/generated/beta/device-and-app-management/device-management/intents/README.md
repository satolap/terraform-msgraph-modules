# /deviceManagement/intents

Create new navigation property to intents for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceintent-devicemanagementintent?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/intents`, `GET/PATCH/DELETE /deviceManagement/intents/{deviceManagementIntent-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/intents"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementIntentAssignment")       target = optional(any)     }))` | no | no |
| `categories` | `categories` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementIntentSettingCategory")       displayName = optional(string)       hasRequiredSetting = optional(bool)       settingDefinitions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementSettingDefinition")       constraints = optional(any)       dependencies = optional(any)       description = optional(string)       displayName = optional(string)       documentationUrl = optional(string)       headerSubtitle = optional(string)       headerTitle = optional(string)       isTopLevel = optional(bool)       keywords = optional(list(string))       placeholderText = optional(string)       valueType = optional(string)     })))       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementSettingInstance")       definitionId = optional(string)       valueJson = optional(string)     })))     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `device_setting_state_summaries` | `deviceSettingStateSummaries` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementIntentDeviceSettingStateSummary")       compliantCount = optional(number)       conflictCount = optional(number)       errorCount = optional(number)       nonCompliantCount = optional(number)       notApplicableCount = optional(number)       remediatedCount = optional(number)       settingName = optional(string)     }))` | no | no |
| `device_state_summary` | `deviceStateSummary` | `any` | no | no |
| `device_states` | `deviceStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementIntentDeviceState")       deviceDisplayName = optional(string)       deviceId = optional(string)       lastReportedDateTime = optional(string)       state = optional(string)       userName = optional(string)       userPrincipalName = optional(string)     }))` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_assigned` | `isAssigned` | `bool` | no | no |
| `is_migrating_to_configuration_policy` | `isMigratingToConfigurationPolicy` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `settings` | `settings` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementSettingInstance")       definitionId = optional(string)       valueJson = optional(string)     }))` | no | no |
| `template_id` | `templateId` | `string` | no | no |
| `user_state_summary` | `userStateSummary` | `any` | no | no |
| `user_states` | `userStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementIntentUserState")       deviceCount = optional(number)       lastReportedDateTime = optional(string)       state = optional(string)       userName = optional(string)       userPrincipalName = optional(string)     }))` | no | no |
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
- categories[].settingDefinitions[].constraints[]: nested schema exceeds depth limit; accepts an untyped value
- categories[].settingDefinitions[].dependencies[]: nested schema exceeds depth limit; accepts an untyped value
- deviceStateSummary: polymorphic schema; accepts an untyped value
- userStateSummary: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
