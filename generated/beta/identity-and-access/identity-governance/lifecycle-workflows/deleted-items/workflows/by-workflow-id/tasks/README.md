# /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks

Create new navigation property to tasks for identityGovernance

[Catalog](../../../../../../../README.md) · [Identity and access](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-task?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks`, `GET/PATCH/DELETE /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks/{task-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/lifecycle-workflows/deleted-items/workflows/by-workflow-id/tasks"
  workflow_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `workflow_id` | URL parameter `workflow-id` | `string` | yes | no |
| `arguments` | `arguments` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     }))` | no | no |
| `category` | `category` | `string` | no | no |
| `continue_on_error` | `continueOnError` | `bool` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `execution_sequence` | `executionSequence` | `number` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `task_definition_id` | `taskDefinitionId` | `string` | no | no |
| `task_processing_results` | `taskProcessingResults` | `list(object({       odata_type = optional(string, "#microsoft.graph.identityGovernance.taskProcessingResult")       completedDateTime = optional(string)       createdDateTime = optional(string)       failureReason = optional(string)       processingInfo = optional(string)       processingStatus = optional(string)       startedDateTime = optional(string)       subject = optional(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequest")       appDisplayName = optional(string)       appId = optional(string)       consentType = optional(string)       pendingScopes = optional(any)       userConsentRequests = optional(any)     })))       appRoleAssignedResources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.servicePrincipal")       accountEnabled = optional(bool)       addIns = optional(any)       alternativeNames = optional(any)       appDescription = optional(string)       appDisplayName = optional(string)       appId = optional(string)       appManagementPolicies = optional(any)       appOwnerOrganizationId = optional(string)       appRoleAssignedTo = optional(any)       appRoleAssignmentRequired = optional(bool)       appRoleAssignments = optional(any)       appRoles = optional(any)       claimsMappingPolicies = optional(any)       claimsPolicy = optional(any)       customSecurityAttributes = optional(any)       delegatedPermissionClassifications = optional(any)       deletedDateTime = optional(string)       description = optional(string)       disabledByMicrosoftStatus = optional(string)       displayName = optional(string)       endpoints = optional(any)       errorUrl = optional(string)       federatedIdentityCredentials = optional(any)       homeRealmDiscoveryPolicies = optional(any)       homepage = optional(string)       info = optional(any)       isDisabled = optional(bool)       keyCredentials = optional(any)       licenseDetails = optional(any)       loginUrl = optional(string)       logoutUrl = optional(string)       notes = optional(string)       notificationEmailAddresses = optional(any)       owners = optional(any)       passwordCredentials = optional(any)       permissionGrantPreApprovalPolicies = optional(any)       preferredSingleSignOnMode = optional(string)       preferredTokenSigningKeyEndDateTime = optional(string)       preferredTokenSigningKeyThumbprint = optional(string)       publishedPermissionScopes = optional(any)       publisherName = optional(string)       remoteDesktopSecurityConfiguration = optional(any)       replyUrls = optional(any)       samlMetadataUrl = optional(string)       samlSingleSignOnSettings = optional(any)       servicePrincipalNames = optional(any)       servicePrincipalType = optional(string)       synchronization = optional(any)       tags = optional(any)       tokenEncryptionKeyId = optional(string)       tokenIssuancePolicies = optional(any)       tokenLifetimePolicies = optional(any)       transitiveMemberOf = optional(any)       verifiedPublisher = optional(any)     })))       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       approvals = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(any)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(any)       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       operations = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(any)       cloudRealtimeCommunicationInfo = optional(any)       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceEnrollmentConfiguration")       assignments = optional(any)       createdDateTime = optional(string)       description = optional(string)       deviceEnrollmentConfigurationType = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       priority = optional(number)       roleScopeTagIds = optional(any)       version = optional(number)     })))       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceKey")       deviceId = optional(string)       keyMaterial = optional(string)       keyType = optional(string)     })))       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       additionalInformation = optional(any)       correlationId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       troubleshootingErrorDetails = optional(any)     })))       devices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(any)       alternativeSecurityIds = optional(any)       commands = optional(any)       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(any)       hostnames = optional(any)       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(any)       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(any)       transitiveMemberOf = optional(any)       usageRights = optional(any)     })))       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityGovernance = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(any)       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(any)       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(any)       resourceProvisioningOptions = optional(any)       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     })))       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       azureADDeviceId = optional(string)       createdDateTime = optional(string)       deviceManufacturer = optional(string)       deviceModel = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(any)       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managedAppLogCollectionRequests = optional(any)       managedDeviceId = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(any)       chassisType = optional(string)       chromeOSDeviceInfo = optional(any)       cloudPcRemoteActionResults = optional(any)       complianceState = optional(string)       configurationManagerClientHealthState = optional(any)       configurationManagerClientInformation = optional(any)       detectedApps = optional(any)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       deviceRegistrationState = optional(string)       deviceType = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       joinType = optional(string)       logCollectionRequests = optional(any)       lostModeState = optional(string)       managedDeviceMobileAppConfigurationStates = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementFeatures = optional(string)       managementState = optional(string)       notes = optional(string)       ownerType = optional(string)       partnerReportedThreatState = optional(string)       processorArchitecture = optional(string)       roleScopeTagIds = optional(any)       securityBaselineStates = optional(any)       skuFamily = optional(string)       users = optional(any)     })))       mobileAppIntentAndStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndState")       managedDeviceIdentifier = optional(string)       mobileAppList = optional(any)       userId = optional(string)     })))       mobileAppTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")       additionalInformation = optional(any)       appLogCollectionRequests = optional(any)       applicationId = optional(string)       correlationId = optional(string)       deviceId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       history = optional(any)       managedDeviceIdentifier = optional(string)       troubleshootingErrorDetails = optional(any)       userId = optional(string)     })))       mySite = optional(string)       notifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.notification")       displayTimeToLive = optional(number)       expirationDateTime = optional(string)       groupName = optional(string)       payload = optional(any)       priority = optional(any)       targetHostName = optional(string)       targetPolicy = optional(any)     })))       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       expiryTime = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)       startTime = optional(string)     })))       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       broadcastRecording = optional(string)       broadcastSettings = optional(any)       capabilities = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       joinUrl = optional(string)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(any)       definition = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)       stages = optional(any)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")       deviceMacAddress = optional(string)       deviceName = optional(string)       deviceRegistrationId = optional(string)       deviceType = optional(string)       lastCheckInDateTime = optional(string)       userId = optional(string)     })))     }))       task = optional(object({       odata_type = optional(string, "#microsoft.graph.identityGovernance.task")       arguments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     })))       category = optional(string)       continueOnError = optional(bool)       description = optional(string)       displayName = optional(string)       executionSequence = optional(number)       isEnabled = optional(bool)       taskDefinitionId = optional(string)       taskProcessingResults = optional(any)     }))       workflowSubject = optional(any)     }))` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- taskProcessingResults[].subject.analytics: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.appConsentRequestsForApproval[].pendingScopes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appConsentRequestsForApproval[].userConsentRequests: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].addIns: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].alternativeNames: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].appManagementPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].appRoleAssignedTo: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].appRoles: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].claimsMappingPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].claimsPolicy: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].delegatedPermissionClassifications: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].endpoints: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].federatedIdentityCredentials: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].homeRealmDiscoveryPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].info: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].keyCredentials: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].licenseDetails: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].notificationEmailAddresses: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].owners: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].passwordCredentials: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].permissionGrantPreApprovalPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].publishedPermissionScopes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].remoteDesktopSecurityConfiguration: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].replyUrls: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].samlSingleSignOnSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].servicePrincipalNames: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].synchronization: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].tags: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].tokenIssuancePolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].tokenLifetimePolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[].verifiedPublisher: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.approvals[].steps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.assignedLicenses[].disabledPlans: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.authentication: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.authorizationInfo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.chats[].installedApps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.chats[].members: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].messages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].migrationMode: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.chats[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].pinnedMessages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].tabs: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].targetedMessages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].viewpoint: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.cloudClipboard: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.cloudLicensing: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.cloudRealtimeCommunicationInfo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.communications: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.customSecurityAttributes: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.deviceEnrollmentConfigurations[].assignments: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.deviceEnrollmentConfigurations[].roleScopeTagIds: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.deviceManagementTroubleshootingEvents[].additionalInformation: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.deviceManagementTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.devices[].alternativeNames: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].alternativeSecurityIds: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].commands: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].extensionAttributes: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.devices[].hostnames: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].physicalIds: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].systemLabels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].usageRights: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.employeeOrgData: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].analytics: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].columns: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].contentModels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].createdByUser: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].deleted: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].documentProcessingJobs: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].drive: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].drives: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].extensions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].externalColumns: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].informationProtection: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].items: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].lists: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].lockState: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].onenote: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].pageTemplates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].pages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].parentReference: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].permissions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].recycleBin: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].sites: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].template: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].termStore: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.identityGovernance: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.inferenceClassification: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.informationProtection: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.invitedBy: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].acceptedSenders: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].accessType: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].assignedLabels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].conversations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].events: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].groupTypes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].infoCatalogs: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].members: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onenote: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].owners: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].photo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].rejectedSenders: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].resourceBehaviorOptions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].resourceProvisioningOptions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].settings: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].sites: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].team: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].threads: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].transitiveMembers: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.mailboxSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].appliedPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].flaggedReasons: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].intendedPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].managedAppLogCollectionRequests: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].assignmentFilterEvaluationStatusDetails: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].chromeOSDeviceInfo: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].cloudPcRemoteActionResults: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].configurationManagerClientHealthState: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].configurationManagerClientInformation: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].detectedApps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].deviceCompliancePolicyStates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].deviceConfigurationStates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].logCollectionRequests: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].managedDeviceMobileAppConfigurationStates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].roleScopeTagIds: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].securityBaselineStates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].users: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mobileAppIntentAndStates[].mobileAppList: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mobileAppTroubleshootingEvents[].additionalInformation: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mobileAppTroubleshootingEvents[].appLogCollectionRequests: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mobileAppTroubleshootingEvents[].history: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mobileAppTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.notifications[].payload: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.notifications[].priority: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.notifications[].targetPolicy: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onenote: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].anonymizeIdentityForRoles: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].capabilities: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].registration: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.passwordProfile: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].decisions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].definition: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].fallbackReviewers: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].reviewers: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].stages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.presence: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.print: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.profile: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.security: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.settings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.todo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.virtualEvents: polymorphic schema; accepts an untyped value
- taskProcessingResults[].task.taskProcessingResults[]: recursive schema; accepts an untyped value
- taskProcessingResults[].workflowSubject: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
