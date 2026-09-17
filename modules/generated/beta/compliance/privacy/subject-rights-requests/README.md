# /privacy/subjectRightsRequests

Create subjectRightsRequest

[Catalog](../../../README.md) · [Compliance](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/subjectrightsrequest?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /privacy/subjectRightsRequests`, `GET/PATCH/DELETE /privacy/subjectRightsRequests/{subjectRightsRequest-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./compliance/privacy/subject-rights-requests"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `approvers` | `approvers` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequest")       appDisplayName = optional(string)       appId = optional(string)       consentType = optional(string)       pendingScopes = optional(any)       userConsentRequests = optional(any)     })))       appRoleAssignedResources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.servicePrincipal")       accountEnabled = optional(bool)       addIns = optional(any)       alternativeNames = optional(list(string))       appDescription = optional(string)       appDisplayName = optional(string)       appId = optional(string)       appManagementPolicies = optional(any)       appOwnerOrganizationId = optional(string)       appRoleAssignedTo = optional(any)       appRoleAssignmentRequired = optional(bool)       appRoleAssignments = optional(any)       appRoles = optional(any)       claimsMappingPolicies = optional(any)       claimsPolicy = optional(any)       customSecurityAttributes = optional(any)       delegatedPermissionClassifications = optional(any)       deletedDateTime = optional(string)       description = optional(string)       disabledByMicrosoftStatus = optional(string)       displayName = optional(string)       endpoints = optional(any)       errorUrl = optional(string)       federatedIdentityCredentials = optional(any)       homeRealmDiscoveryPolicies = optional(any)       homepage = optional(string)       info = optional(any)       isDisabled = optional(bool)       keyCredentials = optional(any)       licenseDetails = optional(any)       loginUrl = optional(string)       logoutUrl = optional(string)       notes = optional(string)       notificationEmailAddresses = optional(list(string))       owners = optional(any)       passwordCredentials = optional(any)       permissionGrantPreApprovalPolicies = optional(any)       preferredSingleSignOnMode = optional(string)       preferredTokenSigningKeyEndDateTime = optional(string)       preferredTokenSigningKeyThumbprint = optional(string)       publishedPermissionScopes = optional(any)       publisherName = optional(string)       remoteDesktopSecurityConfiguration = optional(any)       replyUrls = optional(list(string))       samlMetadataUrl = optional(string)       samlSingleSignOnSettings = optional(any)       servicePrincipalNames = optional(list(string))       servicePrincipalType = optional(string)       synchronization = optional(any)       tags = optional(list(string))       tokenEncryptionKeyId = optional(string)       tokenIssuancePolicies = optional(any)       tokenLifetimePolicies = optional(any)       transitiveMemberOf = optional(any)       verifiedPublisher = optional(any)     })))       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       approvals = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(any)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       operations = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(any)       cloudRealtimeCommunicationInfo = optional(any)       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceEnrollmentConfiguration")       assignments = optional(any)       createdDateTime = optional(string)       description = optional(string)       deviceEnrollmentConfigurationType = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       priority = optional(number)       roleScopeTagIds = optional(list(string))       version = optional(number)     })))       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceKey")       deviceId = optional(string)       keyMaterial = optional(string)       keyType = optional(string)     })))       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       additionalInformation = optional(any)       correlationId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       troubleshootingErrorDetails = optional(any)     })))       devices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(list(string))       alternativeSecurityIds = optional(any)       commands = optional(any)       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(any)       hostnames = optional(list(string))       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(list(string))       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(list(string))       transitiveMemberOf = optional(any)       usageRights = optional(any)     })))       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityGovernance = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     })))       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       azureADDeviceId = optional(string)       createdDateTime = optional(string)       deviceManufacturer = optional(string)       deviceModel = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managedAppLogCollectionRequests = optional(any)       managedDeviceId = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(any)       chassisType = optional(string)       chromeOSDeviceInfo = optional(any)       cloudPcRemoteActionResults = optional(any)       complianceState = optional(string)       configurationManagerClientHealthState = optional(any)       configurationManagerClientInformation = optional(any)       detectedApps = optional(any)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       deviceRegistrationState = optional(string)       deviceType = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       joinType = optional(string)       logCollectionRequests = optional(any)       lostModeState = optional(string)       managedDeviceMobileAppConfigurationStates = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementFeatures = optional(string)       managementState = optional(string)       notes = optional(string)       ownerType = optional(string)       partnerReportedThreatState = optional(string)       processorArchitecture = optional(string)       roleScopeTagIds = optional(list(string))       securityBaselineStates = optional(any)       skuFamily = optional(string)       users = optional(any)     })))       mobileAppIntentAndStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndState")       managedDeviceIdentifier = optional(string)       mobileAppList = optional(any)       userId = optional(string)     })))       mobileAppTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")       additionalInformation = optional(any)       appLogCollectionRequests = optional(any)       applicationId = optional(string)       correlationId = optional(string)       deviceId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       history = optional(any)       managedDeviceIdentifier = optional(string)       troubleshootingErrorDetails = optional(any)       userId = optional(string)     })))       mySite = optional(string)       notifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.notification")       displayTimeToLive = optional(number)       expirationDateTime = optional(string)       groupName = optional(string)       payload = optional(object({       odata_type = optional(string, "#microsoft.graph.payloadTypes")       rawContent = optional(string)       visualContent = optional(any)     }))       priority = optional(any)       targetHostName = optional(string)       targetPolicy = optional(any)     })))       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       expiryTime = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)       startTime = optional(string)     })))       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       broadcastRecording = optional(string)       broadcastSettings = optional(any)       capabilities = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       joinUrl = optional(string)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(any)       definition = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)       stages = optional(any)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")       deviceMacAddress = optional(string)       deviceName = optional(string)       deviceRegistrationId = optional(string)       deviceType = optional(string)       lastCheckInDateTime = optional(string)       userId = optional(string)     })))     }))` | no | yes |
| `assigned_to` | `assignedTo` | `any` | no | no |
| `closed_date_time` | `closedDateTime` | `string` | no | no |
| `collaborators` | `collaborators` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequest")       appDisplayName = optional(string)       appId = optional(string)       consentType = optional(string)       pendingScopes = optional(any)       userConsentRequests = optional(any)     })))       appRoleAssignedResources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.servicePrincipal")       accountEnabled = optional(bool)       addIns = optional(any)       alternativeNames = optional(list(string))       appDescription = optional(string)       appDisplayName = optional(string)       appId = optional(string)       appManagementPolicies = optional(any)       appOwnerOrganizationId = optional(string)       appRoleAssignedTo = optional(any)       appRoleAssignmentRequired = optional(bool)       appRoleAssignments = optional(any)       appRoles = optional(any)       claimsMappingPolicies = optional(any)       claimsPolicy = optional(any)       customSecurityAttributes = optional(any)       delegatedPermissionClassifications = optional(any)       deletedDateTime = optional(string)       description = optional(string)       disabledByMicrosoftStatus = optional(string)       displayName = optional(string)       endpoints = optional(any)       errorUrl = optional(string)       federatedIdentityCredentials = optional(any)       homeRealmDiscoveryPolicies = optional(any)       homepage = optional(string)       info = optional(any)       isDisabled = optional(bool)       keyCredentials = optional(any)       licenseDetails = optional(any)       loginUrl = optional(string)       logoutUrl = optional(string)       notes = optional(string)       notificationEmailAddresses = optional(list(string))       owners = optional(any)       passwordCredentials = optional(any)       permissionGrantPreApprovalPolicies = optional(any)       preferredSingleSignOnMode = optional(string)       preferredTokenSigningKeyEndDateTime = optional(string)       preferredTokenSigningKeyThumbprint = optional(string)       publishedPermissionScopes = optional(any)       publisherName = optional(string)       remoteDesktopSecurityConfiguration = optional(any)       replyUrls = optional(list(string))       samlMetadataUrl = optional(string)       samlSingleSignOnSettings = optional(any)       servicePrincipalNames = optional(list(string))       servicePrincipalType = optional(string)       synchronization = optional(any)       tags = optional(list(string))       tokenEncryptionKeyId = optional(string)       tokenIssuancePolicies = optional(any)       tokenLifetimePolicies = optional(any)       transitiveMemberOf = optional(any)       verifiedPublisher = optional(any)     })))       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       approvals = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(any)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       operations = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(any)       cloudRealtimeCommunicationInfo = optional(any)       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceEnrollmentConfiguration")       assignments = optional(any)       createdDateTime = optional(string)       description = optional(string)       deviceEnrollmentConfigurationType = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       priority = optional(number)       roleScopeTagIds = optional(list(string))       version = optional(number)     })))       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceKey")       deviceId = optional(string)       keyMaterial = optional(string)       keyType = optional(string)     })))       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       additionalInformation = optional(any)       correlationId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       troubleshootingErrorDetails = optional(any)     })))       devices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(list(string))       alternativeSecurityIds = optional(any)       commands = optional(any)       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(any)       hostnames = optional(list(string))       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(list(string))       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(list(string))       transitiveMemberOf = optional(any)       usageRights = optional(any)     })))       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityGovernance = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     })))       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       azureADDeviceId = optional(string)       createdDateTime = optional(string)       deviceManufacturer = optional(string)       deviceModel = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managedAppLogCollectionRequests = optional(any)       managedDeviceId = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(any)       chassisType = optional(string)       chromeOSDeviceInfo = optional(any)       cloudPcRemoteActionResults = optional(any)       complianceState = optional(string)       configurationManagerClientHealthState = optional(any)       configurationManagerClientInformation = optional(any)       detectedApps = optional(any)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       deviceRegistrationState = optional(string)       deviceType = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       joinType = optional(string)       logCollectionRequests = optional(any)       lostModeState = optional(string)       managedDeviceMobileAppConfigurationStates = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementFeatures = optional(string)       managementState = optional(string)       notes = optional(string)       ownerType = optional(string)       partnerReportedThreatState = optional(string)       processorArchitecture = optional(string)       roleScopeTagIds = optional(list(string))       securityBaselineStates = optional(any)       skuFamily = optional(string)       users = optional(any)     })))       mobileAppIntentAndStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndState")       managedDeviceIdentifier = optional(string)       mobileAppList = optional(any)       userId = optional(string)     })))       mobileAppTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")       additionalInformation = optional(any)       appLogCollectionRequests = optional(any)       applicationId = optional(string)       correlationId = optional(string)       deviceId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       history = optional(any)       managedDeviceIdentifier = optional(string)       troubleshootingErrorDetails = optional(any)       userId = optional(string)     })))       mySite = optional(string)       notifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.notification")       displayTimeToLive = optional(number)       expirationDateTime = optional(string)       groupName = optional(string)       payload = optional(object({       odata_type = optional(string, "#microsoft.graph.payloadTypes")       rawContent = optional(string)       visualContent = optional(any)     }))       priority = optional(any)       targetHostName = optional(string)       targetPolicy = optional(any)     })))       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       expiryTime = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)       startTime = optional(string)     })))       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       broadcastRecording = optional(string)       broadcastSettings = optional(any)       capabilities = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       joinUrl = optional(string)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(any)       definition = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)       stages = optional(any)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")       deviceMacAddress = optional(string)       deviceName = optional(string)       deviceRegistrationId = optional(string)       deviceType = optional(string)       lastCheckInDateTime = optional(string)       userId = optional(string)     })))     }))` | no | yes |
| `content_query` | `contentQuery` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `data_subject` | `dataSubject` | `any` | no | no |
| `data_subject_type` | `dataSubjectType` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `history` | `history` | `list(object({       odata_type = optional(string, "#microsoft.graph.subjectRightsRequestHistory")       changedBy = optional(any)       eventDateTime = optional(string)       stage = optional(any)       stageStatus = optional(any)       type = optional(string)     }))` | no | no |
| `include_all_versions` | `includeAllVersions` | `bool` | no | no |
| `include_authored_content` | `includeAuthoredContent` | `bool` | no | no |
| `insight` | `insight` | `any` | no | no |
| `internal_due_date_time` | `internalDueDateTime` | `string` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `mailbox_locations` | `mailboxLocations` | `any` | no | no |
| `notes` | `notes` | `list(object({       odata_type = optional(string, "#microsoft.graph.authoredNote")       author = optional(any)       content = optional(any)       createdDateTime = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `pause_after_estimate` | `pauseAfterEstimate` | `bool` | no | no |
| `regulations` | `regulations` | `list(string)` | no | no |
| `site_locations` | `siteLocations` | `any` | no | no |
| `stages` | `stages` | `list(object({       odata_type = optional(string, "#microsoft.graph.subjectRightsRequestStageDetail")       error = optional(any)       stage = optional(any)       status = optional(any)     }))` | no | no |
| `status` | `status` | `any` | no | no |
| `team` | `team` | `any` | no | no |
| `type` | `type` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- approvers[].analytics: polymorphic schema; accepts an untyped value
- approvers[].appConsentRequestsForApproval[].pendingScopes[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appConsentRequestsForApproval[].userConsentRequests[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].addIns[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].appManagementPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].appRoleAssignedTo[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].appRoles[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].claimsMappingPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].claimsPolicy: polymorphic schema; accepts an untyped value
- approvers[].appRoleAssignedResources[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- approvers[].appRoleAssignedResources[].delegatedPermissionClassifications[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].endpoints[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].federatedIdentityCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].homeRealmDiscoveryPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].info: polymorphic schema; accepts an untyped value
- approvers[].appRoleAssignedResources[].keyCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].licenseDetails[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].passwordCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].permissionGrantPreApprovalPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].publishedPermissionScopes[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].remoteDesktopSecurityConfiguration: polymorphic schema; accepts an untyped value
- approvers[].appRoleAssignedResources[].samlSingleSignOnSettings: polymorphic schema; accepts an untyped value
- approvers[].appRoleAssignedResources[].synchronization: polymorphic schema; accepts an untyped value
- approvers[].appRoleAssignedResources[].tokenIssuancePolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].tokenLifetimePolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].appRoleAssignedResources[].verifiedPublisher: polymorphic schema; accepts an untyped value
- approvers[].approvals[].steps[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].authentication: polymorphic schema; accepts an untyped value
- approvers[].authorizationInfo: polymorphic schema; accepts an untyped value
- approvers[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- approvers[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].migrationMode: polymorphic schema; accepts an untyped value
- approvers[].chats[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].viewpoint: polymorphic schema; accepts an untyped value
- approvers[].cloudClipboard: polymorphic schema; accepts an untyped value
- approvers[].cloudLicensing: polymorphic schema; accepts an untyped value
- approvers[].cloudRealtimeCommunicationInfo: polymorphic schema; accepts an untyped value
- approvers[].communications: polymorphic schema; accepts an untyped value
- approvers[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- approvers[].deviceEnrollmentConfigurations[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].deviceManagementTroubleshootingEvents[].additionalInformation[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].deviceManagementTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- approvers[].devices[].alternativeSecurityIds[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].devices[].commands[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].devices[].extensionAttributes: polymorphic schema; accepts an untyped value
- approvers[].devices[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].devices[].usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].employeeOrgData: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].analytics: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].createdByUser: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].deleted: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].drive: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].informationProtection: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].lockState: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].onenote: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].parentReference: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].recycleBin: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].sites[]: recursive schema; accepts an untyped value
- approvers[].followedSites[].template: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].termStore: polymorphic schema; accepts an untyped value
- approvers[].identityGovernance: polymorphic schema; accepts an untyped value
- approvers[].inferenceClassification: polymorphic schema; accepts an untyped value
- approvers[].informationProtection: polymorphic schema; accepts an untyped value
- approvers[].invitedBy: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].acceptedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].accessType: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].assignedLabels[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].conversations[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].events[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].members[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].onenote: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].photo: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].rejectedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].settings[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].sites[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].team: polymorphic schema; accepts an untyped value
- approvers[].joinedGroups[].threads[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].transitiveMembers[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value
- approvers[].mailboxSettings: polymorphic schema; accepts an untyped value
- approvers[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- approvers[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedAppRegistrations[].managedAppLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].assignmentFilterEvaluationStatusDetails[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].chromeOSDeviceInfo[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].cloudPcRemoteActionResults[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].configurationManagerClientHealthState: polymorphic schema; accepts an untyped value
- approvers[].managedDevices[].configurationManagerClientInformation: polymorphic schema; accepts an untyped value
- approvers[].managedDevices[].detectedApps[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- approvers[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].managedDeviceMobileAppConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].securityBaselineStates[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].users[]: recursive schema; accepts an untyped value
- approvers[].mobileAppIntentAndStates[].mobileAppList[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].mobileAppTroubleshootingEvents[].additionalInformation[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].mobileAppTroubleshootingEvents[].appLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].mobileAppTroubleshootingEvents[].history[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].mobileAppTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- approvers[].notifications[].payload.visualContent: polymorphic schema; accepts an untyped value
- approvers[].notifications[].priority: polymorphic schema; accepts an untyped value
- approvers[].notifications[].targetPolicy: polymorphic schema; accepts an untyped value
- approvers[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- approvers[].onenote: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].anonymizeIdentityForRoles[]: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].capabilities[]: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].registration: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- approvers[].passwordProfile: polymorphic schema; accepts an untyped value
- approvers[].pendingAccessReviewInstances[].decisions[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].pendingAccessReviewInstances[].definition: polymorphic schema; accepts an untyped value
- approvers[].pendingAccessReviewInstances[].fallbackReviewers[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].pendingAccessReviewInstances[].reviewers[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].pendingAccessReviewInstances[].stages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].presence: polymorphic schema; accepts an untyped value
- approvers[].print: polymorphic schema; accepts an untyped value
- approvers[].profile: polymorphic schema; accepts an untyped value
- approvers[].security: polymorphic schema; accepts an untyped value
- approvers[].settings: polymorphic schema; accepts an untyped value
- approvers[].todo: polymorphic schema; accepts an untyped value
- approvers[].virtualEvents: polymorphic schema; accepts an untyped value
- assignedTo: polymorphic schema; accepts an untyped value
- collaborators[].analytics: polymorphic schema; accepts an untyped value
- collaborators[].appConsentRequestsForApproval[].pendingScopes[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appConsentRequestsForApproval[].userConsentRequests[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].addIns[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].appManagementPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].appRoleAssignedTo[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].appRoles[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].claimsMappingPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].claimsPolicy: polymorphic schema; accepts an untyped value
- collaborators[].appRoleAssignedResources[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- collaborators[].appRoleAssignedResources[].delegatedPermissionClassifications[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].endpoints[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].federatedIdentityCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].homeRealmDiscoveryPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].info: polymorphic schema; accepts an untyped value
- collaborators[].appRoleAssignedResources[].keyCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].licenseDetails[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].passwordCredentials[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].permissionGrantPreApprovalPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].publishedPermissionScopes[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].remoteDesktopSecurityConfiguration: polymorphic schema; accepts an untyped value
- collaborators[].appRoleAssignedResources[].samlSingleSignOnSettings: polymorphic schema; accepts an untyped value
- collaborators[].appRoleAssignedResources[].synchronization: polymorphic schema; accepts an untyped value
- collaborators[].appRoleAssignedResources[].tokenIssuancePolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].tokenLifetimePolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].appRoleAssignedResources[].verifiedPublisher: polymorphic schema; accepts an untyped value
- collaborators[].approvals[].steps[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].authentication: polymorphic schema; accepts an untyped value
- collaborators[].authorizationInfo: polymorphic schema; accepts an untyped value
- collaborators[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- collaborators[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].migrationMode: polymorphic schema; accepts an untyped value
- collaborators[].chats[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].viewpoint: polymorphic schema; accepts an untyped value
- collaborators[].cloudClipboard: polymorphic schema; accepts an untyped value
- collaborators[].cloudLicensing: polymorphic schema; accepts an untyped value
- collaborators[].cloudRealtimeCommunicationInfo: polymorphic schema; accepts an untyped value
- collaborators[].communications: polymorphic schema; accepts an untyped value
- collaborators[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- collaborators[].deviceEnrollmentConfigurations[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].deviceManagementTroubleshootingEvents[].additionalInformation[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].deviceManagementTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- collaborators[].devices[].alternativeSecurityIds[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].devices[].commands[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].devices[].extensionAttributes: polymorphic schema; accepts an untyped value
- collaborators[].devices[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].devices[].usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].employeeOrgData: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].analytics: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].createdByUser: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].deleted: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].drive: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].informationProtection: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].lockState: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].onenote: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].parentReference: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].recycleBin: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].sites[]: recursive schema; accepts an untyped value
- collaborators[].followedSites[].template: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].termStore: polymorphic schema; accepts an untyped value
- collaborators[].identityGovernance: polymorphic schema; accepts an untyped value
- collaborators[].inferenceClassification: polymorphic schema; accepts an untyped value
- collaborators[].informationProtection: polymorphic schema; accepts an untyped value
- collaborators[].invitedBy: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].acceptedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].accessType: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].assignedLabels[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].conversations[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].events[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].members[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].onenote: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].owners[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].photo: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].rejectedSenders[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].settings[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].sites[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].team: polymorphic schema; accepts an untyped value
- collaborators[].joinedGroups[].threads[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].transitiveMembers[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value
- collaborators[].mailboxSettings: polymorphic schema; accepts an untyped value
- collaborators[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- collaborators[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedAppRegistrations[].managedAppLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].assignmentFilterEvaluationStatusDetails[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].chromeOSDeviceInfo[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].cloudPcRemoteActionResults[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].configurationManagerClientHealthState: polymorphic schema; accepts an untyped value
- collaborators[].managedDevices[].configurationManagerClientInformation: polymorphic schema; accepts an untyped value
- collaborators[].managedDevices[].detectedApps[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- collaborators[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].managedDeviceMobileAppConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].securityBaselineStates[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].users[]: recursive schema; accepts an untyped value
- collaborators[].mobileAppIntentAndStates[].mobileAppList[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].mobileAppTroubleshootingEvents[].additionalInformation[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].mobileAppTroubleshootingEvents[].appLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].mobileAppTroubleshootingEvents[].history[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].mobileAppTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- collaborators[].notifications[].payload.visualContent: polymorphic schema; accepts an untyped value
- collaborators[].notifications[].priority: polymorphic schema; accepts an untyped value
- collaborators[].notifications[].targetPolicy: polymorphic schema; accepts an untyped value
- collaborators[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- collaborators[].onenote: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].anonymizeIdentityForRoles[]: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].capabilities[]: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].registration: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- collaborators[].passwordProfile: polymorphic schema; accepts an untyped value
- collaborators[].pendingAccessReviewInstances[].decisions[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].pendingAccessReviewInstances[].definition: polymorphic schema; accepts an untyped value
- collaborators[].pendingAccessReviewInstances[].fallbackReviewers[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].pendingAccessReviewInstances[].reviewers[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].pendingAccessReviewInstances[].stages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].presence: polymorphic schema; accepts an untyped value
- collaborators[].print: polymorphic schema; accepts an untyped value
- collaborators[].profile: polymorphic schema; accepts an untyped value
- collaborators[].security: polymorphic schema; accepts an untyped value
- collaborators[].settings: polymorphic schema; accepts an untyped value
- collaborators[].todo: polymorphic schema; accepts an untyped value
- collaborators[].virtualEvents: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- dataSubject: polymorphic schema; accepts an untyped value
- dataSubjectType: polymorphic schema; accepts an untyped value
- history[].changedBy: polymorphic schema; accepts an untyped value
- history[].stage: polymorphic schema; accepts an untyped value
- history[].stageStatus: polymorphic schema; accepts an untyped value
- insight: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- mailboxLocations: polymorphic schema; accepts an untyped value
- notes[].author: polymorphic schema; accepts an untyped value
- notes[].content: polymorphic schema; accepts an untyped value
- siteLocations: polymorphic schema; accepts an untyped value
- stages[].error: polymorphic schema; accepts an untyped value
- stages[].stage: polymorphic schema; accepts an untyped value
- stages[].status: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- team: polymorphic schema; accepts an untyped value
- type: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
