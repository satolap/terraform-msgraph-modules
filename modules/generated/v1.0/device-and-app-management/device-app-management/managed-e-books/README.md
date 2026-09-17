# /deviceAppManagement/managedEBooks

Create new navigation property to managedEBooks for deviceAppManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-managedebook?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceAppManagement/managedEBooks`, `GET/PATCH/DELETE /deviceAppManagement/managedEBooks/{managedEBook-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-app-management/managed-e-books"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedEBookAssignment")       installIntent = optional(string)       target = optional(any)     }))` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `device_states` | `deviceStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceInstallState")       deviceId = optional(string)       deviceName = optional(string)       errorCode = optional(string)       installState = optional(string)       lastSyncDateTime = optional(string)       osDescription = optional(string)       osVersion = optional(string)       userName = optional(string)     }))` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `information_url` | `informationUrl` | `string` | no | no |
| `install_summary` | `installSummary` | `any` | no | no |
| `large_cover` | `largeCover` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `privacy_information_url` | `privacyInformationUrl` | `string` | no | no |
| `published_date_time` | `publishedDateTime` | `string` | no | no |
| `publisher` | `publisher` | `string` | no | no |
| `user_state_summary` | `userStateSummary` | `list(object({       odata_type = optional(string, "#microsoft.graph.userInstallStateSummary")       deviceStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceInstallState")       deviceId = optional(string)       deviceName = optional(string)       errorCode = optional(string)       installState = optional(string)       lastSyncDateTime = optional(string)       osDescription = optional(string)       osVersion = optional(string)       userName = optional(string)     })))       failedDeviceCount = optional(number)       installedDeviceCount = optional(number)       notInstalledDeviceCount = optional(number)       userName = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- assignments[].target: polymorphic schema; accepts an untyped value
- installSummary: polymorphic schema; accepts an untyped value
- largeCover: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
