# /compliance/ediscovery/cases/{case-id}/legalHolds/{legalHold-id}/unifiedGroupSources

Create new navigation property to unifiedGroupSources for compliance

[Catalog](../../../../../../../../README.md) · [Compliance](../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/complianceapioverview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /compliance/ediscovery/cases/{case-id}/legalHolds/{legalHold-id}/unifiedGroupSources`, `GET/PATCH/DELETE /compliance/ediscovery/cases/{case-id}/legalHolds/{legalHold-id}/unifiedGroupSources/{unifiedGroupSource-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./compliance/compliance/ediscovery/cases/by-case-id/legal-holds/by-legal-hold-id/unified-group-sources"
  case_id = "parent-object-id"
  legal_hold_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `case_id` | URL parameter `case-id` | `string` | yes | no |
| `legal_hold_id` | URL parameter `legalHold-id` | `string` | yes | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `group` | `group` | `object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(list(string))     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")       allotments = optional(any)       assignments = optional(any)       externalServiceIdentifier = optional(string)     })))     }))       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(any)       type = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(any)       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingValue")       name = optional(string)       value = optional(string)     })))     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(string)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(string)       listItemUniqueId = optional(string)       status = optional(string)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(any)       bundles = optional(any)       createdByUser = optional(any)       description = optional(string)       following = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       extensions = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(any)       columns = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       lastModifiedByUser = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(string)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)       titleArea = optional(any)       webParts = optional(any)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(any)       categories = optional(any)       createdDateTime = optional(string)       from = optional(any)       hasAttachments = optional(bool)       importance = optional(string)       lastModifiedDateTime = optional(string)       mentions = optional(any)       newParticipants = optional(any)       receivedDateTime = optional(string)       sender = optional(any)     })))       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     }))     })` | no | no |
| `hold_status` | `holdStatus` | `string` | no | no |
| `included_sources` | `includedSources` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
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
- group.acceptedSenders[]: polymorphic schema; accepts an untyped value
- group.cloudLicensing.assignments[].allotment: navigation property; accepts an untyped value
- group.cloudLicensing.assignments[].assignedTo: polymorphic schema; accepts an untyped value
- group.cloudLicensing.usageRights[].allotments[]: nested schema exceeds depth limit; accepts an untyped value
- group.cloudLicensing.usageRights[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- group.events[].attendees[].emailAddress: polymorphic schema; accepts an untyped value
- group.events[].attendees[].proposedNewTime: polymorphic schema; accepts an untyped value
- group.events[].attendees[].status: nested schema exceeds depth limit; accepts an untyped value
- group.events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- group.events[].extensions[]: polymorphic schema; accepts an untyped value
- group.events[].location: polymorphic schema; accepts an untyped value
- group.events[].locations[]: polymorphic schema; accepts an untyped value
- group.events[].organizer: polymorphic schema; accepts an untyped value
- group.events[].recurrence.pattern.daysOfWeek: nested schema exceeds depth limit; accepts an untyped value
- group.members[]: polymorphic schema; accepts an untyped value
- group.onPremisesSyncBehavior: navigation property; accepts an untyped value
- group.onenote: navigation property; accepts an untyped value
- group.owners[]: polymorphic schema; accepts an untyped value
- group.photo: navigation property; accepts an untyped value
- group.rejectedSenders[]: polymorphic schema; accepts an untyped value
- group.serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- group.sites[].analytics: navigation property; accepts an untyped value
- group.sites[].columns[].boolean: polymorphic schema; accepts an untyped value
- group.sites[].columns[].calculated: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].choice: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- group.sites[].columns[].currency: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].dateTime: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].defaultValue: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].geolocation: polymorphic schema; accepts an untyped value
- group.sites[].columns[].hyperlinkOrPicture: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].lookup: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].number: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].personOrGroup: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].sourceColumn: navigation property; accepts an untyped value
- group.sites[].columns[].sourceContentType: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].term: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].text: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- group.sites[].columns[].validation: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].associatedHubsUrls: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].base: navigation property; accepts an untyped value
- group.sites[].contentTypes[].baseTypes: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].columnLinks: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].columnPositions: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].columns: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].documentSet: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].documentTemplate: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].inheritedFrom: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].contentTypes[].order: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].createdByUser: polymorphic schema; accepts an untyped value
- group.sites[].drive: navigation property; accepts an untyped value
- group.sites[].drives[].activities: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].drives[].bundles: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].drives[].createdByUser: polymorphic schema; accepts an untyped value
- group.sites[].drives[].following: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].drives[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- group.sites[].drives[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].drives[].sharePointIds: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].extensions[]: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].boolean: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].calculated: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].choice: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].currency: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].dateTime: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].defaultValue: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].hyperlinkOrPicture: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].lookup: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].number: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].personOrGroup: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].sourceColumn: navigation property; accepts an untyped value
- group.sites[].externalColumns[].sourceContentType: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].term: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].text: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- group.sites[].externalColumns[].validation: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].informationProtection: navigation property; accepts an untyped value
- group.sites[].items[]: polymorphic schema; accepts an untyped value
- group.sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- group.sites[].lists[].activities: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].columns: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].createdByUser: polymorphic schema; accepts an untyped value
- group.sites[].lists[].drive: navigation property; accepts an untyped value
- group.sites[].lists[].items: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- group.sites[].lists[].list: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].operations: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].lists[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].onenote: navigation property; accepts an untyped value
- group.sites[].operations[].error: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].pageTemplates[].canvasLayout: navigation property; accepts an untyped value
- group.sites[].pageTemplates[].createdByUser: polymorphic schema; accepts an untyped value
- group.sites[].pageTemplates[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- group.sites[].pageTemplates[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].pageTemplates[].publishingState: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].pageTemplates[].titleArea: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].pageTemplates[].webParts: nested schema exceeds depth limit; accepts an untyped value
- group.sites[].pages[]: polymorphic schema; accepts an untyped value
- group.sites[].recycleBin: navigation property; accepts an untyped value
- group.sites[].sites[]: recursive schema; accepts an untyped value
- group.sites[].termStore: navigation property; accepts an untyped value
- group.team: navigation property; accepts an untyped value
- group.threads[].ccRecipients[]: polymorphic schema; accepts an untyped value
- group.threads[].posts[].body: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].categories: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].from: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].mentions: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].newParticipants: nested schema exceeds depth limit; accepts an untyped value
- group.threads[].posts[].sender: polymorphic schema; accepts an untyped value
- group.threads[].toRecipients[]: polymorphic schema; accepts an untyped value
- group.transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- group.transitiveMembers[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
