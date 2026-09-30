# /policies/mobileDeviceManagementPolicies

Create new navigation property to mobileDeviceManagementPolicies for policies

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/mobiledevicemanagementpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /policies/mobileDeviceManagementPolicies`, `GET/PATCH/DELETE /policies/mobileDeviceManagementPolicies/{mobileDeviceManagementPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/identity-and-access/policies/mobile-device-management-policies?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `applies_to` | `appliesTo` | `string` | no | no |
| `compliance_url` | `complianceUrl` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `discovery_url` | `discoveryUrl` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `included_groups` | `includedGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(any)     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")       allotments = optional(any)       assignments = optional(any)       externalServiceIdentifier = optional(string)     })))     }))       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(any)       range = optional(any)     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     }))     }))` | no | no |
| `is_mdm_enrollment_during_registration_disabled` | `isMdmEnrollmentDuringRegistrationDisabled` | `bool` | no | no |
| `is_valid` | `isValid` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `terms_of_use_url` | `termsOfUseUrl` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- includedGroups[].acceptedSenders[]: polymorphic schema; accepts an untyped value
- includedGroups[].cloudLicensing.assignments[].allotment: navigation property; accepts an untyped value
- includedGroups[].cloudLicensing.assignments[].assignedTo: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].cloudLicensing.assignments[].disabledServicePlanIds: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].cloudLicensing.usageRights[].allotments: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].cloudLicensing.usageRights[].assignments: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].attendees[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- includedGroups[].events[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].location: polymorphic schema; accepts an untyped value
- includedGroups[].events[].locations[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].organizer: polymorphic schema; accepts an untyped value
- includedGroups[].events[].recurrence.pattern: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].recurrence.range: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].members[]: polymorphic schema; accepts an untyped value
- includedGroups[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- includedGroups[].onenote: navigation property; accepts an untyped value
- includedGroups[].owners[]: polymorphic schema; accepts an untyped value
- includedGroups[].photo: navigation property; accepts an untyped value
- includedGroups[].rejectedSenders[]: polymorphic schema; accepts an untyped value
- includedGroups[].serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- includedGroups[].settings[].values[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].analytics: navigation property; accepts an untyped value
- includedGroups[].sites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].createdByUser: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].drive: navigation property; accepts an untyped value
- includedGroups[].sites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].informationProtection: navigation property; accepts an untyped value
- includedGroups[].sites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].onenote: navigation property; accepts an untyped value
- includedGroups[].sites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].recycleBin: navigation property; accepts an untyped value
- includedGroups[].sites[].sites[]: recursive schema; accepts an untyped value
- includedGroups[].sites[].termStore: navigation property; accepts an untyped value
- includedGroups[].team: navigation property; accepts an untyped value
- includedGroups[].threads[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].threads[].posts[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].threads[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- includedGroups[].transitiveMembers[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
