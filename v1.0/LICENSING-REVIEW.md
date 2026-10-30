# Microsoft Graph v1.0 licensing review queue

[Catalog](README.md) Â· [manifest.json](manifest.json)

299 generated endpoints carry an unknown licensing record. Each path links to its generated module README; review the endpoint's Microsoft Graph documentation and Microsoft Entra licensing before relying on it. No license entitlement is inferred from API behavior.

## Applications (`applications`)

9 unknown endpoints.

- [`/applications/{application-id}/extensionProperties`](applications/extension-properties/README.md)
- [`/applications/{application-id}/federatedIdentityCredentials`](applications/federated-identity-credentials/README.md)
- [`/policies/appManagementPolicies`](policies/app-management-policies/README.md)
- [`/policies/claimsMappingPolicies`](policies/claims-mapping-policies/README.md)
- [`/policies/tokenIssuancePolicies`](policies/token-issuance-policies/README.md)
- [`/policies/tokenLifetimePolicies`](policies/token-lifetime-policies/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/delegatedPermissionClassifications`](service-principals/delegated-permission-classifications/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/remoteDesktopSecurityConfiguration/approvedClientApps`](service-principals/remote-desktop-security-configuration/approved-client-apps/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/synchronization/jobs`](service-principals/synchronization/jobs/README.md)

## Backup and recovery (`backup-and-recovery`)

4 unknown endpoints.

- [`/solutions/backupRestore/exchangeRestoreSessions/{exchangeRestoreSession-id}/mailboxRestoreArtifactsBulkAdditionRequests`](solutions/backup-restore/exchange-restore-sessions/mailbox-restore-artifacts-bulk-addition-requests/README.md)
- [`/solutions/backupRestore/oneDriveForBusinessRestoreSessions/{oneDriveForBusinessRestoreSession-id}/driveRestoreArtifactsBulkAdditionRequests`](solutions/backup-restore/one-drive-for-business-restore-sessions/drive-restore-artifacts-bulk-addition-requests/README.md)
- [`/solutions/backupRestore/serviceApps`](solutions/backup-restore/service-apps/README.md)
- [`/solutions/backupRestore/sharePointRestoreSessions/{sharePointRestoreSession-id}/siteRestoreArtifactsBulkAdditionRequests`](solutions/backup-restore/share-point-restore-sessions/site-restore-artifacts-bulk-addition-requests/README.md)

## Calendars (`calendars`)

22 unknown endpoints.

- [`/groups/{group-id}/calendar/calendarPermissions`](groups/calendar/calendar-permissions/README.md)
- [`/groups/{group-id}/calendar/events`](groups/calendar/events/README.md)
- [`/groups/{group-id}/events`](groups/events/README.md)
- [`/me/calendar/events`](me/calendar/events/README.md)
- [`/me/calendarGroups`](me/calendar-groups/README.md)
- [`/me/calendarGroups/{calendarGroup-id}/calendars`](me/calendar-groups/calendars/README.md)
- [`/me/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](me/calendar-groups/calendars/events/README.md)
- [`/me/calendars`](me/calendars/README.md)
- [`/me/calendars/{calendar-id}/events`](me/calendars/events/README.md)
- [`/me/events`](me/events/README.md)
- [`/me/settings/workHoursAndLocations/occurrences`](me/settings/work-hours-and-locations/occurrences/README.md)
- [`/me/settings/workHoursAndLocations/recurrences`](me/settings/work-hours-and-locations/recurrences/README.md)
- [`/users/{user-id}/calendar/calendarPermissions`](users/calendar/calendar-permissions/README.md)
- [`/users/{user-id}/calendar/events`](users/calendar/events/README.md)
- [`/users/{user-id}/calendarGroups`](users/calendar-groups/README.md)
- [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars`](users/calendar-groups/calendars/README.md)
- [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](users/calendar-groups/calendars/events/README.md)
- [`/users/{user-id}/calendars`](users/calendars/README.md)
- [`/users/{user-id}/calendars/{calendar-id}/events`](users/calendars/events/README.md)
- [`/users/{user-id}/events`](users/events/README.md)
- [`/users/{user-id}/settings/workHoursAndLocations/occurrences`](users/settings/work-hours-and-locations/occurrences/README.md)
- [`/users/{user-id}/settings/workHoursAndLocations/recurrences`](users/settings/work-hours-and-locations/recurrences/README.md)

## Change notifications (`change-notifications`)

1 unknown endpoint.

- [`/subscriptions`](subscriptions/README.md)

## Customer booking (`customer-booking`)

6 unknown endpoints.

- [`/solutions/bookingBusinesses`](solutions/booking-businesses/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/appointments`](solutions/booking-businesses/appointments/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/customQuestions`](solutions/booking-businesses/custom-questions/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/customers`](solutions/booking-businesses/customers/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/services`](solutions/booking-businesses/services/README.md)
- [`/solutions/bookingBusinesses/{bookingBusiness-id}/staffMembers`](solutions/booking-businesses/staff-members/README.md)

## Device and app management (`device-and-app-management`)

82 unknown endpoints.

- [`/admin/edge/internetExplorerMode/siteLists`](admin/edge/internet-explorer-mode/site-lists/README.md)
- [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sharedCookies`](admin/edge/internet-explorer-mode/site-lists/shared-cookies/README.md)
- [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sites`](admin/edge/internet-explorer-mode/site-lists/sites/README.md)
- [`/deviceAppManagement/androidManagedAppProtections`](device-app-management/android-managed-app-protections/README.md)
- [`/deviceAppManagement/androidManagedAppProtections/{androidManagedAppProtection-id}/apps`](device-app-management/android-managed-app-protections/apps/README.md)
- [`/deviceAppManagement/defaultManagedAppProtections`](device-app-management/default-managed-app-protections/README.md)
- [`/deviceAppManagement/defaultManagedAppProtections/{defaultManagedAppProtection-id}/apps`](device-app-management/default-managed-app-protections/apps/README.md)
- [`/deviceAppManagement/iosManagedAppProtections`](device-app-management/ios-managed-app-protections/README.md)
- [`/deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}/apps`](device-app-management/ios-managed-app-protections/apps/README.md)
- [`/deviceAppManagement/managedAppRegistrations/{managedAppRegistration-id}/operations`](device-app-management/managed-app-registrations/operations/README.md)
- [`/deviceAppManagement/managedEBooks`](device-app-management/managed-e-books/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/assignments`](device-app-management/managed-e-books/assignments/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/deviceStates`](device-app-management/managed-e-books/device-states/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary`](device-app-management/managed-e-books/user-state-summary/README.md)
- [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary/{userInstallStateSummary-id}/deviceStates`](device-app-management/managed-e-books/user-state-summary/device-states/README.md)
- [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies`](device-app-management/mdm-windows-information-protection-policies/README.md)
- [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](device-app-management/mdm-windows-information-protection-policies/exempt-app-locker-files/README.md)
- [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](device-app-management/mdm-windows-information-protection-policies/protected-app-locker-files/README.md)
- [`/deviceAppManagement/mobileAppCategories`](device-app-management/mobile-app-categories/README.md)
- [`/deviceAppManagement/mobileAppConfigurations`](device-app-management/mobile-app-configurations/README.md)
- [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/assignments`](device-app-management/mobile-app-configurations/assignments/README.md)
- [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/deviceStatuses`](device-app-management/mobile-app-configurations/device-statuses/README.md)
- [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/userStatuses`](device-app-management/mobile-app-configurations/user-statuses/README.md)
- [`/deviceAppManagement/mobileApps`](device-app-management/mobile-apps/README.md)
- [`/deviceAppManagement/mobileApps/{mobileApp-id}/assignments`](device-app-management/mobile-apps/assignments/README.md)
- [`/deviceAppManagement/targetedManagedAppConfigurations`](device-app-management/targeted-managed-app-configurations/README.md)
- [`/deviceAppManagement/targetedManagedAppConfigurations/{targetedManagedAppConfiguration-id}/apps`](device-app-management/targeted-managed-app-configurations/apps/README.md)
- [`/deviceAppManagement/vppTokens`](device-app-management/vpp-tokens/README.md)
- [`/deviceAppManagement/windowsInformationProtectionPolicies`](device-app-management/windows-information-protection-policies/README.md)
- [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](device-app-management/windows-information-protection-policies/exempt-app-locker-files/README.md)
- [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](device-app-management/windows-information-protection-policies/protected-app-locker-files/README.md)
- [`/deviceManagement/auditEvents`](device-management/audit-events/README.md)
- [`/deviceManagement/complianceManagementPartners`](device-management/compliance-management-partners/README.md)
- [`/deviceManagement/detectedApps`](device-management/detected-apps/README.md)
- [`/deviceManagement/deviceCategories`](device-management/device-categories/README.md)
- [`/deviceManagement/deviceCompliancePolicies`](device-management/device-compliance-policies/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/assignments`](device-management/device-compliance-policies/assignments/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceSettingStateSummaries`](device-management/device-compliance-policies/device-setting-state-summaries/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceStatuses`](device-management/device-compliance-policies/device-statuses/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule`](device-management/device-compliance-policies/scheduled-actions-for-rule/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule/{deviceComplianceScheduledActionForRule-id}/scheduledActionConfigurations`](device-management/device-compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations/README.md)
- [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/userStatuses`](device-management/device-compliance-policies/user-statuses/README.md)
- [`/deviceManagement/deviceCompliancePolicySettingStateSummaries`](device-management/device-compliance-policy-setting-state-summaries/README.md)
- [`/deviceManagement/deviceCompliancePolicySettingStateSummaries/{deviceCompliancePolicySettingStateSummary-id}/deviceComplianceSettingStates`](device-management/device-compliance-policy-setting-state-summaries/device-compliance-setting-states/README.md)
- [`/deviceManagement/deviceConfigurations`](device-management/device-configurations/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/assignments`](device-management/device-configurations/assignments/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceSettingStateSummaries`](device-management/device-configurations/device-setting-state-summaries/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceStatuses`](device-management/device-configurations/device-statuses/README.md)
- [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/userStatuses`](device-management/device-configurations/user-statuses/README.md)
- [`/deviceManagement/deviceEnrollmentConfigurations`](device-management/device-enrollment-configurations/README.md)
- [`/deviceManagement/deviceEnrollmentConfigurations/{deviceEnrollmentConfiguration-id}/assignments`](device-management/device-enrollment-configurations/assignments/README.md)
- [`/deviceManagement/deviceManagementPartners`](device-management/device-management-partners/README.md)
- [`/deviceManagement/exchangeConnectors`](device-management/exchange-connectors/README.md)
- [`/deviceManagement/importedWindowsAutopilotDeviceIdentities`](device-management/imported-windows-autopilot-device-identities/README.md)
- [`/deviceManagement/iosUpdateStatuses`](device-management/ios-update-statuses/README.md)
- [`/deviceManagement/managedDevices`](device-management/managed-devices/README.md)
- [`/deviceManagement/mobileAppTroubleshootingEvents`](device-management/mobile-app-troubleshooting-events/README.md)
- [`/deviceManagement/mobileAppTroubleshootingEvents/{mobileAppTroubleshootingEvent-id}/appLogCollectionRequests`](device-management/mobile-app-troubleshooting-events/app-log-collection-requests/README.md)
- [`/deviceManagement/mobileThreatDefenseConnectors`](device-management/mobile-threat-defense-connectors/README.md)
- [`/deviceManagement/notificationMessageTemplates`](device-management/notification-message-templates/README.md)
- [`/deviceManagement/notificationMessageTemplates/{notificationMessageTemplate-id}/localizedNotificationMessages`](device-management/notification-message-templates/localized-notification-messages/README.md)
- [`/deviceManagement/remoteAssistancePartners`](device-management/remote-assistance-partners/README.md)
- [`/deviceManagement/resourceOperations`](device-management/resource-operations/README.md)
- [`/deviceManagement/roleAssignments`](device-management/role-assignments/README.md)
- [`/deviceManagement/roleDefinitions`](device-management/role-definitions/README.md)
- [`/deviceManagement/roleDefinitions/{roleDefinition-id}/roleAssignments`](device-management/role-definitions/role-assignments/README.md)
- [`/deviceManagement/termsAndConditions`](device-management/terms-and-conditions/README.md)
- [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/acceptanceStatuses`](device-management/terms-and-conditions/acceptance-statuses/README.md)
- [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/assignments`](device-management/terms-and-conditions/assignments/README.md)
- [`/deviceManagement/troubleshootingEvents`](device-management/troubleshooting-events/README.md)
- [`/deviceManagement/virtualEndpoint/deviceImages`](device-management/virtual-endpoint/device-images/README.md)
- [`/deviceManagement/virtualEndpoint/onPremisesConnections`](device-management/virtual-endpoint/on-premises-connections/README.md)
- [`/deviceManagement/virtualEndpoint/provisioningPolicies`](device-management/virtual-endpoint/provisioning-policies/README.md)
- [`/deviceManagement/virtualEndpoint/userSettings`](device-management/virtual-endpoint/user-settings/README.md)
- [`/deviceManagement/windowsAutopilotDeviceIdentities`](device-management/windows-autopilot-device-identities/README.md)
- [`/deviceManagement/windowsInformationProtectionAppLearningSummaries`](device-management/windows-information-protection-app-learning-summaries/README.md)
- [`/deviceManagement/windowsInformationProtectionNetworkLearningSummaries`](device-management/windows-information-protection-network-learning-summaries/README.md)
- [`/deviceManagement/windowsMalwareInformation`](device-management/windows-malware-information/README.md)
- [`/deviceManagement/windowsMalwareInformation/{windowsMalwareInformation-id}/deviceMalwareStates`](device-management/windows-malware-information/device-malware-states/README.md)
- [`/print/printers/{printer-id}/taskTriggers`](print/printers/task-triggers/README.md)
- [`/print/shares`](print/shares/README.md)
- [`/print/taskDefinitions`](print/task-definitions/README.md)

## Education (`education`)

12 unknown endpoints.

- [`/education/classes`](education/classes/README.md)
- [`/education/classes/{educationClass-id}/assignmentCategories`](education/classes/assignment-categories/README.md)
- [`/education/classes/{educationClass-id}/assignmentSettings/gradingSchemes`](education/classes/assignment-settings/grading-schemes/README.md)
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

- [`/employeeExperience/communities`](employee-experience/communities/README.md)

## Extensions (`extensions`)

13 unknown endpoints.

- [`/devices/{device-id}/extensions`](devices/extensions/README.md)
- [`/groups/{group-id}/events/{event-id}/extensions`](groups/events/extensions/README.md)
- [`/groups/{group-id}/extensions`](groups/extensions/README.md)
- [`/groups/{group-id}/threads/{conversationThread-id}/posts/{post-id}/extensions`](groups/threads/posts/extensions/README.md)
- [`/organization/{organization-id}/extensions`](organization/extensions/README.md)
- [`/schemaExtensions`](schema-extensions/README.md)
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
- [`/storage/fileStorage/containerTypes`](storage/file-storage/container-types/README.md)
- [`/storage/fileStorage/containers`](storage/file-storage/containers/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/migrationJobs`](storage/file-storage/containers/migration-jobs/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups`](storage/file-storage/containers/share-point-groups/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups/{sharePointGroup-id}/members`](storage/file-storage/containers/share-point-groups/members/README.md)

## Groups (`groups`)

3 unknown endpoints.

- [`/groupLifecyclePolicies`](group-lifecycle-policies/README.md)
- [`/groups/{group-id}/conversations/{conversation-id}/threads`](groups/conversations/threads/README.md)
- [`/groups/{group-id}/threads`](groups/threads/README.md)

## Identity and access (`identity-and-access`)

46 unknown endpoints.

- [`/devices`](devices/README.md)
- [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations`](directory/public-key-infrastructure/certificate-based-auth-configurations/README.md)
- [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{certificateBasedAuthPki-id}/certificateAuthorities`](directory/public-key-infrastructure/certificate-based-auth-configurations/certificate-authorities/README.md)
- [`/domains`](domains/README.md)
- [`/domains/{domain-id}/federationConfiguration`](domains/federation-configuration/README.md)
- [`/groupSettings`](group-settings/README.md)
- [`/groups/{group-id}/appRoleAssignments`](groups/app-role-assignments/README.md)
- [`/groups/{group-id}/settings`](groups/settings/README.md)
- [`/identity/apiConnectors`](identity/api-connectors/README.md)
- [`/identity/authenticationEventListeners`](identity/authentication-event-listeners/README.md)
- [`/identity/authenticationEventsFlows`](identity/authentication-events-flows/README.md)
- [`/identity/b2xUserFlows`](identity/b2x-user-flows/README.md)
- [`/identity/b2xUserFlows/{b2xIdentityUserFlow-id}/userAttributeAssignments`](identity/b2x-user-flows/user-attribute-assignments/README.md)
- [`/identity/conditionalAccess/authenticationStrength/policies/{authenticationStrengthPolicy-id}/combinationConfigurations`](identity/conditional-access/authentication-strength/policies/combination-configurations/README.md)
- [`/identity/conditionalAccess/policies`](identity/conditional-access/policies/README.md)
- [`/identity/customAuthenticationExtensions`](identity/custom-authentication-extensions/README.md)
- [`/identity/identityProviders`](identity/identity-providers/README.md)
- [`/identity/riskPrevention/fraudProtectionProviders`](identity/risk-prevention/fraud-protection-providers/README.md)
- [`/identity/riskPrevention/webApplicationFirewallProviders`](identity/risk-prevention/web-application-firewall-providers/README.md)
- [`/identity/userFlowAttributes`](identity/user-flow-attributes/README.md)
- [`/identity/verifiedId/profiles`](identity/verified-id/profiles/README.md)
- [`/identityGovernance/accessReviews/definitions`](identity-governance/access-reviews/definitions/README.md)
- [`/identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/resourceRoleScopes`](identity-governance/entitlement-management/access-packages/resource-role-scopes/README.md)
- [`/identityGovernance/entitlementManagement/catalogs/{accessPackageCatalog-id}/resources/{accessPackageResource-id}/uploadSessions`](identity-governance/entitlement-management/catalogs/resources/upload-sessions/README.md)
- [`/identityGovernance/entitlementManagement/connectedOrganizations`](identity-governance/entitlement-management/connected-organizations/README.md)
- [`/identityGovernance/entitlementManagement/externalOriginResourceConnectors`](identity-governance/entitlement-management/external-origin-resource-connectors/README.md)
- [`/identityGovernance/privilegedAccess/customExtensions`](identity-governance/privileged-access/custom-extensions/README.md)
- [`/identityGovernance/termsOfUse/agreements`](identity-governance/terms-of-use/agreements/README.md)
- [`/identityProviders`](identity-providers/README.md)
- [`/oauth2PermissionGrants`](oauth2-permission-grants/README.md)
- [`/organization/{organization-id}/branding/localizations`](organization/branding/localizations/README.md)
- [`/policies/activityBasedTimeoutPolicies`](policies/activity-based-timeout-policies/README.md)
- [`/policies/authenticationStrengthPolicies`](policies/authentication-strength-policies/README.md)
- [`/policies/featureRolloutPolicies`](policies/feature-rollout-policies/README.md)
- [`/policies/homeRealmDiscoveryPolicies`](policies/home-realm-discovery-policies/README.md)
- [`/policies/permissionGrantPolicies`](policies/permission-grant-policies/README.md)
- [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/excludes`](policies/permission-grant-policies/excludes/README.md)
- [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/includes`](policies/permission-grant-policies/includes/README.md)
- [`/roleManagement/directory/roleAssignments`](role-management/directory/role-assignments/README.md)
- [`/roleManagement/directory/roleDefinitions`](role-management/directory/role-definitions/README.md)
- [`/roleManagement/entitlementManagement/roleAssignments`](role-management/entitlement-management/role-assignments/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignedTo`](service-principals/app-role-assigned-to/README.md)
- [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignments`](service-principals/app-role-assignments/README.md)
- [`/users/{user-id}/appRoleAssignments`](users/app-role-assignments/README.md)
- [`/users/{user-id}/authentication/emailMethods`](users/authentication/email-methods/README.md)
- [`/users/{user-id}/authentication/phoneMethods`](users/authentication/phone-methods/README.md)

## Mail (`mail`)

10 unknown endpoints.

- [`/me/inferenceClassification/overrides`](me/inference-classification/overrides/README.md)
- [`/me/mailFolders`](me/mail-folders/README.md)
- [`/me/mailFolders/{mailFolder-id}/messages`](me/mail-folders/messages/README.md)
- [`/me/messages`](me/messages/README.md)
- [`/me/notes`](me/notes/README.md)
- [`/users/{user-id}/inferenceClassification/overrides`](users/inference-classification/overrides/README.md)
- [`/users/{user-id}/mailFolders`](users/mail-folders/README.md)
- [`/users/{user-id}/mailFolders/{mailFolder-id}/messages`](users/mail-folders/messages/README.md)
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

- [`/admin/people/profileCardProperties`](admin/people/profile-card-properties/README.md)
- [`/admin/people/profilePropertySettings`](admin/people/profile-property-settings/README.md)

## Personal contacts (`personal-contacts`)

6 unknown endpoints.

- [`/me/contactFolders`](me/contact-folders/README.md)
- [`/me/contactFolders/{contactFolder-id}/contacts`](me/contact-folders/contacts/README.md)
- [`/me/contacts`](me/contacts/README.md)
- [`/users/{user-id}/contactFolders`](users/contact-folders/README.md)
- [`/users/{user-id}/contactFolders/{contactFolder-id}/contacts`](users/contact-folders/contacts/README.md)
- [`/users/{user-id}/contacts`](users/contacts/README.md)

## Reports (`reports`)

1 unknown endpoint.

- [`/deviceManagement/reports/exportJobs`](device-management/reports/export-jobs/README.md)

## Search (`search`)

3 unknown endpoints.

- [`/search/acronyms`](search/acronyms/README.md)
- [`/search/bookmarks`](search/bookmarks/README.md)
- [`/search/qnas`](search/qnas/README.md)

## Security (`security`)

11 unknown endpoints.

- [`/security/attackSimulation/simulations`](security/attack-simulation/simulations/README.md)
- [`/security/cases/ediscoveryCases`](security/cases/ediscovery-cases/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/caseMembers`](security/cases/ediscovery-cases/case-members/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/siteSources`](security/cases/ediscovery-cases/custodians/site-sources/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources`](security/cases/ediscovery-cases/custodians/unified-group-sources/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/userSources`](security/cases/ediscovery-cases/custodians/user-sources/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/reviewSets/{ediscoveryReviewSet-id}/queries`](security/cases/ediscovery-cases/review-sets/queries/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/searches`](security/cases/ediscovery-cases/searches/README.md)
- [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/tags`](security/cases/ediscovery-cases/tags/README.md)
- [`/security/labels/retentionLabels`](security/labels/retention-labels/README.md)
- [`/security/triggers/retentionEvents`](security/triggers/retention-events/README.md)

## Sites and lists (`sites-and-lists`)

13 unknown endpoints.

- [`/sites/{site-id}/columns`](sites/columns/README.md)
- [`/sites/{site-id}/contentTypes`](sites/content-types/README.md)
- [`/sites/{site-id}/contentTypes/{contentType-id}/columns`](sites/content-types/columns/README.md)
- [`/sites/{site-id}/lists/{list-id}/columns`](sites/lists/columns/README.md)
- [`/sites/{site-id}/lists/{list-id}/contentTypes/{contentType-id}/columns`](sites/lists/content-types/columns/README.md)
- [`/sites/{site-id}/lists/{list-id}/items`](sites/lists/items/README.md)
- [`/sites/{site-id}/lists/{list-id}/items/{listItem-id}/documentSetVersions`](sites/lists/items/document-set-versions/README.md)
- [`/sites/{site-id}/pages`](sites/pages/README.md)
- [`/sites/{site-id}/permissions`](sites/permissions/README.md)
- [`/sites/{site-id}/termStore/groups`](sites/term-store/groups/README.md)
- [`/sites/{site-id}/termStore/sets`](sites/term-store/sets/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/columns`](storage/file-storage/containers/columns/README.md)
- [`/storage/fileStorage/containers/{fileStorageContainer-id}/permissions`](storage/file-storage/containers/permissions/README.md)

## Teamwork and communications (`teamwork-and-communications`)

26 unknown endpoints.

- [`/appCatalogs/teamsApps`](app-catalogs/teams-apps/README.md)
- [`/appCatalogs/teamsApps/{teamsApp-id}/appDefinitions`](app-catalogs/teams-apps/app-definitions/README.md)
- [`/chats`](chats/README.md)
- [`/chats/{chat-id}/installedApps`](chats/installed-apps/README.md)
- [`/chats/{chat-id}/members`](chats/members/README.md)
- [`/chats/{chat-id}/pinnedMessages`](chats/pinned-messages/README.md)
- [`/chats/{chat-id}/tabs`](chats/tabs/README.md)
- [`/communications/calls`](communications/calls/README.md)
- [`/communications/calls/{call-id}/audioRoutingGroups`](communications/calls/audio-routing-groups/README.md)
- [`/employeeExperience/learningProviders/{learningProvider-id}/learningCourseActivities`](employee-experience/learning-providers/learning-course-activities/README.md)
- [`/me/onlineMeetings`](me/online-meetings/README.md)
- [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/presenters`](solutions/virtual-events/townhalls/presenters/README.md)
- [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/registrationConfiguration/questions`](solutions/virtual-events/townhalls/registration-configuration/questions/README.md)
- [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/presenters`](solutions/virtual-events/webinars/presenters/README.md)
- [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/registrationConfiguration/questions`](solutions/virtual-events/webinars/registration-configuration/questions/README.md)
- [`/teams/{team-id}/channels`](teams/channels/README.md)
- [`/teams/{team-id}/channels/{channel-id}/members`](teams/channels/members/README.md)
- [`/teams/{team-id}/channels/{channel-id}/tabs`](teams/channels/tabs/README.md)
- [`/teams/{team-id}/installedApps`](teams/installed-apps/README.md)
- [`/teams/{team-id}/members`](teams/members/README.md)
- [`/teams/{team-id}/schedule/timeOffRequests`](teams/schedule/time-off-requests/README.md)
- [`/teams/{team-id}/tags`](teams/tags/README.md)
- [`/teams/{team-id}/tags/{teamworkTag-id}/members`](teams/tags/members/README.md)
- [`/teamwork/workforceIntegrations`](teamwork/workforce-integrations/README.md)
- [`/users/{user-id}/onlineMeetings`](users/online-meetings/README.md)
- [`/users/{user-id}/teamwork/installedApps`](users/teamwork/installed-apps/README.md)

## Tenants (`tenants`)

5 unknown endpoints.

- [`/admin/configurationManagement/configurationMonitors`](admin/configuration-management/configuration-monitors/README.md)
- [`/directory/tenantGovernance/governanceInvitations`](directory/tenant-governance/governance-invitations/README.md)
- [`/directory/tenantGovernance/governancePolicyTemplates`](directory/tenant-governance/governance-policy-templates/README.md)
- [`/policies/crossTenantAccessPolicy/partners/{crossTenantAccessPolicyConfigurationPartner-tenantId}/m365Capabilities`](policies/cross-tenant-access-policy/partners/m365-capabilities/README.md)
- [`/tenantRelationships/multiTenantOrganization/tenants`](tenant-relationships/multi-tenant-organization/tenants/README.md)

## To-do tasks (`to-do-tasks`)

8 unknown endpoints.

- [`/me/todo/lists`](me/todo/lists/README.md)
- [`/me/todo/lists/{todoTaskList-id}/tasks`](me/todo/lists/tasks/README.md)
- [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](me/todo/lists/tasks/checklist-items/README.md)
- [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](me/todo/lists/tasks/linked-resources/README.md)
- [`/users/{user-id}/todo/lists`](users/todo/lists/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks`](users/todo/lists/tasks/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](users/todo/lists/tasks/checklist-items/README.md)
- [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](users/todo/lists/tasks/linked-resources/README.md)

## Users (`users`)

2 unknown endpoints.

- [`/me/outlook/masterCategories`](me/outlook/master-categories/README.md)
- [`/users/{user-id}/outlook/masterCategories`](users/outlook/master-categories/README.md)
