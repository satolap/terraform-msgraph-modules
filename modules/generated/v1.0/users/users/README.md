# /users

Create User

[Catalog](../../README.md) · [Users](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/user?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

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
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `assigned_licenses` | `assignedLicenses` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     }))` | no | no |
| `authentication` | `authentication` | `any` | no | no |
| `authorization_info` | `authorizationInfo` | `any` | no | no |
| `birthday` | `birthday` | `string` | no | no |
| `chats` | `chats` | `list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppInstallation")       consentedPermissionSet = optional(any)       teamsApp = optional(any)       teamsAppDefinition = optional(any)     })))       lastMessagePreview = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       pinnedMessages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")       message = optional(any)     })))       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       teamsApp = optional(any)     })))       targetedMessages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.targetedChatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       policyViolation = optional(any)       reactions = optional(any)       recipient = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       topic = optional(string)       viewpoint = optional(any)     }))` | no | no |
| `city` | `city` | `string` | no | no |
| `cloud_clipboard` | `cloudClipboard` | `any` | no | no |
| `company_name` | `companyName` | `string` | no | no |
| `consent_provided_for_minor` | `consentProvidedForMinor` | `string` | no | no |
| `country` | `country` | `string` | no | no |
| `custom_security_attributes` | `customSecurityAttributes` | `any` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `department` | `department` | `string` | no | no |
| `device_enrollment_limit` | `deviceEnrollmentLimit` | `number` | no | no |
| `device_management_troubleshooting_events` | `deviceManagementTroubleshootingEvents` | `list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       correlationId = optional(string)       eventDateTime = optional(string)     }))` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `employee_experience` | `employeeExperience` | `any` | no | no |
| `employee_hire_date` | `employeeHireDate` | `string` | no | no |
| `employee_id` | `employeeId` | `string` | no | no |
| `employee_leave_date_time` | `employeeLeaveDateTime` | `string` | no | no |
| `employee_org_data` | `employeeOrgData` | `any` | no | no |
| `employee_type` | `employeeType` | `string` | no | no |
| `external_user_state` | `externalUserState` | `string` | no | no |
| `external_user_state_change_date_time` | `externalUserStateChangeDateTime` | `string` | no | no |
| `fax_number` | `faxNumber` | `string` | no | no |
| `followed_sites` | `followedSites` | `list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       description = optional(string)       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       bundles = optional(any)       description = optional(string)       following = optional(any)       name = optional(string)       parentReference = optional(any)       sharePointIds = optional(any)     })))       error = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseItem")       description = optional(string)       name = optional(string)       parentReference = optional(any)     })))       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(any)       list = optional(any)       name = optional(string)       operations = optional(any)       parentReference = optional(any)       subscriptions = optional(any)     })))       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(any)       statusDetail = optional(string)       type = optional(string)     })))       pages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.baseSitePage")       description = optional(string)       name = optional(string)       pageLayout = optional(any)       parentReference = optional(any)       publishingState = optional(any)       title = optional(string)     })))       parentReference = optional(any)       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       sites = optional(any)       termStore = optional(any)       termStores = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.store")       defaultLanguageTag = optional(string)       groups = optional(any)       languageTags = optional(list(string))       sets = optional(any)     })))     }))` | no | no |
| `given_name` | `givenName` | `string` | no | no |
| `hire_date` | `hireDate` | `string` | no | no |
| `identities` | `identities` | `list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     }))` | no | no |
| `identity_parent_id` | `identityParentId` | `string` | no | no |
| `inference_classification` | `inferenceClassification` | `any` | no | no |
| `interests` | `interests` | `list(string)` | no | no |
| `is_resource_account` | `isResourceAccount` | `bool` | no | no |
| `job_title` | `jobTitle` | `string` | no | no |
| `joined_teams` | `joinedTeams` | `list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(any)       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(any)       members = optional(any)       membershipType = optional(any)       messages = optional(any)       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(any)       summary = optional(any)       tabs = optional(any)       tenantId = optional(string)     })))       channels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(any)       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(any)       members = optional(any)       membershipType = optional(any)       messages = optional(any)       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(any)       summary = optional(any)       tabs = optional(any)       tenantId = optional(string)     })))       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(any)       group = optional(any)       guestSettings = optional(any)       incomingChannels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(any)       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(any)       members = optional(any)       membershipType = optional(any)       messages = optional(any)       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(any)       summary = optional(any)       tabs = optional(any)       tenantId = optional(string)     })))       installedApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppInstallation")       consentedPermissionSet = optional(any)       teamsApp = optional(any)       teamsAppDefinition = optional(any)     })))       internalId = optional(string)       memberSettings = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       messagingSettings = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(any)       summary = optional(any)       tags = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTag")       description = optional(string)       displayName = optional(string)       memberCount = optional(number)       members = optional(any)       tagType = optional(any)       teamId = optional(string)     })))       template = optional(any)       tenantId = optional(string)       visibility = optional(any)       webUrl = optional(string)     }))` | no | no |
| `last_password_change_date_time` | `lastPasswordChangeDateTime` | `string` | no | yes |
| `mail` | `mail` | `string` | no | no |
| `mail_nickname` | `mailNickname` | `string` | no | no |
| `mailbox_settings` | `mailboxSettings` | `any` | no | no |
| `managed_app_registrations` | `managedAppRegistrations` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppPolicy")       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       version = optional(string)     })))       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppPolicy")       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       version = optional(string)     })))       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppOperation")       displayName = optional(string)       lastModifiedDateTime = optional(string)       state = optional(string)       version = optional(string)     })))       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     }))` | no | no |
| `managed_devices` | `managedDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       complianceState = optional(string)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       version = optional(number)     })))       deviceConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       version = optional(number)     })))       deviceEnrollmentType = optional(string)       deviceRegistrationState = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       logCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceLogCollectionResponse")       enrolledByUser = optional(string)       expirationDateTimeUTC = optional(string)       initiatedByUserPrincipalName = optional(string)       managedDeviceId = optional(string)       receivedDateTimeUTC = optional(string)       requestedDateTimeUTC = optional(string)       sizeInKB = optional(any)       status = optional(string)     })))       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementState = optional(string)       notes = optional(string)       partnerReportedThreatState = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(any)       assignedLicenses = optional(any)       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(any)       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(any)       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(any)       givenName = optional(string)       hireDate = optional(string)       identities = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(any)       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppRegistrations = optional(any)       managedDevices = optional(any)       mySite = optional(string)       oauth2PermissionGrants = optional(any)       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(any)       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       permissionGrants = optional(any)       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     })))     }))` | no | yes |
| `my_site` | `mySite` | `string` | no | no |
| `oauth2_permission_grants` | `oauth2PermissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `office_location` | `officeLocation` | `string` | no | no |
| `on_premises_immutable_id` | `onPremisesImmutableId` | `string` | no | no |
| `on_premises_provisioning_errors` | `onPremisesProvisioningErrors` | `list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     }))` | no | no |
| `on_premises_sync_behavior` | `onPremisesSyncBehavior` | `any` | no | no |
| `onenote` | `onenote` | `any` | no | no |
| `online_meetings` | `onlineMeetings` | `list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       broadcastSettings = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     }))` | no | no |
| `other_mails` | `otherMails` | `list(string)` | no | no |
| `outlook` | `outlook` | `any` | no | no |
| `password_policies` | `passwordPolicies` | `string` | no | yes |
| `password_profile` | `passwordProfile` | `any` | no | yes |
| `past_projects` | `pastProjects` | `list(string)` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `postal_code` | `postalCode` | `string` | no | no |
| `preferred_data_location` | `preferredDataLocation` | `string` | no | no |
| `preferred_language` | `preferredLanguage` | `string` | no | no |
| `preferred_name` | `preferredName` | `string` | no | no |
| `presence` | `presence` | `any` | no | no |
| `print` | `print` | `any` | no | no |
| `responsibilities` | `responsibilities` | `list(string)` | no | no |
| `schools` | `schools` | `list(string)` | no | no |
| `scoped_role_member_of` | `scopedRoleMemberOf` | `list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.identity")       displayName = optional(string)       id = optional(string)     }))     }))` | no | no |
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
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
| `user_type` | `userType` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Standard user creation requires accountEnabled, displayName, mailNickname, passwordProfile.password, and userPrincipalName; identities-based accounts have different requirements. Review https://learn.microsoft.com/graph/api/user-post-users.
- authentication: polymorphic schema; accepts an untyped value
- authorizationInfo: polymorphic schema; accepts an untyped value
- chats[].installedApps[].consentedPermissionSet: polymorphic schema; accepts an untyped value
- chats[].installedApps[].teamsApp: polymorphic schema; accepts an untyped value
- chats[].installedApps[].teamsAppDefinition: polymorphic schema; accepts an untyped value
- chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- chats[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- chats[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- chats[].messages[].from: polymorphic schema; accepts an untyped value
- chats[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- chats[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].messages[].replies[]: recursive schema; accepts an untyped value
- chats[].migrationMode: polymorphic schema; accepts an untyped value
- chats[].pinnedMessages[].message: polymorphic schema; accepts an untyped value
- chats[].tabs[].configuration: polymorphic schema; accepts an untyped value
- chats[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].body.contentType: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].channelIdentity: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].from: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].policyViolation: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].targetedMessages[].recipient: polymorphic schema; accepts an untyped value
- chats[].targetedMessages[].replies[]: nested schema exceeds depth limit; accepts an untyped value
- chats[].viewpoint: polymorphic schema; accepts an untyped value
- cloudClipboard: polymorphic schema; accepts an untyped value
- customSecurityAttributes: polymorphic schema; accepts an untyped value
- employeeExperience: polymorphic schema; accepts an untyped value
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
- followedSites[].columns[].term: polymorphic schema; accepts an untyped value
- followedSites[].columns[].text: polymorphic schema; accepts an untyped value
- followedSites[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- followedSites[].columns[].validation: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].base: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- followedSites[].contentTypes[].columnLinks[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].columnPositions[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].contentTypes[].documentSet: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- followedSites[].contentTypes[].order: polymorphic schema; accepts an untyped value
- followedSites[].drive: polymorphic schema; accepts an untyped value
- followedSites[].drives[].bundles[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].drives[].following[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].drives[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].drives[].sharePointIds: polymorphic schema; accepts an untyped value
- followedSites[].error: polymorphic schema; accepts an untyped value
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
- followedSites[].externalColumns[].term: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].text: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- followedSites[].externalColumns[].validation: polymorphic schema; accepts an untyped value
- followedSites[].items[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].lists[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].drive: polymorphic schema; accepts an untyped value
- followedSites[].lists[].items[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].list: polymorphic schema; accepts an untyped value
- followedSites[].lists[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].lists[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].lists[].subscriptions[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].onenote: polymorphic schema; accepts an untyped value
- followedSites[].operations[].error: polymorphic schema; accepts an untyped value
- followedSites[].operations[].status: polymorphic schema; accepts an untyped value
- followedSites[].pages[].pageLayout: polymorphic schema; accepts an untyped value
- followedSites[].pages[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].pages[].publishingState: polymorphic schema; accepts an untyped value
- followedSites[].parentReference: polymorphic schema; accepts an untyped value
- followedSites[].sites[]: recursive schema; accepts an untyped value
- followedSites[].termStore: polymorphic schema; accepts an untyped value
- followedSites[].termStores[].groups[]: nested schema exceeds depth limit; accepts an untyped value
- followedSites[].termStores[].sets[]: nested schema exceeds depth limit; accepts an untyped value
- inferenceClassification: polymorphic schema; accepts an untyped value
- joinedTeams[].allChannels[].allMembers[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].enabledApps[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].filesFolder: polymorphic schema; accepts an untyped value
- joinedTeams[].allChannels[].layoutType: polymorphic schema; accepts an untyped value
- joinedTeams[].allChannels[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].membershipType: polymorphic schema; accepts an untyped value
- joinedTeams[].allChannels[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].migrationMode: polymorphic schema; accepts an untyped value
- joinedTeams[].allChannels[].sharedWithTeams[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].allChannels[].summary: polymorphic schema; accepts an untyped value
- joinedTeams[].allChannels[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].allMembers[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].enabledApps[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].filesFolder: polymorphic schema; accepts an untyped value
- joinedTeams[].channels[].layoutType: polymorphic schema; accepts an untyped value
- joinedTeams[].channels[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].membershipType: polymorphic schema; accepts an untyped value
- joinedTeams[].channels[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].migrationMode: polymorphic schema; accepts an untyped value
- joinedTeams[].channels[].sharedWithTeams[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].channels[].summary: polymorphic schema; accepts an untyped value
- joinedTeams[].channels[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].funSettings: polymorphic schema; accepts an untyped value
- joinedTeams[].group: polymorphic schema; accepts an untyped value
- joinedTeams[].guestSettings: polymorphic schema; accepts an untyped value
- joinedTeams[].incomingChannels[].allMembers[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].enabledApps[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].filesFolder: polymorphic schema; accepts an untyped value
- joinedTeams[].incomingChannels[].layoutType: polymorphic schema; accepts an untyped value
- joinedTeams[].incomingChannels[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].membershipType: polymorphic schema; accepts an untyped value
- joinedTeams[].incomingChannels[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].migrationMode: polymorphic schema; accepts an untyped value
- joinedTeams[].incomingChannels[].sharedWithTeams[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].incomingChannels[].summary: polymorphic schema; accepts an untyped value
- joinedTeams[].incomingChannels[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].installedApps[].consentedPermissionSet: polymorphic schema; accepts an untyped value
- joinedTeams[].installedApps[].teamsApp: polymorphic schema; accepts an untyped value
- joinedTeams[].installedApps[].teamsAppDefinition: polymorphic schema; accepts an untyped value
- joinedTeams[].memberSettings: polymorphic schema; accepts an untyped value
- joinedTeams[].messagingSettings: polymorphic schema; accepts an untyped value
- joinedTeams[].operations[].error: polymorphic schema; accepts an untyped value
- joinedTeams[].photo: polymorphic schema; accepts an untyped value
- joinedTeams[].primaryChannel: polymorphic schema; accepts an untyped value
- joinedTeams[].schedule: polymorphic schema; accepts an untyped value
- joinedTeams[].specialization: polymorphic schema; accepts an untyped value
- joinedTeams[].summary: polymorphic schema; accepts an untyped value
- joinedTeams[].tags[].members[]: nested schema exceeds depth limit; accepts an untyped value
- joinedTeams[].tags[].tagType: polymorphic schema; accepts an untyped value
- joinedTeams[].template: polymorphic schema; accepts an untyped value
- joinedTeams[].visibility: polymorphic schema; accepts an untyped value
- mailboxSettings: polymorphic schema; accepts an untyped value
- managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- managedDevices[].deviceCompliancePolicyStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].deviceConfigurationStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].logCollectionRequests[].sizeInKB: polymorphic schema; accepts an untyped value
- managedDevices[].users[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].authentication: polymorphic schema; accepts an untyped value
- managedDevices[].users[].authorizationInfo: polymorphic schema; accepts an untyped value
- managedDevices[].users[].chats[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudClipboard: polymorphic schema; accepts an untyped value
- managedDevices[].users[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- managedDevices[].users[].deviceManagementTroubleshootingEvents[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].employeeExperience: polymorphic schema; accepts an untyped value
- managedDevices[].users[].employeeOrgData: polymorphic schema; accepts an untyped value
- managedDevices[].users[].followedSites[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].identities[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].inferenceClassification: polymorphic schema; accepts an untyped value
- managedDevices[].users[].joinedTeams[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings: polymorphic schema; accepts an untyped value
- managedDevices[].users[].managedAppRegistrations[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedDevices[]: recursive schema; accepts an untyped value
- managedDevices[].users[].oauth2PermissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- managedDevices[].users[].onenote: polymorphic schema; accepts an untyped value
- managedDevices[].users[].onlineMeetings[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].outlook: polymorphic schema; accepts an untyped value
- managedDevices[].users[].passwordProfile: polymorphic schema; accepts an untyped value
- managedDevices[].users[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].presence: polymorphic schema; accepts an untyped value
- managedDevices[].users[].print: polymorphic schema; accepts an untyped value
- managedDevices[].users[].scopedRoleMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].settings: polymorphic schema; accepts an untyped value
- managedDevices[].users[].sponsors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].todo: polymorphic schema; accepts an untyped value
- managedDevices[].users[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- onenote: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- outlook: polymorphic schema; accepts an untyped value
- passwordProfile: polymorphic schema; accepts an untyped value
- presence: polymorphic schema; accepts an untyped value
- print: polymorphic schema; accepts an untyped value
- settings: polymorphic schema; accepts an untyped value
- todo: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
