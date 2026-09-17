# /compliance/ediscovery/cases

Create case

[Catalog](../../../../README.md) · [Compliance](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/ediscovery-case?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /compliance/ediscovery/cases`, `GET/PATCH/DELETE /compliance/ediscovery/cases/{case-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./compliance/compliance/ediscovery/cases"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `closed_by` | `closedBy` | `any` | no | no |
| `closed_date_time` | `closedDateTime` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custodians` | `custodians` | `list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.custodian")       acknowledgedDateTime = optional(string)       applyHoldToSources = optional(bool)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(any)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       siteSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     }))     })))       status = optional(any)       unifiedGroupSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.unifiedGroupSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       group = optional(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(any)       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(any)       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(any)       resourceProvisioningOptions = optional(any)       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     }))       holdStatus = optional(any)       includedSources = optional(any)     })))       userSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(any)       includedSources = optional(any)     })))     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `legal_holds` | `legalHolds` | `list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.legalHold")       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       errors = optional(list(string))       isEnabled = optional(bool)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       siteSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     }))     })))       status = optional(any)       unifiedGroupSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.unifiedGroupSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       group = optional(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(any)       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(any)       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(any)       resourceProvisioningOptions = optional(any)       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     }))       holdStatus = optional(any)       includedSources = optional(any)     })))       userSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(any)       includedSources = optional(any)     })))     }))` | no | no |
| `noncustodial_data_sources` | `noncustodialDataSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.noncustodialDataSource")       applyHoldToSource = optional(bool)       createdDateTime = optional(string)       dataSource = optional(any)       displayName = optional(string)       holdStatus = optional(any)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       status = optional(any)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.caseOperation")       action = optional(any)       completedDateTime = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       percentProgress = optional(number)       resultInfo = optional(any)       status = optional(any)     }))` | no | no |
| `settings` | `settings` | `any` | no | no |
| `source_collections` | `sourceCollections` | `list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.sourceCollection")       addToReviewSetOperation = optional(any)       additionalSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.dataSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)     })))       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       custodianSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.dataSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)     })))       dataSourceScopes = optional(any)       description = optional(string)       displayName = optional(string)       lastEstimateStatisticsOperation = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       noncustodialSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.noncustodialDataSource")       applyHoldToSource = optional(bool)       createdDateTime = optional(string)       dataSource = optional(any)       displayName = optional(string)       holdStatus = optional(any)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       status = optional(any)     })))     }))` | no | no |
| `status` | `status` | `any` | no | no |
| `tags` | `tags` | `list(object({       odata_type = optional(string, "#microsoft.graph.ediscovery.tag")       childSelectability = optional(any)       childTags = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       parent = optional(any)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- closedBy: polymorphic schema; accepts an untyped value
- custodians[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].lastIndexOperation: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.analytics: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.columns: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.contentModels: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.contentTypes: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.createdByUser: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.deleted: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.documentProcessingJobs: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.drive: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.drives: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.extensions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.externalColumns: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.informationProtection: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.items: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.lists: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.lockState: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.onenote: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.operations: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.pageTemplates: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.pages: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.parentReference: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.permissions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.recycleBin: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.sites: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.template: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.termStore: polymorphic schema; accepts an untyped value
- custodians[].status: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.acceptedSenders: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.accessType: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.assignedLabels: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.cloudLicensing: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.conversations: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.events: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.groupTypes: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.infoCatalogs: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.members: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onenote: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.owners: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.photo: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.rejectedSenders: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.resourceBehaviorOptions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.resourceProvisioningOptions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.settings: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.sites: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.team: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.threads: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.transitiveMembers: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.writebackConfiguration: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].includedSources: polymorphic schema; accepts an untyped value
- custodians[].userSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].userSources[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].userSources[].includedSources: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- legalHolds[].createdBy: polymorphic schema; accepts an untyped value
- legalHolds[].lastModifiedBy: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].createdBy: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].holdStatus: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.analytics: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.columns: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.contentModels: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.contentTypes: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.createdByUser: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.deleted: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.documentProcessingJobs: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.drive: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.drives: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.extensions: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.externalColumns: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.informationProtection: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.items: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.lists: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.lockState: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.onenote: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.operations: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.pageTemplates: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.pages: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.parentReference: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.permissions: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.recycleBin: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.sites: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.template: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.termStore: polymorphic schema; accepts an untyped value
- legalHolds[].status: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].createdBy: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.acceptedSenders: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.accessType: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.assignedLabels: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.cloudLicensing: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.conversations: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.events: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.groupTypes: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.infoCatalogs: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.members: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.onenote: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.owners: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.photo: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.rejectedSenders: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.resourceBehaviorOptions: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.resourceProvisioningOptions: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.settings: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.sites: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.team: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.threads: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.transitiveMembers: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].unifiedGroupSources[].group.writebackConfiguration: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].holdStatus: polymorphic schema; accepts an untyped value
- legalHolds[].unifiedGroupSources[].includedSources: polymorphic schema; accepts an untyped value
- legalHolds[].userSources[].createdBy: polymorphic schema; accepts an untyped value
- legalHolds[].userSources[].holdStatus: polymorphic schema; accepts an untyped value
- legalHolds[].userSources[].includedSources: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].dataSource: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].holdStatus: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].lastIndexOperation: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].status: polymorphic schema; accepts an untyped value
- operations[].action: polymorphic schema; accepts an untyped value
- operations[].createdBy: polymorphic schema; accepts an untyped value
- operations[].resultInfo: polymorphic schema; accepts an untyped value
- operations[].status: polymorphic schema; accepts an untyped value
- settings: polymorphic schema; accepts an untyped value
- sourceCollections[].addToReviewSetOperation: polymorphic schema; accepts an untyped value
- sourceCollections[].additionalSources[].createdBy: polymorphic schema; accepts an untyped value
- sourceCollections[].additionalSources[].holdStatus: polymorphic schema; accepts an untyped value
- sourceCollections[].createdBy: polymorphic schema; accepts an untyped value
- sourceCollections[].custodianSources[].createdBy: polymorphic schema; accepts an untyped value
- sourceCollections[].custodianSources[].holdStatus: polymorphic schema; accepts an untyped value
- sourceCollections[].dataSourceScopes: polymorphic schema; accepts an untyped value
- sourceCollections[].lastEstimateStatisticsOperation: polymorphic schema; accepts an untyped value
- sourceCollections[].lastModifiedBy: polymorphic schema; accepts an untyped value
- sourceCollections[].noncustodialSources[].dataSource: polymorphic schema; accepts an untyped value
- sourceCollections[].noncustodialSources[].holdStatus: polymorphic schema; accepts an untyped value
- sourceCollections[].noncustodialSources[].lastIndexOperation: polymorphic schema; accepts an untyped value
- sourceCollections[].noncustodialSources[].status: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- tags[].childSelectability: polymorphic schema; accepts an untyped value
- tags[].childTags[]: recursive schema; accepts an untyped value
- tags[].createdBy: polymorphic schema; accepts an untyped value
- tags[].parent: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
