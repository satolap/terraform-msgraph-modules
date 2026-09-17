# /deviceManagement/deviceHealthScripts

Create new navigation property to deviceHealthScripts for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-devicehealthscript?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/deviceHealthScripts`, `GET/PATCH/DELETE /deviceManagement/deviceHealthScripts/{deviceHealthScript-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/device-health-scripts"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceHealthScriptAssignment")       runRemediationScript = optional(bool)       runSchedule = optional(any)       target = optional(any)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `detection_script_content` | `detectionScriptContent` | `string` | no | no |
| `detection_script_parameters` | `detectionScriptParameters` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceHealthScriptParameter")       applyDefaultValueWhenNotAssigned = optional(bool)       description = optional(string)       isRequired = optional(bool)       name = optional(string)     }))` | no | no |
| `device_health_script_type` | `deviceHealthScriptType` | `string` | no | no |
| `device_run_states` | `deviceRunStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceHealthScriptDeviceState")       assignmentFilterIds = optional(list(string))       detectionState = optional(string)       expectedStateUpdateDateTime = optional(string)       lastStateUpdateDateTime = optional(string)       lastSyncDateTime = optional(string)       managedDevice = optional(any)       postRemediationDetectionScriptError = optional(string)       postRemediationDetectionScriptOutput = optional(string)       preRemediationDetectionScriptError = optional(string)       preRemediationDetectionScriptOutput = optional(string)       remediationScriptError = optional(string)       remediationState = optional(string)     }))` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enforce_signature_check` | `enforceSignatureCheck` | `bool` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `highest_available_version` | `highestAvailableVersion` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `publisher` | `publisher` | `string` | no | no |
| `remediation_script_content` | `remediationScriptContent` | `string` | no | no |
| `remediation_script_parameters` | `remediationScriptParameters` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceHealthScriptParameter")       applyDefaultValueWhenNotAssigned = optional(bool)       description = optional(string)       isRequired = optional(bool)       name = optional(string)     }))` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `run_as32_bit` | `runAs32Bit` | `bool` | no | no |
| `run_as_account` | `runAsAccount` | `string` | no | no |
| `run_summary` | `runSummary` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignments[].runSchedule: polymorphic schema; accepts an untyped value
- assignments[].target: polymorphic schema; accepts an untyped value
- deviceRunStates[].managedDevice: polymorphic schema; accepts an untyped value
- runSummary: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
