# /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks

Create new navigation property to tasks for identityGovernance

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-task?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks`, `GET/PATCH/DELETE /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks/{task-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/by-path-e1c257f8acfe/tasks"
  workflow_id = "parent-object-id"
  workflow_version_version_number = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `workflow_id` | URL parameter `workflow-id` | `string` | yes | no |
| `workflow_version_version_number` | URL parameter `workflowVersion-versionNumber` | `string` | yes | no |
| `arguments` | `arguments` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     }))` | no | no |
| `category` | `category` | `string` | no | no |
| `continue_on_error` | `continueOnError` | `bool` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `execution_sequence` | `executionSequence` | `number` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `task_definition_id` | `taskDefinitionId` | `string` | no | no |
| `task_processing_results` | `taskProcessingResults` | `list(object({       odata_type = optional(string, "#microsoft.graph.identityGovernance.taskProcessingResult")       completedDateTime = optional(string)       createdDateTime = optional(string)       failureReason = optional(string)       processingInfo = optional(string)       processingStatus = optional(string)       startedDateTime = optional(string)       subject = optional(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(any)       skuId = optional(string)     })))       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chat")       chatType = optional(string)       installedApps = optional(any)       lastMessagePreview = optional(any)       members = optional(any)       messages = optional(any)       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       permissionGrants = optional(any)       pinnedMessages = optional(any)       tabs = optional(any)       targetedMessages = optional(any)       topic = optional(string)       viewpoint = optional(any)     })))       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")       correlationId = optional(string)       eventDateTime = optional(string)     })))       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(list(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(any)       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     })))       givenName = optional(string)       hireDate = optional(string)       identities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.objectIdentity")       issuer = optional(string)       issuerAssignedId = optional(string)       signInType = optional(string)     })))       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.team")       allChannels = optional(any)       channels = optional(any)       classification = optional(string)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       firstChannelName = optional(string)       funSettings = optional(any)       group = optional(any)       guestSettings = optional(any)       incomingChannels = optional(any)       installedApps = optional(any)       internalId = optional(string)       memberSettings = optional(any)       members = optional(any)       messagingSettings = optional(any)       operations = optional(any)       permissionGrants = optional(any)       photo = optional(any)       primaryChannel = optional(any)       schedule = optional(any)       specialization = optional(any)       summary = optional(any)       tags = optional(any)       template = optional(any)       tenantId = optional(string)       visibility = optional(any)       webUrl = optional(string)     })))       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppRegistrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedAppRegistration")       appIdentifier = optional(any)       applicationVersion = optional(string)       appliedPolicies = optional(any)       createdDateTime = optional(string)       deviceName = optional(string)       deviceTag = optional(string)       deviceType = optional(string)       flaggedReasons = optional(any)       intendedPolicies = optional(any)       lastSyncDateTime = optional(string)       managementSdkVersion = optional(string)       operations = optional(any)       platformVersion = optional(string)       userId = optional(string)       version = optional(string)     })))       managedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       complianceState = optional(string)       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(any)       deviceConfigurationStates = optional(any)       deviceEnrollmentType = optional(string)       deviceRegistrationState = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       logCollectionRequests = optional(any)       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementState = optional(string)       notes = optional(string)       partnerReportedThreatState = optional(string)       users = optional(any)     })))       mySite = optional(string)       oauth2PermissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.oAuth2PermissionGrant")       clientId = optional(string)       consentType = optional(string)       principalId = optional(string)       resourceId = optional(string)       scope = optional(string)     })))       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesProvisioningError")       category = optional(string)       occurredDateTime = optional(string)       propertyCausingError = optional(string)       value = optional(string)     })))       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       broadcastSettings = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })))       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       permissionGrants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     })))       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(any)     })))       serviceProvisioningErrors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.serviceProvisioningError")       createdDateTime = optional(string)       isResolved = optional(bool)       serviceInstance = optional(string)     })))       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     }))       task = optional(object({       odata_type = optional(string, "#microsoft.graph.identityGovernance.task")       arguments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     })))       category = optional(string)       continueOnError = optional(bool)       description = optional(string)       displayName = optional(string)       executionSequence = optional(number)       isEnabled = optional(bool)       taskDefinitionId = optional(string)       taskProcessingResults = optional(any)     }))       workflowSubject = optional(any)     }))` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- taskProcessingResults[].subject.assignedLicenses[].disabledPlans: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.authentication: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.authorizationInfo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.chats[].installedApps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].lastMessagePreview: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.chats[].members: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].messages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].migrationMode: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.chats[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].pinnedMessages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].tabs: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].targetedMessages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.chats[].viewpoint: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.cloudClipboard: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.customSecurityAttributes: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.employeeExperience: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.employeeOrgData: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].analytics: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].columns: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].contentTypes: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].drive: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].drives: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].error: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].externalColumns: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].items: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].lists: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].onenote: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].pages: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].parentReference: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].permissions: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].sites: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].termStore: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.followedSites[].termStores: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.inferenceClassification: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].allChannels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].channels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].funSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].group: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].guestSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].incomingChannels: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].installedApps: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].memberSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].members: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].messagingSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].photo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].primaryChannel: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].schedule: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].specialization: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].summary: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].tags: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].template: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.joinedTeams[].visibility: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.mailboxSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].appIdentifier: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].appliedPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].flaggedReasons: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].intendedPolicies: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedAppRegistrations[].operations: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].deviceCategory: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].deviceCompliancePolicyStates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].deviceConfigurationStates: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].logCollectionRequests: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.managedDevices[].users: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onenote: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowLiveShare: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowMeetingChat: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].allowedPresenters: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].broadcastSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].chatInfo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].chatRestrictions: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].participants: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.onlineMeetings[].watermarkProtection: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.outlook: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.passwordProfile: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.presence: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.print: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.scopedRoleMemberOf[].roleMemberInfo: nested schema exceeds depth limit; accepts an untyped value
- taskProcessingResults[].subject.settings: polymorphic schema; accepts an untyped value
- taskProcessingResults[].subject.todo: polymorphic schema; accepts an untyped value
- taskProcessingResults[].task.taskProcessingResults[]: recursive schema; accepts an untyped value
- taskProcessingResults[].workflowSubject: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
