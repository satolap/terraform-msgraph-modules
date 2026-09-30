# /storage/fileStorage/containers

Create fileStorageContainer

[Catalog](../../../../README.md) · [Files](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/filestoragecontainer?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /storage/fileStorage/containers`, `GET/PATCH/DELETE /storage/fileStorage/containers/{fileStorageContainer-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/files/storage/file-storage/containers?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assigned_sensitivity_label` | `assignedSensitivityLabel` | `object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })` | no | no |
| `columns` | `columns` | `list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(list(string))       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.displayNameLocalization")       displayName = optional(string)       languageTag = optional(string)     })))       formula = optional(string)     }))     }))` | no | no |
| `custom_properties` | `customProperties` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `migration_jobs` | `migrationJobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharePointMigrationJob")       containerInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.sharePointMigrationContainerInfo")     }))       progressEvents = optional(any)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `permissions` | `permissions` | `list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     }))` | no | no |
| `settings` | `settings` | `object({       odata_type = optional(string, "#microsoft.graph.fileStorageContainerSettings")       isItemVersioningEnabled = optional(bool)       isOcrEnabled = optional(bool)       itemMajorVersionLimit = optional(number)     })` | no | no |
| `share_point_groups` | `sharePointGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharePointGroup")       description = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharePointGroupMember")       identity = optional(object({       odata_type = optional(string, "#microsoft.graph.sharePointIdentitySet")       application = optional(any)       device = optional(any)       group = optional(any)       sharePointGroup = optional(any)       siteGroup = optional(any)       siteUser = optional(any)       user = optional(any)     }))     })))       title = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- columns[].boolean: polymorphic schema; accepts an untyped value
- columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- columns[].geolocation: polymorphic schema; accepts an untyped value
- columns[].number.maximum: polymorphic schema; accepts an untyped value
- columns[].number.minimum: polymorphic schema; accepts an untyped value
- columns[].sourceColumn: navigation property; accepts an untyped value
- columns[].term.parentTerm: navigation property; accepts an untyped value
- columns[].term.termSet: navigation property; accepts an untyped value
- columns[].thumbnail: polymorphic schema; accepts an untyped value
- customProperties: polymorphic schema; accepts an untyped value
- migrationJobs[].progressEvents[]: polymorphic schema; accepts an untyped value
- sharePointGroups[].members[].identity.application: polymorphic schema; accepts an untyped value
- sharePointGroups[].members[].identity.device: polymorphic schema; accepts an untyped value
- sharePointGroups[].members[].identity.group: polymorphic schema; accepts an untyped value
- sharePointGroups[].members[].identity.sharePointGroup: nested schema exceeds depth limit; accepts an untyped value
- sharePointGroups[].members[].identity.siteGroup: nested schema exceeds depth limit; accepts an untyped value
- sharePointGroups[].members[].identity.siteUser: nested schema exceeds depth limit; accepts an untyped value
- sharePointGroups[].members[].identity.user: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
