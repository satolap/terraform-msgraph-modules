# /employeeExperience/communities

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `owners`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create community

[Catalog](../../README.md) Â· [Employee experience](../../README.md#employee-experience) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/community?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /employeeExperience/communities`, `GET/PATCH/DELETE /employeeExperience/communities/{community-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/employee-experience/communities"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `group` | `group` | `any` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `owners` | `owners` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequest")       appDisplayName = optional(string)       appId = optional(string)       consentType = optional(string)       pendingScopes = optional(any)       userConsentRequests = optional(any)     })))       appRoleAssignedResources = optional(any)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       approvals = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(any)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(list(string))     }))       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(string)       operations = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(object({       odata_type = optional(string, "#microsoft.graph.chatViewpoint")       isHidden = optional(bool)       lastMessageReadDateTime = optional(string)     }))     })))       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.userCloudLicensing")       assignmentErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignmentError")       assignedTo = optional(any)       code = optional(string)       message = optional(string)       occurrenceDateTime = optional(string)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")       allotment = optional(any)       assignedTo = optional(any)       disabledServicePlanIds = optional(any)     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.usageRight")       allotments = optional(any)       assignments = optional(any)       externalServiceIdentifier = optional(string)     })))       waitingMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.waitingMember")       allotment = optional(any)       assignedTo = optional(any)       waitingSinceDateTime = optional(string)     })))     }))       cloudRealtimeCommunicationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudRealtimeCommunicationInfo")     }))       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(any)       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceKey")       deviceId = optional(string)       keyMaterial = optional(string)       keyType = optional(string)     })))       deviceManagementTroubleshootingEvents = optional(any)       devices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(list(string))       alternativeSecurityIds = optional(any)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.deviceCloudLicensing")       assignments = optional(any)       usageRights = optional(any)       waitingMembers = optional(any)     }))       commands = optional(any)       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       hostnames = optional(list(string))       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(list(string))       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(list(string))       transitiveMemberOf = optional(any)       usageRights = optional(any)     })))       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     }))       employeeType = optional(string)       extensions = optional(any)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityGovernance = optional(object({       odata_type = optional(string, "#microsoft.graph.identityGovernanceUserSettings")       approverDelegate = optional(object({       odata_type = optional(string, "#microsoft.graph.approverDelegate")       delegate = optional(any)       schedule = optional(object({       odata_type = optional(string, "#microsoft.graph.requestSchedule")       expiration = optional(any)       recurrence = optional(any)       startDateTime = optional(string)     }))     }))     }))       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")       assignments = optional(any)       usageRights = optional(any)     }))       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")       extensionAttribute1 = optional(string)       extensionAttribute10 = optional(string)       extensionAttribute11 = optional(string)       extensionAttribute12 = optional(string)       extensionAttribute13 = optional(string)       extensionAttribute14 = optional(string)       extensionAttribute15 = optional(string)       extensionAttribute2 = optional(string)       extensionAttribute3 = optional(string)       extensionAttribute4 = optional(string)       extensionAttribute5 = optional(string)       extensionAttribute6 = optional(string)       extensionAttribute7 = optional(string)       extensionAttribute8 = optional(string)       extensionAttribute9 = optional(string)     }))       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.groupWritebackConfiguration")       isEnabled = optional(bool)       onPremisesGroupType = optional(string)     }))     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       automaticRepliesSetting = optional(object({       odata_type = optional(string, "#microsoft.graph.automaticRepliesSetting")       externalAudience = optional(string)       externalReplyMessage = optional(string)       internalReplyMessage = optional(string)       scheduledEndDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       scheduledStartDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       status = optional(string)     }))       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(object({       odata_type = optional(string, "#microsoft.graph.localeInfo")       displayName = optional(string)       locale = optional(string)     }))       timeFormat = optional(string)       timeZone = optional(string)       userPurposeV2 = optional(string)       workingHours = optional(object({       odata_type = optional(string, "#microsoft.graph.workingHours")       daysOfWeek = optional(list(string))       endTime = optional(string)       startTime = optional(string)       timeZone = optional(any)     }))     }))       managedAppLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     })))       managedAppRegistrations = optional(any)       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(any)       chromeOSDeviceInfo = optional(any)       cloudPcRemoteActionResults = optional(any)       configurationManagerClientHealthState = optional(object({       odata_type = optional(string, "#microsoft.graph.configurationManagerClientHealthState")       errorCode = optional(number)       lastSyncDateTime = optional(string)       state = optional(string)     }))       configurationManagerClientInformation = optional(object({       odata_type = optional(string, "#microsoft.graph.configurationManagerClientInformation")       clientIdentifier = optional(string)       clientVersion = optional(string)       isBlocked = optional(bool)     }))       detectedApps = optional(any)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       joinType = optional(string)       logCollectionRequests = optional(any)       managedDeviceMobileAppConfigurationStates = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementFeatures = optional(string)       notes = optional(string)       ownerType = optional(string)       roleScopeTagIds = optional(list(string))       securityBaselineStates = optional(any)       skuFamily = optional(string)       users = optional(any)     })))       mobileAppIntentAndStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndState")       managedDeviceIdentifier = optional(string)       mobileAppList = optional(any)       userId = optional(string)     })))       mobileAppTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")       additionalInformation = optional(any)       appLogCollectionRequests = optional(any)       applicationId = optional(string)       correlationId = optional(string)       deviceId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       history = optional(any)       managedDeviceIdentifier = optional(string)       troubleshootingErrorDetails = optional(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingErrorDetails")       context = optional(string)       failure = optional(string)       failureDetails = optional(string)       remediation = optional(string)       resources = optional(any)     }))       userId = optional(string)     })))       mySite = optional(string)       notifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.notification")       displayTimeToLive = optional(number)       expirationDateTime = optional(string)       groupName = optional(string)       payload = optional(object({       odata_type = optional(string, "#microsoft.graph.payloadTypes")       rawContent = optional(string)       visualContent = optional(any)     }))       priority = optional(string)       targetHostName = optional(string)       targetPolicy = optional(object({       odata_type = optional(string, "#microsoft.graph.targetPolicyEndpoints")       platformTypes = optional(any)     }))     })))       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       expiryTime = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)       startTime = optional(string)     })))       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       anonymizeIdentityForRoles = optional(list(string))       broadcastRecording = optional(string)       broadcastSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingSettings")       allowedAudience = optional(string)       captions = optional(any)       isAttendeeReportEnabled = optional(bool)       isQuestionAndAnswerEnabled = optional(bool)       isRecordingEnabled = optional(bool)       isVideoOnDemandEnabled = optional(bool)     }))       capabilities = optional(list(string))       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       joinUrl = optional(string)       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(object({       odata_type = optional(string, "#microsoft.graph.meetingParticipants")       attendees = optional(any)       contributors = optional(any)       organizer = optional(any)       producers = optional(any)     }))       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     })))       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(any)       definition = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)       stages = optional(any)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printerShare")       allowAllUsers = optional(bool)       allowedGroups = optional(any)       allowedUsers = optional(any)       capabilities = optional(any)       defaults = optional(any)       displayName = optional(string)       isAcceptingJobs = optional(bool)       jobs = optional(any)       location = optional(any)       manufacturer = optional(string)       model = optional(string)       name = optional(string)       printer = optional(any)       status = optional(any)       viewPoint = optional(any)     })))     }))       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")       deviceMacAddress = optional(string)       deviceName = optional(string)       deviceRegistrationId = optional(string)       deviceType = optional(string)       lastCheckInDateTime = optional(string)       userId = optional(string)     })))     }))` | no | yes | in place |
| `privacy` | `privacy` | `string` | no | no | in place |
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

Server-assigned properties in `response`: `groupId`, `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /employeeExperience/communities` | DelegatedWork | `Community.ReadWrite.All` | — |
| `POST /employeeExperience/communities` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /employeeExperience/communities` | Application | `Community.ReadWrite.All` | — |
| `GET /employeeExperience/communities/{community-id}` | DelegatedWork | `Community.Read.All` | — |
| `GET /employeeExperience/communities/{community-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /employeeExperience/communities/{community-id}` | Application | `Community.Read.All` | — |
| `PATCH /employeeExperience/communities/{community-id}` | DelegatedWork | `Community.ReadWrite.All` | — |
| `PATCH /employeeExperience/communities/{community-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /employeeExperience/communities/{community-id}` | Application | `Community.ReadWrite.All` | — |
| `DELETE /employeeExperience/communities/{community-id}` | DelegatedWork | `Community.ReadWrite.All` | — |
| `DELETE /employeeExperience/communities/{community-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /employeeExperience/communities/{community-id}` | Application | `Community.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- group: navigation property; accepts an untyped value
- owners[].analytics: navigation property; accepts an untyped value
- owners[].appConsentRequestsForApproval[].pendingScopes[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appConsentRequestsForApproval[].userConsentRequests[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[]: polymorphic schema; accepts an untyped value
- owners[].approvals[].steps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].authentication: navigation property; accepts an untyped value
- owners[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].lastMessagePreview: navigation property; accepts an untyped value
- owners[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudClipboard: navigation property; accepts an untyped value
- owners[].cloudLicensing.assignmentErrors[].assignedTo: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudLicensing.assignments[].allotment: navigation property; accepts an untyped value
- owners[].cloudLicensing.assignments[].assignedTo: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudLicensing.assignments[].disabledServicePlanIds: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudLicensing.usageRights[].allotments: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudLicensing.usageRights[].assignments: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudLicensing.waitingMembers[].allotment: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudLicensing.waitingMembers[].assignedTo: nested schema exceeds depth limit; accepts an untyped value
- owners[].communications: navigation property; accepts an untyped value
- owners[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- owners[].deviceEnrollmentConfigurations[]: polymorphic schema; accepts an untyped value
- owners[].deviceManagementTroubleshootingEvents[]: polymorphic schema; accepts an untyped value
- owners[].devices[].alternativeSecurityIds[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].cloudLicensing.assignments: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].cloudLicensing.usageRights: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].cloudLicensing.waitingMembers: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].commands[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].extensions[]: polymorphic schema; accepts an untyped value
- owners[].followedSites[].analytics: navigation property; accepts an untyped value
- owners[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].createdByUser: polymorphic schema; accepts an untyped value
- owners[].followedSites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].drive: navigation property; accepts an untyped value
- owners[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].informationProtection: navigation property; accepts an untyped value
- owners[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- owners[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].onenote: navigation property; accepts an untyped value
- owners[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].recycleBin: navigation property; accepts an untyped value
- owners[].followedSites[].sites[]: recursive schema; accepts an untyped value
- owners[].followedSites[].termStore: navigation property; accepts an untyped value
- owners[].identityGovernance.approverDelegate.delegate: polymorphic schema; accepts an untyped value
- owners[].identityGovernance.approverDelegate.schedule.expiration: nested schema exceeds depth limit; accepts an untyped value
- owners[].identityGovernance.approverDelegate.schedule.recurrence: nested schema exceeds depth limit; accepts an untyped value
- owners[].inferenceClassification: navigation property; accepts an untyped value
- owners[].informationProtection: navigation property; accepts an untyped value
- owners[].invitedBy: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].acceptedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].assignedLabels[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].cloudLicensing.assignments: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].cloudLicensing.usageRights: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].conversations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].events[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].members[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- owners[].joinedGroups[].onenote: navigation property; accepts an untyped value
- owners[].joinedGroups[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].photo: navigation property; accepts an untyped value
- owners[].joinedGroups[].rejectedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].settings[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].sites[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].team: navigation property; accepts an untyped value
- owners[].joinedGroups[].threads[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].transitiveMembers[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].mailboxSettings.workingHours.timeZone: polymorphic schema; accepts an untyped value
- owners[].managedAppRegistrations[]: polymorphic schema; accepts an untyped value
- owners[].managedDevices[].assignmentFilterEvaluationStatusDetails[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].chromeOSDeviceInfo[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].cloudPcRemoteActionResults[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].detectedApps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].deviceCategory: navigation property; accepts an untyped value
- owners[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].managedDeviceMobileAppConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].securityBaselineStates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].users[]: recursive schema; accepts an untyped value
- owners[].mobileAppIntentAndStates[].mobileAppList[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].mobileAppTroubleshootingEvents[].additionalInformation[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].mobileAppTroubleshootingEvents[].appLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].mobileAppTroubleshootingEvents[].history[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].mobileAppTroubleshootingEvents[].troubleshootingErrorDetails.resources: nested schema exceeds depth limit; accepts an untyped value
- owners[].notifications[].payload.visualContent: nested schema exceeds depth limit; accepts an untyped value
- owners[].notifications[].targetPolicy.platformTypes: nested schema exceeds depth limit; accepts an untyped value
- owners[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- owners[].onenote: navigation property; accepts an untyped value
- owners[].onlineMeetings[].anonymizeIdentityForRoles[]: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: coorganizer; excluded from typed input validation
- owners[].onlineMeetings[].broadcastSettings.captions: nested schema exceeds depth limit; accepts an untyped value
- owners[].onlineMeetings[].lobbyBypassSettings.scope: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: invited, organizationExcludingGuests; excluded from typed input validation
- owners[].onlineMeetings[].participants.attendees: nested schema exceeds depth limit; accepts an untyped value
- owners[].onlineMeetings[].participants.contributors: nested schema exceeds depth limit; accepts an untyped value
- owners[].onlineMeetings[].participants.organizer: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].participants.producers: nested schema exceeds depth limit; accepts an untyped value
- owners[].onlineMeetings[].registration: navigation property; accepts an untyped value
- owners[].pendingAccessReviewInstances[].decisions[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].pendingAccessReviewInstances[].definition: navigation property; accepts an untyped value
- owners[].pendingAccessReviewInstances[].fallbackReviewers[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].pendingAccessReviewInstances[].reviewers[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].pendingAccessReviewInstances[].stages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].presence: navigation property; accepts an untyped value
- owners[].print.recentPrinterShares[].allowedGroups: nested schema exceeds depth limit; accepts an untyped value
- owners[].print.recentPrinterShares[].allowedUsers: nested schema exceeds depth limit; accepts an untyped value
- owners[].print.recentPrinterShares[].capabilities: nested schema exceeds depth limit; accepts an untyped value
- owners[].print.recentPrinterShares[].defaults: nested schema exceeds depth limit; accepts an untyped value
- owners[].print.recentPrinterShares[].jobs: nested schema exceeds depth limit; accepts an untyped value
- owners[].print.recentPrinterShares[].location: nested schema exceeds depth limit; accepts an untyped value
- owners[].print.recentPrinterShares[].printer: navigation property; accepts an untyped value
- owners[].print.recentPrinterShares[].status: nested schema exceeds depth limit; accepts an untyped value
- owners[].print.recentPrinterShares[].viewPoint: nested schema exceeds depth limit; accepts an untyped value
- owners[].profile: navigation property; accepts an untyped value
- owners[].security: navigation property; accepts an untyped value
- owners[].serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- owners[].settings: navigation property; accepts an untyped value
- owners[].sponsors[]: polymorphic schema; accepts an untyped value
- owners[].todo: navigation property; accepts an untyped value
- owners[].transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- owners[].virtualEvents: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
