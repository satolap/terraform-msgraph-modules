# /storage/fileStorage/deletedContainers

Create new navigation property to deletedContainers for storage

[Catalog](../../../../README.md) · [Files](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/filestoragecontainer?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /storage/fileStorage/deletedContainers`, `GET/PATCH/DELETE /storage/fileStorage/deletedContainers/{fileStorageContainer-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./files/storage/file-storage/deleted-containers"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `archival_details` | `archivalDetails` | `any` | no | no |
| `assigned_sensitivity_label` | `assignedSensitivityLabel` | `any` | no | no |
| `columns` | `columns` | `list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     }))` | no | no |
| `custom_properties` | `customProperties` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `external_group_id` | `externalGroupId` | `string` | no | no |
| `information_barrier` | `informationBarrier` | `any` | no | no |
| `migration_jobs` | `migrationJobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharePointMigrationJob")       containerInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.sharePointMigrationContainerInfo")     }))       progressEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharePointMigrationEvent")     })))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `permissions` | `permissions` | `list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     }))` | no | no |
| `settings` | `settings` | `object({       odata_type = optional(string, "#microsoft.graph.fileStorageContainerSettings")       isItemVersioningEnabled = optional(bool)       isOcrEnabled = optional(bool)       itemDefaultSensitivityLabelId = optional(string)       itemMajorVersionLimit = optional(number)     })` | no | no |
| `share_point_groups` | `sharePointGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharePointGroup")       description = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharePointGroupMember")       identity = optional(any)     })))       title = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- archivalDetails: polymorphic schema; accepts an untyped value
- assignedSensitivityLabel: polymorphic schema; accepts an untyped value
- columns[].boolean: polymorphic schema; accepts an untyped value
- columns[].calculated: polymorphic schema; accepts an untyped value
- columns[].choice: polymorphic schema; accepts an untyped value
- columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- columns[].currency: polymorphic schema; accepts an untyped value
- columns[].dateTime: polymorphic schema; accepts an untyped value
- columns[].defaultValue: polymorphic schema; accepts an untyped value
- columns[].geolocation: polymorphic schema; accepts an untyped value
- columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- columns[].lookup: polymorphic schema; accepts an untyped value
- columns[].number: polymorphic schema; accepts an untyped value
- columns[].personOrGroup: polymorphic schema; accepts an untyped value
- columns[].sourceColumn: polymorphic schema; accepts an untyped value
- columns[].sourceContentType: polymorphic schema; accepts an untyped value
- columns[].term: polymorphic schema; accepts an untyped value
- columns[].text: polymorphic schema; accepts an untyped value
- columns[].thumbnail: polymorphic schema; accepts an untyped value
- columns[].validation: polymorphic schema; accepts an untyped value
- customProperties: polymorphic schema; accepts an untyped value
- informationBarrier: polymorphic schema; accepts an untyped value
- sharePointGroups[].members[].identity: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
