# /storage/fileStorage/containers

Create fileStorageContainer

[Catalog](../../../README.md) Â· [Files](../../../README.md#files) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/filestoragecontainer?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /storage/fileStorage/containers`, `GET/PATCH/DELETE /storage/fileStorage/containers/{fileStorageContainer-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/storage/file-storage/containers"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `archivalDetails`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `archival_details` | `archivalDetails` | `object({       odata_type = optional(string, "#microsoft.graph.siteArchivalDetails")       archiveStatus = optional(string)       archivedBy = optional(any)       archivedDateTime = optional(string)     })` | no | no | in place |
| `assigned_sensitivity_label` | `assignedSensitivityLabel` | `object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })` | no | no | in place |
| `columns` | `columns` | `list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(list(string))       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.displayNameLocalization")       displayName = optional(string)       languageTag = optional(string)     })))       formula = optional(string)     }))     }))` | no | no | in place |
| `custom_properties` | `customProperties` | `any` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `external_group_id` | `externalGroupId` | `string` | no | no | in place |
| `information_barrier` | `informationBarrier` | `object({       odata_type = optional(string, "#microsoft.graph.informationBarrier")       mode = optional(string)       segmentIds = optional(list(string))     })` | no | no | in place |
| `migration_jobs` | `migrationJobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharePointMigrationJob")       containerInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.sharePointMigrationContainerInfo")     }))       progressEvents = optional(any)     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `permissions` | `permissions` | `list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     }))` | no | no | in place |
| `settings` | `settings` | `object({       odata_type = optional(string, "#microsoft.graph.fileStorageContainerSettings")       isItemVersioningEnabled = optional(bool)       isOcrEnabled = optional(bool)       itemDefaultSensitivityLabelId = optional(string)       itemMajorVersionLimit = optional(number)     })` | no | no | in place |
| `share_point_groups` | `sharePointGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharePointGroup")       description = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharePointGroupMember")       identity = optional(object({       odata_type = optional(string, "#microsoft.graph.sharePointIdentitySet")       application = optional(any)       device = optional(any)       group = optional(any)       sharePointGroup = optional(any)       siteGroup = optional(any)       siteUser = optional(any)       user = optional(any)     }))     })))       title = optional(string)     }))` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `containerTypeId`, `createdDateTime`, `dataLocationCode`, `drive`, `id`, `lockState`, `owners`, `ownershipType`, `recycleBin`, `status`, `storageUsedInBytes`, `viewpoint`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- archivalDetails.archivedBy: polymorphic schema; accepts an untyped value
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
