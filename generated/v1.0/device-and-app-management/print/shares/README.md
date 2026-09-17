# /print/shares

Create printerShare

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/printershare?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /print/shares`, `GET/PATCH/DELETE /print/shares/{printerShare-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/print/shares"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allow_all_users` | `allowAllUsers` | `bool` | no | no |
| `allowed_groups` | `allowedGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLabels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLabel")       labelId = optional(string)     })))       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       conversations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversation")       hasAttachments = optional(bool)       lastDeliveredDateTime = optional(string)       preview = optional(string)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(any)       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     })))       groupTypes = optional(list(string))       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(list(string))       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       photo = optional(any)       planner = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       resourceBehaviorOptions = optional(list(string))       resourceProvisioningOptions = optional(list(string))       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.groupSetting")       displayName = optional(string)       values = optional(any)     })))       sites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(any)       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       team = optional(any)       theme = optional(string)       threads = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationThread")       ccRecipients = optional(any)       hasAttachments = optional(bool)       isLocked = optional(bool)       lastDeliveredDateTime = optional(string)       posts = optional(any)       preview = optional(string)       toRecipients = optional(any)       topic = optional(string)       uniqueSenders = optional(list(string))     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       transitiveMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)     }))` | no | no |
| `allowed_users` | `allowedUsers` | `list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       correlationId = optional(string)       eventDateTime = optional(string)     })))       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(any)       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(any)       channels = optional(any)       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(any)       group = optional(any)       guestSettings = optional(any)       incomingChannels = optional(any)       installedApps = optional(any)       internalId = optional(string)       memberSettings = optional(any)       members = optional(any)       messagingSettings = optional(any)       operations = optional(any)       permissionGrants = optional(any)       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(any)       summary = optional(any)       tags = optional(any)       template = optional(any)       tenantId = optional(string)       visibility = optional(any)       webUrl = optional(string)     })))       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(list(string))       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       complianceState = optional(string)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceRegistrationState = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       logCollectionRequests = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementState = optional(string)       notes = optional(string)       partnerReportedThreatState = optional(string)       users = optional(any)     })))       mySite = optional(string)       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     })))       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       broadcastSettings = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.identity")       displayName = optional(string)       id = optional(string)     }))     })))       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes |
| `capabilities` | `capabilities` | `any` | no | no |
| `defaults` | `defaults` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_accepting_jobs` | `isAcceptingJobs` | `bool` | no | no |
| `jobs` | `jobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.printJob")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.printJobConfiguration")       collate = optional(bool)       finishings = optional(any)       fitPdfToPage = optional(bool)       inputBin = optional(string)       margin = optional(any)       mediaSize = optional(string)       mediaType = optional(string)       multipageLayout = optional(any)       orientation = optional(any)       outputBin = optional(string)       pagesPerSheet = optional(number)       scaling = optional(any)     }))       createdBy = optional(any)       documents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printDocument")     })))       isFetchable = optional(bool)       redirectedFrom = optional(string)       redirectedTo = optional(string)       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printJobStatus")       state = optional(string)     }))       tasks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.printTask")       definition = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskDefinition")       createdBy = optional(any)       displayName = optional(string)     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskStatus")       description = optional(string)       state = optional(string)     }))       trigger = optional(object({       odata_type = optional(string, "#microsoft.graph.printTaskTrigger")       definition = optional(any)       event = optional(string)     }))     })))     }))` | no | no |
| `location` | `location` | `any` | no | no |
| `manufacturer` | `manufacturer` | `string` | no | no |
| `model` | `model` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `printer` | `printer` | `any` | no | no |
| `status` | `status` | `object({       odata_type = optional(string, "#microsoft.graph.printerStatus")       state = optional(string)     })` | no | no |
| `view_point` | `viewPoint` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- allowedGroups[].accessType: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].attendees[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].events[].body: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].end: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- allowedGroups[].events[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].events[].importance: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].location: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].locations[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].events[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].organizer: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].recurrence: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].responseStatus: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].sensitivity: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].showAs: polymorphic schema; accepts an untyped value
- allowedGroups[].events[].start: polymorphic schema; accepts an untyped value
- allowedGroups[].onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- allowedGroups[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- allowedGroups[].onenote: polymorphic schema; accepts an untyped value
- allowedGroups[].photo: polymorphic schema; accepts an untyped value
- allowedGroups[].planner: polymorphic schema; accepts an untyped value
- allowedGroups[].settings[].values[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].analytics: polymorphic schema; accepts an untyped value
- allowedGroups[].sites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].drive: polymorphic schema; accepts an untyped value
- allowedGroups[].sites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].error: polymorphic schema; accepts an untyped value
- allowedGroups[].sites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].onenote: polymorphic schema; accepts an untyped value
- allowedGroups[].sites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].parentReference: polymorphic schema; accepts an untyped value
- allowedGroups[].sites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].sites[].sites[]: recursive schema; accepts an untyped value
- allowedGroups[].sites[].termStore: polymorphic schema; accepts an untyped value
- allowedGroups[].sites[].termStores[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].team: polymorphic schema; accepts an untyped value
- allowedGroups[].threads[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].threads[].posts[]: nested schema exceeds depth limit; accepts an untyped value
- allowedGroups[].threads[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].authentication: polymorphic schema; accepts an untyped value
- allowedUsers[].authorizationInfo: polymorphic schema; accepts an untyped value
- allowedUsers[].chats[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- allowedUsers[].chats[].members[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].chats[].messages[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].chats[].migrationMode: polymorphic schema; accepts an untyped value
- allowedUsers[].chats[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].chats[].pinnedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].chats[].tabs[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].chats[].targetedMessages[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].chats[].viewpoint: polymorphic schema; accepts an untyped value
- allowedUsers[].cloudClipboard: polymorphic schema; accepts an untyped value
- allowedUsers[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- allowedUsers[].employeeExperience: polymorphic schema; accepts an untyped value
- allowedUsers[].employeeOrgData: polymorphic schema; accepts an untyped value
- allowedUsers[].followedSites[].analytics: polymorphic schema; accepts an untyped value
- allowedUsers[].followedSites[].columns[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].contentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].drive: polymorphic schema; accepts an untyped value
- allowedUsers[].followedSites[].drives[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].error: polymorphic schema; accepts an untyped value
- allowedUsers[].followedSites[].externalColumns[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].items[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].lists[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].onenote: polymorphic schema; accepts an untyped value
- allowedUsers[].followedSites[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].pages[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].parentReference: polymorphic schema; accepts an untyped value
- allowedUsers[].followedSites[].permissions[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].followedSites[].sites[]: recursive schema; accepts an untyped value
- allowedUsers[].followedSites[].termStore: polymorphic schema; accepts an untyped value
- allowedUsers[].followedSites[].termStores[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].inferenceClassification: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].allChannels[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].channels[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].funSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].group: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].guestSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].incomingChannels[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].installedApps[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].memberSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].members[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].messagingSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].photo: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].primaryChannel: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].schedule: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].specialization: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].summary: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].tags[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].joinedTeams[].template: polymorphic schema; accepts an untyped value
- allowedUsers[].joinedTeams[].visibility: polymorphic schema; accepts an untyped value
- allowedUsers[].mailboxSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- allowedUsers[].managedAppRegistrations[].appliedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].managedAppRegistrations[].intendedPolicies[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].managedAppRegistrations[].operations[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- allowedUsers[].managedDevices[].deviceCompliancePolicyStates[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].managedDevices[].deviceConfigurationStates[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].managedDevices[].logCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- allowedUsers[].managedDevices[].users[]: recursive schema; accepts an untyped value
- allowedUsers[].onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- allowedUsers[].onenote: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- allowedUsers[].onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- allowedUsers[].outlook: polymorphic schema; accepts an untyped value
- allowedUsers[].passwordProfile: polymorphic schema; accepts an untyped value
- allowedUsers[].presence: polymorphic schema; accepts an untyped value
- allowedUsers[].print: polymorphic schema; accepts an untyped value
- allowedUsers[].settings: polymorphic schema; accepts an untyped value
- allowedUsers[].todo: polymorphic schema; accepts an untyped value
- capabilities: polymorphic schema; accepts an untyped value
- defaults: polymorphic schema; accepts an untyped value
- jobs[].configuration.finishings[]: polymorphic schema; accepts an untyped value
- jobs[].configuration.margin: polymorphic schema; accepts an untyped value
- jobs[].configuration.multipageLayout: polymorphic schema; accepts an untyped value
- jobs[].configuration.orientation: polymorphic schema; accepts an untyped value
- jobs[].configuration.scaling: polymorphic schema; accepts an untyped value
- jobs[].createdBy: polymorphic schema; accepts an untyped value
- jobs[].tasks[].definition.createdBy: nested schema exceeds depth limit; accepts an untyped value
- jobs[].tasks[].trigger.definition: nested schema exceeds depth limit; accepts an untyped value
- location: polymorphic schema; accepts an untyped value
- printer: polymorphic schema; accepts an untyped value
- viewPoint: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
