# /users

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `last_password_change_date_time`, `managed_devices`, `password_policies`, `password_profile`, `print`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create User

[Catalog](../README.md) Â· [Users](../README.md#users) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/user?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users`, `GET/PATCH/DELETE /users/{user-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/users"
  version = "<version>"

  account_enabled = false
  display_name = "example"
  mail_nickname = "example"
  password_profile = {  }
  user_principal_name = "example"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Creation profiles

Microsoft documents alternative sets of required inputs for this collection. A plan-time precondition requires every property of at least one profile in the request body, set through typed inputs or `additional_properties`; the usage example shows the first.

- **standard**: `accountEnabled`, `displayName`, `mailNickname`, `passwordProfile`, `userPrincipalName`. Work or school account signing in with a user principal name.
- **identities**: `identities`. Account created with an identities collection (local or social sign-in). Local-account identities also need passwordProfile and passwordPolicies set to DisablePasswordExpiration.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `aboutMe`, `accountEnabled`, `ageGroup`, `assignedLicenses`, `birthday`, `city`, `companyName`, `consentProvidedForMinor`, `country`, `customSecurityAttributes`, `department`, `employeeHireDate`, `employeeId`, `employeeOrgData`, `employeeType`, `externalUserState`, `externalUserStateChangeDateTime`, `faxNumber`, `hireDate`, `identities`, `interests`, `lastPasswordChangeDateTime`, `mailNickname`, `mailboxSettings`, `mySite`, `onPremisesExtensionAttributes`, `onPremisesImmutableId`, `onPremisesProvisioningErrors`, `otherMails`, `passwordPolicies`, `passwordProfile`, `pastProjects`, `postalCode`, `preferredName`, `print`, `responsibilities`, `schools`, `skills`, `state`, `streetAddress`, `usageLocation`, `userType`.

Write-only paths: `passwordProfile.password`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

The clearing sidecar retains its existing strict read of cleared names. The separate ordered output GET keeps its full default response; only `select_response = true` narrows it to configured readable and cleared keys.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Clearing properties

Microsoft Graph keeps every property that an update omits, and the `microsoft/msgraph` provider drops a value that changed to `null` from the update of `msgraph_resource`, so setting an optional input to `null` never clears it. List a reviewed property in `clear_properties` (a list of Graph field names) to clear it: `msgraph_update_resource.clear` then sends it as JSON `null` in a `PATCH` of the object.

| Graph property | Typed input |
| --- | --- |
| `ageGroup` | `age_group` |
| `consentProvidedForMinor` | `consent_provided_for_minor` |

- Only the reviewed names above are accepted; each is documented to accept `null` on [the Microsoft Learn update page](https://learn.microsoft.com/en-us/graph/api/user-update).
- A listed property is owned by the clearing request. Leave its typed input and its `additional_properties` key unset: a plan precondition refuses a value for it.
- Removing a name from `clear_properties` does not restore the value; set the typed input to write a new one. Destroying the clearing request sends nothing and restores nothing.
- The clearing request is created while a name is listed and replaced, so the `PATCH` is sent again, on every update or replacement of `msgraph_resource.this`, not only when `clear_properties` changes. The repeated null is idempotent.
- The clearing request reads the listed properties back (`$select`) and does not ignore a missing one. This assumes Graph returns an explicit `null` for a cleared, selected property; that is not verified against a live tenant, and a response that omits the property would fail the read.
- While a name is listed, the `response` output comes from a read that runs after both writers (`data.msgraph_resource.after_writes`, one extra `GET` per refresh), so it shows the cleared state; with an empty `clear_properties` it comes from `msgraph_resource.this` as in a module without clearing.
- The ownership check of a listed name is a precondition of `msgraph_resource.this`, so a conflicting value that is unknown at plan time is refused before that resource writes.
- The behavior is covered by mocked plan tests only; the provider's transport and Graph's response to a clearing `PATCH` are not verified against a live tenant.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `about_me` | `aboutMe` | `string` | no | no | in place |
| `account_enabled` | `accountEnabled` | `bool` | profile standard | no | in place |
| `age_group` | `ageGroup` | `string` | no | no | in place |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no | in place |
| `assigned_licenses` | `assignedLicenses` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     }))` | no | no | in place |
| `authentication` | `authentication` | `any` | no | no | in place |
| `authorization_info` | `authorizationInfo` | `object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(list(string))     })` | no | no | in place |
| `birthday` | `birthday` | `string` | no | no | in place |
| `business_phones` | `businessPhones` | `list(string)` | no | no | in place |
| `chats` | `chats` | `list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       pinnedMessages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")       message = optional(any)     })))       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")       contentUrl = optional(string)       entityId = optional(string)       removeUrl = optional(string)       websiteUrl = optional(string)     }))       displayName = optional(string)       teamsApp = optional(any)     })))       targetedMessages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.targetedChatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       channelIdentity = optional(object({       odata_type = optional(string, "#microsoft.graph.channelIdentity")       channelId = optional(string)       teamId = optional(string)     }))       chatId = optional(string)       createdDateTime = optional(string)       from = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       policyViolation = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessagePolicyViolation")       dlpAction = optional(string)       justificationText = optional(string)       policyTip = optional(any)       userAction = optional(string)       verdictDetails = optional(string)     }))       reactions = optional(any)       recipient = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       topic = optional(string)       viewpoint = optional(object({       odata_type = optional(string, "#microsoft.graph.chatViewpoint")       isHidden = optional(bool)       lastMessageReadDateTime = optional(string)     }))     }))` | no | no | in place |
| `city` | `city` | `string` | no | no | in place |
| `cloud_clipboard` | `cloudClipboard` | `any` | no | no | in place |
| `company_name` | `companyName` | `string` | no | no | in place |
| `consent_provided_for_minor` | `consentProvidedForMinor` | `string` | no | no | in place |
| `country` | `country` | `string` | no | no | in place |
| `custom_security_attributes` | `customSecurityAttributes` | `any` | no | no | in place |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no | in place |
| `department` | `department` | `string` | no | no | in place |
| `device_enrollment_limit` | `deviceEnrollmentLimit` | `number` | no | no | in place |
| `device_management_troubleshooting_events` | `deviceManagementTroubleshootingEvents` | `any` | no | no | in place |
| `display_name` | `displayName` | `string` | profile standard | no | in place |
| `employee_experience` | `employeeExperience` | `any` | no | no | in place |
| `employee_hire_date` | `employeeHireDate` | `string` | no | no | in place |
| `employee_id` | `employeeId` | `string` | no | no | in place |
| `employee_leave_date_time` | `employeeLeaveDateTime` | `string` | no | no | in place |
| `employee_org_data` | `employeeOrgData` | `object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     })` | no | no | in place |
| `employee_type` | `employeeType` | `string` | no | no | in place |
| `external_user_state` | `externalUserState` | `string` | no | no | in place |
| `external_user_state_change_date_time` | `externalUserStateChangeDateTime` | `string` | no | no | in place |
| `fax_number` | `faxNumber` | `string` | no | no | in place |
| `followed_sites` | `followedSites` | `list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSet")       allowedContentTypes = optional(any)       defaultContents = optional(any)       propagateWelcomePageChanges = optional(bool)       sharedColumns = optional(any)       shouldPrefixNameToFile = optional(bool)       welcomePageColumns = optional(any)       welcomePageUrl = optional(string)     }))       documentTemplate = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSetContent")       contentType = optional(any)       fileName = optional(string)       folderName = optional(string)     }))       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       isBuiltIn = optional(bool)       name = optional(string)       order = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeOrder")       default = optional(bool)       position = optional(number)     }))       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       description = optional(string)       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       bundles = optional(any)       description = optional(string)       following = optional(any)       name = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       sharePointIds = optional(object({       odata_type = optional(string, "#microsoft.graph.sharepointIds")       listId = optional(string)       listItemId = optional(string)       listItemUniqueId = optional(string)       siteId = optional(string)       siteUrl = optional(string)       tenantId = optional(string)       webId = optional(string)     }))     })))       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(list(object({       odata_type = optional(string, "#microsoft.graph.publicErrorDetail")       code = optional(string)       message = optional(string)       target = optional(string)     })))       innerError = optional(object({       odata_type = optional(string, "#microsoft.graph.publicInnerError")       code = optional(string)       details = optional(any)       message = optional(string)       target = optional(string)     }))       message = optional(string)       target = optional(string)     }))       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(any)       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       items = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       list = optional(object({       odata_type = optional(string, "#microsoft.graph.listInfo")       contentTypesEnabled = optional(bool)       hidden = optional(bool)       template = optional(string)     }))       name = optional(string)       operations = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       subscriptions = optional(any)     })))       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(any)       message = optional(string)       target = optional(string)     }))       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       sites = optional(any)       termStore = optional(any)       termStores = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.store")       defaultLanguageTag = optional(string)       groups = optional(any)       languageTags = optional(list(string))       sets = optional(any)     })))     }))` | no | no | in place |
| `given_name` | `givenName` | `string` | no | no | in place |
| `hire_date` | `hireDate` | `string` | no | no | in place |
| `identities` | `identities` | `list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     }))` | profile identities | no | in place |
| `identity_parent_id` | `identityParentId` | `string` | no | no | in place |
| `inference_classification` | `inferenceClassification` | `any` | no | no | in place |
| `interests` | `interests` | `list(string)` | no | no | in place |
| `is_resource_account` | `isResourceAccount` | `bool` | no | no | in place |
| `job_title` | `jobTitle` | `string` | no | no | in place |
| `joined_teams` | `joinedTeams` | `list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(any)       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(string)       members = optional(any)       membershipType = optional(string)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(any)       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.channelSummary")       guestsCount = optional(number)       hasMembersFromOtherTenants = optional(bool)       membersCount = optional(number)       ownersCount = optional(number)     }))       tabs = optional(any)       tenantId = optional(string)     })))       channels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(any)       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(string)       members = optional(any)       membershipType = optional(string)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(any)       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.channelSummary")       guestsCount = optional(number)       hasMembersFromOtherTenants = optional(bool)       membersCount = optional(number)       ownersCount = optional(number)     }))       tabs = optional(any)       tenantId = optional(string)     })))       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamFunSettings")       allowCustomMemes = optional(bool)       allowGiphy = optional(bool)       allowStickersAndMemes = optional(bool)       giphyContentRating = optional(string)     }))       group = optional(any)       guestSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamGuestSettings")       allowCreateUpdateChannels = optional(bool)       allowDeleteChannels = optional(bool)     }))       incomingChannels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(any)       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(string)       members = optional(any)       membershipType = optional(string)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(any)       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.channelSummary")       guestsCount = optional(number)       hasMembersFromOtherTenants = optional(bool)       membersCount = optional(number)       ownersCount = optional(number)     }))       tabs = optional(any)       tenantId = optional(string)     })))       installedApps = optional(any)       internalId = optional(string)       memberSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamMemberSettings")       allowAddRemoveApps = optional(bool)       allowCreatePrivateChannels = optional(bool)       allowCreateUpdateChannels = optional(bool)       allowCreateUpdateRemoveConnectors = optional(bool)       allowCreateUpdateRemoveTabs = optional(bool)       allowDeleteChannels = optional(bool)     }))       members = optional(any)       messagingSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamMessagingSettings")       allowChannelMentions = optional(bool)       allowOwnerDeleteMessages = optional(bool)       allowTeamMentions = optional(bool)       allowUserDeleteMessages = optional(bool)       allowUserEditMessages = optional(bool)     }))       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.operationError")       code = optional(string)       message = optional(string)     }))       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(string)       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.teamSummary")       guestsCount = optional(number)       membersCount = optional(number)       ownersCount = optional(number)     }))       tags = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTag")       description = optional(string)       displayName = optional(string)       memberCount = optional(number)       members = optional(any)       tagType = optional(string)       teamId = optional(string)     })))       template = optional(any)       tenantId = optional(string)       visibility = optional(string)       webUrl = optional(string)     }))` | no | no | in place |
| `last_password_change_date_time` | `lastPasswordChangeDateTime` | `string` | no | yes | in place |
| `mail` | `mail` | `string` | no | no | in place |
| `mail_nickname` | `mailNickname` | `string` | profile standard | no | in place |
| `mailbox_settings` | `mailboxSettings` | `object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       archiveFolder = optional(string)       automaticRepliesSetting = optional(object({       odata_type = optional(string, "#microsoft.graph.automaticRepliesSetting")       externalAudience = optional(string)       externalReplyMessage = optional(string)       internalReplyMessage = optional(string)       scheduledEndDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       scheduledStartDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       status = optional(string)     }))       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(object({       odata_type = optional(string, "#microsoft.graph.localeInfo")       displayName = optional(string)       locale = optional(string)     }))       timeFormat = optional(string)       timeZone = optional(string)       workingHours = optional(object({       odata_type = optional(string, "#microsoft.graph.workingHours")       daysOfWeek = optional(list(string))       endTime = optional(string)       startTime = optional(string)       timeZone = optional(any)     }))     })` | no | no | in place |
| `managed_app_registrations` | `managedAppRegistrations` | `list(object({       odata_type = string       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppOperation")       displayName = optional(string)       lastModifiedDateTime = optional(string)       state = optional(string)       version = optional(string)     })))       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     }))` | no | no | in place |
| `managed_devices` | `managedDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       version = optional(number)     })))       deviceConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       version = optional(number)     })))       logCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceLogCollectionResponse")       enrolledByUser = optional(string)       expirationDateTimeUTC = optional(string)       initiatedByUserPrincipalName = optional(string)       managedDeviceId = optional(string)       receivedDateTimeUTC = optional(string)       requestedDateTimeUTC = optional(string)       sizeInKB = optional(any)       status = optional(string)     })))       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       notes = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(any)       assignedLicenses = optional(any)       authentication = optional(any)       authorizationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(any)     }))       birthday = optional(string)       chats = optional(any)       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(any)       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     }))       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(any)       givenName = optional(string)       hireDate = optional(string)       identities = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(any)       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       archiveFolder = optional(string)       automaticRepliesSetting = optional(any)       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(any)       timeFormat = optional(string)       timeZone = optional(string)       workingHours = optional(any)     }))       managedAppRegistrations = optional(any)       managedDevices = optional(any)       mySite = optional(string)       oauth2PermissionGrants = optional(any)       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(any)       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       pastProjects = optional(list(string))       permissionGrants = optional(any)       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(any)     }))       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     })))     }))` | no | yes | in place |
| `mobile_phone` | `mobilePhone` | `string` | no | no | in place |
| `my_site` | `mySite` | `string` | no | no | in place |
| `oauth2_permission_grants` | `oauth2PermissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `office_location` | `officeLocation` | `string` | no | no | in place |
| `on_premises_extension_attributes` | `onPremisesExtensionAttributes` | `object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     })` | no | no | in place |
| `on_premises_immutable_id` | `onPremisesImmutableId` | `string` | no | no | in place |
| `on_premises_provisioning_errors` | `onPremisesProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     }))` | no | no | in place |
| `on_premises_sync_behavior` | `onPremisesSyncBehavior` | `any` | no | no | in place |
| `onenote` | `onenote` | `any` | no | no | in place |
| `online_meetings` | `onlineMeetings` | `list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       broadcastSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingSettings")       allowedAudience = optional(string)       captions = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingCaptionSettings")       isCaptionEnabled = optional(bool)       spokenLanguage = optional(string)       translationLanguages = optional(list(string))     }))       isAttendeeReportEnabled = optional(bool)       isQuestionAndAnswerEnabled = optional(bool)       isRecordingEnabled = optional(bool)       isVideoOnDemandEnabled = optional(bool)     }))       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(object({       odata_type = optional(string, "#microsoft.graph.meetingParticipants")       attendees = optional(any)       organizer = optional(any)     }))       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     }))` | no | no | in place |
| `other_mails` | `otherMails` | `list(string)` | no | no | in place |
| `outlook` | `outlook` | `any` | no | no | in place |
| `password_policies` | `passwordPolicies` | `string` | no | yes | in place |
| `password_profile` | `passwordProfile` | `object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     })` | profile standard | yes | in place |
| `past_projects` | `pastProjects` | `list(string)` | no | no | in place |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no | in place |
| `postal_code` | `postalCode` | `string` | no | no | in place |
| `preferred_data_location` | `preferredDataLocation` | `string` | no | no | in place |
| `preferred_language` | `preferredLanguage` | `string` | no | no | in place |
| `preferred_name` | `preferredName` | `string` | no | no | in place |
| `presence` | `presence` | `any` | no | no | in place |
| `print` | `print` | `object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printerShare")       allowAllUsers = optional(bool)       allowedGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(any)       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(any)       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       planner = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(any)       resourceProvisioningOptions = optional(any)       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)     })))       allowedUsers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(any)       assignedLicenses = optional(any)       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(any)       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(any)       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(any)       givenName = optional(string)       hireDate = optional(string)       identities = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(any)       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppRegistrations = optional(any)       managedDevices = optional(any)       mySite = optional(string)       oauth2PermissionGrants = optional(any)       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(any)       otherMails = optional(any)       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(any)       permissionGrants = optional(any)       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       responsibilities = optional(any)       schools = optional(any)       scopedRoleMemberOf = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(any)       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     })))       capabilities = optional(object({       odata_type = optional(string, "#microsoft.graph.printerCapabilities")       bottomMargins = optional(list(number))       collation = optional(bool)       colorModes = optional(list(string))       contentTypes = optional(list(string))       copiesPerJob = optional(object({       odata_type = optional(string, "#microsoft.graph.integerRange")       end = optional(number)       start = optional(number)     }))       dpis = optional(list(number))       duplexModes = optional(list(string))       feedOrientations = optional(list(string))       finishings = optional(list(string))       inputBins = optional(list(string))       isPageRangeSupported = optional(bool)       leftMargins = optional(list(number))       mediaColors = optional(list(string))       mediaSizes = optional(list(string))       mediaTypes = optional(list(string))       multipageLayouts = optional(list(string))       orientations = optional(list(string))       outputBins = optional(list(string))       pagesPerSheet = optional(list(number))       qualities = optional(list(string))       rightMargins = optional(list(number))       scalings = optional(list(string))       supportsFitPdfToPage = optional(bool)       topMargins = optional(list(number))     }))       defaults = optional(object({       odata_type = optional(string, "#microsoft.graph.printerDefaults")       colorMode = optional(string)       contentType = optional(string)       copiesPerJob = optional(number)       dpi = optional(number)       duplexMode = optional(string)       finishings = optional(list(string))       fitPdfToPage = optional(bool)       inputBin = optional(string)       mediaColor = optional(string)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(string)       orientation = optional(string)       outputBin = optional(string)       pagesPerSheet = optional(number)       quality = optional(string)       scaling = optional(string)     }))       displayName = optional(string)       isAcceptingJobs = optional(bool)       jobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printJob")       configuration = optional(any)       createdBy = optional(any)       documents = optional(any)       isFetchable = optional(bool)       redirectedFrom = optional(string)       redirectedTo = optional(string)       status = optional(any)       tasks = optional(any)     })))       location = optional(object({       odata_type = optional(string, "#microsoft.graph.printerLocation")       altitudeInMeters = optional(number)       building = optional(string)       city = optional(string)       countryOrRegion = optional(string)       floor = optional(string)       floorDescription = optional(string)       latitude = optional(any)       longitude = optional(any)       organization = optional(list(string))       postalCode = optional(string)       roomDescription = optional(string)       roomName = optional(string)       site = optional(string)       stateOrProvince = optional(string)       streetAddress = optional(string)       subdivision = optional(list(string))       subunit = optional(list(string))     }))       manufacturer = optional(string)       model = optional(string)       printer = optional(any)       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printerStatus")       state = optional(string)     }))       viewPoint = optional(object({       odata_type = optional(string, "#microsoft.graph.printerShareViewpoint")       lastUsedDateTime = optional(string)     }))     })))     })` | no | yes | in place |
| `responsibilities` | `responsibilities` | `list(string)` | no | no | in place |
| `schools` | `schools` | `list(string)` | no | no | in place |
| `scoped_role_member_of` | `scopedRoleMemberOf` | `list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(any)     }))` | no | no | in place |
| `service_provisioning_errors` | `serviceProvisioningErrors` | `any` | no | no | in place |
| `settings` | `settings` | `any` | no | no | in place |
| `show_in_address_list` | `showInAddressList` | `bool` | no | no | in place |
| `skills` | `skills` | `list(string)` | no | no | in place |
| `sponsors` | `sponsors` | `any` | no | no | in place |
| `state` | `state` | `string` | no | no | in place |
| `street_address` | `streetAddress` | `string` | no | no | in place |
| `surname` | `surname` | `string` | no | no | in place |
| `todo` | `todo` | `any` | no | no | in place |
| `transitive_member_of` | `transitiveMemberOf` | `any` | no | no | in place |
| `usage_location` | `usageLocation` | `string` | no | no | in place |
| `user_principal_name` | `userPrincipalName` | `string` | profile standard | no | in place |
| `user_type` | `userType` | `string` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |
| `clear_properties` | Reviewed properties to clear: `ageGroup`, `consentProvidedForMinor` | `list(string)` | no | no | sends a clearing request for the listed names; the object is not replaced |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `user_principal_name` within `/users`. Graph refuses a value already used in that scope, or, where the rule is a combination, only the same combination; some of these values, such as identity provider claims, are dictated by another system rather than chosen freely.

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults, except for abstract types listed in the generation notes: set their `odata_type` to a concrete type.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `activities`, `adhocCalls`, `agreementAcceptances`, `assignedPlans`, `calendar`, `calendarGroups`, `calendarView`, `calendars`, `cloudPCs`, `contactFolders`, `contacts`, `createdDateTime`, `createdObjects`, `creationType`, `dataSecurityAndGovernance`, `directReports`, `drive`, `drives`, `events`, `extensions`, `id`, `imAddresses`, `insights`, `isManagementRestricted`, `legalAgeGroupClassification`, `licenseAssignmentStates`, `licenseDetails`, `mailFolders`, `manager`, `memberOf`, `messages`, `notes`, `onPremisesDistinguishedName`, `onPremisesDomainName`, `onPremisesLastSyncDateTime`, `onPremisesSamAccountName`, `onPremisesSecurityIdentifier`, `onPremisesSyncEnabled`, `onPremisesUserPrincipalName`, `ownedDevices`, `ownedObjects`, `people`, `photo`, `photos`, `planner`, `provisionedPlans`, `proxyAddresses`, `registeredDevices`, `securityIdentifier`, `signInActivity`, `signInSessionsValidFromDateTime`, `solutions`, `sponsorOf`, `teamwork`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Creation profile identities: requires identities. Account created with an identities collection (local or social sign-in). Local-account identities also need passwordProfile and passwordPolicies set to DisablePasswordExpiration.
- Creation profile standard: requires accountEnabled, displayName, mailNickname, passwordProfile, userPrincipalName. Work or school account signing in with a user principal name.
- Reviewed clearable properties: ageGroup, consentProvidedForMinor (https://learn.microsoft.com/en-us/graph/api/user-update); the clear_properties input sends JSON null for them through a separate msgraph_update_resource.
- Reviewed writable correction: businessPhones. Writable for cloud-only users; read-only for users synchronized from an on-premises directory. Updates remain subject to sensitive-action permission and role restrictions.
- Reviewed writable correction: mobilePhone. Writable for cloud-only users; read-only for users synchronized from an on-premises directory. Updates remain subject to sensitive-action permission and role restrictions. See https://learn.microsoft.com/en-us/graph/api/user-update.
- Reviewed writable correction: onPremisesExtensionAttributes. Writable for cloud-only users that were not previously synchronized; currently or previously synchronized users can remain read-only through Graph.
- authentication: navigation property; accepts an untyped value
- chats[].installedApps[]: polymorphic schema; accepts an untyped value
- chats[].lastMessagePreview: navigation property; accepts an untyped value
- chats[].members[]: polymorphic schema; accepts an untyped value
- chats[].messages[]: polymorphic schema; accepts an untyped value
- chats[].pinnedMessages[].message: polymorphic schema; accepts an untyped value
- chats[].tabs[].teamsApp: navigation property; accepts an untyped value
- chats[].targetedMessages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].from.application: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].from.device: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].from.user: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].messageType: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: systemEventMessage; excluded from typed input validation
- chats[].targetedMessages[].policyViolation.policyTip: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].recipient: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].replies[]: nested schema exceeds depth limit; accepts an untyped value
- cloudClipboard: navigation property; accepts an untyped value
- customSecurityAttributes: polymorphic schema; accepts an untyped value
- deviceManagementTroubleshootingEvents[]: polymorphic schema; accepts an untyped value
- employeeExperience: navigation property; accepts an untyped value
- followedSites[].analytics: navigation property; accepts an untyped value
- followedSites[].columns[].boolean: polymorphic schema; accepts an untyped value
- followedSites[].columns[].choice.choices: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- followedSites[].columns[].geolocation: polymorphic schema; accepts an untyped value
- followedSites[].columns[].number.maximum: polymorphic schema; accepts an untyped value
- followedSites[].columns[].number.minimum: polymorphic schema; accepts an untyped value
- followedSites[].columns[].sourceColumn: navigation property; accepts an untyped value
- followedSites[].columns[].term.parentTerm: navigation property; accepts an untyped value
- followedSites[].columns[].term.termSet: navigation property; accepts an untyped value
- followedSites[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- followedSites[].columns[].validation.descriptions: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].base: navigation property; accepts an untyped value
- followedSites[].contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- followedSites[].contentTypes[].columnLinks[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].columnPositions[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].documentSet.allowedContentTypes: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].documentSet.defaultContents: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].documentSet.sharedColumns: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].documentSet.welcomePageColumns: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].documentTemplate.contentType: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].drive: navigation property; accepts an untyped value
- followedSites[].drives[].bundles[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].drives[].following[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].error.innerError.details[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].externalColumns[].boolean: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].choice.choices: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].number.maximum: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].number.minimum: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].sourceColumn: navigation property; accepts an untyped value
- followedSites[].externalColumns[].term.parentTerm: navigation property; accepts an untyped value
- followedSites[].externalColumns[].term.termSet: navigation property; accepts an untyped value
- followedSites[].externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].validation.descriptions: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].items[]: polymorphic schema; accepts an untyped value
- followedSites[].lists[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].drive: navigation property; accepts an untyped value
- followedSites[].lists[].items[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].subscriptions[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].onenote: navigation property; accepts an untyped value
- followedSites[].operations[].error.details: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].operations[].error.innerError: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].pages[]: polymorphic schema; accepts an untyped value
- followedSites[].sites[]: recursive schema; accepts an untyped value
- followedSites[].termStore: navigation property; accepts an untyped value
- followedSites[].termStores[].groups[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].termStores[].sets[]: nested schema exceeds depth limit; accepts an untyped value
- inferenceClassification: navigation property; accepts an untyped value
- joinedTeams[].allChannels[].allMembers[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].enabledApps[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].filesFolder: navigation property; accepts an untyped value
- joinedTeams[].allChannels[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].membershipType: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: shared; excluded from typed input validation
- joinedTeams[].allChannels[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].sharedWithTeams[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].allMembers[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].enabledApps[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].filesFolder: navigation property; accepts an untyped value
- joinedTeams[].channels[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].membershipType: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: shared; excluded from typed input validation
- joinedTeams[].channels[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].sharedWithTeams[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].group: navigation property; accepts an untyped value
- joinedTeams[].incomingChannels[].allMembers[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].enabledApps[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].filesFolder: navigation property; accepts an untyped value
- joinedTeams[].incomingChannels[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].membershipType: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: shared; excluded from typed input validation
- joinedTeams[].incomingChannels[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].sharedWithTeams[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].installedApps[]: polymorphic schema; accepts an untyped value
- joinedTeams[].members[]: polymorphic schema; accepts an untyped value
- joinedTeams[].operations[].operationType: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: teamifyGroup, createChannel, archiveChannel, unarchiveChannel; excluded from typed input validation
- joinedTeams[].photo: navigation property; accepts an untyped value
- joinedTeams[].primaryChannel: navigation property; accepts an untyped value
- joinedTeams[].schedule: navigation property; accepts an untyped value
- joinedTeams[].tags[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].template: navigation property; accepts an untyped value
- mailboxSettings.workingHours.timeZone: polymorphic schema; accepts an untyped value
- managedAppRegistrations[].@odata.type: microsoft.graph.managedAppRegistration is abstract; odata_type has no default and must name a concrete type
- managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- managedAppRegistrations[].appliedPolicies[]: polymorphic schema; accepts an untyped value
- managedAppRegistrations[].intendedPolicies[]: polymorphic schema; accepts an untyped value
- managedDevices[].deviceCategory: navigation property; accepts an untyped value
- managedDevices[].deviceCompliancePolicyStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].deviceConfigurationStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].logCollectionRequests[].sizeInKB: polymorphic schema; accepts an untyped value
- managedDevices[].users[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].authentication: navigation property; accepts an untyped value
- managedDevices[].users[].authorizationInfo.certificateUserIds: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].chats[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudClipboard: navigation property; accepts an untyped value
- managedDevices[].users[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- managedDevices[].users[].deviceManagementTroubleshootingEvents[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].employeeExperience: navigation property; accepts an untyped value
- managedDevices[].users[].followedSites[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].identities[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].inferenceClassification: navigation property; accepts an untyped value
- managedDevices[].users[].joinedTeams[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.automaticRepliesSetting: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.language: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.workingHours: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedAppRegistrations[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedDevices[]: recursive schema; accepts an untyped value
- managedDevices[].users[].oauth2PermissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- managedDevices[].users[].onenote: navigation property; accepts an untyped value
- managedDevices[].users[].onlineMeetings[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].outlook: navigation property; accepts an untyped value
- managedDevices[].users[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].presence: navigation property; accepts an untyped value
- managedDevices[].users[].print.recentPrinterShares: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].scopedRoleMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].settings: navigation property; accepts an untyped value
- managedDevices[].users[].sponsors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].todo: navigation property; accepts an untyped value
- managedDevices[].users[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- onPremisesSyncBehavior: navigation property; accepts an untyped value
- onenote: navigation property; accepts an untyped value
- onlineMeetings[].lobbyBypassSettings.scope: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: invited, organizationExcludingGuests; excluded from typed input validation
- onlineMeetings[].participants.attendees[]: polymorphic schema; accepts an untyped value
- onlineMeetings[].participants.organizer: polymorphic schema; accepts an untyped value
- outlook: navigation property; accepts an untyped value
- presence: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].acceptedSenders: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].assignedLabels: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].conversations: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].events: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].groupTypes: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].infoCatalogs: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].members: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].onPremisesExtensionAttributes: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].onenote: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].owners: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].photo: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].planner: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].rejectedSenders: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].resourceBehaviorOptions: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].resourceProvisioningOptions: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].settings: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].sites: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].team: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].threads: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedGroups[].transitiveMembers: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].assignedLicenses: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].authentication: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].authorizationInfo: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].chats: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].cloudClipboard: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].deviceManagementTroubleshootingEvents: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].employeeExperience: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].employeeOrgData: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].followedSites: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].identities: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].inferenceClassification: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].interests: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].joinedTeams: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].mailboxSettings: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].managedAppRegistrations: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].managedDevices: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].oauth2PermissionGrants: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].onenote: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].onlineMeetings: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].otherMails: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].outlook: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].passwordProfile: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].pastProjects: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].presence: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].print: recursive schema; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].responsibilities: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].schools: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].scopedRoleMemberOf: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].settings: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].skills: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].sponsors: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].todo: navigation property; accepts an untyped value
- print.recentPrinterShares[].allowedUsers[].transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].capabilities.finishings[]: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: stapleTripleLeft, stapleTripleTop, stapleTripleRight, stapleTripleBottom, bindLeft, bindTop, bindRight, bindBottom, foldAccordion, foldDoubleGate, foldGate, foldHalf, foldHalfZ, foldLeftGate, foldLetter, foldParallel, foldPoster, foldRightGate, foldZ, foldEngineeringZ, punchTopLeft, punchBottomLeft, punchTopRight, punchBottomRight, punchDualLeft, punchDualTop, punchDualRight, punchDualBottom, punchTripleLeft, punchTripleTop, punchTripleRight, punchTripleBottom, punchQuadLeft, punchQuadTop, punchQuadRight, punchQuadBottom, fold, trim, bale, bookletMaker, coat, laminate, trimAfterPages, trimAfterDocuments, trimAfterCopies, trimAfterJob; excluded from typed input validation
- print.recentPrinterShares[].defaults.finishings[]: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: stapleTripleLeft, stapleTripleTop, stapleTripleRight, stapleTripleBottom, bindLeft, bindTop, bindRight, bindBottom, foldAccordion, foldDoubleGate, foldGate, foldHalf, foldHalfZ, foldLeftGate, foldLetter, foldParallel, foldPoster, foldRightGate, foldZ, foldEngineeringZ, punchTopLeft, punchBottomLeft, punchTopRight, punchBottomRight, punchDualLeft, punchDualTop, punchDualRight, punchDualBottom, punchTripleLeft, punchTripleTop, punchTripleRight, punchTripleBottom, punchQuadLeft, punchQuadTop, punchQuadRight, punchQuadBottom, fold, trim, bale, bookletMaker, coat, laminate, trimAfterPages, trimAfterDocuments, trimAfterCopies, trimAfterJob; excluded from typed input validation
- print.recentPrinterShares[].jobs[].configuration: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].jobs[].createdBy: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].jobs[].documents: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].jobs[].status: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].jobs[].tasks: nested schema exceeds depth limit; accepts an untyped value
- print.recentPrinterShares[].location.latitude: polymorphic schema; accepts an untyped value
- print.recentPrinterShares[].location.longitude: polymorphic schema; accepts an untyped value
- print.recentPrinterShares[].printer: navigation property; accepts an untyped value
- scopedRoleMemberOf[].roleMemberInfo: polymorphic schema; accepts an untyped value
- serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- settings: navigation property; accepts an untyped value
- sponsors[]: polymorphic schema; accepts an untyped value
- todo: navigation property; accepts an untyped value
- transitiveMemberOf[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent verified module `verified/users` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
