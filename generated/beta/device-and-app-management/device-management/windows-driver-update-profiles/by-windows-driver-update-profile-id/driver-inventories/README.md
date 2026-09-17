# /deviceManagement/windowsDriverUpdateProfiles/{windowsDriverUpdateProfile-id}/driverInventories

Create new navigation property to driverInventories for deviceManagement

[Catalog](../../../../../README.md) · [Device and app management](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-softwareupdate-windowsdriverupdateinventory?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/windowsDriverUpdateProfiles/{windowsDriverUpdateProfile-id}/driverInventories`, `GET/PATCH/DELETE /deviceManagement/windowsDriverUpdateProfiles/{windowsDriverUpdateProfile-id}/driverInventories/{windowsDriverUpdateInventory-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/windows-driver-update-profiles/by-windows-driver-update-profile-id/driver-inventories"
  windows_driver_update_profile_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `windows_driver_update_profile_id` | URL parameter `windowsDriverUpdateProfile-id` | `string` | yes | no |
| `applicable_device_count` | `applicableDeviceCount` | `number` | no | no |
| `approval_status` | `approvalStatus` | `string` | no | no |
| `category` | `category` | `string` | no | no |
| `deploy_date_time` | `deployDateTime` | `string` | no | no |
| `driver_class` | `driverClass` | `string` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `manufacturer` | `manufacturer` | `string` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `release_date_time` | `releaseDateTime` | `string` | no | no |
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
