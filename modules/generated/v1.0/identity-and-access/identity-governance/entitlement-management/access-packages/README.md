# /identityGovernance/entitlementManagement/accessPackages

Create accessPackage

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackage?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

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
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `incompatible_access_packages` | `incompatibleAccessPackages` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackage")       description = optional(string)       displayName = optional(string)       incompatibleAccessPackages = optional(any)       incompatibleGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       planner = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)     })))       isHidden = optional(bool)       resourceRoleScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")       createdDateTime = optional(string)       role = optional(any)       scope = optional(any)     })))     }))` | no | no |
| `incompatible_groups` | `incompatibleGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(any)       range = optional(any)     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       planner = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.groupSetting")       displayName = optional(string)       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(any)       message = optional(string)       target = optional(string)     }))       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)     }))` | no | no |
| `is_hidden` | `isHidden` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resource_role_scopes` | `resourceRoleScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")       createdDateTime = optional(string)       role = optional(any)       scope = optional(any)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- incompatibleAccessPackages[].incompatibleAccessPackages[]: recursive schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].acceptedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].assignedLabels[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].conversations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].events[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].members[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onenote: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].photo: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].planner: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].rejectedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].settings[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].sites[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].team: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].threads[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].transitiveMembers[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].resourceRoleScopes[].role: navigation property; accepts an untyped value
- incompatibleAccessPackages[].resourceRoleScopes[].scope: navigation property; accepts an untyped value
- incompatibleGroups[].acceptedSenders[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].attendees[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- incompatibleGroups[].events[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].events[].location: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].locations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].events[].organizer: polymorphic schema; accepts an untyped value
- incompatibleGroups[].events[].recurrence.pattern: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].events[].recurrence.range: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].members[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- incompatibleGroups[].onenote: navigation property; accepts an untyped value
- incompatibleGroups[].owners[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].photo: navigation property; accepts an untyped value
- incompatibleGroups[].planner: navigation property; accepts an untyped value
- incompatibleGroups[].rejectedSenders[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].settings[].values[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].analytics: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].drive: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].error.details: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].error.innerError: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].onenote: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].sites[]: recursive schema; accepts an untyped value
- incompatibleGroups[].sites[].termStore: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].termStores[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].team: navigation property; accepts an untyped value
- incompatibleGroups[].threads[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].threads[].posts[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].threads[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].transitiveMembers[]: polymorphic schema; accepts an untyped value
- resourceRoleScopes[].role: navigation property; accepts an untyped value
- resourceRoleScopes[].scope: navigation property; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent curated module `curated/identity-governance/entitlement-management/access-packages` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **EM-CORE**: Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). Coverage: Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing. Assignment: direct; capacity: per_user. Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
