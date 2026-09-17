# /teams

Create team

[Catalog](../../README.md) · [Teamwork and communications](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/team?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teams`, `GET/PATCH/DELETE /teams/{team-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/teams"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `all_channels` | `allChannels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       joinedUsers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       layoutType = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       membershipType = optional(any)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       moderationSettings = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(any)       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       messageId = optional(string)       sortOrderIndex = optional(string)       teamsApp = optional(any)       teamsAppId = optional(string)     })))       tenantId = optional(string)     }))` | no | no |
| `channels` | `channels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       joinedUsers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       layoutType = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       membershipType = optional(any)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       moderationSettings = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(any)       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       messageId = optional(string)       sortOrderIndex = optional(string)       teamsApp = optional(any)       teamsAppId = optional(string)     })))       tenantId = optional(string)     }))` | no | no |
| `classification` | `classification` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `discovery_settings` | `discoverySettings` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `first_channel_name` | `firstChannelName` | `string` | no | no |
| `fun_settings` | `funSettings` | `any` | no | no |
| `group` | `group` | `any` | no | no |
| `guest_settings` | `guestSettings` | `any` | no | no |
| `incoming_channels` | `incomingChannels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       joinedUsers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       layoutType = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       membershipType = optional(any)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       moderationSettings = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(any)       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       messageId = optional(string)       sortOrderIndex = optional(string)       teamsApp = optional(any)       teamsAppId = optional(string)     })))       tenantId = optional(string)     }))` | no | no |
| `installed_apps` | `installedApps` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppInstallation")       consentedPermissionSet = optional(any)       scopeInfo = optional(any)       teamsApp = optional(any)       teamsAppDefinition = optional(any)     }))` | no | no |
| `internal_id` | `internalId` | `string` | no | no |
| `is_membership_limited_to_owners` | `isMembershipLimitedToOwners` | `bool` | no | no |
| `member_settings` | `memberSettings` | `any` | no | no |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     }))` | no | no |
| `messaging_settings` | `messagingSettings` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     }))` | no | no |
| `owners` | `owners` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequest")       appDisplayName = optional(string)       appId = optional(string)       consentType = optional(string)       pendingScopes = optional(any)       userConsentRequests = optional(any)     })))       appRoleAssignedResources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.servicePrincipal")       accountEnabled = optional(bool)       addIns = optional(any)       alternativeNames = optional(list(string))       appDescription = optional(string)       appDisplayName = optional(string)       appId = optional(string)       appManagementPolicies = optional(any)       appOwnerOrganizationId = optional(string)       appRoleAssignedTo = optional(any)       appRoleAssignmentRequired = optional(bool)       appRoleAssignments = optional(any)       appRoles = optional(any)       claimsMappingPolicies = optional(any)       claimsPolicy = optional(any)       customSecurityAttributes = optional(any)       delegatedPermissionClassifications = optional(any)       deletedDateTime = optional(string)       description = optional(string)       disabledByMicrosoftStatus = optional(string)       displayName = optional(string)       endpoints = optional(any)       errorUrl = optional(string)       federatedIdentityCredentials = optional(any)       homeRealmDiscoveryPolicies = optional(any)       homepage = optional(string)       info = optional(any)       isDisabled = optional(bool)       keyCredentials = optional(any)       licenseDetails = optional(any)       loginUrl = optional(string)       logoutUrl = optional(string)       notes = optional(string)       notificationEmailAddresses = optional(list(string))       owners = optional(any)       passwordCredentials = optional(any)       permissionGrantPreApprovalPolicies = optional(any)       preferredSingleSignOnMode = optional(string)       preferredTokenSigningKeyEndDateTime = optional(string)       preferredTokenSigningKeyThumbprint = optional(string)       publishedPermissionScopes = optional(any)       publisherName = optional(string)       remoteDesktopSecurityConfiguration = optional(any)       replyUrls = optional(list(string))       samlMetadataUrl = optional(string)       samlSingleSignOnSettings = optional(any)       servicePrincipalNames = optional(list(string))       servicePrincipalType = optional(string)       synchronization = optional(any)       tags = optional(list(string))       tokenEncryptionKeyId = optional(string)       tokenIssuancePolicies = optional(any)       tokenLifetimePolicies = optional(any)       transitiveMemberOf = optional(any)       verifiedPublisher = optional(any)     })))       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       approvals = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(any)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       operations = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(any)       cloudRealtimeCommunicationInfo = optional(any)       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceEnrollmentConfiguration")       assignments = optional(any)       createdDateTime = optional(string)       description = optional(string)       deviceEnrollmentConfigurationType = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       priority = optional(number)       roleScopeTagIds = optional(list(string))       version = optional(number)     })))       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceKey")       deviceId = optional(string)       keyMaterial = optional(string)       keyType = optional(string)     })))       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       additionalInformation = optional(any)       correlationId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       troubleshootingErrorDetails = optional(any)     })))       devices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(list(string))       alternativeSecurityIds = optional(any)       commands = optional(any)       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(any)       hostnames = optional(list(string))       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(list(string))       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(list(string))       transitiveMemberOf = optional(any)       usageRights = optional(any)     })))       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityGovernance = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     })))       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       azureADDeviceId = optional(string)       createdDateTime = optional(string)       deviceManufacturer = optional(string)       deviceModel = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managedAppLogCollectionRequests = optional(any)       managedDeviceId = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(any)       chassisType = optional(string)       chromeOSDeviceInfo = optional(any)       cloudPcRemoteActionResults = optional(any)       complianceState = optional(string)       configurationManagerClientHealthState = optional(any)       configurationManagerClientInformation = optional(any)       detectedApps = optional(any)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       deviceRegistrationState = optional(string)       deviceType = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       joinType = optional(string)       logCollectionRequests = optional(any)       lostModeState = optional(string)       managedDeviceMobileAppConfigurationStates = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementFeatures = optional(string)       managementState = optional(string)       notes = optional(string)       ownerType = optional(string)       partnerReportedThreatState = optional(string)       processorArchitecture = optional(string)       roleScopeTagIds = optional(list(string))       securityBaselineStates = optional(any)       skuFamily = optional(string)       users = optional(any)     })))       mobileAppIntentAndStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndState")       managedDeviceIdentifier = optional(string)       mobileAppList = optional(any)       userId = optional(string)     })))       mobileAppTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")       additionalInformation = optional(any)       appLogCollectionRequests = optional(any)       applicationId = optional(string)       correlationId = optional(string)       deviceId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       history = optional(any)       managedDeviceIdentifier = optional(string)       troubleshootingErrorDetails = optional(any)       userId = optional(string)     })))       mySite = optional(string)       notifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.notification")       displayTimeToLive = optional(number)       expirationDateTime = optional(string)       groupName = optional(string)       payload = optional(object({       odata_type = optional(string, "#microsoft.graph.payloadTypes")       rawContent = optional(string)       visualContent = optional(any)     }))       priority = optional(any)       targetHostName = optional(string)       targetPolicy = optional(any)     })))       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       expiryTime = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)       startTime = optional(string)     })))       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       broadcastRecording = optional(string)       broadcastSettings = optional(any)       capabilities = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       joinUrl = optional(string)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(any)       definition = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)       stages = optional(any)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")       deviceMacAddress = optional(string)       deviceName = optional(string)       deviceRegistrationId = optional(string)       deviceType = optional(string)       lastCheckInDateTime = optional(string)       userId = optional(string)     })))     }))` | no | yes |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `photo` | `photo` | `any` | no | no |
| `primary_channel` | `primaryChannel` | `any` | no | no |
| `schedule` | `schedule` | `any` | no | no |
| `specialization` | `specialization` | `any` | no | no |
| `summary` | `summary` | `any` | no | no |
| `tags` | `tags` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTag")       description = optional(string)       displayName = optional(string)       memberCount = optional(number)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTagMember")       displayName = optional(string)       tenantId = optional(string)       userId = optional(string)     })))       tagType = optional(any)       teamId = optional(string)     }))` | no | no |
| `template` | `template` | `any` | no | no |
| `template_definition` | `templateDefinition` | `any` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `visibility` | `visibility` | `any` | no | no |
| `web_url` | `webUrl` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- allChannels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].filesFolder: polymorphic schema; accepts an untyped value
- allChannels[].layoutType: polymorphic schema; accepts an untyped value
- allChannels[].membershipType: polymorphic schema; accepts an untyped value
- allChannels[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- allChannels[].messages[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- allChannels[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- allChannels[].messages[].from: polymorphic schema; accepts an untyped value
- allChannels[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].onBehalfOf: polymorphic schema; accepts an untyped value
- allChannels[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- allChannels[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].replies[]: recursive schema; accepts an untyped value
- allChannels[].migrationMode: polymorphic schema; accepts an untyped value
- allChannels[].moderationSettings: polymorphic schema; accepts an untyped value
- allChannels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].sharedWithTeams[].team: polymorphic schema; accepts an untyped value
- allChannels[].summary: polymorphic schema; accepts an untyped value
- allChannels[].tabs[].configuration: polymorphic schema; accepts an untyped value
- allChannels[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- channels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].filesFolder: polymorphic schema; accepts an untyped value
- channels[].layoutType: polymorphic schema; accepts an untyped value
- channels[].membershipType: polymorphic schema; accepts an untyped value
- channels[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- channels[].messages[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- channels[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- channels[].messages[].from: polymorphic schema; accepts an untyped value
- channels[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].onBehalfOf: polymorphic schema; accepts an untyped value
- channels[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- channels[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].replies[]: recursive schema; accepts an untyped value
- channels[].migrationMode: polymorphic schema; accepts an untyped value
- channels[].moderationSettings: polymorphic schema; accepts an untyped value
- channels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].sharedWithTeams[].team: polymorphic schema; accepts an untyped value
- channels[].summary: polymorphic schema; accepts an untyped value
- channels[].tabs[].configuration: polymorphic schema; accepts an untyped value
- channels[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- discoverySettings: polymorphic schema; accepts an untyped value
- funSettings: polymorphic schema; accepts an untyped value
- group: polymorphic schema; accepts an untyped value
- guestSettings: polymorphic schema; accepts an untyped value
- incomingChannels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].filesFolder: polymorphic schema; accepts an untyped value
- incomingChannels[].layoutType: polymorphic schema; accepts an untyped value
- incomingChannels[].membershipType: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].from: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].onBehalfOf: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].replies[]: recursive schema; accepts an untyped value
- incomingChannels[].migrationMode: polymorphic schema; accepts an untyped value
- incomingChannels[].moderationSettings: polymorphic schema; accepts an untyped value
- incomingChannels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].sharedWithTeams[].team: polymorphic schema; accepts an untyped value
- incomingChannels[].summary: polymorphic schema; accepts an untyped value
- incomingChannels[].tabs[].configuration: polymorphic schema; accepts an untyped value
- incomingChannels[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- installedApps[].consentedPermissionSet: polymorphic schema; accepts an untyped value
- installedApps[].scopeInfo: polymorphic schema; accepts an untyped value
- installedApps[].teamsApp: polymorphic schema; accepts an untyped value
- installedApps[].teamsAppDefinition: polymorphic schema; accepts an untyped value
- memberSettings: polymorphic schema; accepts an untyped value
- messagingSettings: polymorphic schema; accepts an untyped value
- operations[].error: polymorphic schema; accepts an untyped value
- owners[].analytics: polymorphic schema; accepts an untyped value
- owners[].appConsentRequestsForApproval[].pendingScopes[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appConsentRequestsForApproval[].userConsentRequests[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].addIns[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].appManagementPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].appRoleAssignedTo[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].appRoles[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].claimsMappingPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].claimsPolicy: polymorphic schema; accepts an untyped value
- owners[].appRoleAssignedResources[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- owners[].appRoleAssignedResources[].delegatedPermissionClassifications[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].endpoints[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].federatedIdentityCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].homeRealmDiscoveryPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].info: polymorphic schema; accepts an untyped value
- owners[].appRoleAssignedResources[].keyCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].licenseDetails[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].passwordCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].permissionGrantPreApprovalPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].publishedPermissionScopes[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].remoteDesktopSecurityConfiguration: polymorphic schema; accepts an untyped value
- owners[].appRoleAssignedResources[].samlSingleSignOnSettings: polymorphic schema; accepts an untyped value
- owners[].appRoleAssignedResources[].synchronization: polymorphic schema; accepts an untyped value
- owners[].appRoleAssignedResources[].tokenIssuancePolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].tokenLifetimePolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].appRoleAssignedResources[].verifiedPublisher: polymorphic schema; accepts an untyped value
- owners[].approvals[].steps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].authentication: polymorphic schema; accepts an untyped value
- owners[].authorizationInfo: polymorphic schema; accepts an untyped value
- owners[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- owners[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].migrationMode: polymorphic schema; accepts an untyped value
- owners[].chats[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].viewpoint: polymorphic schema; accepts an untyped value
- owners[].cloudClipboard: polymorphic schema; accepts an untyped value
- owners[].cloudLicensing: polymorphic schema; accepts an untyped value
- owners[].cloudRealtimeCommunicationInfo: polymorphic schema; accepts an untyped value
- owners[].communications: polymorphic schema; accepts an untyped value
- owners[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- owners[].deviceEnrollmentConfigurations[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].deviceManagementTroubleshootingEvents[].additionalInformation[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].deviceManagementTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- owners[].devices[].alternativeSecurityIds[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].commands[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].extensionAttributes: polymorphic schema; accepts an untyped value
- owners[].devices[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].devices[].usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].employeeOrgData: polymorphic schema; accepts an untyped value
- owners[].followedSites[].analytics: polymorphic schema; accepts an untyped value
- owners[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].createdByUser: polymorphic schema; accepts an untyped value
- owners[].followedSites[].deleted: polymorphic schema; accepts an untyped value
- owners[].followedSites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].drive: polymorphic schema; accepts an untyped value
- owners[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].informationProtection: polymorphic schema; accepts an untyped value
- owners[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- owners[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].lockState: polymorphic schema; accepts an untyped value
- owners[].followedSites[].onenote: polymorphic schema; accepts an untyped value
- owners[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- owners[].followedSites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].parentReference: polymorphic schema; accepts an untyped value
- owners[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].recycleBin: polymorphic schema; accepts an untyped value
- owners[].followedSites[].sites[]: recursive schema; accepts an untyped value
- owners[].followedSites[].template: polymorphic schema; accepts an untyped value
- owners[].followedSites[].termStore: polymorphic schema; accepts an untyped value
- owners[].identityGovernance: polymorphic schema; accepts an untyped value
- owners[].inferenceClassification: polymorphic schema; accepts an untyped value
- owners[].informationProtection: polymorphic schema; accepts an untyped value
- owners[].invitedBy: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].acceptedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].accessType: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].assignedLabels[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].conversations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].events[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].members[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].onenote: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].photo: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].rejectedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].settings[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].sites[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].team: polymorphic schema; accepts an untyped value
- owners[].joinedGroups[].threads[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].transitiveMembers[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value
- owners[].mailboxSettings: polymorphic schema; accepts an untyped value
- owners[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- owners[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedAppRegistrations[].managedAppLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].assignmentFilterEvaluationStatusDetails[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].chromeOSDeviceInfo[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].cloudPcRemoteActionResults[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].configurationManagerClientHealthState: polymorphic schema; accepts an untyped value
- owners[].managedDevices[].configurationManagerClientInformation: polymorphic schema; accepts an untyped value
- owners[].managedDevices[].detectedApps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
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
- owners[].mobileAppTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- owners[].notifications[].payload.visualContent: polymorphic schema; accepts an untyped value
- owners[].notifications[].priority: polymorphic schema; accepts an untyped value
- owners[].notifications[].targetPolicy: polymorphic schema; accepts an untyped value
- owners[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- owners[].onenote: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].anonymizeIdentityForRoles[]: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].capabilities[]: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].registration: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- owners[].onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- owners[].passwordProfile: polymorphic schema; accepts an untyped value
- owners[].pendingAccessReviewInstances[].decisions[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].pendingAccessReviewInstances[].definition: polymorphic schema; accepts an untyped value
- owners[].pendingAccessReviewInstances[].fallbackReviewers[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].pendingAccessReviewInstances[].reviewers[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].pendingAccessReviewInstances[].stages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].presence: polymorphic schema; accepts an untyped value
- owners[].print: polymorphic schema; accepts an untyped value
- owners[].profile: polymorphic schema; accepts an untyped value
- owners[].security: polymorphic schema; accepts an untyped value
- owners[].settings: polymorphic schema; accepts an untyped value
- owners[].todo: polymorphic schema; accepts an untyped value
- owners[].virtualEvents: polymorphic schema; accepts an untyped value
- photo: polymorphic schema; accepts an untyped value
- primaryChannel: polymorphic schema; accepts an untyped value
- schedule: polymorphic schema; accepts an untyped value
- specialization: polymorphic schema; accepts an untyped value
- summary: polymorphic schema; accepts an untyped value
- tags[].tagType: polymorphic schema; accepts an untyped value
- template: polymorphic schema; accepts an untyped value
- templateDefinition: polymorphic schema; accepts an untyped value
- visibility: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
