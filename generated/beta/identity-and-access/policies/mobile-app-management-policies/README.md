# /policies/mobileAppManagementPolicies

Create new navigation property to mobileAppManagementPolicies for policies

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/mobileappmanagementpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /policies/mobileAppManagementPolicies`, `GET/PATCH/DELETE /policies/mobileAppManagementPolicies/{mobileAppManagementPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/policies/mobile-app-management-policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `applies_to` | `appliesTo` | `any` | no | no |
| `compliance_url` | `complianceUrl` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `discovery_url` | `discoveryUrl` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `included_groups` | `includedGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       transitiveMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     }))` | no | no |
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
- appliesTo: polymorphic schema; accepts an untyped value
- includedGroups[].accessType: polymorphic schema; accepts an untyped value
- includedGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- includedGroups[].events[].attendees[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].body: polymorphic schema; accepts an untyped value
- includedGroups[].events[].end: polymorphic schema; accepts an untyped value
- includedGroups[].events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- includedGroups[].events[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].importance: polymorphic schema; accepts an untyped value
- includedGroups[].events[].location: polymorphic schema; accepts an untyped value
- includedGroups[].events[].locations[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].events[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- includedGroups[].events[].organizer: polymorphic schema; accepts an untyped value
- includedGroups[].events[].recurrence: polymorphic schema; accepts an untyped value
- includedGroups[].events[].responseStatus: polymorphic schema; accepts an untyped value
- includedGroups[].events[].sensitivity: polymorphic schema; accepts an untyped value
- includedGroups[].events[].showAs: polymorphic schema; accepts an untyped value
- includedGroups[].events[].start: polymorphic schema; accepts an untyped value
- includedGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- includedGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- includedGroups[].onenote: polymorphic schema; accepts an untyped value
- includedGroups[].photo: polymorphic schema; accepts an untyped value
- includedGroups[].settings[].values[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].analytics: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].createdByUser: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].deleted: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].drive: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].informationProtection: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].lockState: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].onenote: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].parentReference: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].sites[].recycleBin: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].sites[]: recursive schema; accepts an untyped value
- includedGroups[].sites[].template: polymorphic schema; accepts an untyped value
- includedGroups[].sites[].termStore: polymorphic schema; accepts an untyped value
- includedGroups[].team: polymorphic schema; accepts an untyped value
- includedGroups[].threads[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].threads[].posts[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].threads[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- includedGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
