# /groups

Create group

[Catalog](../../README.md) · [Groups](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups`, `GET/PATCH/DELETE /groups/{group-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./groups/groups"
  display_name = "example"
  mail_enabled = false
  mail_nickname = "example"
  security_enabled = false
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | yes | no |
| `mail_enabled` | `mailEnabled` | `bool` | yes | no |
| `mail_nickname` | `mailNickname` | `string` | yes | no |
| `security_enabled` | `securityEnabled` | `bool` | yes | no |
| `accepted_senders` | `acceptedSenders` | `any` | no | no |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `assigned_labels` | `assignedLabels` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     }))` | no | no |
| `classification` | `classification` | `string` | no | no |
| `cloud_licensing` | `cloudLicensing` | `object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(list(string))     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")       allotments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.allotment")       assignableTo = optional(string)       assignments = optional(any)       externalServiceIdentifier = optional(string)       subscriptions = optional(any)       waitingMembers = optional(any)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(any)     })))       externalServiceIdentifier = optional(string)     })))     })` | no | no |
| `conversations` | `conversations` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `events` | `events` | `list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       type = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     }))` | no | no |
| `group_types` | `groupTypes` | `list(string)` | no | no |
| `has_members_with_license_errors` | `hasMembersWithLicenseErrors` | `bool` | no | no |
| `info_catalogs` | `infoCatalogs` | `list(string)` | no | no |
| `is_assignable_to_role` | `isAssignableToRole` | `bool` | no | no |
| `members` | `members` | `any` | no | no |
| `membership_rule` | `membershipRule` | `string` | no | no |
| `membership_rule_processing_state` | `membershipRuleProcessingState` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `on_premises_extension_attributes` | `onPremisesExtensionAttributes` | `object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     })` | no | no |
| `on_premises_provisioning_errors` | `onPremisesProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     }))` | no | no |
| `on_premises_sync_behavior` | `onPremisesSyncBehavior` | `any` | no | no |
| `onenote` | `onenote` | `any` | no | no |
| `organization_id` | `organizationId` | `string` | no | no |
| `owners` | `owners` | `any` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `photo` | `photo` | `any` | no | no |
| `preferred_data_location` | `preferredDataLocation` | `string` | no | no |
| `preferred_language` | `preferredLanguage` | `string` | no | no |
| `rejected_senders` | `rejectedSenders` | `any` | no | no |
| `resource_behavior_options` | `resourceBehaviorOptions` | `list(string)` | no | no |
| `resource_provisioning_options` | `resourceProvisioningOptions` | `list(string)` | no | no |
| `service_provisioning_errors` | `serviceProvisioningErrors` | `any` | no | no |
| `settings` | `settings` | `list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingValue")       name = optional(string)       value = optional(string)     })))     }))` | no | no |
| `sites` | `sites` | `list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(string)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSet")       allowedContentTypes = optional(any)       defaultContents = optional(any)       propagateWelcomePageChanges = optional(bool)       sharedColumns = optional(any)       shouldPrefixNameToFile = optional(bool)       welcomePageColumns = optional(any)       welcomePageUrl = optional(string)     }))       documentTemplate = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSetContent")       contentType = optional(any)       fileName = optional(string)       folderName = optional(string)     }))       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       isBuiltIn = optional(bool)       name = optional(string)       order = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeOrder")       default = optional(bool)       position = optional(number)     }))       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(string)       listItemUniqueId = optional(string)       status = optional(string)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(any)       bundles = optional(any)       createdByUser = optional(any)       description = optional(string)       following = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       sharePointIds = optional(object({       odata_type = optional(string, "#microsoft.graph.sharepointIds")       listId = optional(string)       listItemId = optional(string)       listItemUniqueId = optional(string)       siteId = optional(string)       siteUrl = optional(string)       tenantId = optional(string)       webId = optional(string)     }))     })))       extensions = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(any)       columns = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       lastModifiedByUser = optional(any)       list = optional(object({       odata_type = optional(string, "#microsoft.graph.listInfo")       contentTypesEnabled = optional(bool)       hidden = optional(bool)       template = optional(string)     }))       name = optional(string)       operations = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       subscriptions = optional(any)     })))       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(any)       message = optional(string)       target = optional(string)     }))       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       publishingState = optional(object({       odata_type = optional(string, "#microsoft.graph.publicationFacet")       checkedOutBy = optional(any)     }))       title = optional(string)       titleArea = optional(object({       odata_type = optional(string, "#microsoft.graph.titleArea")       alternativeText = optional(string)       enableGradientEffect = optional(bool)       imageWebUrl = optional(string)       layout = optional(string)       serverProcessedContent = optional(any)       showAuthor = optional(bool)       showPublishedDate = optional(bool)       showTextBlockAboveTitle = optional(bool)       textAboveTitle = optional(string)       textAlignment = optional(string)     }))       webParts = optional(any)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     }))` | no | no |
| `team` | `team` | `any` | no | no |
| `theme` | `theme` | `string` | no | no |
| `threads` | `threads` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       categories = optional(list(string))       createdDateTime = optional(string)       from = optional(any)       hasAttachments = optional(bool)       importance = optional(string)       lastModifiedDateTime = optional(string)       mentions = optional(any)       newParticipants = optional(any)       receivedDateTime = optional(string)       sender = optional(any)     })))       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no |
| `transitive_member_of` | `transitiveMemberOf` | `any` | no | no |
| `transitive_members` | `transitiveMembers` | `any` | no | no |
| `visibility` | `visibility` | `string` | no | no |
| `welcome_message_enabled` | `welcomeMessageEnabled` | `bool` | no | no |
| `writeback_configuration` | `writebackConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- Reviewed create-required correction: displayName, mailEnabled, mailNickname, securityEnabled.
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

Baseline rules reviewed on 2026-09-18 for the equivalent curated module `curated/groups` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
