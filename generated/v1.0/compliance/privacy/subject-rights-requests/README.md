# /privacy/subjectRightsRequests

Create subjectRightsRequest

[Catalog](../../../README.md) · [Compliance](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/subjectrightsrequest?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

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
| `approvers` | `approvers` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       correlationId = optional(string)       eventDateTime = optional(string)     })))       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(any)       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(any)       channels = optional(any)       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(any)       group = optional(any)       guestSettings = optional(any)       incomingChannels = optional(any)       installedApps = optional(any)       internalId = optional(string)       memberSettings = optional(any)       members = optional(any)       messagingSettings = optional(any)       operations = optional(any)       permissionGrants = optional(any)       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(any)       summary = optional(any)       tags = optional(any)       template = optional(any)       tenantId = optional(string)       visibility = optional(any)       webUrl = optional(string)     })))       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       complianceState = optional(string)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceRegistrationState = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       logCollectionRequests = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementState = optional(string)       notes = optional(string)       partnerReportedThreatState = optional(string)       users = optional(any)     })))       mySite = optional(string)       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     })))       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       broadcastSettings = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.identity")       displayName = optional(string)       id = optional(string)     }))     })))       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes |
| `assigned_to` | `assignedTo` | `any` | no | no |
| `closed_date_time` | `closedDateTime` | `string` | no | no |
| `collaborators` | `collaborators` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       correlationId = optional(string)       eventDateTime = optional(string)     })))       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(any)       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(any)       channels = optional(any)       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(any)       group = optional(any)       guestSettings = optional(any)       incomingChannels = optional(any)       installedApps = optional(any)       internalId = optional(string)       memberSettings = optional(any)       members = optional(any)       messagingSettings = optional(any)       operations = optional(any)       permissionGrants = optional(any)       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(any)       summary = optional(any)       tags = optional(any)       template = optional(any)       tenantId = optional(string)       visibility = optional(any)       webUrl = optional(string)     })))       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       complianceState = optional(string)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceRegistrationState = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       logCollectionRequests = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementState = optional(string)       notes = optional(string)       partnerReportedThreatState = optional(string)       users = optional(any)     })))       mySite = optional(string)       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     })))       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       broadcastSettings = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.identity")       displayName = optional(string)       id = optional(string)     }))     })))       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes |
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

- approvers[].authentication: polymorphic schema; accepts an untyped value
- approvers[].authorizationInfo: polymorphic schema; accepts an untyped value
- approvers[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- approvers[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].migrationMode: polymorphic schema; accepts an untyped value
- approvers[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].chats[].viewpoint: polymorphic schema; accepts an untyped value
- approvers[].cloudClipboard: polymorphic schema; accepts an untyped value
- approvers[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- approvers[].employeeExperience: polymorphic schema; accepts an untyped value
- approvers[].employeeOrgData: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].analytics: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].drive: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].error: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].onenote: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].parentReference: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].followedSites[].sites[]: recursive schema; accepts an untyped value
- approvers[].followedSites[].termStore: polymorphic schema; accepts an untyped value
- approvers[].followedSites[].termStores[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].inferenceClassification: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].allChannels[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].channels[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].funSettings: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].group: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].guestSettings: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].incomingChannels[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].memberSettings: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].members[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].messagingSettings: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].photo: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].primaryChannel: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].schedule: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].specialization: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].summary: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].tags[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].joinedTeams[].template: polymorphic schema; accepts an untyped value
- approvers[].joinedTeams[].visibility: polymorphic schema; accepts an untyped value
- approvers[].mailboxSettings: polymorphic schema; accepts an untyped value
- approvers[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- approvers[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- approvers[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- approvers[].managedDevices[].users[]: recursive schema; accepts an untyped value
- approvers[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- approvers[].onenote: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- approvers[].onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- approvers[].outlook: polymorphic schema; accepts an untyped value
- approvers[].passwordProfile: polymorphic schema; accepts an untyped value
- approvers[].presence: polymorphic schema; accepts an untyped value
- approvers[].print: polymorphic schema; accepts an untyped value
- approvers[].settings: polymorphic schema; accepts an untyped value
- approvers[].todo: polymorphic schema; accepts an untyped value
- assignedTo: polymorphic schema; accepts an untyped value
- collaborators[].authentication: polymorphic schema; accepts an untyped value
- collaborators[].authorizationInfo: polymorphic schema; accepts an untyped value
- collaborators[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- collaborators[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].migrationMode: polymorphic schema; accepts an untyped value
- collaborators[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].chats[].viewpoint: polymorphic schema; accepts an untyped value
- collaborators[].cloudClipboard: polymorphic schema; accepts an untyped value
- collaborators[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- collaborators[].employeeExperience: polymorphic schema; accepts an untyped value
- collaborators[].employeeOrgData: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].analytics: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].drive: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].error: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].onenote: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].parentReference: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].followedSites[].sites[]: recursive schema; accepts an untyped value
- collaborators[].followedSites[].termStore: polymorphic schema; accepts an untyped value
- collaborators[].followedSites[].termStores[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].inferenceClassification: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].allChannels[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].channels[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].funSettings: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].group: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].guestSettings: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].incomingChannels[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].memberSettings: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].members[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].messagingSettings: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].photo: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].primaryChannel: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].schedule: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].specialization: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].summary: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].tags[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].joinedTeams[].template: polymorphic schema; accepts an untyped value
- collaborators[].joinedTeams[].visibility: polymorphic schema; accepts an untyped value
- collaborators[].mailboxSettings: polymorphic schema; accepts an untyped value
- collaborators[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- collaborators[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- collaborators[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- collaborators[].managedDevices[].users[]: recursive schema; accepts an untyped value
- collaborators[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- collaborators[].onenote: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- collaborators[].onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- collaborators[].outlook: polymorphic schema; accepts an untyped value
- collaborators[].passwordProfile: polymorphic schema; accepts an untyped value
- collaborators[].presence: polymorphic schema; accepts an untyped value
- collaborators[].print: polymorphic schema; accepts an untyped value
- collaborators[].settings: polymorphic schema; accepts an untyped value
- collaborators[].todo: polymorphic schema; accepts an untyped value
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
