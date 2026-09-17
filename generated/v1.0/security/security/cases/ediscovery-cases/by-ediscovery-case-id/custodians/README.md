# /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians

Create custodians

[Catalog](../../../../../../README.md) · [Security](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycustodian?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/cases/ediscovery-cases/by-ediscovery-case-id/custodians"
  ediscovery_case_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `ediscovery_case_id` | URL parameter `ediscoveryCase-id` | `string` | yes | no |
| `acknowledged_date_time` | `acknowledgedDateTime` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `email` | `email` | `string` | no | no |
| `hold_status` | `holdStatus` | `any` | no | no |
| `last_index_operation` | `lastIndexOperation` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `released_date_time` | `releasedDateTime` | `string` | no | no |
| `site_sources` | `siteSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       description = optional(string)       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       bundles = optional(any)       description = optional(string)       following = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       error = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseItem")       description = optional(string)       name = optional(string)       parentReference = optional(any)     })))       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       pages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseSitePage")       description = optional(string)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)     })))       parentReference = optional(any)       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       sites = optional(any)       termStore = optional(any)       termStores = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.store")       defaultLanguageTag = optional(string)       groups = optional(any)       languageTags = optional(any)       sets = optional(any)     })))     }))     }))` | no | no |
| `status` | `status` | `any` | no | no |
| `unified_group_sources` | `unifiedGroupSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.unifiedGroupSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       group = optional(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(any)     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(any)       categories = optional(any)       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       planner = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.groupSetting")       displayName = optional(string)       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(any)       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(any)     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       transitiveMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)     }))       holdStatus = optional(any)       includedSources = optional(any)     }))` | no | no |
| `user_sources` | `userSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(any)       includedSources = optional(any)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- holdStatus: polymorphic schema; accepts an untyped value
- lastIndexOperation: polymorphic schema; accepts an untyped value
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
- siteSources[].site.columns[].term: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].text: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].thumbnail: polymorphic schema; accepts an untyped value
- siteSources[].site.columns[].validation: polymorphic schema; accepts an untyped value
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
- siteSources[].site.drive: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].bundles: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].following: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.drives[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.drives[].sharePointIds: polymorphic schema; accepts an untyped value
- siteSources[].site.error: polymorphic schema; accepts an untyped value
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
- siteSources[].site.externalColumns[].term: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].text: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- siteSources[].site.externalColumns[].validation: polymorphic schema; accepts an untyped value
- siteSources[].site.items[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].columns: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].drive: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].items: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].list: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].operations: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.lists[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.lists[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.onenote: polymorphic schema; accepts an untyped value
- siteSources[].site.operations[].error: polymorphic schema; accepts an untyped value
- siteSources[].site.operations[].status: polymorphic schema; accepts an untyped value
- siteSources[].site.pages[].pageLayout: polymorphic schema; accepts an untyped value
- siteSources[].site.pages[].parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.pages[].publishingState: polymorphic schema; accepts an untyped value
- siteSources[].site.parentReference: polymorphic schema; accepts an untyped value
- siteSources[].site.sites[]: recursive schema; accepts an untyped value
- siteSources[].site.termStore: polymorphic schema; accepts an untyped value
- siteSources[].site.termStores[].groups: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.termStores[].languageTags: nested schema exceeds depth limit; accepts an untyped value
- siteSources[].site.termStores[].sets: nested schema exceeds depth limit; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].createdBy: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.accessType: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.conversations[].uniqueSenders: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].attendees: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].body: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].cancelledOccurrences: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].categories: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].end: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].exceptionOccurrences: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].extensions: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].importance: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].location: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].locations: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.events[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].organizer: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].recurrence: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].responseStatus: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].sensitivity: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].showAs: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.events[].start: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.onenote: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.photo: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.planner: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.settings[].values: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].analytics: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].columns: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].drive: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].drives: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].error: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].externalColumns: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].items: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].lists: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].onenote: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].operations: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].pages: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].parentReference: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].permissions: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].sites: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.sites[].termStore: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.sites[].termStores: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.team: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].group.threads[].ccRecipients: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.threads[].posts: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.threads[].toRecipients: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].group.threads[].uniqueSenders: nested schema exceeds depth limit; accepts an untyped value
- unifiedGroupSources[].holdStatus: polymorphic schema; accepts an untyped value
- unifiedGroupSources[].includedSources: polymorphic schema; accepts an untyped value
- userSources[].createdBy: polymorphic schema; accepts an untyped value
- userSources[].holdStatus: polymorphic schema; accepts an untyped value
- userSources[].includedSources: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
