# /deviceManagement/windowsAutopilotDeploymentProfiles/{windowsAutopilotDeploymentProfile-id}/assignedDevices

Create new navigation property to assignedDevices for deviceManagement

[Catalog](../../../../README.md) · [Device and app management](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-enrollment-windowsautopilotdeviceidentity?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/windowsAutopilotDeploymentProfiles/{windowsAutopilotDeploymentProfile-id}/assignedDevices`, `GET/PATCH/DELETE /deviceManagement/windowsAutopilotDeploymentProfiles/{windowsAutopilotDeploymentProfile-id}/assignedDevices/{windowsAutopilotDeviceIdentity-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/by-path-89b9eb3ba675/assigned-devices"
  windows_autopilot_deployment_profile_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `windows_autopilot_deployment_profile_id` | URL parameter `windowsAutopilotDeploymentProfile-id` | `string` | yes | no |
| `addressable_user_name` | `addressableUserName` | `string` | no | no |
| `azure_active_directory_device_id` | `azureActiveDirectoryDeviceId` | `string` | no | no |
| `azure_ad_device_id` | `azureAdDeviceId` | `string` | no | no |
| `deployment_profile` | `deploymentProfile` | `any` | no | no |
| `deployment_profile_assigned_date_time` | `deploymentProfileAssignedDateTime` | `string` | no | no |
| `deployment_profile_assignment_detailed_status` | `deploymentProfileAssignmentDetailedStatus` | `string` | no | no |
| `deployment_profile_assignment_status` | `deploymentProfileAssignmentStatus` | `string` | no | no |
| `device_account_password` | `deviceAccountPassword` | `string` | no | yes |
| `device_account_upn` | `deviceAccountUpn` | `string` | no | no |
| `device_friendly_name` | `deviceFriendlyName` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enrollment_state` | `enrollmentState` | `string` | no | no |
| `group_tag` | `groupTag` | `string` | no | no |
| `intended_deployment_profile` | `intendedDeploymentProfile` | `any` | no | no |
| `last_contacted_date_time` | `lastContactedDateTime` | `string` | no | no |
| `managed_device_id` | `managedDeviceId` | `string` | no | no |
| `manufacturer` | `manufacturer` | `string` | no | no |
| `model` | `model` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `product_key` | `productKey` | `string` | no | no |
| `purchase_order_identifier` | `purchaseOrderIdentifier` | `string` | no | no |
| `remediation_state` | `remediationState` | `string` | no | no |
| `remediation_state_last_modified_date_time` | `remediationStateLastModifiedDateTime` | `string` | no | no |
| `resource_name` | `resourceName` | `string` | no | no |
| `serial_number` | `serialNumber` | `string` | no | no |
| `sku_number` | `skuNumber` | `string` | no | no |
| `system_family` | `systemFamily` | `string` | no | no |
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
| `userless_enrollment_status` | `userlessEnrollmentStatus` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- deploymentProfile: polymorphic schema; accepts an untyped value
- intendedDeploymentProfile: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
