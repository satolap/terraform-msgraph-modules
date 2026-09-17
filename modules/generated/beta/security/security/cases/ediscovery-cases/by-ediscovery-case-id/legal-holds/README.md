# /security/cases/ediscoveryCases/{ediscoveryCase-id}/legalHolds

Create ediscoveryHoldPolicy

[Catalog](../../../../../../README.md) · [Security](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoveryholdpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/legalHolds`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/legalHolds/{ediscoveryHoldPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/cases/ediscovery-cases/by-ediscovery-case-id/legal-holds"
  ediscovery_case_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `ediscovery_case_id` | URL parameter `ediscoveryCase-id` | `string` | yes | no |
| `content_query` | `contentQuery` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `errors` | `errors` | `list(string)` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `site_sources` | `siteSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(any)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(any)       listItemUniqueId = optional(string)       status = optional(any)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(any)       bundles = optional(any)       createdByUser = optional(any)       description = optional(string)       following = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseItem")       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)     })))       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(any)       columns = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       lastModifiedByUser = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(any)       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)       titleArea = optional(any)       webParts = optional(any)     })))       pages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseSitePage")       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)     })))       parentReference = optional(any)       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     }))     }))` | no | no |
| `status` | `status` | `any` | no | no |
| `user_sources` | `userSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(any)       includedSources = optional(any)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- createdBy: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- siteSources[].createdBy: polymorphic schema; accepts an untyped value
- siteSources[].holdStatus: polymorphic schema; accepts an untyped value
- siteSources[].site.analytics: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].boolean: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].calculated: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].choice: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].currency: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].dateTime: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].defaultValue: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].geolocation: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].lookup: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].number: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].personOrGroup: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].sourceColumn: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].sourceContentType: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].term: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].text: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].thumbnail: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].validation: polymorphic schema; accepts an untyped value
- siteSources[].site.contentModels[].modelType: polymorphic schema; accepts an untyped value
- siteSources[].site.contentTypes[].associatedHubsUrls: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].base: polymorphic schema; accepts an untyped value
- siteSources[].site.contentTypes[].baseTypes: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].columnLinks: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].columnPositions: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].columns: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- siteSources[].site.contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- siteSources[].site.contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- siteSources[].site.contentTypes[].order: polymorphic schema; accepts an untyped value
- siteSources[].site.createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.deleted: polymorphic schema; accepts an untyped value
- siteSources[].site.documentProcessingJobs[].jobType: polymorphic schema; accepts an untyped value
- siteSources[].site.documentProcessingJobs[].status: polymorphic schema; accepts an untyped value
- siteSources[].site.drive: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].activities: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].bundles: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].following: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].sharePointIds: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].boolean: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].calculated: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].choice: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].currency: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].dateTime: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].defaultValue: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].lookup: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].number: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].personOrGroup: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].sourceColumn: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].sourceContentType: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].term: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].text: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].validation: polymorphic schema; accepts an untyped value
- siteSources[].site.informationProtection: polymorphic schema; accepts an untyped value
- siteSources[].site.items[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.items[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.items[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].activities: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].columns: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].drive: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].items: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].list: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].operations: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lockState: polymorphic schema; accepts an untyped value
- siteSources[].site.onenote: polymorphic schema; accepts an untyped value
- siteSources[].site.operations[].error: polymorphic schema; accepts an untyped value
- siteSources[].site.operations[].status: polymorphic schema; accepts an untyped value
- siteSources[].site.ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].canvasLayout: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].pageLayout: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].publishingState: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].titleArea: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].webParts: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.pages[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.pages[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.pages[].pageLayout: polymorphic schema; accepts an untyped value
- siteSources[].site.pages[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.pages[].publishingState: polymorphic schema; accepts an untyped value
- siteSources[].site.parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.recycleBin: polymorphic schema; accepts an untyped value
- siteSources[].site.sites[]: recursive schema; accepts an untyped value
- siteSources[].site.template: polymorphic schema; accepts an untyped value
- siteSources[].site.termStore: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- userSources[].createdBy: polymorphic schema; accepts an untyped value
- userSources[].holdStatus: polymorphic schema; accepts an untyped value
- userSources[].includedSources: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
