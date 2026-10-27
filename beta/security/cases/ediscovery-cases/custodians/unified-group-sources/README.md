# /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources

Create custodian unifiedGroupSource

[Catalog](../../../../../README.md) Â· [Security](../../../../../README.md#security) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources/{unifiedGroupSource-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/security/cases/ediscovery-cases/custodians/unified-group-sources"
  version = "<version>"

  ediscovery_case_id = "parent-object-id"
  ediscovery_custodian_id = "parent-object-id"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `group`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `ediscovery_case_id` | URL parameter `ediscoveryCase-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `ediscovery_custodian_id` | URL parameter `ediscoveryCustodian-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `created_by` | `createdBy` | `any` | no | no | in place |
| `created_date_time` | `createdDateTime` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `group` | `group` | `object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(list(string))     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")       allotments = optional(any)       assignments = optional(any)       externalServiceIdentifier = optional(string)     })))     }))       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(any)       type = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(any)       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(list(object({       odata_type = optional(string, "#microsoft.graph.settingValue")       name = optional(string)       value = optional(string)     })))     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(string)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(string)       listItemUniqueId = optional(string)       status = optional(string)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(any)       bundles = optional(any)       createdByUser = optional(any)       description = optional(string)       following = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       extensions = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(any)       columns = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       lastModifiedByUser = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(string)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)       titleArea = optional(any)       webParts = optional(any)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(any)       categories = optional(any)       createdDateTime = optional(string)       from = optional(any)       hasAttachments = optional(bool)       importance = optional(string)       lastModifiedDateTime = optional(string)       mentions = optional(any)       newParticipants = optional(any)       receivedDateTime = optional(string)       sender = optional(any)     })))       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     }))     })` | no | no | in place |
| `hold_status` | `holdStatus` | `string` | no | no | in place |
| `included_sources` | `includedSources` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

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
- group.sites[].pageTemplates[].pageLayout: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: newsLink, videoNewsLink; excluded from typed input validation
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
