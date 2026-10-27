# /groups

Create group

[Catalog](../README.md) Â· [Groups](../README.md#groups) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups`, `GET/PATCH/DELETE /groups/{group-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/groups"
  version = "<version>"

  display_name = "example"
  mail_enabled = false
  mail_nickname = "example"
  security_enabled = false
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Replacement on change

Microsoft Graph accepts the inputs below only when it creates the object (the generation notes cite the reviewed source; the Core.Immutable annotation of the pinned metadata marks some of them). A change to one, set as a typed input or as the same key in `additional_properties`, plans a destroy and a create of `msgraph_resource.this` through `terraform_data.immutable` and `replace_triggered_by`, so Graph never receives a changed create-only value in an update and `terraform apply -replace` is not needed. Every other input and every other key of `additional_properties` updates the object in place. Terraform deletes the old object before it creates the new one (`create_before_destroy` is not set). The replacement has a new `id`, and anything that stored the old `id` must read the new one. `terraform_data.immutable` holds the values below and makes no API call.

| Input | Graph property |
| --- | --- |
| `is_assignable_to_role` | `isAssignableToRole` |

Graph applies a default when one of these inputs is omitted, so unset and the default are the same value: changing between them keeps the object, and the default is not sent in the request. `is_assignable_to_role` defaults to `false`. Changing to any other value, or back to unset from one, replaces the object.

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

Select-only inputs: `assignedLabels`, `onPremisesExtensionAttributes`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | yes | no | in place |
| `mail_enabled` | `mailEnabled` | `bool` | yes | no | in place |
| `mail_nickname` | `mailNickname` | `string` | yes | no | in place |
| `security_enabled` | `securityEnabled` | `bool` | yes | no | in place |
| `accepted_senders` | `acceptedSenders` | `any` | no | no | in place |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no | in place |
| `assigned_labels` | `assignedLabels` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     }))` | no | no | in place |
| `classification` | `classification` | `string` | no | no | in place |
| `conversations` | `conversations` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no | in place |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `events` | `events` | `list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     }))       proposedNewTime = optional(object({       odata_type = optional(string, "#microsoft.graph.timeSlot")       end = optional(any)       start = optional(any)     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       type = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     }))` | no | no | in place |
| `group_types` | `groupTypes` | `list(string)` | no | no | in place |
| `has_members_with_license_errors` | `hasMembersWithLicenseErrors` | `bool` | no | no | in place |
| `info_catalogs` | `infoCatalogs` | `list(string)` | no | no | in place |
| `is_assignable_to_role` | `isAssignableToRole` | `bool` | no | no | replaces object |
| `members` | `members` | `any` | no | no | in place |
| `membership_rule` | `membershipRule` | `string` | no | no | in place |
| `membership_rule_processing_state` | `membershipRuleProcessingState` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `on_premises_extension_attributes` | `onPremisesExtensionAttributes` | `object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     })` | no | no | in place |
| `on_premises_provisioning_errors` | `onPremisesProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     }))` | no | no | in place |
| `on_premises_sync_behavior` | `onPremisesSyncBehavior` | `any` | no | no | in place |
| `onenote` | `onenote` | `any` | no | no | in place |
| `organization_id` | `organizationId` | `string` | no | no | in place |
| `owners` | `owners` | `any` | no | no | in place |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no | in place |
| `photo` | `photo` | `any` | no | no | in place |
| `planner` | `planner` | `any` | no | no | in place |
| `preferred_data_location` | `preferredDataLocation` | `string` | no | no | in place |
| `preferred_language` | `preferredLanguage` | `string` | no | no | in place |
| `rejected_senders` | `rejectedSenders` | `any` | no | no | in place |
| `resource_behavior_options` | `resourceBehaviorOptions` | `list(string)` | no | no | in place |
| `resource_provisioning_options` | `resourceProvisioningOptions` | `list(string)` | no | no | in place |
| `service_provisioning_errors` | `serviceProvisioningErrors` | `any` | no | no | in place |
| `settings` | `settings` | `list(object({       odata_type = optional(string, "#microsoft.graph.groupSetting")       displayName = optional(string)       values = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingValue")       name = optional(string)       value = optional(string)     })))     }))` | no | no | in place |
| `sites` | `sites` | `list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSet")       allowedContentTypes = optional(any)       defaultContents = optional(any)       propagateWelcomePageChanges = optional(bool)       sharedColumns = optional(any)       shouldPrefixNameToFile = optional(bool)       welcomePageColumns = optional(any)       welcomePageUrl = optional(string)     }))       documentTemplate = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSetContent")       contentType = optional(any)       fileName = optional(string)       folderName = optional(string)     }))       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       isBuiltIn = optional(bool)       name = optional(string)       order = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeOrder")       default = optional(bool)       position = optional(number)     }))       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       description = optional(string)       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       bundles = optional(any)       description = optional(string)       following = optional(any)       name = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       sharePointIds = optional(object({       odata_type = optional(string, "#microsoft.graph.sharepointIds")       listId = optional(string)       listItemId = optional(string)       listItemUniqueId = optional(string)       siteId = optional(string)       siteUrl = optional(string)       tenantId = optional(string)       webId = optional(string)     }))     })))       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(list(object({       odata_type = optional(string, "#microsoft.graph.publicErrorDetail")       code = optional(string)       message = optional(string)       target = optional(string)     })))       innerError = optional(object({       odata_type = optional(string, "#microsoft.graph.publicInnerError")       code = optional(string)       details = optional(any)       message = optional(string)       target = optional(string)     }))       message = optional(string)       target = optional(string)     }))       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       items = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       list = optional(object({       odata_type = optional(string, "#microsoft.graph.listInfo")       contentTypesEnabled = optional(bool)       hidden = optional(bool)       template = optional(string)     }))       name = optional(string)       operations = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       subscriptions = optional(any)     })))       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(any)       message = optional(string)       target = optional(string)     }))       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       sites = optional(any)       termStore = optional(any)       termStores = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.store")       defaultLanguageTag = optional(string)       groups = optional(any)       languageTags = optional(list(string))       sets = optional(any)     })))     }))` | no | no | in place |
| `team` | `team` | `any` | no | no | in place |
| `theme` | `theme` | `string` | no | no | in place |
| `threads` | `threads` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       categories = optional(list(string))       createdDateTime = optional(string)       from = optional(any)       hasAttachments = optional(bool)       lastModifiedDateTime = optional(string)       newParticipants = optional(any)       receivedDateTime = optional(string)       sender = optional(any)     })))       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no | in place |
| `transitive_member_of` | `transitiveMemberOf` | `any` | no | no | in place |
| `transitive_members` | `transitiveMembers` | `any` | no | no | in place |
| `visibility` | `visibility` | `string` | no | no | in place |
| `welcome_message_enabled` | `welcomeMessageEnabled` | `bool` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | replaces object for keys `isAssignableToRole` |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `mail_nickname` within the tenant, among Microsoft 365 groups. Graph refuses a value already used in that scope, or, where the rule is a combination, only the same combination; some of these values, such as identity provider claims, are dictated by another system rather than chosen freely.

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `accessType`, `allowExternalSenders`, `assignedLicenses`, `autoSubscribeNewMembers`, `calendar`, `calendarView`, `createdDateTime`, `createdOnBehalfOf`, `drive`, `drives`, `expirationDateTime`, `extensions`, `groupLifecyclePolicies`, `hideFromAddressLists`, `hideFromOutlookClients`, `id`, `isArchived`, `isFavorite`, `isManagementRestricted`, `isSubscribedByMail`, `licenseProcessingState`, `mail`, `memberOf`, `membersWithLicenseErrors`, `onPremisesDomainName`, `onPremisesLastSyncDateTime`, `onPremisesNetBiosName`, `onPremisesSamAccountName`, `onPremisesSecurityIdentifier`, `onPremisesSyncEnabled`, `photos`, `proxyAddresses`, `renewedDateTime`, `securityIdentifier`, `uniqueName`, `unseenConversationsCount`, `unseenCount`, `unseenMessagesCount`.

Unique server-assigned values: `uniqueName` within `/groups`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- A replacement deletes the old group before it creates the new one: members and owners that were added outside this module are lost, and the new group has a new id. Microsoft Learn does not say whether a deleted group keeps its mailNickname while it can be restored (30 days), so creating the replacement can be refused for a Microsoft 365 group until the old one is permanently deleted or another mailNickname is chosen.
- Graph applies these defaults when a create-only input is omitted, so unset and the default are one value and the default is not sent: isAssignableToRole = false (https://learn.microsoft.com/en-us/graph/api/group-post-groups).
- Reviewed create-only inputs: isAssignableToRole (https://learn.microsoft.com/en-us/graph/api/resources/group); a change to one replaces the object and every other input updates in place.
- Reviewed create-required correction: displayName, mailEnabled, mailNickname, securityEnabled.
- acceptedSenders[]: polymorphic schema; accepts an untyped value
- events[].attendees[].proposedNewTime.end: nested schema exceeds depth limit; accepts an untyped value
- events[].attendees[].proposedNewTime.start: nested schema exceeds depth limit; accepts an untyped value
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
- planner: navigation property; accepts an untyped value
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
- sites[].drive: navigation property; accepts an untyped value
- sites[].drives[].bundles[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].drives[].following[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].error.innerError.details[]: nested schema exceeds depth limit; accepts an untyped value
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
- sites[].items[]: polymorphic schema; accepts an untyped value
- sites[].lists[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].drive: navigation property; accepts an untyped value
- sites[].lists[].items[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].subscriptions[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].onenote: navigation property; accepts an untyped value
- sites[].operations[].error.details: nested schema exceeds depth limit; accepts an untyped value
- sites[].operations[].error.innerError: nested schema exceeds depth limit; accepts an untyped value
- sites[].pages[]: polymorphic schema; accepts an untyped value
- sites[].sites[]: recursive schema; accepts an untyped value
- sites[].termStore: navigation property; accepts an untyped value
- sites[].termStores[].groups[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].termStores[].sets[]: nested schema exceeds depth limit; accepts an untyped value
- team: navigation property; accepts an untyped value
- threads[].ccRecipients[]: polymorphic schema; accepts an untyped value
- threads[].posts[].from: polymorphic schema; accepts an untyped value
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
