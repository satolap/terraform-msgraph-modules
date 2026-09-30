# /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks

Create new navigation property to tasks for identityGovernance

[Catalog](../../../../../../README.md) · [Identity and access](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-task?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks`, `GET/PATCH/DELETE /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks/{task-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/identity-and-access/identity-governance/lifecycle-workflows/workflows/by-workflow-id/tasks?ref=<release-tag>"
  workflow_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `task_processing_results` | `taskProcessingResults` | `list(object({       odata_type = optional(string, "#microsoft.graph.identityGovernance.taskProcessingResult")       completedDateTime = optional(string)       createdDateTime = optional(string)       failureReason = optional(string)       processingInfo = optional(string)       processingStatus = optional(string)       startedDateTime = optional(string)       subject = optional(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequest")       appDisplayName = optional(string)       appId = optional(string)       consentType = optional(string)       pendingScopes = optional(any)       userConsentRequests = optional(any)     })))       appRoleAssignedResources = optional(any)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       approvals = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(any)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(any)       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(list(string))     }))       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(string)       operations = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.userCloudLicensing")       assignmentErrors = optional(any)       assignments = optional(any)       usageRights = optional(any)       waitingMembers = optional(any)     }))       cloudRealtimeCommunicationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudRealtimeCommunicationInfo")     }))       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(any)       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceKey")       deviceId = optional(string)       keyMaterial = optional(string)       keyType = optional(string)     })))       deviceManagementTroubleshootingEvents = optional(any)       devices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(any)       alternativeSecurityIds = optional(any)       commands = optional(any)       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(any)       hostnames = optional(any)       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(any)       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(any)       transitiveMemberOf = optional(any)       usageRights = optional(any)     })))       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     }))       employeeType = optional(string)       extensions = optional(any)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityGovernance = optional(object({       odata_type = optional(string, "#microsoft.graph.identityGovernanceUserSettings")       approverDelegate = optional(object({       odata_type = optional(string, "#microsoft.graph.approverDelegate")       delegate = optional(any)       schedule = optional(any)     }))     }))       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(any)       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(any)       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(any)       resourceProvisioningOptions = optional(any)       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       automaticRepliesSetting = optional(object({       odata_type = optional(string, "#microsoft.graph.automaticRepliesSetting")       externalAudience = optional(string)       externalReplyMessage = optional(string)       internalReplyMessage = optional(string)       scheduledEndDateTime = optional(any)       scheduledStartDateTime = optional(any)       status = optional(string)     }))       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(object({       odata_type = optional(string, "#microsoft.graph.localeInfo")       displayName = optional(string)       locale = optional(string)     }))       timeFormat = optional(string)       timeZone = optional(string)       userPurposeV2 = optional(string)       workingHours = optional(object({       odata_type = optional(string, "#microsoft.graph.workingHours")       daysOfWeek = optional(any)       endTime = optional(string)       startTime = optional(string)       timeZone = optional(any)     }))     }))       managedAppLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     })))       managedAppRegistrations = optional(any)       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(any)       chromeOSDeviceInfo = optional(any)       cloudPcRemoteActionResults = optional(any)       configurationManagerClientHealthState = optional(any)       configurationManagerClientInformation = optional(any)       detectedApps = optional(any)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       joinType = optional(string)       logCollectionRequests = optional(any)       managedDeviceMobileAppConfigurationStates = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementFeatures = optional(string)       notes = optional(string)       ownerType = optional(string)       roleScopeTagIds = optional(any)       securityBaselineStates = optional(any)       skuFamily = optional(string)       users = optional(any)     })))       mobileAppIntentAndStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndState")       managedDeviceIdentifier = optional(string)       mobileAppList = optional(any)       userId = optional(string)     })))       mobileAppTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")       additionalInformation = optional(any)       appLogCollectionRequests = optional(any)       applicationId = optional(string)       correlationId = optional(string)       deviceId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       history = optional(any)       managedDeviceIdentifier = optional(string)       troubleshootingErrorDetails = optional(any)       userId = optional(string)     })))       mySite = optional(string)       notifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.notification")       displayTimeToLive = optional(number)       expirationDateTime = optional(string)       groupName = optional(string)       payload = optional(any)       priority = optional(string)       targetHostName = optional(string)       targetPolicy = optional(any)     })))       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       expiryTime = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)       startTime = optional(string)     })))       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       anonymizeIdentityForRoles = optional(any)       broadcastRecording = optional(string)       broadcastSettings = optional(any)       capabilities = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       joinUrl = optional(string)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(any)       definition = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)       stages = optional(any)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(any)     }))       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")       deviceMacAddress = optional(string)       deviceName = optional(string)       deviceRegistrationId = optional(string)       deviceType = optional(string)       lastCheckInDateTime = optional(string)       userId = optional(string)     })))     }))       task = optional(object({       odata_type = optional(string, "#microsoft.graph.identityGovernance.task")       arguments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     })))       category = optional(string)       continueOnError = optional(bool)       description = optional(string)       displayName = optional(string)       executionSequence = optional(number)       isEnabled = optional(bool)       taskDefinitionId = optional(string)       taskProcessingResults = optional(any)     }))       workflowSubject = optional(any)     }))` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- taskProcessingResults[].subject.analytics: navigation property; accepts an untyped value
- taskProcessingResults[].subject.appConsentRequestsForApproval[].pendingScopes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appConsentRequestsForApproval[].userConsentRequests: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.appRoleAssignedResources[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.approvals[].steps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.assignedLicenses[].disabledPlans: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.authentication: navigation property; accepts an untyped value
- taskProcessingResults[].subject.chats[].installedApps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].lastMessagePreview: navigation property; accepts an untyped value
- taskProcessingResults[].subject.chats[].members: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].messages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].pinnedMessages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].tabs: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].targetedMessages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].viewpoint: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.cloudClipboard: navigation property; accepts an untyped value
- taskProcessingResults[].subject.cloudLicensing.assignmentErrors[]: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.cloudLicensing.assignments[]: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.cloudLicensing.usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.cloudLicensing.waitingMembers[]: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.communications: navigation property; accepts an untyped value
- taskProcessingResults[].subject.customSecurityAttributes: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.deviceEnrollmentConfigurations[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.deviceManagementTroubleshootingEvents[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.devices[].alternativeNames: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].alternativeSecurityIds: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].commands: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].extensionAttributes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].hostnames: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].physicalIds: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].systemLabels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.devices[].usageRights: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.extensions[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].analytics: navigation property; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].columns: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].contentModels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].createdByUser: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].deleted: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].documentProcessingJobs: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].drive: navigation property; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].drives: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].extensions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].externalColumns: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].informationProtection: navigation property; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].items: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].lists: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].onenote: navigation property; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].ownerIdentityToResolve: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].pageTemplates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].pages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].permissions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].recycleBin: navigation property; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].sites: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].termStore: navigation property; accepts an untyped value
- taskProcessingResults[].subject.identityGovernance.approverDelegate.delegate: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.identityGovernance.approverDelegate.schedule: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.inferenceClassification: navigation property; accepts an untyped value
- taskProcessingResults[].subject.informationProtection: navigation property; accepts an untyped value
- taskProcessingResults[].subject.invitedBy: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].acceptedSenders: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].assignedLabels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].cloudLicensing: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].conversations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].events: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].groupTypes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].infoCatalogs: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].members: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onPremisesExtensionAttributes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].onenote: navigation property; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].owners: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].photo: navigation property; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].rejectedSenders: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].resourceBehaviorOptions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].resourceProvisioningOptions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].settings: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].sites: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].team: navigation property; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].threads: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].transitiveMembers: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedGroups[].writebackConfiguration: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mailboxSettings.automaticRepliesSetting.scheduledEndDateTime: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mailboxSettings.automaticRepliesSetting.scheduledStartDateTime: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mailboxSettings.workingHours.daysOfWeek: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.mailboxSettings.workingHours.timeZone: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].assignmentFilterEvaluationStatusDetails: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].chromeOSDeviceInfo: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].cloudPcRemoteActionResults: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].configurationManagerClientHealthState: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].configurationManagerClientInformation: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].detectedApps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].deviceCategory: navigation property; accepts an untyped value
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
- taskProcessingResults[].subject.mobileAppTroubleshootingEvents[].troubleshootingErrorDetails: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.notifications[].payload: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.notifications[].targetPolicy: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onPremisesSyncBehavior: navigation property; accepts an untyped value
- taskProcessingResults[].subject.onenote: navigation property; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].anonymizeIdentityForRoles: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].broadcastSettings: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].capabilities: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].chatInfo: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].chatRestrictions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].joinMeetingIdSettings: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].lobbyBypassSettings: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].participants: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].registration: navigation property; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].sensitivityLabelAssignment: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].watermarkProtection: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].decisions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].definition: navigation property; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].fallbackReviewers: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].reviewers: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.pendingAccessReviewInstances[].stages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.presence: navigation property; accepts an untyped value
- taskProcessingResults[].subject.print.recentPrinterShares[]: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.profile: navigation property; accepts an untyped value
- taskProcessingResults[].subject.security: navigation property; accepts an untyped value
- taskProcessingResults[].subject.serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.settings: navigation property; accepts an untyped value
- taskProcessingResults[].subject.sponsors[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.todo: navigation property; accepts an untyped value
- taskProcessingResults[].subject.transitiveMemberOf[]: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.virtualEvents: navigation property; accepts an untyped value
- taskProcessingResults[].task.taskProcessingResults[]: recursive schema; accepts an untyped value
- taskProcessingResults[].workflowSubject: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
