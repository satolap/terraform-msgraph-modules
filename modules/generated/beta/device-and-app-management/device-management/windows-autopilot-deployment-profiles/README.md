# /deviceManagement/windowsAutopilotDeploymentProfiles

Create new navigation property to windowsAutopilotDeploymentProfiles for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/windowsAutopilotDeploymentProfiles`, `GET/PATCH/DELETE /deviceManagement/windowsAutopilotDeploymentProfiles/{windowsAutopilotDeploymentProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/windows-autopilot-deployment-profiles"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assigned_devices` | `assignedDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsAutopilotDeviceIdentity")       addressableUserName = optional(string)       azureActiveDirectoryDeviceId = optional(string)       azureAdDeviceId = optional(string)       deploymentProfile = optional(any)       deploymentProfileAssignedDateTime = optional(string)       deploymentProfileAssignmentDetailedStatus = optional(string)       deploymentProfileAssignmentStatus = optional(string)       deviceAccountPassword = optional(string)       deviceAccountUpn = optional(string)       deviceFriendlyName = optional(string)       displayName = optional(string)       enrollmentState = optional(string)       groupTag = optional(string)       intendedDeploymentProfile = optional(any)       lastContactedDateTime = optional(string)       managedDeviceId = optional(string)       manufacturer = optional(string)       model = optional(string)       productKey = optional(string)       purchaseOrderIdentifier = optional(string)       remediationState = optional(string)       remediationStateLastModifiedDateTime = optional(string)       resourceName = optional(string)       serialNumber = optional(string)       skuNumber = optional(string)       systemFamily = optional(string)       userPrincipalName = optional(string)       userlessEnrollmentStatus = optional(string)     }))` | no | yes |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsAutopilotDeploymentProfileAssignment")       source = optional(string)       sourceId = optional(string)       target = optional(any)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `device_name_template` | `deviceNameTemplate` | `string` | no | no |
| `device_type` | `deviceType` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enrollment_status_screen_settings` | `enrollmentStatusScreenSettings` | `any` | no | no |
| `hardware_hash_extraction_enabled` | `hardwareHashExtractionEnabled` | `bool` | no | no |
| `locale` | `locale` | `string` | no | no |
| `management_service_app_id` | `managementServiceAppId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `out_of_box_experience_setting` | `outOfBoxExperienceSetting` | `any` | no | no |
| `preprovisioning_allowed` | `preprovisioningAllowed` | `bool` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignedDevices[].deploymentProfile: polymorphic schema; accepts an untyped value
- assignedDevices[].intendedDeploymentProfile: polymorphic schema; accepts an untyped value
- assignments[].target: polymorphic schema; accepts an untyped value
- enrollmentStatusScreenSettings: polymorphic schema; accepts an untyped value
- outOfBoxExperienceSetting: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
