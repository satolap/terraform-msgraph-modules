# /employeeExperience/communities

Create community

[Catalog](../../../README.md) · [Employee experience](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/community?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /employeeExperience/communities`, `GET/PATCH/DELETE /employeeExperience/communities/{community-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/employee-experience/employee-experience/communities?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `group` | `group` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `owners` | `owners` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(list(string))     }))       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(object({       odata_type = optional(string, "#microsoft.graph.chatViewpoint")       isHidden = optional(bool)       lastMessageReadDateTime = optional(string)     }))     })))       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(any)       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     }))       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(any)       message = optional(string)       target = optional(string)     }))       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(any)       channels = optional(any)       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamFunSettings")       allowCustomMemes = optional(bool)       allowGiphy = optional(bool)       allowStickersAndMemes = optional(bool)       giphyContentRating = optional(string)     }))       group = optional(any)       guestSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamGuestSettings")       allowCreateUpdateChannels = optional(bool)       allowDeleteChannels = optional(bool)     }))       incomingChannels = optional(any)       installedApps = optional(any)       internalId = optional(string)       memberSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamMemberSettings")       allowAddRemoveApps = optional(bool)       allowCreatePrivateChannels = optional(bool)       allowCreateUpdateChannels = optional(bool)       allowCreateUpdateRemoveConnectors = optional(bool)       allowCreateUpdateRemoveTabs = optional(bool)       allowDeleteChannels = optional(bool)     }))       members = optional(any)       messagingSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.teamMessagingSettings")       allowChannelMentions = optional(bool)       allowOwnerDeleteMessages = optional(bool)       allowTeamMentions = optional(bool)       allowUserDeleteMessages = optional(bool)       allowUserEditMessages = optional(bool)     }))       operations = optional(any)       permissionGrants = optional(any)       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(string)       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.teamSummary")       guestsCount = optional(number)       membersCount = optional(number)       ownersCount = optional(number)     }))       tags = optional(any)       template = optional(any)       tenantId = optional(string)       visibility = optional(string)       webUrl = optional(string)     })))       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       archiveFolder = optional(string)       automaticRepliesSetting = optional(object({       odata_type = optional(string, "#microsoft.graph.automaticRepliesSetting")       externalAudience = optional(string)       externalReplyMessage = optional(string)       internalReplyMessage = optional(string)       scheduledEndDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       scheduledStartDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       status = optional(string)     }))       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(object({       odata_type = optional(string, "#microsoft.graph.localeInfo")       displayName = optional(string)       locale = optional(string)     }))       timeFormat = optional(string)       timeZone = optional(string)       workingHours = optional(object({       odata_type = optional(string, "#microsoft.graph.workingHours")       daysOfWeek = optional(list(string))       endTime = optional(string)       startTime = optional(string)       timeZone = optional(any)     }))     }))       managedAppRegistrations = optional(list(object({       odata_type = string       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       logCollectionRequests = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       notes = optional(string)       users = optional(any)     })))       mySite = optional(string)       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     })))       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       broadcastSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingSettings")       allowedAudience = optional(string)       captions = optional(any)       isAttendeeReportEnabled = optional(bool)       isQuestionAndAnswerEnabled = optional(bool)       isRecordingEnabled = optional(bool)       isVideoOnDemandEnabled = optional(bool)     }))       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(object({       odata_type = optional(string, "#microsoft.graph.meetingParticipants")       attendees = optional(any)       organizer = optional(any)     }))       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     })))       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       pastProjects = optional(list(string))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printerShare")       allowAllUsers = optional(bool)       allowedGroups = optional(any)       allowedUsers = optional(any)       capabilities = optional(any)       defaults = optional(any)       displayName = optional(string)       isAcceptingJobs = optional(bool)       jobs = optional(any)       location = optional(any)       manufacturer = optional(string)       model = optional(string)       printer = optional(any)       status = optional(any)       viewPoint = optional(any)     })))     }))       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(any)     })))       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes |
| `privacy` | `privacy` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults, except for abstract types listed in the generation notes: set their `odata_type` to a concrete type.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- group: navigation property; accepts an untyped value
- owners[].authentication: navigation property; accepts an untyped value
- owners[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].lastMessagePreview: navigation property; accepts an untyped value
- owners[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].cloudClipboard: navigation property; accepts an untyped value
- owners[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- owners[].deviceManagementTroubleshootingEvents[]: polymorphic schema; accepts an untyped value
- owners[].employeeExperience: navigation property; accepts an untyped value
- owners[].followedSites[].analytics: navigation property; accepts an untyped value
- owners[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].drive: navigation property; accepts an untyped value
- owners[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].error.details: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].error.innerError: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].onenote: navigation property; accepts an untyped value
- owners[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].followedSites[].sites[]: recursive schema; accepts an untyped value
- owners[].followedSites[].termStore: navigation property; accepts an untyped value
- owners[].followedSites[].termStores[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].inferenceClassification: navigation property; accepts an untyped value
- owners[].joinedTeams[].allChannels[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].channels[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].group: navigation property; accepts an untyped value
- owners[].joinedTeams[].incomingChannels[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].members[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].photo: navigation property; accepts an untyped value
- owners[].joinedTeams[].primaryChannel: navigation property; accepts an untyped value
- owners[].joinedTeams[].schedule: navigation property; accepts an untyped value
- owners[].joinedTeams[].tags[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].joinedTeams[].template: navigation property; accepts an untyped value
- owners[].mailboxSettings.workingHours.timeZone: polymorphic schema; accepts an untyped value
- owners[].managedAppRegistrations[].@odata.type: microsoft.graph.managedAppRegistration is abstract; odata_type has no default and must name a concrete type
- owners[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- owners[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].deviceCategory: navigation property; accepts an untyped value
- owners[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- owners[].managedDevices[].users[]: recursive schema; accepts an untyped value
- owners[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- owners[].onenote: navigation property; accepts an untyped value
- owners[].onlineMeetings[].broadcastSettings.captions: nested schema exceeds depth limit; accepts an untyped value
- owners[].onlineMeetings[].participants.attendees: nested schema exceeds depth limit; accepts an untyped value
- owners[].onlineMeetings[].participants.organizer: polymorphic schema; accepts an untyped value
- owners[].outlook: navigation property; accepts an untyped value
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
- owners[].scopedRoleMemberOf[].roleMemberInfo: polymorphic schema; accepts an untyped value
- owners[].serviceProvisioningErrors[]: polymorphic schema; accepts an untyped value
- owners[].settings: navigation property; accepts an untyped value
- owners[].sponsors[]: polymorphic schema; accepts an untyped value
- owners[].todo: navigation property; accepts an untyped value
- owners[].transitiveMemberOf[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
