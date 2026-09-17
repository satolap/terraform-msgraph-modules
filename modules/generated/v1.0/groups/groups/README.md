# /groups

Create group

[Catalog](../../README.md) · [Groups](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

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
| `accepted_senders` | `acceptedSenders` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `assigned_labels` | `assignedLabels` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     }))` | no | no |
| `classification` | `classification` | `string` | no | no |
| `conversations` | `conversations` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `events` | `events` | `list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(any)       type = optional(any)     })))       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.location")       address = optional(any)       coordinates = optional(any)       displayName = optional(string)       locationEmailAddress = optional(string)       locationUri = optional(string)       uniqueId = optional(string)       uniqueIdType = optional(any)     })))       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     }))` | no | no |
| `group_types` | `groupTypes` | `list(string)` | no | no |
| `has_members_with_license_errors` | `hasMembersWithLicenseErrors` | `bool` | no | no |
| `info_catalogs` | `infoCatalogs` | `list(string)` | no | no |
| `is_assignable_to_role` | `isAssignableToRole` | `bool` | no | no |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `membership_rule` | `membershipRule` | `string` | no | no |
| `membership_rule_processing_state` | `membershipRuleProcessingState` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `on_premises_extension_attributes` | `onPremisesExtensionAttributes` | `any` | no | no |
| `on_premises_provisioning_errors` | `onPremisesProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     }))` | no | no |
| `on_premises_sync_behavior` | `onPremisesSyncBehavior` | `any` | no | no |
| `onenote` | `onenote` | `any` | no | no |
| `organization_id` | `organizationId` | `string` | no | no |
| `owners` | `owners` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `photo` | `photo` | `any` | no | no |
| `planner` | `planner` | `any` | no | no |
| `preferred_data_location` | `preferredDataLocation` | `string` | no | no |
| `preferred_language` | `preferredLanguage` | `string` | no | no |
| `rejected_senders` | `rejectedSenders` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `resource_behavior_options` | `resourceBehaviorOptions` | `list(string)` | no | no |
| `resource_provisioning_options` | `resourceProvisioningOptions` | `list(string)` | no | no |
| `service_provisioning_errors` | `serviceProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     }))` | no | no |
| `settings` | `settings` | `list(object({       odata_type = optional(string, "#microsoft.graph.groupSetting")       displayName = optional(string)       values = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingValue")       name = optional(string)       value = optional(string)     })))     }))` | no | no |
| `sites` | `sites` | `list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       description = optional(string)       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       bundles = optional(any)       description = optional(string)       following = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       error = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseItem")       description = optional(string)       name = optional(string)       parentReference = optional(any)     })))       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       pages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseSitePage")       description = optional(string)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)     })))       parentReference = optional(any)       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       sites = optional(any)       termStore = optional(any)       termStores = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.store")       defaultLanguageTag = optional(string)       groups = optional(any)       languageTags = optional(list(string))       sets = optional(any)     })))     }))` | no | no |
| `team` | `team` | `any` | no | no |
| `theme` | `theme` | `string` | no | no |
| `threads` | `threads` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(any)       categories = optional(list(string))       createdDateTime = optional(string)       from = optional(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     }))       hasAttachments = optional(bool)       lastModifiedDateTime = optional(string)       newParticipants = optional(any)       receivedDateTime = optional(string)       sender = optional(any)     })))       preview = optional(string)       toRecipients = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       topic = optional(string)       uniqueSenders = optional(list(string))     }))` | no | no |
| `transitive_member_of` | `transitiveMemberOf` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `transitive_members` | `transitiveMembers` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `visibility` | `visibility` | `string` | no | no |
| `welcome_message_enabled` | `welcomeMessageEnabled` | `bool` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Reviewed create-required correction: displayName, mailEnabled, mailNickname, securityEnabled.
- events[].attendees[].emailAddress: polymorphic schema; accepts an untyped value
- events[].attendees[].proposedNewTime: polymorphic schema; accepts an untyped value
- events[].attendees[].status: polymorphic schema; accepts an untyped value
- events[].attendees[].type: polymorphic schema; accepts an untyped value
- events[].body: polymorphic schema; accepts an untyped value
- events[].end: polymorphic schema; accepts an untyped value
- events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- events[].importance: polymorphic schema; accepts an untyped value
- events[].location: polymorphic schema; accepts an untyped value
- events[].locations[].address: polymorphic schema; accepts an untyped value
- events[].locations[].coordinates: polymorphic schema; accepts an untyped value
- events[].locations[].uniqueIdType: polymorphic schema; accepts an untyped value
- events[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- events[].organizer: polymorphic schema; accepts an untyped value
- events[].recurrence: polymorphic schema; accepts an untyped value
- events[].responseStatus: polymorphic schema; accepts an untyped value
- events[].sensitivity: polymorphic schema; accepts an untyped value
- events[].showAs: polymorphic schema; accepts an untyped value
- events[].start: polymorphic schema; accepts an untyped value
- onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- onenote: polymorphic schema; accepts an untyped value
- photo: polymorphic schema; accepts an untyped value
- planner: polymorphic schema; accepts an untyped value
- sites[].analytics: polymorphic schema; accepts an untyped value
- sites[].columns[].boolean: polymorphic schema; accepts an untyped value
- sites[].columns[].calculated: polymorphic schema; accepts an untyped value
- sites[].columns[].choice: polymorphic schema; accepts an untyped value
- sites[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- sites[].columns[].currency: polymorphic schema; accepts an untyped value
- sites[].columns[].dateTime: polymorphic schema; accepts an untyped value
- sites[].columns[].defaultValue: polymorphic schema; accepts an untyped value
- sites[].columns[].geolocation: polymorphic schema; accepts an untyped value
- sites[].columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- sites[].columns[].lookup: polymorphic schema; accepts an untyped value
- sites[].columns[].number: polymorphic schema; accepts an untyped value
- sites[].columns[].personOrGroup: polymorphic schema; accepts an untyped value
- sites[].columns[].sourceColumn: polymorphic schema; accepts an untyped value
- sites[].columns[].term: polymorphic schema; accepts an untyped value
- sites[].columns[].text: polymorphic schema; accepts an untyped value
- sites[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- sites[].columns[].validation: polymorphic schema; accepts an untyped value
- sites[].contentTypes[].base: polymorphic schema; accepts an untyped value
- sites[].contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- sites[].contentTypes[].columnLinks[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].columnPositions[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- sites[].contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- sites[].contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- sites[].contentTypes[].order: polymorphic schema; accepts an untyped value
- sites[].drive: polymorphic schema; accepts an untyped value
- sites[].drives[].bundles[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].drives[].following[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].drives[].parentReference: polymorphic schema; accepts an untyped value
- sites[].drives[].sharePointIds: polymorphic schema; accepts an untyped value
- sites[].error: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].boolean: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].calculated: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].choice: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].currency: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].dateTime: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].defaultValue: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].lookup: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].number: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].personOrGroup: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].sourceColumn: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].term: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].text: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- sites[].externalColumns[].validation: polymorphic schema; accepts an untyped value
- sites[].items[].parentReference: polymorphic schema; accepts an untyped value
- sites[].lists[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].drive: polymorphic schema; accepts an untyped value
- sites[].lists[].items[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].list: polymorphic schema; accepts an untyped value
- sites[].lists[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].lists[].parentReference: polymorphic schema; accepts an untyped value
- sites[].lists[].subscriptions[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].onenote: polymorphic schema; accepts an untyped value
- sites[].operations[].error: polymorphic schema; accepts an untyped value
- sites[].operations[].status: polymorphic schema; accepts an untyped value
- sites[].pages[].pageLayout: polymorphic schema; accepts an untyped value
- sites[].pages[].parentReference: polymorphic schema; accepts an untyped value
- sites[].pages[].publishingState: polymorphic schema; accepts an untyped value
- sites[].parentReference: polymorphic schema; accepts an untyped value
- sites[].sites[]: recursive schema; accepts an untyped value
- sites[].termStore: polymorphic schema; accepts an untyped value
- sites[].termStores[].groups[]: nested schema exceeds depth limit; accepts an untyped value
- sites[].termStores[].sets[]: nested schema exceeds depth limit; accepts an untyped value
- team: polymorphic schema; accepts an untyped value
- threads[].ccRecipients[].emailAddress: polymorphic schema; accepts an untyped value
- threads[].posts[].body: polymorphic schema; accepts an untyped value
- threads[].posts[].from.emailAddress: polymorphic schema; accepts an untyped value
- threads[].posts[].newParticipants[]: nested schema exceeds depth limit; accepts an untyped value
- threads[].posts[].sender: polymorphic schema; accepts an untyped value
- threads[].toRecipients[].emailAddress: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
