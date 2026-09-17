# /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/siteSources

Create siteSource

[Catalog](../../../../../../../../README.md) · [Security](../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/siteSources`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/siteSources/{siteSource-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/cases/ediscovery-cases/by-ediscovery-case-id/custodians/by-ediscovery-custodian-id/site-sources"
  ediscovery_case_id = "parent-object-id"
  ediscovery_custodian_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `ediscovery_case_id` | URL parameter `ediscoveryCase-id` | `string` | yes | no |
| `ediscovery_custodian_id` | URL parameter `ediscoveryCustodian-id` | `string` | yes | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `hold_status` | `holdStatus` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `site` | `site` | `object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(any)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnLink")       name = optional(string)     })))       columnPositions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(any)       listItemUniqueId = optional(string)       status = optional(any)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.itemActivityOLD")       action = optional(any)       actor = optional(any)       driveItem = optional(any)       listItem = optional(any)       times = optional(any)     })))       bundles = optional(list(object({       odata_type = optional(string, "#microsoft.graph.driveItem")       activities = optional(any)       analytics = optional(any)       content = optional(string)       contentStream = optional(string)       createdByUser = optional(any)       description = optional(string)       extensions = optional(any)       fileSystemInfo = optional(any)       lastModifiedByUser = optional(any)       media = optional(any)       name = optional(string)       parentReference = optional(any)       retentionLabel = optional(any)       root = optional(any)       subscriptions = optional(any)       webDavUrl = optional(string)       workbook = optional(any)     })))       createdByUser = optional(any)       description = optional(string)       following = optional(list(object({       odata_type = optional(string, "#microsoft.graph.driveItem")       activities = optional(any)       analytics = optional(any)       content = optional(string)       contentStream = optional(string)       createdByUser = optional(any)       description = optional(string)       extensions = optional(any)       fileSystemInfo = optional(any)       lastModifiedByUser = optional(any)       media = optional(any)       name = optional(string)       parentReference = optional(any)       retentionLabel = optional(any)       root = optional(any)       subscriptions = optional(any)       webDavUrl = optional(string)       workbook = optional(any)     })))       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseItem")       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)     })))       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.itemActivityOLD")       action = optional(any)       actor = optional(any)       driveItem = optional(any)       listItem = optional(any)       times = optional(any)     })))       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.listItem")       activities = optional(any)       analytics = optional(any)       contentType = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentSetVersions = optional(any)       driveItem = optional(any)       fields = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       versions = optional(any)     })))       lastModifiedByUser = optional(any)       list = optional(any)       name = optional(string)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       parentReference = optional(any)       subscriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.subscription")       changeType = optional(string)       clientState = optional(string)       encryptionCertificate = optional(string)       encryptionCertificateId = optional(string)       expirationDateTime = optional(string)       includeResourceData = optional(bool)       latestSupportedTlsVersion = optional(string)       lifecycleNotificationUrl = optional(string)       notificationContentType = optional(string)       notificationQueryOptions = optional(string)       notificationUrl = optional(string)       notificationUrlAppId = optional(string)       resource = optional(string)       vapidPublicKey = optional(string)       webPushEncryptionP256dhPublicKey = optional(string)       webPushEncryptionSecret = optional(string)     })))     })))       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(any)       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)       titleArea = optional(any)       webParts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.webPart")     })))     })))       pages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseSitePage")       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)     })))       parentReference = optional(any)       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })` | no | yes |
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
- holdStatus: polymorphic schema; accepts an untyped value
- site.analytics: polymorphic schema; accepts an untyped value
- site.columns[].boolean: polymorphic schema; accepts an untyped value
- site.columns[].calculated: polymorphic schema; accepts an untyped value
- site.columns[].choice: polymorphic schema; accepts an untyped value
- site.columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.columns[].currency: polymorphic schema; accepts an untyped value
- site.columns[].dateTime: polymorphic schema; accepts an untyped value
- site.columns[].defaultValue: polymorphic schema; accepts an untyped value
- site.columns[].geolocation: polymorphic schema; accepts an untyped value
- site.columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- site.columns[].lookup: polymorphic schema; accepts an untyped value
- site.columns[].number: polymorphic schema; accepts an untyped value
- site.columns[].personOrGroup: polymorphic schema; accepts an untyped value
- site.columns[].sourceColumn: polymorphic schema; accepts an untyped value
- site.columns[].sourceContentType: polymorphic schema; accepts an untyped value
- site.columns[].term: polymorphic schema; accepts an untyped value
- site.columns[].text: polymorphic schema; accepts an untyped value
- site.columns[].thumbnail: polymorphic schema; accepts an untyped value
- site.columns[].validation: polymorphic schema; accepts an untyped value
- site.contentModels[].modelType: polymorphic schema; accepts an untyped value
- site.contentTypes[].base: polymorphic schema; accepts an untyped value
- site.contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- site.contentTypes[].columnPositions[].boolean: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].calculated: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].choice: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].currency: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].dateTime: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].defaultValue: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].geolocation: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].lookup: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].number: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].personOrGroup: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].sourceColumn: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].sourceContentType: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].term: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].text: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].thumbnail: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].validation: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].boolean: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].calculated: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].choice: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].currency: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].dateTime: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].defaultValue: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].geolocation: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].lookup: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].number: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].personOrGroup: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].sourceColumn: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].sourceContentType: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].term: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].text: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].validation: polymorphic schema; accepts an untyped value
- site.contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- site.contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- site.contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- site.contentTypes[].order: polymorphic schema; accepts an untyped value
- site.createdByUser: polymorphic schema; accepts an untyped value
- site.deleted: polymorphic schema; accepts an untyped value
- site.documentProcessingJobs[].jobType: polymorphic schema; accepts an untyped value
- site.documentProcessingJobs[].status: polymorphic schema; accepts an untyped value
- site.drive: polymorphic schema; accepts an untyped value
- site.drives[].activities[].action: polymorphic schema; accepts an untyped value
- site.drives[].activities[].actor: polymorphic schema; accepts an untyped value
- site.drives[].activities[].driveItem: polymorphic schema; accepts an untyped value
- site.drives[].activities[].listItem: polymorphic schema; accepts an untyped value
- site.drives[].activities[].times: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].activities: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].analytics: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].createdByUser: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].extensions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].fileSystemInfo: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].media: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].parentReference: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].retentionLabel: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].root: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].workbook: polymorphic schema; accepts an untyped value
- site.drives[].createdByUser: polymorphic schema; accepts an untyped value
- site.drives[].following[].activities: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].analytics: polymorphic schema; accepts an untyped value
- site.drives[].following[].createdByUser: polymorphic schema; accepts an untyped value
- site.drives[].following[].extensions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].fileSystemInfo: polymorphic schema; accepts an untyped value
- site.drives[].following[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.drives[].following[].media: polymorphic schema; accepts an untyped value
- site.drives[].following[].parentReference: polymorphic schema; accepts an untyped value
- site.drives[].following[].retentionLabel: polymorphic schema; accepts an untyped value
- site.drives[].following[].root: polymorphic schema; accepts an untyped value
- site.drives[].following[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].workbook: polymorphic schema; accepts an untyped value
- site.drives[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.drives[].parentReference: polymorphic schema; accepts an untyped value
- site.drives[].sharePointIds: polymorphic schema; accepts an untyped value
- site.externalColumns[].boolean: polymorphic schema; accepts an untyped value
- site.externalColumns[].calculated: polymorphic schema; accepts an untyped value
- site.externalColumns[].choice: polymorphic schema; accepts an untyped value
- site.externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.externalColumns[].currency: polymorphic schema; accepts an untyped value
- site.externalColumns[].dateTime: polymorphic schema; accepts an untyped value
- site.externalColumns[].defaultValue: polymorphic schema; accepts an untyped value
- site.externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- site.externalColumns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- site.externalColumns[].lookup: polymorphic schema; accepts an untyped value
- site.externalColumns[].number: polymorphic schema; accepts an untyped value
- site.externalColumns[].personOrGroup: polymorphic schema; accepts an untyped value
- site.externalColumns[].sourceColumn: polymorphic schema; accepts an untyped value
- site.externalColumns[].sourceContentType: polymorphic schema; accepts an untyped value
- site.externalColumns[].term: polymorphic schema; accepts an untyped value
- site.externalColumns[].text: polymorphic schema; accepts an untyped value
- site.externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- site.externalColumns[].validation: polymorphic schema; accepts an untyped value
- site.informationProtection: polymorphic schema; accepts an untyped value
- site.items[].createdByUser: polymorphic schema; accepts an untyped value
- site.items[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.items[].parentReference: polymorphic schema; accepts an untyped value
- site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.lists[].activities[].action: polymorphic schema; accepts an untyped value
- site.lists[].activities[].actor: polymorphic schema; accepts an untyped value
- site.lists[].activities[].driveItem: polymorphic schema; accepts an untyped value
- site.lists[].activities[].listItem: polymorphic schema; accepts an untyped value
- site.lists[].activities[].times: polymorphic schema; accepts an untyped value
- site.lists[].columns[].boolean: polymorphic schema; accepts an untyped value
- site.lists[].columns[].calculated: polymorphic schema; accepts an untyped value
- site.lists[].columns[].choice: polymorphic schema; accepts an untyped value
- site.lists[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.lists[].columns[].currency: polymorphic schema; accepts an untyped value
- site.lists[].columns[].dateTime: polymorphic schema; accepts an untyped value
- site.lists[].columns[].defaultValue: polymorphic schema; accepts an untyped value
- site.lists[].columns[].geolocation: polymorphic schema; accepts an untyped value
- site.lists[].columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- site.lists[].columns[].lookup: polymorphic schema; accepts an untyped value
- site.lists[].columns[].number: polymorphic schema; accepts an untyped value
- site.lists[].columns[].personOrGroup: polymorphic schema; accepts an untyped value
- site.lists[].columns[].sourceColumn: polymorphic schema; accepts an untyped value
- site.lists[].columns[].sourceContentType: polymorphic schema; accepts an untyped value
- site.lists[].columns[].term: polymorphic schema; accepts an untyped value
- site.lists[].columns[].text: polymorphic schema; accepts an untyped value
- site.lists[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- site.lists[].columns[].validation: polymorphic schema; accepts an untyped value
- site.lists[].contentTypes[].associatedHubsUrls: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].base: polymorphic schema; accepts an untyped value
- site.lists[].contentTypes[].baseTypes: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].columnLinks: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].columnPositions: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].columns: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- site.lists[].contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- site.lists[].contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- site.lists[].contentTypes[].order: polymorphic schema; accepts an untyped value
- site.lists[].createdByUser: polymorphic schema; accepts an untyped value
- site.lists[].drive: polymorphic schema; accepts an untyped value
- site.lists[].items[].activities: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].items[].analytics: polymorphic schema; accepts an untyped value
- site.lists[].items[].contentType: polymorphic schema; accepts an untyped value
- site.lists[].items[].createdByUser: polymorphic schema; accepts an untyped value
- site.lists[].items[].deleted: polymorphic schema; accepts an untyped value
- site.lists[].items[].documentSetVersions: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].items[].driveItem: polymorphic schema; accepts an untyped value
- site.lists[].items[].fields: polymorphic schema; accepts an untyped value
- site.lists[].items[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.lists[].items[].parentReference: polymorphic schema; accepts an untyped value
- site.lists[].items[].versions: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.lists[].list: polymorphic schema; accepts an untyped value
- site.lists[].operations[].error: polymorphic schema; accepts an untyped value
- site.lists[].operations[].status: polymorphic schema; accepts an untyped value
- site.lists[].parentReference: polymorphic schema; accepts an untyped value
- site.lockState: polymorphic schema; accepts an untyped value
- site.onenote: polymorphic schema; accepts an untyped value
- site.operations[].error: polymorphic schema; accepts an untyped value
- site.operations[].status: polymorphic schema; accepts an untyped value
- site.ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- site.pageTemplates[].canvasLayout: polymorphic schema; accepts an untyped value
- site.pageTemplates[].createdByUser: polymorphic schema; accepts an untyped value
- site.pageTemplates[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.pageTemplates[].pageLayout: polymorphic schema; accepts an untyped value
- site.pageTemplates[].parentReference: polymorphic schema; accepts an untyped value
- site.pageTemplates[].publishingState: polymorphic schema; accepts an untyped value
- site.pageTemplates[].titleArea: polymorphic schema; accepts an untyped value
- site.pages[].createdByUser: polymorphic schema; accepts an untyped value
- site.pages[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.pages[].pageLayout: polymorphic schema; accepts an untyped value
- site.pages[].parentReference: polymorphic schema; accepts an untyped value
- site.pages[].publishingState: polymorphic schema; accepts an untyped value
- site.parentReference: polymorphic schema; accepts an untyped value
- site.recycleBin: polymorphic schema; accepts an untyped value
- site.sites[]: recursive schema; accepts an untyped value
- site.template: polymorphic schema; accepts an untyped value
- site.termStore: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
