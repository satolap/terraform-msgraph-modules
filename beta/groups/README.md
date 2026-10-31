# /groups

Create group

[Catalog](../README.md) Â· [Groups](../README.md#groups) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups`, `GET/PATCH/DELETE /groups/{group-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/groups"
  version = "<version>"

  displayName = "example"
  mailEnabled = false
  mailNickname = "example"
  securityEnabled = false
}
```

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Replacement on change

Microsoft Graph accepts the inputs below only when it creates the object (the generation notes cite the reviewed source; the Core.Immutable annotation of the pinned metadata marks some of them). A change to one, set as a typed input or as the same key in `additional_properties`, plans a destroy and a create of `msgraph_resource.this` through `terraform_data.immutable` and `replace_triggered_by`, so Graph never receives a changed create-only value in an update and `terraform apply -replace` is not needed. Every other input and every other key of `additional_properties` updates the object in place. Terraform deletes the old object before it creates the new one (`create_before_destroy` is not set). The replacement has a new `id`, and anything that stored the old `id` must read the new one. `terraform_data.immutable` holds the values below and makes no API call.

| Input | Graph property |
| --- | --- |
| `isAssignableToRole` | `isAssignableToRole` |

Graph applies a default when one of these inputs is omitted, so unset and the default are the same value: changing between them keeps the object, and the default is not sent in the request. `isAssignableToRole` defaults to `false`. Changing to any other value, or back to unset from one, replaces the object.

Because the old object is deleted before Graph sees the new one, lifecycle preconditions on the merged request body reject combinations that Microsoft Learn documents as invalid, so the plan fails before the destroy:
- A role-assignable group must have visibility Private or leave it unset; Microsoft Graph refuses the replacement after the old group is deleted.
- A role-assignable group must have security_enabled = true.
- A role-assignable group cannot have dynamic membership.

Terraform plans a replacement only when `terraform_data.immutable` is updated or replaced, not when it is created. After an upgrade from a release that lacked it, or after an import, apply once with unchanged inputs; a change to one of these inputs made in the apply that creates it still updates the object in place. The replacement behavior is covered by mocked tests only, not by a live tenant.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `assignedLabels`, `disableNesting`, `onPremisesExtensionAttributes`, `welcomeMessageEnabled`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `displayName` | `displayName` | `string` | yes | no | in place |
| `mailEnabled` | `mailEnabled` | `bool` | yes | no | in place |
| `mailNickname` | `mailNickname` | `string` | yes | no | in place |
| `securityEnabled` | `securityEnabled` | `bool` | yes | no | in place |
| `acceptedSenders` | `acceptedSenders` | `any` | no | no | in place |
| `appRoleAssignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no | in place |
| `assignedLabels` | `assignedLabels` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     }))` | no | no | in place |
| `classification` | `classification` | `string` | no | no | in place |
| `cloudLicensing` | `cloudLicensing` | `object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(list(string))     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")       allotments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.allotment")       assignableTo = optional(string)       assignments = optional(any)       externalServiceIdentifier = optional(string)       subscriptions = optional(any)       waitingMembers = optional(any)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(any)     })))       externalServiceIdentifier = optional(string)     })))     })` | no | no | in place |
| `conversations` | `conversations` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no | in place |
| `deletedDateTime` | `deletedDateTime` | `string` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `disableNesting` | `disableNesting` | `bool` | no | no | in place |
| `events` | `events` | `list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       type = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     }))` | no | no | in place |
| `groupTypes` | `groupTypes` | `list(string)` | no | no | in place |
| `hasMembersWithLicenseErrors` | `hasMembersWithLicenseErrors` | `bool` | no | no | in place |
| `infoCatalogs` | `infoCatalogs` | `list(string)` | no | no | in place |
| `isAssignableToRole` | `isAssignableToRole` | `bool` | no | no | replaces object |
| `members` | `members` | `any` | no | no | in place |
| `membershipRule` | `membershipRule` | `string` | no | no | in place |
| `membershipRuleProcessingState` | `membershipRuleProcessingState` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `onPremisesExtensionAttributes` | `onPremisesExtensionAttributes` | `object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     })` | no | no | in place |
| `onPremisesProvisioningErrors` | `onPremisesProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     }))` | no | no | in place |
| `onPremisesSyncBehavior` | `onPremisesSyncBehavior` | `any` | no | no | in place |
| `onenote` | `onenote` | `any` | no | no | in place |
| `organizationId` | `organizationId` | `string` | no | no | in place |
| `owners` | `owners` | `any` | no | no | in place |
| `permissionGrants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no | in place |
| `photo` | `photo` | `any` | no | no | in place |
| `preferredDataLocation` | `preferredDataLocation` | `string` | no | no | in place |
| `preferredLanguage` | `preferredLanguage` | `string` | no | no | in place |
| `rejectedSenders` | `rejectedSenders` | `any` | no | no | in place |
| `resourceBehaviorOptions` | `resourceBehaviorOptions` | `list(string)` | no | no | in place |
| `resourceProvisioningOptions` | `resourceProvisioningOptions` | `list(string)` | no | no | in place |
| `serviceProvisioningErrors` | `serviceProvisioningErrors` | `any` | no | no | in place |
| `settings` | `settings` | `list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingValue")       name = optional(string)       value = optional(string)     })))     }))` | no | no | in place |
| `sites` | `sites` | `list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(string)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSet")       allowedContentTypes = optional(any)       defaultContents = optional(any)       propagateWelcomePageChanges = optional(bool)       sharedColumns = optional(any)       shouldPrefixNameToFile = optional(bool)       welcomePageColumns = optional(any)       welcomePageUrl = optional(string)     }))       documentTemplate = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSetContent")       contentType = optional(any)       fileName = optional(string)       folderName = optional(string)     }))       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       isBuiltIn = optional(bool)       name = optional(string)       order = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeOrder")       default = optional(bool)       position = optional(number)     }))       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(string)       listItemUniqueId = optional(string)       status = optional(string)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(any)       bundles = optional(any)       createdByUser = optional(any)       description = optional(string)       following = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       sharePointIds = optional(object({       odata_type = optional(string, "#microsoft.graph.sharepointIds")       listId = optional(string)       listItemId = optional(string)       listItemUniqueId = optional(string)       siteId = optional(string)       siteUrl = optional(string)       tenantId = optional(string)       webId = optional(string)     }))     })))       extensions = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(any)       columns = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       lastModifiedByUser = optional(any)       list = optional(object({       odata_type = optional(string, "#microsoft.graph.listInfo")       contentTypesEnabled = optional(bool)       hidden = optional(bool)       template = optional(string)     }))       name = optional(string)       operations = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       subscriptions = optional(any)     })))       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(any)       message = optional(string)       target = optional(string)     }))       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       publishingState = optional(object({       odata_type = optional(string, "#microsoft.graph.publicationFacet")       checkedOutBy = optional(any)     }))       title = optional(string)       titleArea = optional(object({       odata_type = optional(string, "#microsoft.graph.titleArea")       alternativeText = optional(string)       enableGradientEffect = optional(bool)       imageWebUrl = optional(string)       layout = optional(string)       serverProcessedContent = optional(any)       showAuthor = optional(bool)       showPublishedDate = optional(bool)       showTextBlockAboveTitle = optional(bool)       textAboveTitle = optional(string)       textAlignment = optional(string)     }))       webParts = optional(any)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     }))` | no | no | in place |
| `team` | `team` | `any` | no | no | in place |
| `theme` | `theme` | `string` | no | no | in place |
| `threads` | `threads` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       categories = optional(list(string))       createdDateTime = optional(string)       from = optional(any)       hasAttachments = optional(bool)       importance = optional(string)       lastModifiedDateTime = optional(string)       mentions = optional(any)       newParticipants = optional(any)       receivedDateTime = optional(string)       sender = optional(any)     })))       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no | in place |
| `transitiveMemberOf` | `transitiveMemberOf` | `any` | no | no | in place |
| `transitiveMembers` | `transitiveMembers` | `any` | no | no | in place |
| `visibility` | `visibility` | `string` | no | no | in place |
| `welcomeMessageEnabled` | `welcomeMessageEnabled` | `bool` | no | no | in place |
| `writebackConfiguration` | `writebackConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     })` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | replaces object for keys `isAssignableToRole` |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `mailNickname` within the tenant, among Microsoft 365 groups. Graph refuses a value already used in that scope, or, where the rule is a combination, only the same combination; some of these values, such as identity provider claims, are dictated by another system rather than chosen freely.

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `accessType`, `allowExternalSenders`, `assignedLicenses`, `autoSubscribeNewMembers`, `calendar`, `calendarView`, `createdByAppId`, `createdDateTime`, `createdOnBehalfOf`, `drive`, `drives`, `endpoints`, `expirationDateTime`, `extensions`, `groupLifecyclePolicies`, `hideFromAddressLists`, `hideFromOutlookClients`, `id`, `isArchived`, `isFavorite`, `isManagementRestricted`, `isSubscribedByMail`, `licenseProcessingState`, `mail`, `memberOf`, `membersWithLicenseErrors`, `membershipRuleProcessingStatus`, `onPremisesDomainName`, `onPremisesLastSyncDateTime`, `onPremisesNetBiosName`, `onPremisesSamAccountName`, `onPremisesSecurityIdentifier`, `onPremisesSyncEnabled`, `photos`, `planner`, `proxyAddresses`, `renewedDateTime`, `securityIdentifier`, `uniqueName`, `unseenConversationsCount`, `unseenCount`, `unseenMessagesCount`.

Unique server-assigned values: `uniqueName` within `/groups`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /groups` | DelegatedWork | `Group.ReadWrite.All` | — |
| `POST /groups` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /groups` | Application | `Group.Create` | — |
| `GET /groups/{group-id}` | DelegatedWork | `Group-NestingSupport.ReadWrite.All` | — |
| `GET /groups/{group-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /groups/{group-id}` | Application | `Group-NestingSupport.ReadWrite.All` | — |
| `PATCH /groups/{group-id}` | DelegatedWork | `Group-NestingSupport.ReadWrite.All` | — |
| `PATCH /groups/{group-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /groups/{group-id}` | Application | `Group-NestingSupport.ReadWrite.All` | — |
| `DELETE /groups/{group-id}` | DelegatedWork | `Group.ReadWrite.All` | — |
| `DELETE /groups/{group-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /groups/{group-id}` | Application | `Group.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- A replacement deletes the old group before it creates the new one: members and owners that were added outside this module are lost, and the new group has a new id. Microsoft Learn does not say whether a deleted group keeps its mailNickname while it can be restored (30 days), so creating the replacement can be refused for a Microsoft 365 group until the old one is permanently deleted or another mailNickname is chosen.
- Graph applies these defaults when a create-only input is omitted, so unset and the default are one value and the default is not sent: isAssignableToRole = false (https://learn.microsoft.com/en-us/graph/api/group-post-groups).
- Microsoft Graph beta contracts can change without notice.
- Reviewed create-only inputs: isAssignableToRole (https://learn.microsoft.com/en-us/graph/api/resources/group); a change to one replaces the object and every other input updates in place.
- Reviewed create-required correction: displayName, mailEnabled, mailNickname, securityEnabled.
- Reviewed writable correction: disableNesting. Writable for security groups with isAssignableToRole set to false; read-only for Microsoft 365 groups and role-assignable groups. Writing it needs Group-NestingSupport.ReadWrite.All. See https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-beta.
- acceptedSenders[]: polymorphic schema; accepts an untyped value
- cloudLicensing.assignments[].allotment: navigation property; accepts an untyped value
- cloudLicensing.assignments[].assignedTo: polymorphic schema; accepts an untyped value
- cloudLicensing.usageRights[].allotments[].assignments: nested schema exceeds depth limit; accepts an untyped value
- cloudLicensing.usageRights[].allotments[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- cloudLicensing.usageRights[].allotments[].waitingMembers: nested schema exceeds depth limit; accepts an untyped value
- cloudLicensing.usageRights[].assignments[].allotment: navigation property; accepts an untyped value
- cloudLicensing.usageRights[].assignments[].assignedTo: nested schema exceeds depth limit; accepts an untyped value
- cloudLicensing.usageRights[].assignments[].disabledServicePlanIds: nested schema exceeds depth limit; accepts an untyped value
- events[].attendees[].emailAddress: polymorphic schema; accepts an untyped value
- events[].attendees[].proposedNewTime: polymorphic schema; accepts an untyped value
- events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- events[].extensions[]: polymorphic schema; accepts an untyped value
- events[].location: polymorphic schema; accepts an untyped value
- events[].locations[]: polymorphic schema; accepts an untyped value
- events[].organizer: polymorphic schema; accepts an untyped value
- members[]: polymorphic schema; accepts an untyped value
- onPremisesSyncBehavior: navigation property; accepts an untyped value
- onenote: navigation property; accepts an untyped value
- owners[]: polymorphic schema; accepts an untyped value
- photo: navigation property; accepts an untyped value
- rejectedSenders[]: polymorphic schema; accepts an untyped value
- serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- sites[].analytics: navigation property; accepts an untyped value
- sites[].columns[].boolean: polymorphic schema; accepts an untyped value
- sites[].columns[].choice.choices: nested schema exceeds depth limit; accepts an untyped value
- sites[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- sites[].columns[].geolocation: polymorphic schema; accepts an untyped value
- sites[].columns[].number.maximum: polymorphic schema; accepts an untyped value
- sites[].columns[].number.minimum: polymorphic schema; accepts an untyped value
- sites[].columns[].sourceColumn: navigation property; accepts an untyped value
- sites[].columns[].term.parentTerm: navigation property; accepts an untyped value
- sites[].columns[].term.termSet: navigation property; accepts an untyped value
- sites[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- sites[].columns[].validation.descriptions: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].base: navigation property; accepts an untyped value
- sites[].contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- sites[].contentTypes[].columnLinks[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].columnPositions[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].documentSet.allowedContentTypes: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].documentSet.defaultContents: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].documentSet.sharedColumns: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].documentSet.welcomePageColumns: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].documentTemplate.contentType: nested schema exceeds depth limit; accepts an untyped value
- sites[].createdByUser: polymorphic schema; accepts an untyped value
- sites[].drive: navigation property; accepts an untyped value
- sites[].drives[].activities[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].drives[].bundles[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].drives[].createdByUser: polymorphic schema; accepts an untyped value
- sites[].drives[].following[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].drives[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- sites[].extensions[]: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].boolean: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].choice.choices: nested schema exceeds depth limit; accepts an untyped value
- sites[].externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].number.maximum: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].number.minimum: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].sourceColumn: navigation property; accepts an untyped value
- sites[].externalColumns[].term.parentTerm: navigation property; accepts an untyped value
- sites[].externalColumns[].term.termSet: navigation property; accepts an untyped value
- sites[].externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].validation.descriptions: nested schema exceeds depth limit; accepts an untyped value
- sites[].informationProtection: navigation property; accepts an untyped value
- sites[].items[]: polymorphic schema; accepts an untyped value
- sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- sites[].lists[].activities[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].createdByUser: polymorphic schema; accepts an untyped value
- sites[].lists[].drive: navigation property; accepts an untyped value
- sites[].lists[].items[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- sites[].lists[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].subscriptions[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].onenote: navigation property; accepts an untyped value
- sites[].operations[].error.details: nested schema exceeds depth limit; accepts an untyped value
- sites[].operations[].error.innerError: nested schema exceeds depth limit; accepts an untyped value
- sites[].pageTemplates[].canvasLayout: navigation property; accepts an untyped value
- sites[].pageTemplates[].createdByUser: polymorphic schema; accepts an untyped value
- sites[].pageTemplates[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- sites[].pageTemplates[].pageLayout: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: newsLink, videoNewsLink; excluded from typed input validation
- sites[].pageTemplates[].publishingState.checkedOutBy: polymorphic schema; accepts an untyped value
- sites[].pageTemplates[].titleArea.serverProcessedContent: nested schema exceeds depth limit; accepts an untyped value
- sites[].pageTemplates[].webParts[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].pages[]: polymorphic schema; accepts an untyped value
- sites[].recycleBin: navigation property; accepts an untyped value
- sites[].sites[]: recursive schema; accepts an untyped value
- sites[].termStore: navigation property; accepts an untyped value
- team: navigation property; accepts an untyped value
- threads[].ccRecipients[]: polymorphic schema; accepts an untyped value
- threads[].posts[].from: polymorphic schema; accepts an untyped value
- threads[].posts[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- threads[].posts[].newParticipants[]: nested schema exceeds depth limit; accepts an untyped value
- threads[].posts[].sender: polymorphic schema; accepts an untyped value
- threads[].toRecipients[]: polymorphic schema; accepts an untyped value
- transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- transitiveMembers[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent verified module `verified/groups` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. Its apply runs also check which input changes update the object in place and which replace it. It does not verify permissions or server behavior.
