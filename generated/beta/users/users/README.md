# /users

Create user

[Catalog](../../README.md) · [Users](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/user?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users`, `GET/PATCH/DELETE /users/{user-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./users/users"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `about_me` | `aboutMe` | `string` | no | no |
| `account_enabled` | `accountEnabled` | `bool` | no | no |
| `age_group` | `ageGroup` | `string` | no | no |
| `analytics` | `analytics` | `any` | no | no |
| `app_consent_requests_for_approval` | `appConsentRequestsForApproval` | `list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequest")       appDisplayName = optional(string)       appId = optional(string)       consentType = optional(string)       pendingScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appConsentRequestScope")       displayName = optional(string)     })))       userConsentRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.userConsentRequest")       approval = optional(any)       approvalId = optional(string)       completedDateTime = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       customData = optional(string)       reason = optional(string)       status = optional(string)     })))     }))` | no | no |
| `app_role_assigned_resources` | `appRoleAssignedResources` | `list(object({       odata_type = optional(string, "#microsoft.graph.servicePrincipal")       accountEnabled = optional(bool)       addIns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.addIn")       id = optional(string)       properties = optional(any)       type = optional(string)     })))       alternativeNames = optional(list(string))       appDescription = optional(string)       appDisplayName = optional(string)       appId = optional(string)       appManagementPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(any)     })))       appOwnerOrganizationId = optional(string)       appRoleAssignedTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       appRoleAssignmentRequired = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       appRoles = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     })))       claimsMappingPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.claimsMappingPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       claimsPolicy = optional(any)       customSecurityAttributes = optional(any)       delegatedPermissionClassifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.delegatedPermissionClassification")       classification = optional(any)       permissionId = optional(string)       permissionName = optional(string)     })))       deletedDateTime = optional(string)       description = optional(string)       disabledByMicrosoftStatus = optional(string)       displayName = optional(string)       endpoints = optional(list(object({       odata_type = optional(string, "#microsoft.graph.endpoint")       deletedDateTime = optional(string)     })))       errorUrl = optional(string)       federatedIdentityCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       claimsMatchingExpression = optional(any)       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     })))       homeRealmDiscoveryPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       homepage = optional(string)       info = optional(any)       isDisabled = optional(bool)       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       loginUrl = optional(string)       logoutUrl = optional(string)       notes = optional(string)       notificationEmailAddresses = optional(list(string))       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     })))       permissionGrantPreApprovalPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permissionGrantPreApprovalPolicy")       conditions = optional(any)       deletedDateTime = optional(string)     })))       preferredSingleSignOnMode = optional(string)       preferredTokenSigningKeyEndDateTime = optional(string)       preferredTokenSigningKeyThumbprint = optional(string)       publishedPermissionScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permissionScope")       adminConsentDescription = optional(string)       adminConsentDisplayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       origin = optional(string)       type = optional(string)       userConsentDescription = optional(string)       userConsentDisplayName = optional(string)       value = optional(string)     })))       publisherName = optional(string)       remoteDesktopSecurityConfiguration = optional(any)       replyUrls = optional(list(string))       samlMetadataUrl = optional(string)       samlSingleSignOnSettings = optional(any)       servicePrincipalNames = optional(list(string))       servicePrincipalType = optional(string)       synchronization = optional(any)       tags = optional(list(string))       tokenEncryptionKeyId = optional(string)       tokenIssuancePolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       tokenLifetimePolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       verifiedPublisher = optional(any)     }))` | no | yes |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `approvals` | `approvals` | `list(object({       odata_type = optional(string, "#microsoft.graph.approval")       steps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.approvalStep")       justification = optional(string)       reviewResult = optional(string)     })))     }))` | no | no |
| `assigned_licenses` | `assignedLicenses` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     }))` | no | no |
| `authentication` | `authentication` | `any` | no | no |
| `authorization_info` | `authorizationInfo` | `any` | no | no |
| `birthday` | `birthday` | `string` | no | no |
| `chats` | `chats` | `list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppInstallation")       consentedPermissionSet = optional(any)       scopeInfo = optional(any)       teamsApp = optional(any)       teamsAppDefinition = optional(any)     })))       lastMessagePreview = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     })))       originalCreatedDateTime = optional(string)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       pinnedMessages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")       message = optional(any)     })))       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       messageId = optional(string)       sortOrderIndex = optional(string)       teamsApp = optional(any)       teamsAppId = optional(string)     })))       targetedMessages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.targetedChatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(any)       recipient = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       topic = optional(string)       viewpoint = optional(any)     }))` | no | no |
| `city` | `city` | `string` | no | no |
| `cloud_clipboard` | `cloudClipboard` | `any` | no | no |
| `cloud_licensing` | `cloudLicensing` | `any` | no | no |
| `cloud_realtime_communication_info` | `cloudRealtimeCommunicationInfo` | `any` | no | no |
| `communications` | `communications` | `any` | no | no |
| `company_name` | `companyName` | `string` | no | no |
| `consent_provided_for_minor` | `consentProvidedForMinor` | `string` | no | no |
| `country` | `country` | `string` | no | no |
| `custom_security_attributes` | `customSecurityAttributes` | `any` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `department` | `department` | `string` | no | no |
| `device_enrollment_configurations` | `deviceEnrollmentConfigurations` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceEnrollmentConfiguration")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.enrollmentConfigurationAssignment")       source = optional(string)       sourceId = optional(string)       target = optional(any)     })))       createdDateTime = optional(string)       description = optional(string)       deviceEnrollmentConfigurationType = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       priority = optional(number)       roleScopeTagIds = optional(list(string))       version = optional(number)     }))` | no | no |
| `device_enrollment_limit` | `deviceEnrollmentLimit` | `number` | no | no |
| `device_keys` | `deviceKeys` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceKey")       deviceId = optional(string)       keyMaterial = optional(string)       keyType = optional(string)     }))` | no | no |
| `device_management_troubleshooting_events` | `deviceManagementTroubleshootingEvents` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       additionalInformation = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     })))       correlationId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       troubleshootingErrorDetails = optional(any)     }))` | no | no |
| `devices` | `devices` | `list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(list(string))       alternativeSecurityIds = optional(list(object({       odata_type = optional(string, "#microsoft.graph.alternativeSecurityId")       identityProvider = optional(string)       key = optional(string)       type = optional(number)     })))       commands = optional(list(object({       odata_type = optional(string, "#microsoft.graph.command")       appServiceName = optional(string)       error = optional(string)       packageFamilyName = optional(string)       payload = optional(any)       permissionTicket = optional(string)       postBackUri = optional(string)       responsepayload = optional(any)       status = optional(string)       type = optional(string)     })))       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(any)       hostnames = optional(list(string))       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(list(string))       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(list(string))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))     }))` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `employee_hire_date` | `employeeHireDate` | `string` | no | no |
| `employee_id` | `employeeId` | `string` | no | no |
| `employee_leave_date_time` | `employeeLeaveDateTime` | `string` | no | no |
| `employee_org_data` | `employeeOrgData` | `any` | no | no |
| `employee_type` | `employeeType` | `string` | no | no |
| `extensions` | `extensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.extension")     }))` | no | no |
| `external_user_state` | `externalUserState` | `string` | no | no |
| `external_user_state_change_date_time` | `externalUserStateChangeDateTime` | `string` | no | no |
| `fax_number` | `faxNumber` | `string` | no | no |
| `followed_sites` | `followedSites` | `list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(any)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(any)       listItemUniqueId = optional(string)       status = optional(any)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(any)       bundles = optional(any)       createdByUser = optional(any)       description = optional(string)       following = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseItem")       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)     })))       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(any)       columns = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       lastModifiedByUser = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(any)       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)       titleArea = optional(any)       webParts = optional(any)     })))       pages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseSitePage")       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)     })))       parentReference = optional(any)       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     }))` | no | no |
| `given_name` | `givenName` | `string` | no | no |
| `hire_date` | `hireDate` | `string` | no | no |
| `identities` | `identities` | `list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     }))` | no | no |
| `identity_governance` | `identityGovernance` | `any` | no | no |
| `identity_parent_id` | `identityParentId` | `string` | no | no |
| `inference_classification` | `inferenceClassification` | `any` | no | no |
| `info_catalogs` | `infoCatalogs` | `list(string)` | no | no |
| `information_protection` | `informationProtection` | `any` | no | no |
| `interests` | `interests` | `list(string)` | no | no |
| `invited_by` | `invitedBy` | `any` | no | no |
| `is_resource_account` | `isResourceAccount` | `bool` | no | no |
| `job_title` | `jobTitle` | `string` | no | no |
| `joined_groups` | `joinedGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       occurrenceId = optional(string)       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       uid = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directorySetting")       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(any)       termStore = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       transitiveMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     }))` | no | no |
| `license_details` | `licenseDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     }))` | no | no |
| `mail` | `mail` | `string` | no | no |
| `mail_nickname` | `mailNickname` | `string` | no | no |
| `mailbox_settings` | `mailboxSettings` | `any` | no | no |
| `managed_app_log_collection_requests` | `managedAppLogCollectionRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     }))` | no | no |
| `managed_app_registrations` | `managedAppRegistrations` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppPolicy")       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       roleScopeTagIds = optional(list(string))       version = optional(string)     })))       azureADDeviceId = optional(string)       createdDateTime = optional(string)       deviceManufacturer = optional(string)       deviceModel = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppPolicy")       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       roleScopeTagIds = optional(list(string))       version = optional(string)     })))       lastSyncDateTime = optional(string)       managedAppLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")       userLogUploadConsent = optional(string)       version = optional(string)     })))       managedDeviceId = optional(string)       managementSdkVersion = optional(string)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppOperation")       displayName = optional(string)       lastModifiedDateTime = optional(string)       state = optional(string)       version = optional(string)     })))       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     }))` | no | no |
| `managed_devices` | `managedDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignmentFilterEvaluationStatusDetails")       payloadId = optional(string)     })))       chassisType = optional(string)       chromeOSDeviceInfo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chromeOSDeviceProperty")       name = optional(string)       updatable = optional(bool)       value = optional(string)       valueType = optional(string)     })))       cloudPcRemoteActionResults = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudPcRemoteActionResult")       actionName = optional(string)       lastUpdatedDateTime = optional(string)       startDateTime = optional(string)       statusDetail = optional(any)       statusDetails = optional(any)     })))       complianceState = optional(string)       configurationManagerClientHealthState = optional(any)       configurationManagerClientInformation = optional(any)       detectedApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.detectedApp")       deviceCount = optional(number)       managedDevices = optional(any)       platform = optional(string)       publisher = optional(string)     })))       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       deviceConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       deviceEnrollmentType = optional(string)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       deviceRegistrationState = optional(string)       deviceType = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       joinType = optional(string)       logCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceLogCollectionResponse")       enrolledByUser = optional(string)       errorCode = optional(number)       expirationDateTimeUTC = optional(string)       initiatedByUserPrincipalName = optional(string)       managedDeviceId = optional(string)       receivedDateTimeUTC = optional(string)       requestedDateTimeUTC = optional(string)       size = optional(any)       sizeInKB = optional(any)       status = optional(string)     })))       lostModeState = optional(string)       managedDeviceMobileAppConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementFeatures = optional(string)       managementState = optional(string)       notes = optional(string)       ownerType = optional(string)       partnerReportedThreatState = optional(string)       processorArchitecture = optional(string)       roleScopeTagIds = optional(list(string))       securityBaselineStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.securityBaselineState")       displayName = optional(string)       securityBaselineTemplateId = optional(string)       settingStates = optional(any)       state = optional(string)       userPrincipalName = optional(string)     })))       skuFamily = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(any)       appRoleAssignedResources = optional(any)       appRoleAssignments = optional(any)       approvals = optional(any)       assignedLicenses = optional(any)       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(any)       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(any)       cloudRealtimeCommunicationInfo = optional(any)       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(any)       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(any)       deviceManagementTroubleshootingEvents = optional(any)       devices = optional(any)       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       extensions = optional(any)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(any)       givenName = optional(string)       hireDate = optional(string)       identities = optional(any)       identityGovernance = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(any)       licenseDetails = optional(any)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppLogCollectionRequests = optional(any)       managedAppRegistrations = optional(any)       managedDevices = optional(any)       mobileAppIntentAndStates = optional(any)       mobileAppTroubleshootingEvents = optional(any)       mySite = optional(string)       notifications = optional(any)       oauth2PermissionGrants = optional(any)       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(any)       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(any)       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(any)       permissionGrants = optional(any)       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       usageRights = optional(any)       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(any)     })))     }))` | no | yes |
| `mobile_app_intent_and_states` | `mobileAppIntentAndStates` | `list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndState")       managedDeviceIdentifier = optional(string)       mobileAppList = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppIntentAndStateDetail")       applicationId = optional(string)       displayName = optional(string)       displayVersion = optional(string)       installState = optional(string)       mobileAppIntent = optional(string)       supportedDeviceTypes = optional(any)     })))       userId = optional(string)     }))` | no | no |
| `mobile_app_troubleshooting_events` | `mobileAppTroubleshootingEvents` | `list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")       additionalInformation = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     })))       appLogCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appLogCollectionRequest")       completedDateTime = optional(string)       customLogFolders = optional(list(string))       errorMessage = optional(string)       status = optional(string)     })))       applicationId = optional(string)       correlationId = optional(string)       deviceId = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       history = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mobileAppTroubleshootingHistoryItem")       occurrenceDateTime = optional(string)       troubleshootingErrorDetails = optional(any)     })))       managedDeviceIdentifier = optional(string)       troubleshootingErrorDetails = optional(any)       userId = optional(string)     }))` | no | no |
| `my_site` | `mySite` | `string` | no | no |
| `notifications` | `notifications` | `list(object({       odata_type = optional(string, "#microsoft.graph.notification")       displayTimeToLive = optional(number)       expirationDateTime = optional(string)       groupName = optional(string)       payload = optional(object({       odata_type = optional(string, "#microsoft.graph.payloadTypes")       rawContent = optional(string)       visualContent = optional(any)     }))       priority = optional(any)       targetHostName = optional(string)       targetPolicy = optional(any)     }))` | no | no |
| `oauth2_permission_grants` | `oauth2PermissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       expiryTime = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)       startTime = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `office_location` | `officeLocation` | `string` | no | no |
| `on_premises_distinguished_name` | `onPremisesDistinguishedName` | `string` | no | no |
| `on_premises_domain_name` | `onPremisesDomainName` | `string` | no | no |
| `on_premises_immutable_id` | `onPremisesImmutableId` | `string` | no | no |
| `on_premises_provisioning_errors` | `onPremisesProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     }))` | no | no |
| `on_premises_sam_account_name` | `onPremisesSamAccountName` | `string` | no | no |
| `on_premises_security_identifier` | `onPremisesSecurityIdentifier` | `string` | no | no |
| `on_premises_sync_behavior` | `onPremisesSyncBehavior` | `any` | no | no |
| `on_premises_user_principal_name` | `onPremisesUserPrincipalName` | `string` | no | no |
| `onenote` | `onenote` | `any` | no | no |
| `online_meetings` | `onlineMeetings` | `list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       broadcastRecording = optional(string)       broadcastSettings = optional(any)       capabilities = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       joinUrl = optional(string)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     }))` | no | no |
| `other_mails` | `otherMails` | `list(string)` | no | no |
| `password_policies` | `passwordPolicies` | `string` | no | yes |
| `password_profile` | `passwordProfile` | `any` | no | yes |
| `past_projects` | `pastProjects` | `list(string)` | no | no |
| `pending_access_review_instances` | `pendingAccessReviewInstances` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItem")       applyDescription = optional(string)       decision = optional(string)       insights = optional(any)       instance = optional(any)       justification = optional(string)       permission = optional(any)     })))       definition = optional(any)       fallbackReviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       reviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       stages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewStage")       decisions = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)     })))     }))` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `postal_code` | `postalCode` | `string` | no | no |
| `preferred_data_location` | `preferredDataLocation` | `string` | no | no |
| `preferred_language` | `preferredLanguage` | `string` | no | no |
| `preferred_name` | `preferredName` | `string` | no | no |
| `presence` | `presence` | `any` | no | no |
| `print` | `print` | `any` | no | no |
| `profile` | `profile` | `any` | no | no |
| `responsibilities` | `responsibilities` | `list(string)` | no | no |
| `schools` | `schools` | `list(string)` | no | no |
| `security` | `security` | `any` | no | no |
| `service_provisioning_errors` | `serviceProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     }))` | no | no |
| `settings` | `settings` | `any` | no | no |
| `show_in_address_list` | `showInAddressList` | `bool` | no | no |
| `skills` | `skills` | `list(string)` | no | no |
| `sponsors` | `sponsors` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `state` | `state` | `string` | no | no |
| `street_address` | `streetAddress` | `string` | no | no |
| `surname` | `surname` | `string` | no | no |
| `todo` | `todo` | `any` | no | no |
| `transitive_member_of` | `transitiveMemberOf` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `usage_location` | `usageLocation` | `string` | no | no |
| `usage_rights` | `usageRights` | `list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     }))` | no | no |
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
| `user_type` | `userType` | `string` | no | no |
| `virtual_events` | `virtualEvents` | `any` | no | no |
| `windows_information_protection_device_registrations` | `windowsInformationProtectionDeviceRegistrations` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")       deviceMacAddress = optional(string)       deviceName = optional(string)       deviceRegistrationId = optional(string)       deviceType = optional(string)       lastCheckInDateTime = optional(string)       userId = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- Standard user creation requires accountEnabled, displayName, mailNickname, passwordProfile.password, and userPrincipalName; identities-based accounts have different requirements. Review https://learn.microsoft.com/graph/api/user-post-users.
- analytics: polymorphic schema; accepts an untyped value
- appConsentRequestsForApproval[].userConsentRequests[].approval: polymorphic schema; accepts an untyped value
- appConsentRequestsForApproval[].userConsentRequests[].createdBy: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].addIns[].properties[]: nested schema exceeds depth limit; accepts an untyped value
- appRoleAssignedResources[].appManagementPolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- appRoleAssignedResources[].appManagementPolicies[].restrictions: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].claimsMappingPolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- appRoleAssignedResources[].claimsPolicy: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].delegatedPermissionClassifications[].classification: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].federatedIdentityCredentials[].claimsMatchingExpression: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].homeRealmDiscoveryPolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- appRoleAssignedResources[].info: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].permissionGrantPreApprovalPolicies[].conditions[]: nested schema exceeds depth limit; accepts an untyped value
- appRoleAssignedResources[].remoteDesktopSecurityConfiguration: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].samlSingleSignOnSettings: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].synchronization: polymorphic schema; accepts an untyped value
- appRoleAssignedResources[].tokenIssuancePolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- appRoleAssignedResources[].tokenLifetimePolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- appRoleAssignedResources[].verifiedPublisher: polymorphic schema; accepts an untyped value
- authentication: polymorphic schema; accepts an untyped value
- authorizationInfo: polymorphic schema; accepts an untyped value
- chats[].installedApps[].consentedPermissionSet: polymorphic schema; accepts an untyped value
- chats[].installedApps[].scopeInfo: polymorphic schema; accepts an untyped value
- chats[].installedApps[].teamsApp: polymorphic schema; accepts an untyped value
- chats[].installedApps[].teamsAppDefinition: polymorphic schema; accepts an untyped value
- chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- chats[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- chats[].messages[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- chats[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- chats[].messages[].from: polymorphic schema; accepts an untyped value
- chats[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].onBehalfOf: polymorphic schema; accepts an untyped value
- chats[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- chats[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].replies[]: recursive schema; accepts an untyped value
- chats[].migrationMode: polymorphic schema; accepts an untyped value
- chats[].operations[].error: polymorphic schema; accepts an untyped value
- chats[].pinnedMessages[].message: polymorphic schema; accepts an untyped value
- chats[].tabs[].configuration: polymorphic schema; accepts an untyped value
- chats[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].body.contentType: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].channelIdentity: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].from: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].onBehalfOf: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].policyViolation: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].recipient: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].replies[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].viewpoint: polymorphic schema; accepts an untyped value
- cloudClipboard: polymorphic schema; accepts an untyped value
- cloudLicensing: polymorphic schema; accepts an untyped value
- cloudRealtimeCommunicationInfo: polymorphic schema; accepts an untyped value
- communications: polymorphic schema; accepts an untyped value
- customSecurityAttributes: polymorphic schema; accepts an untyped value
- deviceEnrollmentConfigurations[].assignments[].target: polymorphic schema; accepts an untyped value
- deviceManagementTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- devices[].commands[].payload: polymorphic schema; accepts an untyped value
- devices[].commands[].responsepayload: polymorphic schema; accepts an untyped value
- devices[].extensionAttributes: polymorphic schema; accepts an untyped value
- employeeOrgData: polymorphic schema; accepts an untyped value
- followedSites[].analytics: polymorphic schema; accepts an untyped value
- followedSites[].columns[].boolean: polymorphic schema; accepts an untyped value
- followedSites[].columns[].calculated: polymorphic schema; accepts an untyped value
- followedSites[].columns[].choice: polymorphic schema; accepts an untyped value
- followedSites[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- followedSites[].columns[].currency: polymorphic schema; accepts an untyped value
- followedSites[].columns[].dateTime: polymorphic schema; accepts an untyped value
- followedSites[].columns[].defaultValue: polymorphic schema; accepts an untyped value
- followedSites[].columns[].geolocation: polymorphic schema; accepts an untyped value
- followedSites[].columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- followedSites[].columns[].lookup: polymorphic schema; accepts an untyped value
- followedSites[].columns[].number: polymorphic schema; accepts an untyped value
- followedSites[].columns[].personOrGroup: polymorphic schema; accepts an untyped value
- followedSites[].columns[].sourceColumn: polymorphic schema; accepts an untyped value
- followedSites[].columns[].sourceContentType: polymorphic schema; accepts an untyped value
- followedSites[].columns[].term: polymorphic schema; accepts an untyped value
- followedSites[].columns[].text: polymorphic schema; accepts an untyped value
- followedSites[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- followedSites[].columns[].validation: polymorphic schema; accepts an untyped value
- followedSites[].contentModels[].modelType: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].base: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- followedSites[].contentTypes[].columnLinks[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].columnPositions[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].order: polymorphic schema; accepts an untyped value
- followedSites[].createdByUser: polymorphic schema; accepts an untyped value
- followedSites[].deleted: polymorphic schema; accepts an untyped value
- followedSites[].documentProcessingJobs[].jobType: polymorphic schema; accepts an untyped value
- followedSites[].documentProcessingJobs[].status: polymorphic schema; accepts an untyped value
- followedSites[].drive: polymorphic schema; accepts an untyped value
- followedSites[].drives[].activities[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].drives[].bundles[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].drives[].createdByUser: polymorphic schema; accepts an untyped value
- followedSites[].drives[].following[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].drives[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- followedSites[].drives[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].drives[].sharePointIds: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].boolean: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].calculated: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].choice: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].currency: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].dateTime: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].defaultValue: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].lookup: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].number: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].personOrGroup: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].sourceColumn: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].sourceContentType: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].term: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].text: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].validation: polymorphic schema; accepts an untyped value
- followedSites[].informationProtection: polymorphic schema; accepts an untyped value
- followedSites[].items[].createdByUser: polymorphic schema; accepts an untyped value
- followedSites[].items[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- followedSites[].items[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- followedSites[].lists[].activities[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].createdByUser: polymorphic schema; accepts an untyped value
- followedSites[].lists[].drive: polymorphic schema; accepts an untyped value
- followedSites[].lists[].items[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- followedSites[].lists[].list: polymorphic schema; accepts an untyped value
- followedSites[].lists[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].lists[].subscriptions[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lockState: polymorphic schema; accepts an untyped value
- followedSites[].onenote: polymorphic schema; accepts an untyped value
- followedSites[].operations[].error: polymorphic schema; accepts an untyped value
- followedSites[].operations[].status: polymorphic schema; accepts an untyped value
- followedSites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].canvasLayout: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].createdByUser: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].pageLayout: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].publishingState: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].titleArea: polymorphic schema; accepts an untyped value
- followedSites[].pageTemplates[].webParts[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].pages[].createdByUser: polymorphic schema; accepts an untyped value
- followedSites[].pages[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- followedSites[].pages[].pageLayout: polymorphic schema; accepts an untyped value
- followedSites[].pages[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].pages[].publishingState: polymorphic schema; accepts an untyped value
- followedSites[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].recycleBin: polymorphic schema; accepts an untyped value
- followedSites[].sites[]: recursive schema; accepts an untyped value
- followedSites[].template: polymorphic schema; accepts an untyped value
- followedSites[].termStore: polymorphic schema; accepts an untyped value
- identityGovernance: polymorphic schema; accepts an untyped value
- inferenceClassification: polymorphic schema; accepts an untyped value
- informationProtection: polymorphic schema; accepts an untyped value
- invitedBy: polymorphic schema; accepts an untyped value
- joinedGroups[].accessType: polymorphic schema; accepts an untyped value
- joinedGroups[].cloudLicensing: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].attendees[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].events[].body: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].end: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- joinedGroups[].events[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].events[].importance: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].location: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].locations[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].events[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].organizer: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].recurrence: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].responseStatus: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].sensitivity: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].showAs: polymorphic schema; accepts an untyped value
- joinedGroups[].events[].start: polymorphic schema; accepts an untyped value
- joinedGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- joinedGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- joinedGroups[].onenote: polymorphic schema; accepts an untyped value
- joinedGroups[].photo: polymorphic schema; accepts an untyped value
- joinedGroups[].settings[].values[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].analytics: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].contentModels[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].createdByUser: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].deleted: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].documentProcessingJobs[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].drive: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].informationProtection: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].lockState: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].onenote: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].ownerIdentityToResolve: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].pageTemplates[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].parentReference: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].sites[].recycleBin: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].sites[]: recursive schema; accepts an untyped value
- joinedGroups[].sites[].template: polymorphic schema; accepts an untyped value
- joinedGroups[].sites[].termStore: polymorphic schema; accepts an untyped value
- joinedGroups[].team: polymorphic schema; accepts an untyped value
- joinedGroups[].threads[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].threads[].posts[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].threads[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- joinedGroups[].writebackConfiguration: polymorphic schema; accepts an untyped value
- mailboxSettings: polymorphic schema; accepts an untyped value
- managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- managedDevices[].cloudPcRemoteActionResults[].statusDetail: polymorphic schema; accepts an untyped value
- managedDevices[].cloudPcRemoteActionResults[].statusDetails: polymorphic schema; accepts an untyped value
- managedDevices[].configurationManagerClientHealthState: polymorphic schema; accepts an untyped value
- managedDevices[].configurationManagerClientInformation: polymorphic schema; accepts an untyped value
- managedDevices[].detectedApps[].managedDevices[]: recursive schema; accepts an untyped value
- managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- managedDevices[].deviceCompliancePolicyStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].deviceConfigurationStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].logCollectionRequests[].size: polymorphic schema; accepts an untyped value
- managedDevices[].logCollectionRequests[].sizeInKB: polymorphic schema; accepts an untyped value
- managedDevices[].managedDeviceMobileAppConfigurationStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].securityBaselineStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].analytics: polymorphic schema; accepts an untyped value
- managedDevices[].users[].appConsentRequestsForApproval[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].appRoleAssignedResources[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].approvals[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].authentication: polymorphic schema; accepts an untyped value
- managedDevices[].users[].authorizationInfo: polymorphic schema; accepts an untyped value
- managedDevices[].users[].chats[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudClipboard: polymorphic schema; accepts an untyped value
- managedDevices[].users[].cloudLicensing: polymorphic schema; accepts an untyped value
- managedDevices[].users[].cloudRealtimeCommunicationInfo: polymorphic schema; accepts an untyped value
- managedDevices[].users[].communications: polymorphic schema; accepts an untyped value
- managedDevices[].users[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- managedDevices[].users[].deviceEnrollmentConfigurations[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].deviceKeys[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].deviceManagementTroubleshootingEvents[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].devices[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].employeeOrgData: polymorphic schema; accepts an untyped value
- managedDevices[].users[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].followedSites[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].identities[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].identityGovernance: polymorphic schema; accepts an untyped value
- managedDevices[].users[].inferenceClassification: polymorphic schema; accepts an untyped value
- managedDevices[].users[].informationProtection: polymorphic schema; accepts an untyped value
- managedDevices[].users[].invitedBy: polymorphic schema; accepts an untyped value
- managedDevices[].users[].joinedGroups[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].licenseDetails[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings: polymorphic schema; accepts an untyped value
- managedDevices[].users[].managedAppLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedAppRegistrations[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedDevices[]: recursive schema; accepts an untyped value
- managedDevices[].users[].mobileAppIntentAndStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mobileAppTroubleshootingEvents[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].notifications[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].oauth2PermissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- managedDevices[].users[].onenote: polymorphic schema; accepts an untyped value
- managedDevices[].users[].onlineMeetings[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].passwordProfile: polymorphic schema; accepts an untyped value
- managedDevices[].users[].pendingAccessReviewInstances[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].presence: polymorphic schema; accepts an untyped value
- managedDevices[].users[].print: polymorphic schema; accepts an untyped value
- managedDevices[].users[].profile: polymorphic schema; accepts an untyped value
- managedDevices[].users[].security: polymorphic schema; accepts an untyped value
- managedDevices[].users[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].settings: polymorphic schema; accepts an untyped value
- managedDevices[].users[].sponsors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].todo: polymorphic schema; accepts an untyped value
- managedDevices[].users[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].virtualEvents: polymorphic schema; accepts an untyped value
- managedDevices[].users[].windowsInformationProtectionDeviceRegistrations[]: nested schema exceeds depth limit; accepts an untyped value
- mobileAppIntentAndStates[].mobileAppList[].supportedDeviceTypes[]: nested schema exceeds depth limit; accepts an untyped value
- mobileAppTroubleshootingEvents[].history[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- mobileAppTroubleshootingEvents[].troubleshootingErrorDetails: polymorphic schema; accepts an untyped value
- notifications[].payload.visualContent: polymorphic schema; accepts an untyped value
- notifications[].priority: polymorphic schema; accepts an untyped value
- notifications[].targetPolicy: polymorphic schema; accepts an untyped value
- onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- onenote: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- onlineMeetings[].anonymizeIdentityForRoles[]: polymorphic schema; accepts an untyped value
- onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- onlineMeetings[].capabilities[]: polymorphic schema; accepts an untyped value
- onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- onlineMeetings[].registration: polymorphic schema; accepts an untyped value
- onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- passwordProfile: polymorphic schema; accepts an untyped value
- pendingAccessReviewInstances[].decisions[].insights[]: nested schema exceeds depth limit; accepts an untyped value
- pendingAccessReviewInstances[].decisions[].instance: polymorphic schema; accepts an untyped value
- pendingAccessReviewInstances[].decisions[].permission: polymorphic schema; accepts an untyped value
- pendingAccessReviewInstances[].definition: polymorphic schema; accepts an untyped value
- pendingAccessReviewInstances[].stages[].decisions[]: nested schema exceeds depth limit; accepts an untyped value
- pendingAccessReviewInstances[].stages[].fallbackReviewers[]: nested schema exceeds depth limit; accepts an untyped value
- pendingAccessReviewInstances[].stages[].reviewers[]: nested schema exceeds depth limit; accepts an untyped value
- presence: polymorphic schema; accepts an untyped value
- print: polymorphic schema; accepts an untyped value
- profile: polymorphic schema; accepts an untyped value
- security: polymorphic schema; accepts an untyped value
- settings: polymorphic schema; accepts an untyped value
- todo: polymorphic schema; accepts an untyped value
- virtualEvents: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
