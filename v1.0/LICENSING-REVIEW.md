# Microsoft Graph v1.0 licensing review queue

[Catalog](README.md) Â· [manifest.json](manifest.json)

299 generated endpoints carry an unknown licensing record. Each path links to its generated module README; review the endpoint's Microsoft Graph documentation and Microsoft Entra licensing before relying on it. No license entitlement is inferred from API behavior.

## Applications (`applications`)

9 unknown endpoints.

- [`/applications/{application-id}/extensionProperties`](applications/extensionProperties/README.md)
- [`/applications/{application-id}/federatedIdentityCredentials`](applications/federatedIdentityCredentials/README.md)
- [`/policies/appManagementPolicies`](policies/appManagementPolicies/README.md)
- [`/policies/claimsMappingPolicies`](policies/claimsMappingPolicies/README.md)
- [`/policies/tokenIssuancePolicies`](policies/tokenIssuancePolicies/README.md)
- [`/policies/tokenLifetimePolicies`](policies/tokenLifetimePolicies/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/delegatedPermissionClassifications`](servicePrincipals/delegatedPermissionClassifications/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/remoteDesktopSecurityConfiguration/approvedClientApps`](servicePrincipals/remoteDesktopSecurityConfiguration/approvedClientApps/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/synchronization/jobs`](servicePrincipals/synchronization/jobs/README.md)

## Backup and recovery (`backup-and-recovery`)

4 unknown endpoints.

- [`/solutions/backupRestore/exchangeRestoreSessions/{exchangeRestoreSession-id}/mailboxRestoreArtifactsBulkAdditionRequests`](solutions/backupRestore/exchangeRestoreSessions/mailboxRestoreArtifactsBulkAdditionRequests/README.md)
- [`/solutions/backupRestore/oneDriveForBusinessRestoreSessions/{oneDriveForBusinessRestoreSession-id}/driveRestoreArtifactsBulkAdditionRequests`](solutions/backupRestore/oneDriveForBusinessRestoreSessions/driveRestoreArtifactsBulkAdditionRequests/README.md)
- [`/solutions/backupRestore/serviceApps`](solutions/backupRestore/serviceApps/README.md)
- [`/solutions/backupRestore/sharePointRestoreSessions/{sharePointRestoreSession-id}/siteRestoreArtifactsBulkAdditionRequests`](solutions/backupRestore/sharePointRestoreSessions/siteRestoreArtifactsBulkAdditionRequests/README.md)

## Calendars (`calendars`)

22 unknown endpoints.

- [`/groups/{group-id}/calendar/calendarPermissions`](groups/calendar/calendarPermissions/README.md)
- [`/groups/{group-id}/calendar/events`](groups/calendar/events/README.md)
- [`/groups/{group-id}/events`](groups/events/README.md)
- [`/me/calendar/events`](me/calendar/events/README.md)
- [`/me/calendarGroups`](me/calendarGroups/README.md)
- [`/me/calendarGroups/{calendarGroup-id}/calendars`](me/calendarGroups/calendars/README.md)
- [`/me/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](me/calendarGroups/calendars/events/README.md)
- [`/me/calendars`](me/calendars/README.md)
- [`/me/calendars/{calendar-id}/events`](me/calendars/events/README.md)
- [`/me/events`](me/events/README.md)
- [`/me/settings/workHoursAndLocations/occurrences`](me/settings/workHoursAndLocations/occurrences/README.md)
- [`/me/settings/workHoursAndLocations/recurrences`](me/settings/workHoursAndLocations/recurrences/README.md)
- [`/users/{user-id}/calendar/calendarPermissions`](users/calendar/calendarPermissions/README.md)
- [`/users/{user-id}/calendar/events`](users/calendar/events/README.md)
- [`/users/{user-id}/calendarGroups`](users/calendarGroups/README.md)
- [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars`](users/calendarGroups/calendars/README.md)
- [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](users/calendarGroups/calendars/events/README.md)
- [`/users/{user-id}/calendars`](users/calendars/README.md)
- [`/users/{user-id}/calendars/{calendar-id}/events`](users/calendars/events/README.md)
- [`/users/{user-id}/events`](users/events/README.md)
- [`/users/{user-id}/settings/workHoursAndLocations/occurrences`](users/settings/workHoursAndLocations/occurrences/README.md)
- [`/users/{user-id}/settings/workHoursAndLocations/recurrences`](users/settings/workHoursAndLocations/recurrences/README.md)

## Change notifications (`change-notifications`)

1 unknown endpoint.

- [`/subscriptions`](subscriptions/README.md)

## Customer booking (`customer-booking`)

6 unknown endpoints.

- [`/solutions/bookingBusinesses`](solutions/bookingBusinesses/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/appointments`](solutions/bookingBusinesses/appointments/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/customQuestions`](solutions/bookingBusinesses/customQuestions/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/customers`](solutions/bookingBusinesses/customers/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/services`](solutions/bookingBusinesses/services/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/staffMembers`](solutions/bookingBusinesses/staffMembers/README.md)

## Device and app management (`device-and-app-management`)

82 unknown endpoints.

- [`/admin/edge/internetExplorerMode/siteLists`](admin/edge/internetExplorerMode/siteLists/README.md)
- [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sharedCookies`](admin/edge/internetExplorerMode/siteLists/sharedCookies/README.md)
- [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sites`](admin/edge/internetExplorerMode/siteLists/sites/README.md)
- [`/deviceAppManagement/androidManagedAppProtections`](deviceAppManagement/androidManagedAppProtections/README.md)
- [`/deviceAppManagement/androidManagedAppProtections/{androidManagedAppProtection-id}/apps`](deviceAppManagement/androidManagedAppProtections/apps/README.md)
- [`/deviceAppManagement/defaultManagedAppProtections`](deviceAppManagement/defaultManagedAppProtections/README.md)
- [`/deviceAppManagement/defaultManagedAppProtections/{defaultManagedAppProtection-id}/apps`](deviceAppManagement/defaultManagedAppProtections/apps/README.md)
- [`/deviceAppManagement/iosManagedAppProtections`](deviceAppManagement/iosManagedAppProtections/README.md)
- [`/deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}/apps`](deviceAppManagement/iosManagedAppProtections/apps/README.md)
- [`/deviceAppManagement/managedAppRegistrations/{managedAppRegistration-id}/operations`](deviceAppManagement/managedAppRegistrations/operations/README.md)
- [`/deviceAppManagement/managedEBooks`](deviceAppManagement/managedEBooks/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/assignments`](deviceAppManagement/managedEBooks/assignments/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/deviceStates`](deviceAppManagement/managedEBooks/deviceStates/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary`](deviceAppManagement/managedEBooks/userStateSummary/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary/{userInstallStateSummary-id}/deviceStates`](deviceAppManagement/managedEBooks/userStateSummary/deviceStates/README.md)
- [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies`](deviceAppManagement/mdmWindowsInformationProtectionPolicies/README.md)
- [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](deviceAppManagement/mdmWindowsInformationProtectionPolicies/exemptAppLockerFiles/README.md)
- [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](deviceAppManagement/mdmWindowsInformationProtectionPolicies/protectedAppLockerFiles/README.md)
- [`/deviceAppManagement/mobileAppCategories`](deviceAppManagement/mobileAppCategories/README.md)
- [`/deviceAppManagement/mobileAppConfigurations`](deviceAppManagement/mobileAppConfigurations/README.md)
- [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/assignments`](deviceAppManagement/mobileAppConfigurations/assignments/README.md)
- [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/deviceStatuses`](deviceAppManagement/mobileAppConfigurations/deviceStatuses/README.md)
- [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/userStatuses`](deviceAppManagement/mobileAppConfigurations/userStatuses/README.md)
- [`/deviceAppManagement/mobileApps`](deviceAppManagement/mobileApps/README.md)
- [`/deviceAppManagement/mobileApps/{mobileApp-id}/assignments`](deviceAppManagement/mobileApps/assignments/README.md)
- [`/deviceAppManagement/targetedManagedAppConfigurations`](deviceAppManagement/targetedManagedAppConfigurations/README.md)
- [`/deviceAppManagement/targetedManagedAppConfigurations/{targetedManagedAppConfiguration-id}/apps`](deviceAppManagement/targetedManagedAppConfigurations/apps/README.md)
- [`/deviceAppManagement/vppTokens`](deviceAppManagement/vppTokens/README.md)
- [`/deviceAppManagement/windowsInformationProtectionPolicies`](deviceAppManagement/windowsInformationProtectionPolicies/README.md)
- [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](deviceAppManagement/windowsInformationProtectionPolicies/exemptAppLockerFiles/README.md)
- [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](deviceAppManagement/windowsInformationProtectionPolicies/protectedAppLockerFiles/README.md)
- [`/deviceManagement/auditEvents`](deviceManagement/auditEvents/README.md)
- [`/deviceManagement/complianceManagementPartners`](deviceManagement/complianceManagementPartners/README.md)
- [`/deviceManagement/detectedApps`](deviceManagement/detectedApps/README.md)
- [`/deviceManagement/deviceCategories`](deviceManagement/deviceCategories/README.md)
- [`/deviceManagement/deviceCompliancePolicies`](deviceManagement/deviceCompliancePolicies/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/assignments`](deviceManagement/deviceCompliancePolicies/assignments/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceSettingStateSummaries`](deviceManagement/deviceCompliancePolicies/deviceSettingStateSummaries/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceStatuses`](deviceManagement/deviceCompliancePolicies/deviceStatuses/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule`](deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule/{deviceComplianceScheduledActionForRule-id}/scheduledActionConfigurations`](deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/scheduledActionConfigurations/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/userStatuses`](deviceManagement/deviceCompliancePolicies/userStatuses/README.md)
- [`/deviceManagement/deviceCompliancePolicySettingStateSummaries`](deviceManagement/deviceCompliancePolicySettingStateSummaries/README.md)
- [`/deviceManagement/deviceCompliancePolicySettingStateSummaries/{deviceCompliancePolicySettingStateSummary-id}/deviceComplianceSettingStates`](deviceManagement/deviceCompliancePolicySettingStateSummaries/deviceComplianceSettingStates/README.md)
- [`/deviceManagement/deviceConfigurations`](deviceManagement/deviceConfigurations/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/assignments`](deviceManagement/deviceConfigurations/assignments/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceSettingStateSummaries`](deviceManagement/deviceConfigurations/deviceSettingStateSummaries/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceStatuses`](deviceManagement/deviceConfigurations/deviceStatuses/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/userStatuses`](deviceManagement/deviceConfigurations/userStatuses/README.md)
- [`/deviceManagement/deviceEnrollmentConfigurations`](deviceManagement/deviceEnrollmentConfigurations/README.md)
- [`/deviceManagement/deviceEnrollmentConfigurations/{deviceEnrollmentConfiguration-id}/assignments`](deviceManagement/deviceEnrollmentConfigurations/assignments/README.md)
- [`/deviceManagement/deviceManagementPartners`](deviceManagement/deviceManagementPartners/README.md)
- [`/deviceManagement/exchangeConnectors`](deviceManagement/exchangeConnectors/README.md)
- [`/deviceManagement/importedWindowsAutopilotDeviceIdentities`](deviceManagement/importedWindowsAutopilotDeviceIdentities/README.md)
- [`/deviceManagement/iosUpdateStatuses`](deviceManagement/iosUpdateStatuses/README.md)
- [`/deviceManagement/managedDevices`](deviceManagement/managedDevices/README.md)
- [`/deviceManagement/mobileAppTroubleshootingEvents`](deviceManagement/mobileAppTroubleshootingEvents/README.md)
- [`/deviceManagement/mobileAppTroubleshootingEvents/{mobileAppTroubleshootingEvent-id}/appLogCollectionRequests`](deviceManagement/mobileAppTroubleshootingEvents/appLogCollectionRequests/README.md)
- [`/deviceManagement/mobileThreatDefenseConnectors`](deviceManagement/mobileThreatDefenseConnectors/README.md)
- [`/deviceManagement/notificationMessageTemplates`](deviceManagement/notificationMessageTemplates/README.md)
- [`/deviceManagement/notificationMessageTemplates/{notificationMessageTemplate-id}/localizedNotificationMessages`](deviceManagement/notificationMessageTemplates/localizedNotificationMessages/README.md)
- [`/deviceManagement/remoteAssistancePartners`](deviceManagement/remoteAssistancePartners/README.md)
- [`/deviceManagement/resourceOperations`](deviceManagement/resourceOperations/README.md)
- [`/deviceManagement/roleAssignments`](deviceManagement/roleAssignments/README.md)
- [`/deviceManagement/roleDefinitions`](deviceManagement/roleDefinitions/README.md)
- [`/deviceManagement/roleDefinitions/{roleDefinition-id}/roleAssignments`](deviceManagement/roleDefinitions/roleAssignments/README.md)
- [`/deviceManagement/termsAndConditions`](deviceManagement/termsAndConditions/README.md)
- [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/acceptanceStatuses`](deviceManagement/termsAndConditions/acceptanceStatuses/README.md)
- [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/assignments`](deviceManagement/termsAndConditions/assignments/README.md)
- [`/deviceManagement/troubleshootingEvents`](deviceManagement/troubleshootingEvents/README.md)
- [`/deviceManagement/virtualEndpoint/deviceImages`](deviceManagement/virtualEndpoint/deviceImages/README.md)
- [`/deviceManagement/virtualEndpoint/onPremisesConnections`](deviceManagement/virtualEndpoint/onPremisesConnections/README.md)
- [`/deviceManagement/virtualEndpoint/provisioningPolicies`](deviceManagement/virtualEndpoint/provisioningPolicies/README.md)
- [`/deviceManagement/virtualEndpoint/userSettings`](deviceManagement/virtualEndpoint/userSettings/README.md)
- [`/deviceManagement/windowsAutopilotDeviceIdentities`](deviceManagement/windowsAutopilotDeviceIdentities/README.md)
- [`/deviceManagement/windowsInformationProtectionAppLearningSummaries`](deviceManagement/windowsInformationProtectionAppLearningSummaries/README.md)
- [`/deviceManagement/windowsInformationProtectionNetworkLearningSummaries`](deviceManagement/windowsInformationProtectionNetworkLearningSummaries/README.md)
- [`/deviceManagement/windowsMalwareInformation`](deviceManagement/windowsMalwareInformation/README.md)
- [`/deviceManagement/windowsMalwareInformation/{windowsMalwareInformation-id}/deviceMalwareStates`](deviceManagement/windowsMalwareInformation/deviceMalwareStates/README.md)
- [`/print/printers/{printer-id}/taskTriggers`](print/printers/taskTriggers/README.md)
- [`/print/shares`](print/shares/README.md)
- [`/print/taskDefinitions`](print/taskDefinitions/README.md)

## Education (`education`)

12 unknown endpoints.

- [`/education/classes`](education/classes/README.md)
- [`/education/classes/{educationClass-id}/assignmentCategories`](education/classes/assignmentCategories/README.md)
- [`/education/classes/{educationClass-id}/assignmentSettings/gradingSchemes`](education/classes/assignmentSettings/gradingSchemes/README.md)
- [`/education/classes/{educationClass-id}/assignments`](education/classes/assignments/README.md)
- [`/education/classes/{educationClass-id}/assignments/{educationAssignment-id}/resources`](education/classes/assignments/resources/README.md)
- [`/education/classes/{educationClass-id}/assignments/{educationAssignment-id}/submissions/{educationSubmission-id}/outcomes`](education/classes/assignments/submissions/outcomes/README.md)
- [`/education/classes/{educationClass-id}/assignments/{educationAssignment-id}/submissions/{educationSubmission-id}/resources`](education/classes/assignments/submissions/resources/README.md)
- [`/education/classes/{educationClass-id}/modules`](education/classes/modules/README.md)
- [`/education/classes/{educationClass-id}/modules/{educationModule-id}/resources`](education/classes/modules/resources/README.md)
- [`/education/me/rubrics`](education/me/rubrics/README.md)
- [`/education/schools`](education/schools/README.md)
- [`/education/users`](education/users/README.md)

## Employee experience (`employee-experience`)

1 unknown endpoint.

- [`/employeeExperience/communities`](employeeExperience/communities/README.md)

## Extensions (`extensions`)

13 unknown endpoints.

- [`/devices/{device-id}/extensions`](devices/extensions/README.md)
- [`/groups/{group-id}/events/{event-id}/extensions`](groups/events/extensions/README.md)
- [`/groups/{group-id}/extensions`](groups/extensions/README.md)
- [`/groups/{group-id}/threads/{conversationThread-id}/posts/{post-id}/extensions`](groups/threads/posts/extensions/README.md)
- [`/organization/{organization-id}/extensions`](organization/extensions/README.md)
- [`/schemaExtensions`](schemaExtensions/README.md)
- [`/users/{user-id}/contacts/{contact-id}/extensions`](users/contacts/extensions/README.md)
- [`/users/{user-id}/events/{event-id}/extensions`](users/events/extensions/README.md)
- [`/users/{user-id}/extensions`](users/extensions/README.md)
- [`/users/{user-id}/messages/{message-id}/extensions`](users/messages/extensions/README.md)
- [`/users/{user-id}/notes/{note-id}/extensions`](users/notes/extensions/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/extensions`](users/todo/lists/extensions/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/extensions`](users/todo/lists/tasks/extensions/README.md)

## External data connections (`external-data-connections`)

3 unknown endpoints.

- [`/external/connections`](external/connections/README.md)
- [`/external/connections/{externalConnection-id}/groups`](external/connections/groups/README.md)
- [`/external/connections/{externalConnection-id}/groups/{externalGroup-id}/members`](external/connections/groups/members/README.md)

## Files (`files`)

6 unknown endpoints.

- [`/drives/{drive-id}/items/{driveItem-id}/permissions`](drives/items/permissions/README.md)
- [`/storage/fileStorage/containerTypes`](storage/fileStorage/containerTypes/README.md)
- [`/storage/fileStorage/containers`](storage/fileStorage/containers/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/migrationJobs`](storage/fileStorage/containers/migrationJobs/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups`](storage/fileStorage/containers/sharePointGroups/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups/{sharePointGroup-id}/members`](storage/fileStorage/containers/sharePointGroups/members/README.md)

## Groups (`groups`)

3 unknown endpoints.

- [`/groupLifecyclePolicies`](groupLifecyclePolicies/README.md)
- [`/groups/{group-id}/conversations/{conversation-id}/threads`](groups/conversations/threads/README.md)
- [`/groups/{group-id}/threads`](groups/threads/README.md)

## Identity and access (`identity-and-access`)

46 unknown endpoints.

- [`/devices`](devices/README.md)
- [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations`](directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/README.md)
- [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{certificateBasedAuthPki-id}/certificateAuthorities`](directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/certificateAuthorities/README.md)
- [`/domains`](domains/README.md)
- [`/domains/{domain-id}/federationConfiguration`](domains/federationConfiguration/README.md)
- [`/groupSettings`](groupSettings/README.md)
- [`/groups/{group-id}/appRoleAssignments`](groups/appRoleAssignments/README.md)
- [`/groups/{group-id}/settings`](groups/settings/README.md)
- [`/identity/apiConnectors`](identity/apiConnectors/README.md)
- [`/identity/authenticationEventListeners`](identity/authenticationEventListeners/README.md)
- [`/identity/authenticationEventsFlows`](identity/authenticationEventsFlows/README.md)
- [`/identity/b2xUserFlows`](identity/b2xUserFlows/README.md)
- [`/identity/b2xUserFlows/{b2xIdentityUserFlow-id}/userAttributeAssignments`](identity/b2xUserFlows/userAttributeAssignments/README.md)
- [`/identity/conditionalAccess/authenticationStrength/policies/{authenticationStrengthPolicy-id}/combinationConfigurations`](identity/conditionalAccess/authenticationStrength/policies/combinationConfigurations/README.md)
- [`/identity/conditionalAccess/policies`](identity/conditionalAccess/policies/README.md)
- [`/identity/customAuthenticationExtensions`](identity/customAuthenticationExtensions/README.md)
- [`/identity/identityProviders`](identity/identityProviders/README.md)
- [`/identity/riskPrevention/fraudProtectionProviders`](identity/riskPrevention/fraudProtectionProviders/README.md)
- [`/identity/riskPrevention/webApplicationFirewallProviders`](identity/riskPrevention/webApplicationFirewallProviders/README.md)
- [`/identity/userFlowAttributes`](identity/userFlowAttributes/README.md)
- [`/identity/verifiedId/profiles`](identity/verifiedId/profiles/README.md)
- [`/identityGovernance/accessReviews/definitions`](identityGovernance/accessReviews/definitions/README.md)
- [`/identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/resourceRoleScopes`](identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes/README.md)
- [`/identityGovernance/entitlementManagement/catalogs/{accessPackageCatalog-id}/resources/{accessPackageResource-id}/uploadSessions`](identityGovernance/entitlementManagement/catalogs/resources/uploadSessions/README.md)
- [`/identityGovernance/entitlementManagement/connectedOrganizations`](identityGovernance/entitlementManagement/connectedOrganizations/README.md)
- [`/identityGovernance/entitlementManagement/externalOriginResourceConnectors`](identityGovernance/entitlementManagement/externalOriginResourceConnectors/README.md)
- [`/identityGovernance/privilegedAccess/customExtensions`](identityGovernance/privilegedAccess/customExtensions/README.md)
- [`/identityGovernance/termsOfUse/agreements`](identityGovernance/termsOfUse/agreements/README.md)
- [`/identityProviders`](identityProviders/README.md)
- [`/oauth2PermissionGrants`](oauth2PermissionGrants/README.md)
- [`/organization/{organization-id}/branding/localizations`](organization/branding/localizations/README.md)
- [`/policies/activityBasedTimeoutPolicies`](policies/activityBasedTimeoutPolicies/README.md)
- [`/policies/authenticationStrengthPolicies`](policies/authenticationStrengthPolicies/README.md)
- [`/policies/featureRolloutPolicies`](policies/featureRolloutPolicies/README.md)
- [`/policies/homeRealmDiscoveryPolicies`](policies/homeRealmDiscoveryPolicies/README.md)
- [`/policies/permissionGrantPolicies`](policies/permissionGrantPolicies/README.md)
- [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/excludes`](policies/permissionGrantPolicies/excludes/README.md)
- [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/includes`](policies/permissionGrantPolicies/includes/README.md)
- [`/roleManagement/directory/roleAssignments`](roleManagement/directory/roleAssignments/README.md)
- [`/roleManagement/directory/roleDefinitions`](roleManagement/directory/roleDefinitions/README.md)
- [`/roleManagement/entitlementManagement/roleAssignments`](roleManagement/entitlementManagement/roleAssignments/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignedTo`](servicePrincipals/appRoleAssignedTo/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignments`](servicePrincipals/appRoleAssignments/README.md)
- [`/users/{user-id}/appRoleAssignments`](users/appRoleAssignments/README.md)
- [`/users/{user-id}/authentication/emailMethods`](users/authentication/emailMethods/README.md)
- [`/users/{user-id}/authentication/phoneMethods`](users/authentication/phoneMethods/README.md)

## Mail (`mail`)

10 unknown endpoints.

- [`/me/inferenceClassification/overrides`](me/inferenceClassification/overrides/README.md)
- [`/me/mailFolders`](me/mailFolders/README.md)
- [`/me/mailFolders/{mailFolder-id}/messages`](me/mailFolders/messages/README.md)
- [`/me/messages`](me/messages/README.md)
- [`/me/notes`](me/notes/README.md)
- [`/users/{user-id}/inferenceClassification/overrides`](users/inferenceClassification/overrides/README.md)
- [`/users/{user-id}/mailFolders`](users/mailFolders/README.md)
- [`/users/{user-id}/mailFolders/{mailFolder-id}/messages`](users/mailFolders/messages/README.md)
- [`/users/{user-id}/messages`](users/messages/README.md)
- [`/users/{user-id}/notes`](users/notes/README.md)

## Notes (`notes`)

4 unknown endpoints.

- [`/groups/{group-id}/onenote/pages`](groups/onenote/pages/README.md)
- [`/me/onenote/pages`](me/onenote/pages/README.md)
- [`/sites/{site-id}/onenote/pages`](sites/onenote/pages/README.md)
- [`/users/{user-id}/onenote/pages`](users/onenote/pages/README.md)

## People and workplace intelligence (`people-and-workplace-intelligence`)

2 unknown endpoints.

- [`/admin/people/profileCardProperties`](admin/people/profileCardProperties/README.md)
- [`/admin/people/profilePropertySettings`](admin/people/profilePropertySettings/README.md)

## Personal contacts (`personal-contacts`)

6 unknown endpoints.

- [`/me/contactFolders`](me/contactFolders/README.md)
- [`/me/contactFolders/{contactFolder-id}/contacts`](me/contactFolders/contacts/README.md)
- [`/me/contacts`](me/contacts/README.md)
- [`/users/{user-id}/contactFolders`](users/contactFolders/README.md)
- [`/users/{user-id}/contactFolders/{contactFolder-id}/contacts`](users/contactFolders/contacts/README.md)
- [`/users/{user-id}/contacts`](users/contacts/README.md)

## Reports (`reports`)

1 unknown endpoint.

- [`/deviceManagement/reports/exportJobs`](deviceManagement/reports/exportJobs/README.md)

## Search (`search`)

3 unknown endpoints.

- [`/search/acronyms`](search/acronyms/README.md)
- [`/search/bookmarks`](search/bookmarks/README.md)
- [`/search/qnas`](search/qnas/README.md)

## Security (`security`)

11 unknown endpoints.

- [`/security/attackSimulation/simulations`](security/attackSimulation/simulations/README.md)
- [`/security/cases/ediscoveryCases`](security/cases/ediscoveryCases/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/caseMembers`](security/cases/ediscoveryCases/caseMembers/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/siteSources`](security/cases/ediscoveryCases/custodians/siteSources/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources`](security/cases/ediscoveryCases/custodians/unifiedGroupSources/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/userSources`](security/cases/ediscoveryCases/custodians/userSources/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/reviewSets/{ediscoveryReviewSet-id}/queries`](security/cases/ediscoveryCases/reviewSets/queries/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/searches`](security/cases/ediscoveryCases/searches/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/tags`](security/cases/ediscoveryCases/tags/README.md)
- [`/security/labels/retentionLabels`](security/labels/retentionLabels/README.md)
- [`/security/triggers/retentionEvents`](security/triggers/retentionEvents/README.md)

## Sites and lists (`sites-and-lists`)

13 unknown endpoints.

- [`/sites/{site-id}/columns`](sites/columns/README.md)
- [`/sites/{site-id}/contentTypes`](sites/contentTypes/README.md)
- [`/sites/{site-id}/contentTypes/{contentType-id}/columns`](sites/contentTypes/columns/README.md)
- [`/sites/{site-id}/lists/{list-id}/columns`](sites/lists/columns/README.md)
- [`/sites/{site-id}/lists/{list-id}/contentTypes/{contentType-id}/columns`](sites/lists/contentTypes/columns/README.md)
- [`/sites/{site-id}/lists/{list-id}/items`](sites/lists/items/README.md)
- [`/sites/{site-id}/lists/{list-id}/items/{listItem-id}/documentSetVersions`](sites/lists/items/documentSetVersions/README.md)
- [`/sites/{site-id}/pages`](sites/pages/README.md)
- [`/sites/{site-id}/permissions`](sites/permissions/README.md)
- [`/sites/{site-id}/termStore/groups`](sites/termStore/groups/README.md)
- [`/sites/{site-id}/termStore/sets`](sites/termStore/sets/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/columns`](storage/fileStorage/containers/columns/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/permissions`](storage/fileStorage/containers/permissions/README.md)

## Teamwork and communications (`teamwork-and-communications`)

26 unknown endpoints.

- [`/appCatalogs/teamsApps`](appCatalogs/teamsApps/README.md)
- [`/appCatalogs/teamsApps/{teamsApp-id}/appDefinitions`](appCatalogs/teamsApps/appDefinitions/README.md)
- [`/chats`](chats/README.md)
- [`/chats/{chat-id}/installedApps`](chats/installedApps/README.md)
- [`/chats/{chat-id}/members`](chats/members/README.md)
- [`/chats/{chat-id}/pinnedMessages`](chats/pinnedMessages/README.md)
- [`/chats/{chat-id}/tabs`](chats/tabs/README.md)
- [`/communications/calls`](communications/calls/README.md)
- [`/communications/calls/{call-id}/audioRoutingGroups`](communications/calls/audioRoutingGroups/README.md)
- [`/employeeExperience/learningProviders/{learningProvider-id}/learningCourseActivities`](employeeExperience/learningProviders/learningCourseActivities/README.md)
- [`/me/onlineMeetings`](me/onlineMeetings/README.md)
- [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/presenters`](solutions/virtualEvents/townhalls/presenters/README.md)
- [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/registrationConfiguration/questions`](solutions/virtualEvents/townhalls/registrationConfiguration/questions/README.md)
- [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/presenters`](solutions/virtualEvents/webinars/presenters/README.md)
- [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/registrationConfiguration/questions`](solutions/virtualEvents/webinars/registrationConfiguration/questions/README.md)
- [`/teams/{team-id}/channels`](teams/channels/README.md)
- [`/teams/{team-id}/channels/{channel-id}/members`](teams/channels/members/README.md)
- [`/teams/{team-id}/channels/{channel-id}/tabs`](teams/channels/tabs/README.md)
- [`/teams/{team-id}/installedApps`](teams/installedApps/README.md)
- [`/teams/{team-id}/members`](teams/members/README.md)
- [`/teams/{team-id}/schedule/timeOffRequests`](teams/schedule/timeOffRequests/README.md)
- [`/teams/{team-id}/tags`](teams/tags/README.md)
- [`/teams/{team-id}/tags/{teamworkTag-id}/members`](teams/tags/members/README.md)
- [`/teamwork/workforceIntegrations`](teamwork/workforceIntegrations/README.md)
- [`/users/{user-id}/onlineMeetings`](users/onlineMeetings/README.md)
- [`/users/{user-id}/teamwork/installedApps`](users/teamwork/installedApps/README.md)

## Tenants (`tenants`)

5 unknown endpoints.

- [`/admin/configurationManagement/configurationMonitors`](admin/configurationManagement/configurationMonitors/README.md)
- [`/directory/tenantGovernance/governanceInvitations`](directory/tenantGovernance/governanceInvitations/README.md)
- [`/directory/tenantGovernance/governancePolicyTemplates`](directory/tenantGovernance/governancePolicyTemplates/README.md)
- [`/policies/crossTenantAccessPolicy/partners/{crossTenantAccessPolicyConfigurationPartner-tenantId}/m365Capabilities`](policies/crossTenantAccessPolicy/partners/m365Capabilities/README.md)
- [`/tenantRelationships/multiTenantOrganization/tenants`](tenantRelationships/multiTenantOrganization/tenants/README.md)

## To-do tasks (`to-do-tasks`)

8 unknown endpoints.

- [`/me/todo/lists`](me/todo/lists/README.md)
- [`/me/todo/lists/{todoTaskList-id}/tasks`](me/todo/lists/tasks/README.md)
- [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](me/todo/lists/tasks/checklistItems/README.md)
- [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](me/todo/lists/tasks/linkedResources/README.md)
- [`/users/{user-id}/todo/lists`](users/todo/lists/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks`](users/todo/lists/tasks/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](users/todo/lists/tasks/checklistItems/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](users/todo/lists/tasks/linkedResources/README.md)

## Users (`users`)

2 unknown endpoints.

- [`/me/outlook/masterCategories`](me/outlook/masterCategories/README.md)
- [`/users/{user-id}/outlook/masterCategories`](users/outlook/masterCategories/README.md)
