# /deviceManagement/autopilotEvents

Create new navigation property to autopilotEvents for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/autopilotEvents`, `GET/PATCH/DELETE /deviceManagement/autopilotEvents/{deviceManagementAutopilotEvent-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/autopilot-events"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `account_setup_duration` | `accountSetupDuration` | `string` | no | no |
| `account_setup_status` | `accountSetupStatus` | `string` | no | no |
| `deployment_duration` | `deploymentDuration` | `string` | no | no |
| `deployment_end_date_time` | `deploymentEndDateTime` | `string` | no | no |
| `deployment_start_date_time` | `deploymentStartDateTime` | `string` | no | no |
| `deployment_state` | `deploymentState` | `string` | no | no |
| `deployment_total_duration` | `deploymentTotalDuration` | `string` | no | no |
| `device_id` | `deviceId` | `string` | no | no |
| `device_registered_date_time` | `deviceRegisteredDateTime` | `string` | no | no |
| `device_serial_number` | `deviceSerialNumber` | `string` | no | no |
| `device_setup_duration` | `deviceSetupDuration` | `string` | no | no |
| `device_setup_status` | `deviceSetupStatus` | `string` | no | no |
| `enrollment_failure_details` | `enrollmentFailureDetails` | `string` | no | no |
| `enrollment_start_date_time` | `enrollmentStartDateTime` | `string` | no | no |
| `enrollment_state` | `enrollmentState` | `string` | no | no |
| `enrollment_type` | `enrollmentType` | `string` | no | no |
| `event_date_time` | `eventDateTime` | `string` | no | no |
| `managed_device_name` | `managedDeviceName` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `os_version` | `osVersion` | `string` | no | no |
| `user_id` | `userId` | `string` | no | no |
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
| `windows10_enrollment_completion_page_configuration_display_name` | `windows10EnrollmentCompletionPageConfigurationDisplayName` | `string` | no | no |
| `windows10_enrollment_completion_page_configuration_id` | `windows10EnrollmentCompletionPageConfigurationId` | `string` | no | no |
| `windows_autopilot_deployment_profile_display_name` | `windowsAutopilotDeploymentProfileDisplayName` | `string` | no | no |
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
