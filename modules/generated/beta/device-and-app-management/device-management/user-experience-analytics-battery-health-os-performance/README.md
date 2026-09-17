# /deviceManagement/userExperienceAnalyticsBatteryHealthOsPerformance

Create new navigation property to userExperienceAnalyticsBatteryHealthOsPerformance for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-userexperienceanalyticsbatteryhealthosperformance?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/userExperienceAnalyticsBatteryHealthOsPerformance`, `GET/PATCH/DELETE /deviceManagement/userExperienceAnalyticsBatteryHealthOsPerformance/{userExperienceAnalyticsBatteryHealthOsPerformance-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/user-experience-analytics-battery-health-os-performance"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `active_devices` | `activeDevices` | `number` | no | no |
| `average_battery_age_in_days` | `averageBatteryAgeInDays` | `number` | no | no |
| `average_estimated_runtime_in_minutes` | `averageEstimatedRuntimeInMinutes` | `number` | no | no |
| `average_max_capacity_percentage` | `averageMaxCapacityPercentage` | `number` | no | no |
| `mean_full_battery_drain_count` | `meanFullBatteryDrainCount` | `number` | no | no |
| `median_estimated_runtime_in_minutes` | `medianEstimatedRuntimeInMinutes` | `number` | no | no |
| `median_full_battery_drain_count` | `medianFullBatteryDrainCount` | `number` | no | no |
| `median_max_capacity_percentage` | `medianMaxCapacityPercentage` | `number` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `os_battery_health_score` | `osBatteryHealthScore` | `number` | no | no |
| `os_build_number` | `osBuildNumber` | `string` | no | no |
| `os_health_status` | `osHealthStatus` | `string` | no | no |
| `os_version` | `osVersion` | `string` | no | no |
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
