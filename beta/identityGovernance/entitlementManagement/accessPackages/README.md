# /identityGovernance/entitlementManagement/accessPackages

Create accessPackage

[Catalog](../../../README.md) Â· [Identity and access](../../../README.md#identity-and-access) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackage?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/accessPackages`, `GET/PATCH/DELETE /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/identityGovernance/entitlementManagement/accessPackages"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `accessPackageCatalog` | `accessPackageCatalog` | `any` | no | no | in place |
| `accessPackageResourceRoleScopes` | `accessPackageResourceRoleScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")       accessPackageResourceScope = optional(any)       createdBy = optional(string)       createdDateTime = optional(string)       modifiedBy = optional(string)       modifiedDateTime = optional(string)     }))` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `displayName` | `displayName` | `string` | no | no | in place |
| `incompatibleAccessPackages` | `incompatibleAccessPackages` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackage")       accessPackageCatalog = optional(any)       accessPackageResourceRoleScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceRoleScope")       accessPackageResourceScope = optional(any)       createdBy = optional(string)       createdDateTime = optional(string)       modifiedBy = optional(string)       modifiedDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       incompatibleAccessPackages = optional(any)       incompatibleGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(any)       usageRights = optional(any)     }))       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     }))     })))       isHidden = optional(bool)       isRoleScopesVisible = optional(bool)       uniqueName = optional(string)     }))` | no | no | in place |
| `incompatibleGroups` | `incompatibleGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(any)     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")       allotments = optional(any)       assignments = optional(any)       externalServiceIdentifier = optional(string)     })))     }))       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(any)       range = optional(any)     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     }))     }))` | no | no | in place |
| `isHidden` | `isHidden` | `bool` | no | no | in place |
| `isRoleScopesVisible` | `isRoleScopesVisible` | `bool` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `uniqueName` | `uniqueName` | `string` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `uniqueName` within `/identityGovernance/entitlementManagement/accessPackages`. Graph refuses a value already used in that scope, or, where the rule is a combination, only the same combination; some of these values, such as identity provider claims, are dictated by another system rather than chosen freely.

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `accessPackageAssignmentPolicies`, `accessPackagesIncompatibleWith`, `catalogId`, `createdBy`, `createdDateTime`, `id`, `modifiedBy`, `modifiedDateTime`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /identityGovernance/entitlementManagement/accessPackages` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | — |
| `POST /identityGovernance/entitlementManagement/accessPackages` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /identityGovernance/entitlementManagement/accessPackages` | Application | `EntitlementManagement.ReadWrite.All` | — |
| `GET /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | DelegatedWork | `EntitlementManagement.Read.All` | — |
| `GET /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | — |
| `GET /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | Application | `EntitlementManagement.Read.All` | — |
| `GET /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | Application | `EntitlementManagement.ReadWrite.All` | — |
| `PATCH /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | — |
| `PATCH /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | Application | `EntitlementManagement.ReadWrite.All` | — |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | — |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}` | Application | `EntitlementManagement.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- accessPackageCatalog: navigation property; accepts an untyped value
- accessPackageResourceRoleScopes[].accessPackageResourceScope: navigation property; accepts an untyped value
- incompatibleAccessPackages[].accessPackageCatalog: navigation property; accepts an untyped value
- incompatibleAccessPackages[].accessPackageResourceRoleScopes[].accessPackageResourceScope: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleAccessPackages[]: recursive schema; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].acceptedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].assignedLabels[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].cloudLicensing.assignments: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].cloudLicensing.usageRights: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].conversations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].events[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].members[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].onenote: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].photo: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].rejectedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].settings[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].sites[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].team: navigation property; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].threads[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleAccessPackages[].incompatibleGroups[].transitiveMembers[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].acceptedSenders[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].cloudLicensing.assignments[].allotment: navigation property; accepts an untyped value
- incompatibleGroups[].cloudLicensing.assignments[].assignedTo: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].cloudLicensing.assignments[].disabledServicePlanIds: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].cloudLicensing.usageRights[].allotments: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].cloudLicensing.usageRights[].assignments: nested schema exceeds depth limit; accepts an untyped value
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
- incompatibleGroups[].rejectedSenders[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].settings[].values[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].analytics: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].createdByUser: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].drive: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].informationProtection: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- incompatibleGroups[].sites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].onenote: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].sites[].recycleBin: navigation property; accepts an untyped value
- incompatibleGroups[].sites[].sites[]: recursive schema; accepts an untyped value
- incompatibleGroups[].sites[].termStore: navigation property; accepts an untyped value
- incompatibleGroups[].team: navigation property; accepts an untyped value
- incompatibleGroups[].threads[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].threads[].posts[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].threads[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- incompatibleGroups[].transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- incompatibleGroups[].transitiveMembers[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent verified module `verified/identityGovernance/entitlementManagement/accessPackages` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **EM-CORE**: Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). Coverage: Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing. Assignment: direct; capacity: per_user. Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
