# /identityGovernance/entitlementManagement/accessPackages

Create accessPackage

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackage?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/accessPackages`, `GET/PATCH/DELETE /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/entitlement-management/access-packages"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `access_package_catalog` | `accessPackageCatalog` | `any` | no | no |
| `access_package_resource_role_scopes` | `accessPackageResourceRoleScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")       accessPackageResourceScope = optional(any)       createdBy = optional(string)       createdDateTime = optional(string)       modifiedBy = optional(string)       modifiedDateTime = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `incompatible_access_packages` | `incompatibleAccessPackages` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackage")       accessPackageCatalog = optional(any)       accessPackageResourceRoleScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")       accessPackageResourceScope = optional(any)       createdBy = optional(string)       createdDateTime = optional(string)       modifiedBy = optional(string)       modifiedDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       incompatibleAccessPackages = optional(any)       incompatibleGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     })))       isHidden = optional(bool)       isRoleScopesVisible = optional(bool)       uniqueName = optional(string)     }))` | no | no |
| `incompatible_groups` | `incompatibleGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       transitiveMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     }))` | no | no |
| `is_hidden` | `isHidden` | `bool` | no | no |
| `is_role_scopes_visible` | `isRoleScopesVisible` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `unique_name` | `uniqueName` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- accessPackageCatalog: polymorphic schema; accepts an untyped value
- accessPackageResourceRoleScopes[].accessPackageResourceScope: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].accessPackageCatalog: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].accessPackageResourceRoleScopes[].accessPackageResourceScope: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleAccessPackages[]: recursive schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].acceptedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].accessType: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].assignedLabels[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].conversations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].events[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].members[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onenote: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].photo: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].rejectedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].settings[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].sites[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].team: polymorphic schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].threads[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].transitiveMembers[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value
- incompatibleGroups[].accessType: polymorphic schema; accepts an untyped value
- incompatibleGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].attendees[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].events[].body: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].end: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- incompatibleGroups[].events[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].events[].importance: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].location: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].locations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].events[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].organizer: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].recurrence: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].responseStatus: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].sensitivity: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].showAs: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].start: polymorphic schema; accepts an untyped value
- incompatibleGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- incompatibleGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- incompatibleGroups[].onenote: polymorphic schema; accepts an untyped value
- incompatibleGroups[].photo: polymorphic schema; accepts an untyped value
- incompatibleGroups[].settings[].values[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].analytics: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].createdByUser: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].deleted: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].drive: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].informationProtection: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].lockState: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].onenote: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].parentReference: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].recycleBin: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].sites[]: recursive schema; accepts an untyped value
- incompatibleGroups[].sites[].template: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].termStore: polymorphic schema; accepts an untyped value
- incompatibleGroups[].team: polymorphic schema; accepts an untyped value
- incompatibleGroups[].threads[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].threads[].posts[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].threads[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
