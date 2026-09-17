# /tenantRelationships/managedTenants/deviceHealthStatuses

Create new navigation property to deviceHealthStatuses for tenantRelationships

[Catalog](../../../../README.md) · [Tenants](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /tenantRelationships/managedTenants/deviceHealthStatuses`, `GET/PATCH/DELETE /tenantRelationships/managedTenants/deviceHealthStatuses/{deviceHealthStatus-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./tenants/tenant-relationships/managed-tenants/device-health-statuses"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `blue_screen_count` | `blueScreenCount` | `number` | no | no |
| `boot_total_duration_in_seconds` | `bootTotalDurationInSeconds` | `any` | no | no |
| `device_id` | `deviceId` | `string` | no | no |
| `device_make` | `deviceMake` | `string` | no | no |
| `device_model` | `deviceModel` | `string` | no | no |
| `device_name` | `deviceName` | `string` | no | no |
| `health_status` | `healthStatus` | `string` | no | no |
| `last_updated_date_time` | `lastUpdatedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `os_version` | `osVersion` | `string` | no | no |
| `primary_disk_type` | `primaryDiskType` | `string` | no | no |
| `restart_count` | `restartCount` | `number` | no | no |
| `startup_performance_score` | `startupPerformanceScore` | `any` | no | no |
| `tenant_display_name` | `tenantDisplayName` | `string` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `top_processes` | `topProcesses` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- bootTotalDurationInSeconds: polymorphic schema; accepts an untyped value
- startupPerformanceScore: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
