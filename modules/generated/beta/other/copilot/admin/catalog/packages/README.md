# /copilot/admin/catalog/packages

Create new navigation property to packages for copilot

[Catalog](../../../../../README.md) · [Uncategorized](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /copilot/admin/catalog/packages`, `GET/PATCH/DELETE /copilot/admin/catalog/packages/{copilotPackageDetail-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./other/copilot/admin/catalog/packages"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `acquire_users_and_groups` | `acquireUsersAndGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.packageAccessEntity")       resourceId = optional(string)       resourceType = optional(string)     }))` | no | no |
| `active_users` | `activeUsers` | `number` | no | no |
| `agent_identity_id` | `agentIdentityId` | `string` | no | no |
| `allowed_users_and_groups` | `allowedUsersAndGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.packageAccessEntity")       resourceId = optional(string)       resourceType = optional(string)     }))` | no | no |
| `app_id` | `appId` | `string` | no | no |
| `asset_id` | `assetId` | `string` | no | no |
| `available_to` | `availableTo` | `string` | no | no |
| `categories` | `categories` | `list(string)` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `deployed_to` | `deployedTo` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `element_details` | `elementDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.packageElementDetail")       elementType = optional(string)       elements = optional(list(object({       odata_type = optional(string, "#microsoft.graph.packageElement")       definition = optional(any)       id = optional(string)     })))     }))` | no | no |
| `element_types` | `elementTypes` | `list(string)` | no | no |
| `exception_rate` | `exceptionRate` | `any` | no | no |
| `governance_metadata` | `governanceMetadata` | `any` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `is_blocked` | `isBlocked` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `last_used_date_time` | `lastUsedDateTime` | `string` | no | no |
| `long_description` | `longDescription` | `string` | no | no |
| `manifest_id` | `manifestId` | `string` | no | no |
| `manifest_version` | `manifestVersion` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `owner_id` | `ownerId` | `string` | no | no |
| `platform` | `platform` | `string` | no | no |
| `publisher` | `publisher` | `string` | no | no |
| `request_status` | `requestStatus` | `any` | no | no |
| `request_type` | `requestType` | `any` | no | no |
| `sensitivity` | `sensitivity` | `string` | no | no |
| `shared_with_users_and_groups` | `sharedWithUsersAndGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.packageAccessEntity")       resourceId = optional(string)       resourceType = optional(string)     }))` | no | no |
| `short_description` | `shortDescription` | `string` | no | no |
| `supported_hosts` | `supportedHosts` | `list(string)` | no | no |
| `total_run_time_in_hours` | `totalRunTimeInHours` | `any` | no | no |
| `total_sessions` | `totalSessions` | `number` | no | no |
| `type` | `type` | `string` | no | no |
| `zip_file` | `zipFile` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- exceptionRate: polymorphic schema; accepts an untyped value
- requestStatus: polymorphic schema; accepts an untyped value
- requestType: polymorphic schema; accepts an untyped value
- totalRunTimeInHours: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
