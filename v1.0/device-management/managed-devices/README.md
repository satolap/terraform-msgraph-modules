# /deviceManagement/managedDevices

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `users`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create new navigation property to managedDevices for deviceManagement

[Catalog](../../README.md) Â· [Device and app management](../../README.md#device-and-app-management) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-manageddevice?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/managedDevices`, `GET/PATCH/DELETE /deviceManagement/managedDevices/{managedDevice-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/device-management/managed-devices"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `device_category` | `deviceCategory` | `any` | no | no | in place |
| `device_compliance_policy_states` | `deviceCompliancePolicyStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicySettingState")       currentValue = optional(string)       errorCode = optional(number)       errorDescription = optional(string)       instanceDisplayName = optional(string)       setting = optional(string)       settingName = optional(string)       sources = optional(any)       state = optional(string)       userEmail = optional(string)       userId = optional(string)       userName = optional(string)       userPrincipalName = optional(string)     })))       state = optional(string)       version = optional(number)     }))` | no | no | in place |
| `device_configuration_states` | `deviceConfigurationStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationSettingState")       currentValue = optional(string)       errorCode = optional(number)       errorDescription = optional(string)       instanceDisplayName = optional(string)       setting = optional(string)       settingName = optional(string)       sources = optional(any)       state = optional(string)       userEmail = optional(string)       userId = optional(string)       userName = optional(string)       userPrincipalName = optional(string)     })))       state = optional(string)       version = optional(number)     }))` | no | no | in place |
| `log_collection_requests` | `logCollectionRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceLogCollectionResponse")       enrolledByUser = optional(string)       expirationDateTimeUTC = optional(string)       initiatedByUserPrincipalName = optional(string)       managedDeviceId = optional(string)       receivedDateTimeUTC = optional(string)       requestedDateTimeUTC = optional(string)       sizeInKB = optional(any)       status = optional(string)     }))` | no | no | in place |
| `managed_device_name` | `managedDeviceName` | `string` | no | no | in place |
| `managed_device_owner_type` | `managedDeviceOwnerType` | `string` | no | no | in place |
| `notes` | `notes` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `users` | `users` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(list(string))     }))       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(object({       odata_type = optional(string, "#microsoft.graph.chatViewpoint")       isHidden = optional(bool)       lastMessageReadDateTime = optional(string)     }))     })))       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(any)       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     }))       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(any)       message = optional(string)       target = optional(string)     }))       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(any)       channels = optional(any)       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamFunSettings")       allowCustomMemes = optional(bool)       allowGiphy = optional(bool)       allowStickersAndMemes = optional(bool)       giphyContentRating = optional(string)     }))       group = optional(any)       guestSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamGuestSettings")       allowCreateUpdateChannels = optional(bool)       allowDeleteChannels = optional(bool)     }))       incomingChannels = optional(any)       installedApps = optional(any)       internalId = optional(string)       memberSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamMemberSettings")       allowAddRemoveApps = optional(bool)       allowCreatePrivateChannels = optional(bool)       allowCreateUpdateChannels = optional(bool)       allowCreateUpdateRemoveConnectors = optional(bool)       allowCreateUpdateRemoveTabs = optional(bool)       allowDeleteChannels = optional(bool)     }))       members = optional(any)       messagingSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamMessagingSettings")       allowChannelMentions = optional(bool)       allowOwnerDeleteMessages = optional(bool)       allowTeamMentions = optional(bool)       allowUserDeleteMessages = optional(bool)       allowUserEditMessages = optional(bool)     }))       operations = optional(any)       permissionGrants = optional(any)       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(string)       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.teamSummary")       guestsCount = optional(number)       membersCount = optional(number)       ownersCount = optional(number)     }))       tags = optional(any)       template = optional(any)       tenantId = optional(string)       visibility = optional(string)       webUrl = optional(string)     })))       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       archiveFolder = optional(string)       automaticRepliesSetting = optional(object({       odata_type = optional(string, "#microsoft.graph.automaticRepliesSetting")       externalAudience = optional(string)       externalReplyMessage = optional(string)       internalReplyMessage = optional(string)       scheduledEndDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       scheduledStartDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       status = optional(string)     }))       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(object({       odata_type = optional(string, "#microsoft.graph.localeInfo")       displayName = optional(string)       locale = optional(string)     }))       timeFormat = optional(string)       timeZone = optional(string)       workingHours = optional(object({       odata_type = optional(string, "#microsoft.graph.workingHours")       daysOfWeek = optional(list(string))       endTime = optional(string)       startTime = optional(string)       timeZone = optional(any)     }))     }))       managedAppRegistrations = optional(list(object({       odata_type = string       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       logCollectionRequests = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       notes = optional(string)       users = optional(any)     })))       mySite = optional(string)       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     })))       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       broadcastSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingSettings")       allowedAudience = optional(string)       captions = optional(any)       isAttendeeReportEnabled = optional(bool)       isQuestionAndAnswerEnabled = optional(bool)       isRecordingEnabled = optional(bool)       isVideoOnDemandEnabled = optional(bool)     }))       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(object({       odata_type = optional(string, "#microsoft.graph.meetingParticipants")       attendees = optional(any)       organizer = optional(any)     }))       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     })))       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       pastProjects = optional(list(string))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printerShare")       allowAllUsers = optional(bool)       allowedGroups = optional(any)       allowedUsers = optional(any)       capabilities = optional(any)       defaults = optional(any)       displayName = optional(string)       isAcceptingJobs = optional(bool)       jobs = optional(any)       location = optional(any)       manufacturer = optional(string)       model = optional(string)       printer = optional(any)       status = optional(any)       viewPoint = optional(any)     })))     }))       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(any)     })))       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults, except for abstract types listed in the generation notes: set their `odata_type` to a concrete type.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `activationLockBypassCode`, `androidSecurityPatchLevel`, `azureADDeviceId`, `azureADRegistered`, `complianceGracePeriodExpirationDateTime`, `complianceState`, `configurationManagerClientEnabledFeatures`, `deviceActionResults`, `deviceCategoryDisplayName`, `deviceEnrollmentType`, `deviceHealthAttestationState`, `deviceName`, `deviceRegistrationState`, `easActivated`, `easActivationDateTime`, `easDeviceId`, `emailAddress`, `enrolledDateTime`, `enrollmentProfileName`, `ethernetMacAddress`, `exchangeAccessState`, `exchangeAccessStateReason`, `exchangeLastSuccessfulSyncDateTime`, `freeStorageSpaceInBytes`, `iccid`, `id`, `imei`, `isEncrypted`, `isSupervised`, `jailBroken`, `lastSyncDateTime`, `managementAgent`, `managementCertificateExpirationDate`, `managementState`, `manufacturer`, `meid`, `model`, `operatingSystem`, `osVersion`, `partnerReportedThreatState`, `phoneNumber`, `physicalMemoryInBytes`, `remoteAssistanceSessionErrorDetails`, `remoteAssistanceSessionUrl`, `requireUserEnrollmentApproval`, `serialNumber`, `subscriberCarrier`, `totalStorageSpaceInBytes`, `udid`, `userDisplayName`, `userId`, `userPrincipalName`, `wiFiMacAddress`, `windowsProtectionState`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- deviceCategory: navigation property; accepts an untyped value
- deviceCompliancePolicyStates[].settingStates[].sources[]: nested schema exceeds depth limit; accepts an untyped value
- deviceConfigurationStates[].settingStates[].sources[]: nested schema exceeds depth limit; accepts an untyped value
- logCollectionRequests[].sizeInKB: polymorphic schema; accepts an untyped value
- users[].authentication: navigation property; accepts an untyped value
- users[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- users[].chats[].lastMessagePreview: navigation property; accepts an untyped value
- users[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- users[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- users[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- users[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- users[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- users[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- users[].cloudClipboard: navigation property; accepts an untyped value
- users[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- users[].deviceManagementTroubleshootingEvents[]: polymorphic schema; accepts an untyped value
- users[].employeeExperience: navigation property; accepts an untyped value
- users[].followedSites[].analytics: navigation property; accepts an untyped value
- users[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].drive: navigation property; accepts an untyped value
- users[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].error.details: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].error.innerError: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].onenote: navigation property; accepts an untyped value
- users[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- users[].followedSites[].sites[]: recursive schema; accepts an untyped value
- users[].followedSites[].termStore: navigation property; accepts an untyped value
- users[].followedSites[].termStores[]: nested schema exceeds depth limit; accepts an untyped value
- users[].inferenceClassification: navigation property; accepts an untyped value
- users[].joinedTeams[].allChannels[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].channels[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].group: navigation property; accepts an untyped value
- users[].joinedTeams[].incomingChannels[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].members[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].photo: navigation property; accepts an untyped value
- users[].joinedTeams[].primaryChannel: navigation property; accepts an untyped value
- users[].joinedTeams[].schedule: navigation property; accepts an untyped value
- users[].joinedTeams[].tags[]: nested schema exceeds depth limit; accepts an untyped value
- users[].joinedTeams[].template: navigation property; accepts an untyped value
- users[].mailboxSettings.workingHours.timeZone: polymorphic schema; accepts an untyped value
- users[].managedAppRegistrations[].@odata.type: microsoft.graph.managedAppRegistration is abstract; odata_type has no default and must name a concrete type
- users[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- users[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- users[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- users[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- users[].managedDevices[].deviceCategory: navigation property; accepts an untyped value
- users[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- users[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- users[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- users[].managedDevices[].users[]: recursive schema; accepts an untyped value
- users[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- users[].onenote: navigation property; accepts an untyped value
- users[].onlineMeetings[].broadcastSettings.captions: nested schema exceeds depth limit; accepts an untyped value
- users[].onlineMeetings[].lobbyBypassSettings.scope: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: invited, organizationExcludingGuests; excluded from typed input validation
- users[].onlineMeetings[].participants.attendees: nested schema exceeds depth limit; accepts an untyped value
- users[].onlineMeetings[].participants.organizer: polymorphic schema; accepts an untyped value
- users[].outlook: navigation property; accepts an untyped value
- users[].presence: navigation property; accepts an untyped value
- users[].print.recentPrinterShares[].allowedGroups: nested schema exceeds depth limit; accepts an untyped value
- users[].print.recentPrinterShares[].allowedUsers: nested schema exceeds depth limit; accepts an untyped value
- users[].print.recentPrinterShares[].capabilities: nested schema exceeds depth limit; accepts an untyped value
- users[].print.recentPrinterShares[].defaults: nested schema exceeds depth limit; accepts an untyped value
- users[].print.recentPrinterShares[].jobs: nested schema exceeds depth limit; accepts an untyped value
- users[].print.recentPrinterShares[].location: nested schema exceeds depth limit; accepts an untyped value
- users[].print.recentPrinterShares[].printer: navigation property; accepts an untyped value
- users[].print.recentPrinterShares[].status: nested schema exceeds depth limit; accepts an untyped value
- users[].print.recentPrinterShares[].viewPoint: nested schema exceeds depth limit; accepts an untyped value
- users[].scopedRoleMemberOf[].roleMemberInfo: polymorphic schema; accepts an untyped value
- users[].serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- users[].settings: navigation property; accepts an untyped value
- users[].sponsors[]: polymorphic schema; accepts an untyped value
- users[].todo: navigation property; accepts an untyped value
- users[].transitiveMemberOf[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
