# /deviceManagement/userExperienceAnalyticsResourcePerformance

Create new navigation property to userExperienceAnalyticsResourcePerformance for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-userexperienceanalyticsresourceperformance?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/userExperienceAnalyticsResourcePerformance`, `GET/PATCH/DELETE /deviceManagement/userExperienceAnalyticsResourcePerformance/{userExperienceAnalyticsResourcePerformance-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/user-experience-analytics-resource-performance"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `average_spike_time_score` | `averageSpikeTimeScore` | `number` | no | no |
| `cpu_clock_speed_in_m_hz` | `cpuClockSpeedInMHz` | `any` | no | no |
| `cpu_display_name` | `cpuDisplayName` | `string` | no | no |
| `cpu_spike_time_percentage` | `cpuSpikeTimePercentage` | `any` | no | no |
| `cpu_spike_time_percentage_threshold` | `cpuSpikeTimePercentageThreshold` | `any` | no | no |
| `cpu_spike_time_score` | `cpuSpikeTimeScore` | `number` | no | no |
| `device_count` | `deviceCount` | `number` | no | no |
| `device_id` | `deviceId` | `string` | no | no |
| `device_name` | `deviceName` | `string` | no | no |
| `device_resource_performance_score` | `deviceResourcePerformanceScore` | `number` | no | no |
| `disk_type` | `diskType` | `string` | no | no |
| `health_status` | `healthStatus` | `string` | no | no |
| `machine_type` | `machineType` | `string` | no | no |
| `manufacturer` | `manufacturer` | `string` | no | no |
| `model` | `model` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `ram_spike_time_percentage` | `ramSpikeTimePercentage` | `any` | no | no |
| `ram_spike_time_percentage_threshold` | `ramSpikeTimePercentageThreshold` | `any` | no | no |
| `ram_spike_time_score` | `ramSpikeTimeScore` | `number` | no | no |
| `total_processor_core_count` | `totalProcessorCoreCount` | `number` | no | no |
| `total_ram_in_mb` | `totalRamInMB` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- cpuClockSpeedInMHz: polymorphic schema; accepts an untyped value
- cpuSpikeTimePercentage: polymorphic schema; accepts an untyped value
- cpuSpikeTimePercentageThreshold: polymorphic schema; accepts an untyped value
- ramSpikeTimePercentage: polymorphic schema; accepts an untyped value
- ramSpikeTimePercentageThreshold: polymorphic schema; accepts an untyped value
- totalRamInMB: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
