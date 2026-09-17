# /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources

Create custodian unifiedGroupSource

[Catalog](../../../../../../../../README.md) · [Security](../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources/{unifiedGroupSource-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/cases/ediscovery-cases/by-ediscovery-case-id/custodians/by-ediscovery-custodian-id/unified-group-sources"
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
| `group` | `group` | `object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(any)       type = optional(any)     })))       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.location")       address = optional(any)       coordinates = optional(any)       displayName = optional(string)       locationEmailAddress = optional(string)       locationUri = optional(string)       uniqueId = optional(string)       uniqueIdType = optional(any)     })))       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       planner = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.groupSetting")       displayName = optional(string)       values = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingValue")       name = optional(string)       value = optional(string)     })))     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       description = optional(string)       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       bundles = optional(any)       description = optional(string)       following = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       error = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseItem")       description = optional(string)       name = optional(string)       parentReference = optional(any)     })))       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       pages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseSitePage")       description = optional(string)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)     })))       parentReference = optional(any)       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       sites = optional(any)       termStore = optional(any)       termStores = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.store")       defaultLanguageTag = optional(string)       groups = optional(any)       languageTags = optional(any)       sets = optional(any)     })))     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(any)       categories = optional(any)       createdDateTime = optional(string)       from = optional(any)       hasAttachments = optional(bool)       lastModifiedDateTime = optional(string)       newParticipants = optional(any)       receivedDateTime = optional(string)       sender = optional(any)     })))       preview = optional(string)       toRecipients = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       transitiveMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)     })` | no | no |
| `hold_status` | `holdStatus` | `any` | no | no |
| `included_sources` | `includedSources` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- createdBy: polymorphic schema; accepts an untyped value
- group.accessType: polymorphic schema; accepts an untyped value
- group.events[].attendees[].emailAddress: polymorphic schema; accepts an untyped value
- group.events[].attendees[].proposedNewTime: polymorphic schema; accepts an untyped value
- group.events[].attendees[].status: polymorphic schema; accepts an untyped value
- group.events[].attendees[].type: polymorphic schema; accepts an untyped value
- group.events[].body: polymorphic schema; accepts an untyped value
- group.events[].end: polymorphic schema; accepts an untyped value
- group.events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- group.events[].importance: polymorphic schema; accepts an untyped value
- group.events[].location: polymorphic schema; accepts an untyped value
- group.events[].locations[].address: polymorphic schema; accepts an untyped value
- group.events[].locations[].coordinates: polymorphic schema; accepts an untyped value
- group.events[].locations[].uniqueIdType: polymorphic schema; accepts an untyped value
- group.events[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- group.events[].organizer: polymorphic schema; accepts an untyped value
- group.events[].recurrence: polymorphic schema; accepts an untyped value
- group.events[].responseStatus: polymorphic schema; accepts an untyped value
- group.events[].sensitivity: polymorphic schema; accepts an untyped value
- group.events[].showAs: polymorphic schema; accepts an untyped value
- group.events[].start: polymorphic schema; accepts an untyped value
- group.onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- group.onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- group.onenote: polymorphic schema; accepts an untyped value
- group.photo: polymorphic schema; accepts an untyped value
- group.planner: polymorphic schema; accepts an untyped value
- group.sites[].analytics: polymorphic schema; accepts an untyped value
- group.sites[].columns[].boolean: polymorphic schema; accepts an untyped value
- group.sites[].columns[].calculated: polymorphic schema; accepts an untyped value
- group.sites[].columns[].choice: polymorphic schema; accepts an untyped value
- group.sites[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- group.sites[].columns[].currency: polymorphic schema; accepts an untyped value
- group.sites[].columns[].dateTime: polymorphic schema; accepts an untyped value
- group.sites[].columns[].defaultValue: polymorphic schema; accepts an untyped value
- group.sites[].columns[].geolocation: polymorphic schema; accepts an untyped value
- group.sites[].columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- group.sites[].columns[].lookup: polymorphic schema; accepts an untyped value
- group.sites[].columns[].number: polymorphic schema; accepts an untyped value
- group.sites[].columns[].personOrGroup: polymorphic schema; accepts an untyped value
- group.sites[].columns[].sourceColumn: polymorphic schema; accepts an untyped value
- group.sites[].columns[].term: polymorphic schema; accepts an untyped value
- group.sites[].columns[].text: polymorphic schema; accepts an untyped value
- group.sites[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- group.sites[].columns[].validation: polymorphic schema; accepts an untyped value
- group.sites[].contentTypes[].associatedHubsUrls: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].base: polymorphic schema; accepts an untyped value
- group.sites[].contentTypes[].baseTypes: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].columnLinks: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].columnPositions: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].columns: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- group.sites[].contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- group.sites[].contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- group.sites[].contentTypes[].order: polymorphic schema; accepts an untyped value
- group.sites[].drive: polymorphic schema; accepts an untyped value
- group.sites[].drives[].bundles: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].drives[].following: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].drives[].parentReference: polymorphic schema; accepts an untyped value
- group.sites[].drives[].sharePointIds: polymorphic schema; accepts an untyped value
- group.sites[].error: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].boolean: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].calculated: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].choice: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].currency: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].dateTime: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].defaultValue: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].lookup: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].number: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].personOrGroup: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].sourceColumn: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].term: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].text: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].validation: polymorphic schema; accepts an untyped value
- group.sites[].items[].parentReference: polymorphic schema; accepts an untyped value
- group.sites[].lists[].columns: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].drive: polymorphic schema; accepts an untyped value
- group.sites[].lists[].items: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].list: polymorphic schema; accepts an untyped value
- group.sites[].lists[].operations: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].parentReference: polymorphic schema; accepts an untyped value
- group.sites[].lists[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].onenote: polymorphic schema; accepts an untyped value
- group.sites[].operations[].error: polymorphic schema; accepts an untyped value
- group.sites[].operations[].status: polymorphic schema; accepts an untyped value
- group.sites[].pages[].pageLayout: polymorphic schema; accepts an untyped value
- group.sites[].pages[].parentReference: polymorphic schema; accepts an untyped value
- group.sites[].pages[].publishingState: polymorphic schema; accepts an untyped value
- group.sites[].parentReference: polymorphic schema; accepts an untyped value
- group.sites[].sites[]: recursive schema; accepts an untyped value
- group.sites[].termStore: polymorphic schema; accepts an untyped value
- group.sites[].termStores[].groups: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].termStores[].languageTags: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].termStores[].sets: nested schema exceeds depth limit; accepts an untyped value
- group.team: polymorphic schema; accepts an untyped value
- group.threads[].ccRecipients[].emailAddress: polymorphic schema; accepts an untyped value
- group.threads[].posts[].body: polymorphic schema; accepts an untyped value
- group.threads[].posts[].categories: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].from: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].newParticipants: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].sender: polymorphic schema; accepts an untyped value
- group.threads[].toRecipients[].emailAddress: polymorphic schema; accepts an untyped value
- holdStatus: polymorphic schema; accepts an untyped value
- includedSources: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
