# /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians

Create custodians

[Catalog](../../../../../../README.md) · [Security](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycustodian?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/security/security/cases/ediscovery-cases/by-ediscovery-case-id/custodians?ref=<release-tag>"
  ediscovery_case_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `ediscovery_case_id` | URL parameter `ediscoveryCase-id` | `string` | yes | no |
| `acknowledged_date_time` | `acknowledgedDateTime` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `email` | `email` | `string` | no | no |
| `hold_status` | `holdStatus` | `string` | no | no |
| `last_index_operation` | `lastIndexOperation` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `released_date_time` | `releasedDateTime` | `string` | no | no |
| `site_sources` | `siteSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(string)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(string)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(string)       listItemUniqueId = optional(string)       status = optional(string)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(any)       bundles = optional(any)       createdByUser = optional(any)       description = optional(string)       following = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       extensions = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(any)       columns = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       lastModifiedByUser = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(string)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)       titleArea = optional(any)       webParts = optional(any)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     }))     }))` | no | no |
| `status` | `status` | `string` | no | no |
| `unified_group_sources` | `unifiedGroupSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.unifiedGroupSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       group = optional(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(any)       usageRights = optional(any)     }))       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(any)     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(any)       categories = optional(any)       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(any)     })))       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     }))     }))       holdStatus = optional(string)       includedSources = optional(string)     }))` | no | no |
| `user_sources` | `userSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(string)       includedSources = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- lastIndexOperation: navigation property; accepts an untyped value
- siteSources[].createdBy: polymorphic schema; accepts an untyped value
- siteSources[].site.analytics: navigation property; accepts an untyped value
- siteSources[].site.columns[].boolean: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].calculated: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].choice: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].currency: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].dateTime: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].defaultValue: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].geolocation: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].hyperlinkOrPicture: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].lookup: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].number: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].personOrGroup: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].sourceColumn: navigation property; accepts an untyped value
- siteSources[].site.columns[].sourceContentType: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].term: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].text: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.columns[].thumbnail: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].validation: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].associatedHubsUrls: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].base: navigation property; accepts an untyped value
- siteSources[].site.contentTypes[].baseTypes: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].columnLinks: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].columnPositions: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].columns: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].documentSet: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].documentTemplate: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].inheritedFrom: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.contentTypes[].order: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.drive: navigation property; accepts an untyped value
- siteSources[].site.drives[].activities: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].bundles: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].following: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].sharePointIds: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.extensions[]: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].boolean: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].calculated: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].choice: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].currency: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].dateTime: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].defaultValue: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].hyperlinkOrPicture: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].lookup: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].number: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].personOrGroup: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].sourceColumn: navigation property; accepts an untyped value
- siteSources[].site.externalColumns[].sourceContentType: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].term: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].text: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].validation: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.informationProtection: navigation property; accepts an untyped value
- siteSources[].site.items[]: polymorphic schema; accepts an untyped value
- siteSources[].site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].activities: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].columns: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].drive: navigation property; accepts an untyped value
- siteSources[].site.lists[].items: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].list: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].operations: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.onenote: navigation property; accepts an untyped value
- siteSources[].site.operations[].error: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.pageTemplates[].canvasLayout: navigation property; accepts an untyped value
- siteSources[].site.pageTemplates[].createdByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- siteSources[].site.pageTemplates[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.pageTemplates[].publishingState: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.pageTemplates[].titleArea: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.pageTemplates[].webParts: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.pages[]: polymorphic schema; accepts an untyped value
- siteSources[].site.recycleBin: navigation property; accepts an untyped value
- siteSources[].site.sites[]: recursive schema; accepts an untyped value
- siteSources[].site.termStore: navigation property; accepts an untyped value
- unifiedGroupSources[].createdBy: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.acceptedSenders[]: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.cloudLicensing.assignments[]: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.cloudLicensing.usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.conversations[].uniqueSenders: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].attendees: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].body: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].cancelledOccurrences: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].categories: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].end: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].exceptionOccurrences: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].extensions: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].location: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].locations: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].organizer: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].recurrence: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].responseStatus: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].start: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.members[]: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.onPremisesSyncBehavior: navigation property; accepts an untyped value
- unifiedGroupSources[].group.onenote: navigation property; accepts an untyped value
- unifiedGroupSources[].group.owners[]: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.photo: navigation property; accepts an untyped value
- unifiedGroupSources[].group.rejectedSenders[]: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.settings[].values: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].analytics: navigation property; accepts an untyped value
- unifiedGroupSources[].group.sites[].columns: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].contentModels: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].createdByUser: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].deleted: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].documentProcessingJobs: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].drive: navigation property; accepts an untyped value
- unifiedGroupSources[].group.sites[].drives: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].extensions: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].externalColumns: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].informationProtection: navigation property; accepts an untyped value
- unifiedGroupSources[].group.sites[].items: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].lists: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].onenote: navigation property; accepts an untyped value
- unifiedGroupSources[].group.sites[].operations: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].ownerIdentityToResolve: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].pageTemplates: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].pages: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].permissions: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].recycleBin: navigation property; accepts an untyped value
- unifiedGroupSources[].group.sites[].sites: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].termStore: navigation property; accepts an untyped value
- unifiedGroupSources[].group.team: navigation property; accepts an untyped value
- unifiedGroupSources[].group.threads[].ccRecipients: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.threads[].posts: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.threads[].toRecipients: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.threads[].uniqueSenders: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.transitiveMembers[]: polymorphic schema; accepts an untyped value
- userSources[].createdBy: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
