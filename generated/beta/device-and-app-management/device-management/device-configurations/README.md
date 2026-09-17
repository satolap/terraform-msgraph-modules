# /deviceManagement/deviceConfigurations

Create new navigation property to deviceConfigurations for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/deviceConfigurations`, `GET/PATCH/DELETE /deviceManagement/deviceConfigurations/{deviceConfiguration-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/device-configurations"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationAssignment")       intent = optional(any)       source = optional(string)       target = optional(any)     }))` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `device_management_applicability_rule_device_mode` | `deviceManagementApplicabilityRuleDeviceMode` | `any` | no | no |
| `device_management_applicability_rule_os_edition` | `deviceManagementApplicabilityRuleOsEdition` | `any` | no | no |
| `device_management_applicability_rule_os_version` | `deviceManagementApplicabilityRuleOsVersion` | `any` | no | no |
| `device_setting_state_summaries` | `deviceSettingStateSummaries` | `list(object({       odata_type = optional(string, "#microsoft.graph.settingStateDeviceSummary")       compliantDeviceCount = optional(number)       conflictDeviceCount = optional(number)       errorDeviceCount = optional(number)       instancePath = optional(string)       nonCompliantDeviceCount = optional(number)       notApplicableDeviceCount = optional(number)       remediatedDeviceCount = optional(number)       settingName = optional(string)       unknownDeviceCount = optional(number)     }))` | no | no |
| `device_status_overview` | `deviceStatusOverview` | `any` | no | no |
| `device_statuses` | `deviceStatuses` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationDeviceStatus")       complianceGracePeriodExpirationDateTime = optional(string)       deviceDisplayName = optional(string)       deviceModel = optional(string)       lastReportedDateTime = optional(string)       platform = optional(number)       status = optional(string)       userName = optional(string)       userPrincipalName = optional(string)     }))` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `graph_version` | `version` | `number` | no | no |
| `group_assignments` | `groupAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationGroupAssignment")       deviceConfiguration = optional(any)       excludeGroup = optional(bool)       targetGroupId = optional(string)     }))` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `user_status_overview` | `userStatusOverview` | `any` | no | no |
| `user_statuses` | `userStatuses` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationUserStatus")       devicesCount = optional(number)       lastReportedDateTime = optional(string)       status = optional(string)       userDisplayName = optional(string)       userPrincipalName = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignments[].intent: polymorphic schema; accepts an untyped value
- assignments[].target: polymorphic schema; accepts an untyped value
- deviceManagementApplicabilityRuleDeviceMode: polymorphic schema; accepts an untyped value
- deviceManagementApplicabilityRuleOsEdition: polymorphic schema; accepts an untyped value
- deviceManagementApplicabilityRuleOsVersion: polymorphic schema; accepts an untyped value
- deviceStatusOverview: polymorphic schema; accepts an untyped value
- groupAssignments[].deviceConfiguration: polymorphic schema; accepts an untyped value
- userStatusOverview: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
