# Generated module casing migration

Baseline: the previous (withdrawn) GraphModules `v5.0.0` release. Generated tree only.

This migration ships together with the verified-tree rename in the same release.
Generated module paths and arguments use Graph spelling. No compatibility aliases are emitted.

On Terraform 1.11 or later, update the module source path and pin the coordinated release version,
rename the arguments listed below, then run `terraform init -upgrade` and inspect a saved plan
before applying.
Keep the caller's module block label and all input values unchanged. Resource labels inside
the module are unchanged, so source and argument renames alone need no state movement.

If you also rename your module block label, use a root-module moved block:

```hcl
moved {
  from = module.old_label
  to   = module.new_label
}
```

Alternatively, after backing up state and with exclusive backend access, run
`terraform state mv 'module.old_label' 'module.new_label'`. Use the exact instance addresses
for modules with count or for_each. Do not do both, and do not move state for a source-only rename.

Graph URLs, JSON keys, nested Graph attributes and generator controls retain their wire spelling
or existing control names. Technical input exceptions below keep their old Terraform name.

## Every affected folder level

| Old path | New path |
| --- | --- |
| `beta/access-reviews` | `beta/accessReviews` |
| `beta/access-reviews/reviewers` | `beta/accessReviews/reviewers` |
| `beta/admin/cloud-licensing` | `beta/admin/cloudLicensing` |
| `beta/admin/cloud-licensing/assignments` | `beta/admin/cloudLicensing/assignments` |
| `beta/admin/configuration-management` | `beta/admin/configurationManagement` |
| `beta/admin/configuration-management/configuration-monitors` | `beta/admin/configurationManagement/configurationMonitors` |
| `beta/admin/edge/internet-explorer-mode` | `beta/admin/edge/internetExplorerMode` |
| `beta/admin/edge/internet-explorer-mode/site-lists` | `beta/admin/edge/internetExplorerMode/siteLists` |
| `beta/admin/edge/internet-explorer-mode/site-lists/shared-cookies` | `beta/admin/edge/internetExplorerMode/siteLists/sharedCookies` |
| `beta/admin/edge/internet-explorer-mode/site-lists/sites` | `beta/admin/edge/internetExplorerMode/siteLists/sites` |
| `beta/admin/people/profile-card-properties` | `beta/admin/people/profileCardProperties` |
| `beta/admin/people/profile-property-settings` | `beta/admin/people/profilePropertySettings` |
| `beta/admin/windows/updates/deployment-audiences` | `beta/admin/windows/updates/deploymentAudiences` |
| `beta/admin/windows/updates/resource-connections` | `beta/admin/windows/updates/resourceConnections` |
| `beta/admin/windows/updates/updatable-assets` | `beta/admin/windows/updates/updatableAssets` |
| `beta/admin/windows/updates/update-policies` | `beta/admin/windows/updates/updatePolicies` |
| `beta/admin/windows/updates/update-policies/compliance-changes` | `beta/admin/windows/updates/updatePolicies/complianceChanges` |
| `beta/administrative-units` | `beta/administrativeUnits` |
| `beta/administrative-units/extensions` | `beta/administrativeUnits/extensions` |
| `beta/administrative-units/scoped-role-members` | `beta/administrativeUnits/scopedRoleMembers` |
| `beta/agent-registry` | `beta/agentRegistry` |
| `beta/agent-registry/agent-collections` | `beta/agentRegistry/agentCollections` |
| `beta/agent-registry/agent-instances` | `beta/agentRegistry/agentInstances` |
| `beta/app-catalogs` | `beta/appCatalogs` |
| `beta/app-catalogs/teams-apps` | `beta/appCatalogs/teamsApps` |
| `beta/app-catalogs/teams-apps/app-definitions` | `beta/appCatalogs/teamsApps/appDefinitions` |
| `beta/app/calls/audio-routing-groups` | `beta/app/calls/audioRoutingGroups` |
| `beta/applications/extension-properties` | `beta/applications/extensionProperties` |
| `beta/applications/federated-identity-credentials` | `beta/applications/federatedIdentityCredentials` |
| `beta/chats/installed-apps` | `beta/chats/installedApps` |
| `beta/chats/pinned-messages` | `beta/chats/pinnedMessages` |
| `beta/communications/calls/audio-routing-groups` | `beta/communications/calls/audioRoutingGroups` |
| `beta/compliance/ediscovery/cases/custodians/site-sources` | `beta/compliance/ediscovery/cases/custodians/siteSources` |
| `beta/compliance/ediscovery/cases/custodians/unified-group-sources` | `beta/compliance/ediscovery/cases/custodians/unifiedGroupSources` |
| `beta/compliance/ediscovery/cases/custodians/user-sources` | `beta/compliance/ediscovery/cases/custodians/userSources` |
| `beta/compliance/ediscovery/cases/legal-holds` | `beta/compliance/ediscovery/cases/legalHolds` |
| `beta/compliance/ediscovery/cases/review-sets` | `beta/compliance/ediscovery/cases/reviewSets` |
| `beta/compliance/ediscovery/cases/review-sets/queries` | `beta/compliance/ediscovery/cases/reviewSets/queries` |
| `beta/compliance/ediscovery/cases/source-collections` | `beta/compliance/ediscovery/cases/sourceCollections` |
| `beta/device-app-management` | `beta/deviceAppManagement` |
| `beta/device-app-management/android-managed-app-protections` | `beta/deviceAppManagement/androidManagedAppProtections` |
| `beta/device-app-management/android-managed-app-protections/apps` | `beta/deviceAppManagement/androidManagedAppProtections/apps` |
| `beta/device-app-management/default-managed-app-protections` | `beta/deviceAppManagement/defaultManagedAppProtections` |
| `beta/device-app-management/default-managed-app-protections/apps` | `beta/deviceAppManagement/defaultManagedAppProtections/apps` |
| `beta/device-app-management/device-app-management-tasks` | `beta/deviceAppManagement/deviceAppManagementTasks` |
| `beta/device-app-management/enterprise-code-signing-certificates` | `beta/deviceAppManagement/enterpriseCodeSigningCertificates` |
| `beta/device-app-management/ios-lob-app-provisioning-configurations` | `beta/deviceAppManagement/iosLobAppProvisioningConfigurations` |
| `beta/device-app-management/ios-lob-app-provisioning-configurations/assignments` | `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/assignments` |
| `beta/device-app-management/ios-lob-app-provisioning-configurations/device-statuses` | `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/deviceStatuses` |
| `beta/device-app-management/ios-lob-app-provisioning-configurations/group-assignments` | `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/groupAssignments` |
| `beta/device-app-management/ios-lob-app-provisioning-configurations/user-statuses` | `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/userStatuses` |
| `beta/device-app-management/ios-managed-app-protections` | `beta/deviceAppManagement/iosManagedAppProtections` |
| `beta/device-app-management/ios-managed-app-protections/apps` | `beta/deviceAppManagement/iosManagedAppProtections/apps` |
| `beta/device-app-management/managed-app-registrations` | `beta/deviceAppManagement/managedAppRegistrations` |
| `beta/device-app-management/managed-app-registrations/managed-app-log-collection-requests` | `beta/deviceAppManagement/managedAppRegistrations/managedAppLogCollectionRequests` |
| `beta/device-app-management/managed-app-registrations/operations` | `beta/deviceAppManagement/managedAppRegistrations/operations` |
| `beta/device-app-management/managed-e-book-categories` | `beta/deviceAppManagement/managedEBookCategories` |
| `beta/device-app-management/managed-e-books` | `beta/deviceAppManagement/managedEBooks` |
| `beta/device-app-management/managed-e-books/assignments` | `beta/deviceAppManagement/managedEBooks/assignments` |
| `beta/device-app-management/managed-e-books/device-states` | `beta/deviceAppManagement/managedEBooks/deviceStates` |
| `beta/device-app-management/managed-e-books/user-state-summary` | `beta/deviceAppManagement/managedEBooks/userStateSummary` |
| `beta/device-app-management/managed-e-books/user-state-summary/device-states` | `beta/deviceAppManagement/managedEBooks/userStateSummary/deviceStates` |
| `beta/device-app-management/mdm-windows-information-protection-policies` | `beta/deviceAppManagement/mdmWindowsInformationProtectionPolicies` |
| `beta/device-app-management/mdm-windows-information-protection-policies/exempt-app-locker-files` | `beta/deviceAppManagement/mdmWindowsInformationProtectionPolicies/exemptAppLockerFiles` |
| `beta/device-app-management/mdm-windows-information-protection-policies/protected-app-locker-files` | `beta/deviceAppManagement/mdmWindowsInformationProtectionPolicies/protectedAppLockerFiles` |
| `beta/device-app-management/mobile-app-categories` | `beta/deviceAppManagement/mobileAppCategories` |
| `beta/device-app-management/mobile-app-configurations` | `beta/deviceAppManagement/mobileAppConfigurations` |
| `beta/device-app-management/mobile-app-configurations/assignments` | `beta/deviceAppManagement/mobileAppConfigurations/assignments` |
| `beta/device-app-management/mobile-app-configurations/device-statuses` | `beta/deviceAppManagement/mobileAppConfigurations/deviceStatuses` |
| `beta/device-app-management/mobile-app-configurations/user-statuses` | `beta/deviceAppManagement/mobileAppConfigurations/userStatuses` |
| `beta/device-app-management/mobile-app-relationships` | `beta/deviceAppManagement/mobileAppRelationships` |
| `beta/device-app-management/mobile-apps` | `beta/deviceAppManagement/mobileApps` |
| `beta/device-app-management/mobile-apps/assignments` | `beta/deviceAppManagement/mobileApps/assignments` |
| `beta/device-app-management/mobile-apps/relationships` | `beta/deviceAppManagement/mobileApps/relationships` |
| `beta/device-app-management/policy-sets` | `beta/deviceAppManagement/policySets` |
| `beta/device-app-management/policy-sets/assignments` | `beta/deviceAppManagement/policySets/assignments` |
| `beta/device-app-management/policy-sets/items` | `beta/deviceAppManagement/policySets/items` |
| `beta/device-app-management/targeted-managed-app-configurations` | `beta/deviceAppManagement/targetedManagedAppConfigurations` |
| `beta/device-app-management/targeted-managed-app-configurations/apps` | `beta/deviceAppManagement/targetedManagedAppConfigurations/apps` |
| `beta/device-app-management/targeted-managed-app-configurations/settings` | `beta/deviceAppManagement/targetedManagedAppConfigurations/settings` |
| `beta/device-app-management/vpp-tokens` | `beta/deviceAppManagement/vppTokens` |
| `beta/device-app-management/wdac-supplemental-policies` | `beta/deviceAppManagement/wdacSupplementalPolicies` |
| `beta/device-app-management/wdac-supplemental-policies/assignments` | `beta/deviceAppManagement/wdacSupplementalPolicies/assignments` |
| `beta/device-app-management/wdac-supplemental-policies/device-statuses` | `beta/deviceAppManagement/wdacSupplementalPolicies/deviceStatuses` |
| `beta/device-app-management/windows-information-protection-device-registrations` | `beta/deviceAppManagement/windowsInformationProtectionDeviceRegistrations` |
| `beta/device-app-management/windows-information-protection-policies` | `beta/deviceAppManagement/windowsInformationProtectionPolicies` |
| `beta/device-app-management/windows-information-protection-policies/exempt-app-locker-files` | `beta/deviceAppManagement/windowsInformationProtectionPolicies/exemptAppLockerFiles` |
| `beta/device-app-management/windows-information-protection-policies/protected-app-locker-files` | `beta/deviceAppManagement/windowsInformationProtectionPolicies/protectedAppLockerFiles` |
| `beta/device-app-management/windows-information-protection-wipe-actions` | `beta/deviceAppManagement/windowsInformationProtectionWipeActions` |
| `beta/device-app-management/windows-managed-app-protections` | `beta/deviceAppManagement/windowsManagedAppProtections` |
| `beta/device-app-management/windows-managed-app-protections/apps` | `beta/deviceAppManagement/windowsManagedAppProtections/apps` |
| `beta/device-management` | `beta/deviceManagement` |
| `beta/device-management/advanced-threat-protection-onboarding-state-summary` | `beta/deviceManagement/advancedThreatProtectionOnboardingStateSummary` |
| `beta/device-management/advanced-threat-protection-onboarding-state-summary/advanced-threat-protection-onboarding-device-setting-states` | `beta/deviceManagement/advancedThreatProtectionOnboardingStateSummary/advancedThreatProtectionOnboardingDeviceSettingStates` |
| `beta/device-management/android-device-owner-enrollment-profiles` | `beta/deviceManagement/androidDeviceOwnerEnrollmentProfiles` |
| `beta/device-management/android-for-work-app-configuration-schemas` | `beta/deviceManagement/androidForWorkAppConfigurationSchemas` |
| `beta/device-management/android-for-work-enrollment-profiles` | `beta/deviceManagement/androidForWorkEnrollmentProfiles` |
| `beta/device-management/android-managed-store-app-configuration-schemas` | `beta/deviceManagement/androidManagedStoreAppConfigurationSchemas` |
| `beta/device-management/apple-user-initiated-enrollment-profiles` | `beta/deviceManagement/appleUserInitiatedEnrollmentProfiles` |
| `beta/device-management/apple-user-initiated-enrollment-profiles/assignments` | `beta/deviceManagement/appleUserInitiatedEnrollmentProfiles/assignments` |
| `beta/device-management/assignment-filters` | `beta/deviceManagement/assignmentFilters` |
| `beta/device-management/audit-events` | `beta/deviceManagement/auditEvents` |
| `beta/device-management/autopilot-events` | `beta/deviceManagement/autopilotEvents` |
| `beta/device-management/cart-to-class-associations` | `beta/deviceManagement/cartToClassAssociations` |
| `beta/device-management/categories` | `beta/deviceManagement/categories` |
| `beta/device-management/categories/setting-definitions` | `beta/deviceManagement/categories/settingDefinitions` |
| `beta/device-management/certificate-connector-details` | `beta/deviceManagement/certificateConnectorDetails` |
| `beta/device-management/chrome-os-onboarding-settings` | `beta/deviceManagement/chromeOSOnboardingSettings` |
| `beta/device-management/cloud-certification-authority` | `beta/deviceManagement/cloudCertificationAuthority` |
| `beta/device-management/cloud-certification-authority-leaf-certificate` | `beta/deviceManagement/cloudCertificationAuthorityLeafCertificate` |
| `beta/device-management/cloud-pc-connectivity-issues` | `beta/deviceManagement/cloudPCConnectivityIssues` |
| `beta/device-management/comanaged-devices` | `beta/deviceManagement/comanagedDevices` |
| `beta/device-management/comanagement-eligible-devices` | `beta/deviceManagement/comanagementEligibleDevices` |
| `beta/device-management/compliance-categories` | `beta/deviceManagement/complianceCategories` |
| `beta/device-management/compliance-management-partners` | `beta/deviceManagement/complianceManagementPartners` |
| `beta/device-management/compliance-policies` | `beta/deviceManagement/compliancePolicies` |
| `beta/device-management/compliance-policies/scheduled-actions-for-rule` | `beta/deviceManagement/compliancePolicies/scheduledActionsForRule` |
| `beta/device-management/compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations` | `beta/deviceManagement/compliancePolicies/scheduledActionsForRule/scheduledActionConfigurations` |
| `beta/device-management/compliance-policies/settings` | `beta/deviceManagement/compliancePolicies/settings` |
| `beta/device-management/compliance-settings` | `beta/deviceManagement/complianceSettings` |
| `beta/device-management/config-manager-collections` | `beta/deviceManagement/configManagerCollections` |
| `beta/device-management/configuration-categories` | `beta/deviceManagement/configurationCategories` |
| `beta/device-management/configuration-policies` | `beta/deviceManagement/configurationPolicies` |
| `beta/device-management/configuration-policies/settings` | `beta/deviceManagement/configurationPolicies/settings` |
| `beta/device-management/configuration-policy-templates` | `beta/deviceManagement/configurationPolicyTemplates` |
| `beta/device-management/configuration-policy-templates/setting-templates` | `beta/deviceManagement/configurationPolicyTemplates/settingTemplates` |
| `beta/device-management/configuration-policy-templates/setting-templates/setting-definitions` | `beta/deviceManagement/configurationPolicyTemplates/settingTemplates/settingDefinitions` |
| `beta/device-management/configuration-settings` | `beta/deviceManagement/configurationSettings` |
| `beta/device-management/data-sharing-consents` | `beta/deviceManagement/dataSharingConsents` |
| `beta/device-management/dep-onboarding-settings` | `beta/deviceManagement/depOnboardingSettings` |
| `beta/device-management/dep-onboarding-settings/enrollment-profiles` | `beta/deviceManagement/depOnboardingSettings/enrollmentProfiles` |
| `beta/device-management/dep-onboarding-settings/imported-apple-device-identities` | `beta/deviceManagement/depOnboardingSettings/importedAppleDeviceIdentities` |
| `beta/device-management/derived-credentials` | `beta/deviceManagement/derivedCredentials` |
| `beta/device-management/detected-apps` | `beta/deviceManagement/detectedApps` |
| `beta/device-management/device-categories` | `beta/deviceManagement/deviceCategories` |
| `beta/device-management/device-compliance-policies` | `beta/deviceManagement/deviceCompliancePolicies` |
| `beta/device-management/device-compliance-policies/assignments` | `beta/deviceManagement/deviceCompliancePolicies/assignments` |
| `beta/device-management/device-compliance-policies/device-setting-state-summaries` | `beta/deviceManagement/deviceCompliancePolicies/deviceSettingStateSummaries` |
| `beta/device-management/device-compliance-policies/device-statuses` | `beta/deviceManagement/deviceCompliancePolicies/deviceStatuses` |
| `beta/device-management/device-compliance-policies/scheduled-actions-for-rule` | `beta/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule` |
| `beta/device-management/device-compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations` | `beta/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/scheduledActionConfigurations` |
| `beta/device-management/device-compliance-policies/user-statuses` | `beta/deviceManagement/deviceCompliancePolicies/userStatuses` |
| `beta/device-management/device-compliance-policy-setting-state-summaries` | `beta/deviceManagement/deviceCompliancePolicySettingStateSummaries` |
| `beta/device-management/device-compliance-policy-setting-state-summaries/device-compliance-setting-states` | `beta/deviceManagement/deviceCompliancePolicySettingStateSummaries/deviceComplianceSettingStates` |
| `beta/device-management/device-compliance-scripts` | `beta/deviceManagement/deviceComplianceScripts` |
| `beta/device-management/device-compliance-scripts/assignments` | `beta/deviceManagement/deviceComplianceScripts/assignments` |
| `beta/device-management/device-compliance-scripts/device-run-states` | `beta/deviceManagement/deviceComplianceScripts/deviceRunStates` |
| `beta/device-management/device-configuration-conflict-summary` | `beta/deviceManagement/deviceConfigurationConflictSummary` |
| `beta/device-management/device-configuration-restricted-apps-violations` | `beta/deviceManagement/deviceConfigurationRestrictedAppsViolations` |
| `beta/device-management/device-configurations` | `beta/deviceManagement/deviceConfigurations` |
| `beta/device-management/device-configurations-all-managed-device-certificate-states` | `beta/deviceManagement/deviceConfigurationsAllManagedDeviceCertificateStates` |
| `beta/device-management/device-configurations/assignments` | `beta/deviceManagement/deviceConfigurations/assignments` |
| `beta/device-management/device-configurations/device-setting-state-summaries` | `beta/deviceManagement/deviceConfigurations/deviceSettingStateSummaries` |
| `beta/device-management/device-configurations/device-statuses` | `beta/deviceManagement/deviceConfigurations/deviceStatuses` |
| `beta/device-management/device-configurations/group-assignments` | `beta/deviceManagement/deviceConfigurations/groupAssignments` |
| `beta/device-management/device-configurations/user-statuses` | `beta/deviceManagement/deviceConfigurations/userStatuses` |
| `beta/device-management/device-custom-attribute-shell-scripts` | `beta/deviceManagement/deviceCustomAttributeShellScripts` |
| `beta/device-management/device-custom-attribute-shell-scripts/assignments` | `beta/deviceManagement/deviceCustomAttributeShellScripts/assignments` |
| `beta/device-management/device-custom-attribute-shell-scripts/device-run-states` | `beta/deviceManagement/deviceCustomAttributeShellScripts/deviceRunStates` |
| `beta/device-management/device-custom-attribute-shell-scripts/group-assignments` | `beta/deviceManagement/deviceCustomAttributeShellScripts/groupAssignments` |
| `beta/device-management/device-custom-attribute-shell-scripts/user-run-states` | `beta/deviceManagement/deviceCustomAttributeShellScripts/userRunStates` |
| `beta/device-management/device-enrollment-configurations` | `beta/deviceManagement/deviceEnrollmentConfigurations` |
| `beta/device-management/device-enrollment-configurations/assignments` | `beta/deviceManagement/deviceEnrollmentConfigurations/assignments` |
| `beta/device-management/device-health-scripts` | `beta/deviceManagement/deviceHealthScripts` |
| `beta/device-management/device-health-scripts/assignments` | `beta/deviceManagement/deviceHealthScripts/assignments` |
| `beta/device-management/device-health-scripts/device-run-states` | `beta/deviceManagement/deviceHealthScripts/deviceRunStates` |
| `beta/device-management/device-management-partners` | `beta/deviceManagement/deviceManagementPartners` |
| `beta/device-management/device-management-scripts` | `beta/deviceManagement/deviceManagementScripts` |
| `beta/device-management/device-management-scripts/assignments` | `beta/deviceManagement/deviceManagementScripts/assignments` |
| `beta/device-management/device-management-scripts/device-run-states` | `beta/deviceManagement/deviceManagementScripts/deviceRunStates` |
| `beta/device-management/device-management-scripts/group-assignments` | `beta/deviceManagement/deviceManagementScripts/groupAssignments` |
| `beta/device-management/device-management-scripts/user-run-states` | `beta/deviceManagement/deviceManagementScripts/userRunStates` |
| `beta/device-management/device-management-scripts/user-run-states/device-run-states` | `beta/deviceManagement/deviceManagementScripts/userRunStates/deviceRunStates` |
| `beta/device-management/device-shell-scripts` | `beta/deviceManagement/deviceShellScripts` |
| `beta/device-management/device-shell-scripts/assignments` | `beta/deviceManagement/deviceShellScripts/assignments` |
| `beta/device-management/device-shell-scripts/device-run-states` | `beta/deviceManagement/deviceShellScripts/deviceRunStates` |
| `beta/device-management/device-shell-scripts/group-assignments` | `beta/deviceManagement/deviceShellScripts/groupAssignments` |
| `beta/device-management/device-shell-scripts/user-run-states` | `beta/deviceManagement/deviceShellScripts/userRunStates` |
| `beta/device-management/domain-join-connectors` | `beta/deviceManagement/domainJoinConnectors` |
| `beta/device-management/elevation-requests` | `beta/deviceManagement/elevationRequests` |
| `beta/device-management/embedded-sim-activation-code-pools` | `beta/deviceManagement/embeddedSIMActivationCodePools` |
| `beta/device-management/embedded-sim-activation-code-pools/assignments` | `beta/deviceManagement/embeddedSIMActivationCodePools/assignments` |
| `beta/device-management/embedded-sim-activation-code-pools/device-states` | `beta/deviceManagement/embeddedSIMActivationCodePools/deviceStates` |
| `beta/device-management/exchange-connectors` | `beta/deviceManagement/exchangeConnectors` |
| `beta/device-management/group-policy-categories` | `beta/deviceManagement/groupPolicyCategories` |
| `beta/device-management/group-policy-configurations` | `beta/deviceManagement/groupPolicyConfigurations` |
| `beta/device-management/group-policy-configurations/assignments` | `beta/deviceManagement/groupPolicyConfigurations/assignments` |
| `beta/device-management/group-policy-configurations/definition-values` | `beta/deviceManagement/groupPolicyConfigurations/definitionValues` |
| `beta/device-management/group-policy-configurations/definition-values/presentation-values` | `beta/deviceManagement/groupPolicyConfigurations/definitionValues/presentationValues` |
| `beta/device-management/group-policy-definitions` | `beta/deviceManagement/groupPolicyDefinitions` |
| `beta/device-management/group-policy-migration-reports` | `beta/deviceManagement/groupPolicyMigrationReports` |
| `beta/device-management/group-policy-migration-reports/group-policy-setting-mappings` | `beta/deviceManagement/groupPolicyMigrationReports/groupPolicySettingMappings` |
| `beta/device-management/group-policy-migration-reports/unsupported-group-policy-extensions` | `beta/deviceManagement/groupPolicyMigrationReports/unsupportedGroupPolicyExtensions` |
| `beta/device-management/group-policy-object-files` | `beta/deviceManagement/groupPolicyObjectFiles` |
| `beta/device-management/group-policy-uploaded-definition-files` | `beta/deviceManagement/groupPolicyUploadedDefinitionFiles` |
| `beta/device-management/hardware-configurations` | `beta/deviceManagement/hardwareConfigurations` |
| `beta/device-management/hardware-configurations/assignments` | `beta/deviceManagement/hardwareConfigurations/assignments` |
| `beta/device-management/hardware-configurations/device-run-states` | `beta/deviceManagement/hardwareConfigurations/deviceRunStates` |
| `beta/device-management/hardware-configurations/user-run-states` | `beta/deviceManagement/hardwareConfigurations/userRunStates` |
| `beta/device-management/hardware-password-details` | `beta/deviceManagement/hardwarePasswordDetails` |
| `beta/device-management/hardware-password-info` | `beta/deviceManagement/hardwarePasswordInfo` |
| `beta/device-management/imported-device-identities` | `beta/deviceManagement/importedDeviceIdentities` |
| `beta/device-management/imported-windows-autopilot-device-identities` | `beta/deviceManagement/importedWindowsAutopilotDeviceIdentities` |
| `beta/device-management/intents` | `beta/deviceManagement/intents` |
| `beta/device-management/intents/assignments` | `beta/deviceManagement/intents/assignments` |
| `beta/device-management/intents/categories` | `beta/deviceManagement/intents/categories` |
| `beta/device-management/intents/categories/setting-definitions` | `beta/deviceManagement/intents/categories/settingDefinitions` |
| `beta/device-management/intents/categories/settings` | `beta/deviceManagement/intents/categories/settings` |
| `beta/device-management/intents/device-setting-state-summaries` | `beta/deviceManagement/intents/deviceSettingStateSummaries` |
| `beta/device-management/intents/device-states` | `beta/deviceManagement/intents/deviceStates` |
| `beta/device-management/intents/settings` | `beta/deviceManagement/intents/settings` |
| `beta/device-management/intents/user-states` | `beta/deviceManagement/intents/userStates` |
| `beta/device-management/intune-branding-profiles` | `beta/deviceManagement/intuneBrandingProfiles` |
| `beta/device-management/intune-branding-profiles/assignments` | `beta/deviceManagement/intuneBrandingProfiles/assignments` |
| `beta/device-management/ios-update-statuses` | `beta/deviceManagement/iosUpdateStatuses` |
| `beta/device-management/mac-os-software-update-account-summaries` | `beta/deviceManagement/macOSSoftwareUpdateAccountSummaries` |
| `beta/device-management/mac-os-software-update-account-summaries/category-summaries` | `beta/deviceManagement/macOSSoftwareUpdateAccountSummaries/categorySummaries` |
| `beta/device-management/mac-os-software-update-account-summaries/category-summaries/update-state-summaries` | `beta/deviceManagement/macOSSoftwareUpdateAccountSummaries/categorySummaries/updateStateSummaries` |
| `beta/device-management/managed-device-cleanup-rules` | `beta/deviceManagement/managedDeviceCleanupRules` |
| `beta/device-management/managed-device-encryption-states` | `beta/deviceManagement/managedDeviceEncryptionStates` |
| `beta/device-management/managed-devices` | `beta/deviceManagement/managedDevices` |
| `beta/device-management/microsoft-tunnel-configurations` | `beta/deviceManagement/microsoftTunnelConfigurations` |
| `beta/device-management/microsoft-tunnel-health-thresholds` | `beta/deviceManagement/microsoftTunnelHealthThresholds` |
| `beta/device-management/microsoft-tunnel-server-log-collection-responses` | `beta/deviceManagement/microsoftTunnelServerLogCollectionResponses` |
| `beta/device-management/microsoft-tunnel-sites` | `beta/deviceManagement/microsoftTunnelSites` |
| `beta/device-management/microsoft-tunnel-sites/microsoft-tunnel-servers` | `beta/deviceManagement/microsoftTunnelSites/microsoftTunnelServers` |
| `beta/device-management/mobile-app-troubleshooting-events` | `beta/deviceManagement/mobileAppTroubleshootingEvents` |
| `beta/device-management/mobile-app-troubleshooting-events/app-log-collection-requests` | `beta/deviceManagement/mobileAppTroubleshootingEvents/appLogCollectionRequests` |
| `beta/device-management/mobile-threat-defense-connectors` | `beta/deviceManagement/mobileThreatDefenseConnectors` |
| `beta/device-management/ndes-connectors` | `beta/deviceManagement/ndesConnectors` |
| `beta/device-management/notification-message-templates` | `beta/deviceManagement/notificationMessageTemplates` |
| `beta/device-management/notification-message-templates/localized-notification-messages` | `beta/deviceManagement/notificationMessageTemplates/localizedNotificationMessages` |
| `beta/device-management/operation-approval-policies` | `beta/deviceManagement/operationApprovalPolicies` |
| `beta/device-management/operation-approval-requests` | `beta/deviceManagement/operationApprovalRequests` |
| `beta/device-management/privilege-management-elevations` | `beta/deviceManagement/privilegeManagementElevations` |
| `beta/device-management/remote-action-audits` | `beta/deviceManagement/remoteActionAudits` |
| `beta/device-management/remote-assistance-partners` | `beta/deviceManagement/remoteAssistancePartners` |
| `beta/device-management/reports` | `beta/deviceManagement/reports` |
| `beta/device-management/reports/cached-report-configurations` | `beta/deviceManagement/reports/cachedReportConfigurations` |
| `beta/device-management/reports/export-jobs` | `beta/deviceManagement/reports/exportJobs` |
| `beta/device-management/resource-access-profiles` | `beta/deviceManagement/resourceAccessProfiles` |
| `beta/device-management/resource-access-profiles/assignments` | `beta/deviceManagement/resourceAccessProfiles/assignments` |
| `beta/device-management/resource-operations` | `beta/deviceManagement/resourceOperations` |
| `beta/device-management/reusable-policy-settings` | `beta/deviceManagement/reusablePolicySettings` |
| `beta/device-management/reusable-policy-settings/referencing-configuration-policies` | `beta/deviceManagement/reusablePolicySettings/referencingConfigurationPolicies` |
| `beta/device-management/reusable-settings` | `beta/deviceManagement/reusableSettings` |
| `beta/device-management/role-assignments` | `beta/deviceManagement/roleAssignments` |
| `beta/device-management/role-definitions` | `beta/deviceManagement/roleDefinitions` |
| `beta/device-management/role-definitions/role-assignments` | `beta/deviceManagement/roleDefinitions/roleAssignments` |
| `beta/device-management/role-scope-tags` | `beta/deviceManagement/roleScopeTags` |
| `beta/device-management/setting-definitions` | `beta/deviceManagement/settingDefinitions` |
| `beta/device-management/template-insights` | `beta/deviceManagement/templateInsights` |
| `beta/device-management/template-settings` | `beta/deviceManagement/templateSettings` |
| `beta/device-management/templates` | `beta/deviceManagement/templates` |
| `beta/device-management/templates/categories` | `beta/deviceManagement/templates/categories` |
| `beta/device-management/templates/categories/recommended-settings` | `beta/deviceManagement/templates/categories/recommendedSettings` |
| `beta/device-management/templates/categories/setting-definitions` | `beta/deviceManagement/templates/categories/settingDefinitions` |
| `beta/device-management/templates/migratable-to` | `beta/deviceManagement/templates/migratableTo` |
| `beta/device-management/templates/settings` | `beta/deviceManagement/templates/settings` |
| `beta/device-management/terms-and-conditions` | `beta/deviceManagement/termsAndConditions` |
| `beta/device-management/terms-and-conditions/acceptance-statuses` | `beta/deviceManagement/termsAndConditions/acceptanceStatuses` |
| `beta/device-management/terms-and-conditions/assignments` | `beta/deviceManagement/termsAndConditions/assignments` |
| `beta/device-management/terms-and-conditions/group-assignments` | `beta/deviceManagement/termsAndConditions/groupAssignments` |
| `beta/device-management/troubleshooting-events` | `beta/deviceManagement/troubleshootingEvents` |
| `beta/device-management/user-pfx-certificates` | `beta/deviceManagement/userPfxCertificates` |
| `beta/device-management/virtual-endpoint` | `beta/deviceManagement/virtualEndpoint` |
| `beta/device-management/virtual-endpoint/cloud-apps` | `beta/deviceManagement/virtualEndpoint/cloudApps` |
| `beta/device-management/virtual-endpoint/cloud-pc-pools` | `beta/deviceManagement/virtualEndpoint/cloudPcPools` |
| `beta/device-management/virtual-endpoint/cloud-pc-pools/assignments` | `beta/deviceManagement/virtualEndpoint/cloudPcPools/assignments` |
| `beta/device-management/virtual-endpoint/device-images` | `beta/deviceManagement/virtualEndpoint/deviceImages` |
| `beta/device-management/virtual-endpoint/on-premises-connections` | `beta/deviceManagement/virtualEndpoint/onPremisesConnections` |
| `beta/device-management/virtual-endpoint/provisioning-policies` | `beta/deviceManagement/virtualEndpoint/provisioningPolicies` |
| `beta/device-management/virtual-endpoint/user-settings` | `beta/deviceManagement/virtualEndpoint/userSettings` |
| `beta/device-management/windows-autopilot-deployment-profiles` | `beta/deviceManagement/windowsAutopilotDeploymentProfiles` |
| `beta/device-management/windows-autopilot-device-identities` | `beta/deviceManagement/windowsAutopilotDeviceIdentities` |
| `beta/device-management/windows-driver-update-profiles` | `beta/deviceManagement/windowsDriverUpdateProfiles` |
| `beta/device-management/windows-driver-update-profiles/assignments` | `beta/deviceManagement/windowsDriverUpdateProfiles/assignments` |
| `beta/device-management/windows-driver-update-profiles/driver-inventories` | `beta/deviceManagement/windowsDriverUpdateProfiles/driverInventories` |
| `beta/device-management/windows-feature-update-profiles` | `beta/deviceManagement/windowsFeatureUpdateProfiles` |
| `beta/device-management/windows-feature-update-profiles/assignments` | `beta/deviceManagement/windowsFeatureUpdateProfiles/assignments` |
| `beta/device-management/windows-information-protection-app-learning-summaries` | `beta/deviceManagement/windowsInformationProtectionAppLearningSummaries` |
| `beta/device-management/windows-information-protection-network-learning-summaries` | `beta/deviceManagement/windowsInformationProtectionNetworkLearningSummaries` |
| `beta/device-management/windows-malware-information` | `beta/deviceManagement/windowsMalwareInformation` |
| `beta/device-management/windows-malware-information/device-malware-states` | `beta/deviceManagement/windowsMalwareInformation/deviceMalwareStates` |
| `beta/device-management/windows-quality-update-policies` | `beta/deviceManagement/windowsQualityUpdatePolicies` |
| `beta/device-management/windows-quality-update-policies/assignments` | `beta/deviceManagement/windowsQualityUpdatePolicies/assignments` |
| `beta/device-management/windows-quality-update-profiles` | `beta/deviceManagement/windowsQualityUpdateProfiles` |
| `beta/device-management/windows-quality-update-profiles/assignments` | `beta/deviceManagement/windowsQualityUpdateProfiles/assignments` |
| `beta/device-management/windows-update-catalog-items` | `beta/deviceManagement/windowsUpdateCatalogItems` |
| `beta/device-management/zebra-fota-artifacts` | `beta/deviceManagement/zebraFotaArtifacts` |
| `beta/directory/authentication-method-devices` | `beta/directory/authenticationMethodDevices` |
| `beta/directory/authentication-method-devices/hardware-oath-devices` | `beta/directory/authenticationMethodDevices/hardwareOathDevices` |
| `beta/directory/certificate-authorities` | `beta/directory/certificateAuthorities` |
| `beta/directory/certificate-authorities/certificate-based-application-configurations` | `beta/directory/certificateAuthorities/certificateBasedApplicationConfigurations` |
| `beta/directory/certificate-authorities/certificate-based-application-configurations/trusted-certificate-authorities` | `beta/directory/certificateAuthorities/certificateBasedApplicationConfigurations/trustedCertificateAuthorities` |
| `beta/directory/certificate-authorities/mutual-tls-oauth-configurations` | `beta/directory/certificateAuthorities/mutualTlsOauthConfigurations` |
| `beta/directory/pending-external-user-profiles` | `beta/directory/pendingExternalUserProfiles` |
| `beta/directory/public-key-infrastructure` | `beta/directory/publicKeyInfrastructure` |
| `beta/directory/public-key-infrastructure/certificate-based-auth-configurations` | `beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations` |
| `beta/directory/public-key-infrastructure/certificate-based-auth-configurations/certificate-authorities` | `beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/certificateAuthorities` |
| `beta/directory/templates/device-templates` | `beta/directory/templates/deviceTemplates` |
| `beta/directory/tenant-governance` | `beta/directory/tenantGovernance` |
| `beta/directory/tenant-governance/governance-invitations` | `beta/directory/tenantGovernance/governanceInvitations` |
| `beta/directory/tenant-governance/governance-policy-templates` | `beta/directory/tenantGovernance/governancePolicyTemplates` |
| `beta/domains/federation-configuration` | `beta/domains/federationConfiguration` |
| `beta/education/classes/assignment-categories` | `beta/education/classes/assignmentCategories` |
| `beta/education/classes/assignment-settings` | `beta/education/classes/assignmentSettings` |
| `beta/education/classes/assignment-settings/grading-schemes` | `beta/education/classes/assignmentSettings/gradingSchemes` |
| `beta/employee-experience` | `beta/employeeExperience` |
| `beta/employee-experience/communities` | `beta/employeeExperience/communities` |
| `beta/employee-experience/learning-providers` | `beta/employeeExperience/learningProviders` |
| `beta/employee-experience/learning-providers/learning-course-activities` | `beta/employeeExperience/learningProviders/learningCourseActivities` |
| `beta/external/industry-data` | `beta/external/industryData` |
| `beta/external/industry-data/data-connectors` | `beta/external/industryData/dataConnectors` |
| `beta/external/industry-data/inbound-flows` | `beta/external/industryData/inboundFlows` |
| `beta/external/industry-data/outbound-provisioning-flow-sets` | `beta/external/industryData/outboundProvisioningFlowSets` |
| `beta/external/industry-data/outbound-provisioning-flow-sets/provisioning-flows` | `beta/external/industryData/outboundProvisioningFlowSets/provisioningFlows` |
| `beta/external/industry-data/reference-definitions` | `beta/external/industryData/referenceDefinitions` |
| `beta/external/industry-data/source-systems` | `beta/external/industryData/sourceSystems` |
| `beta/external/industry-data/years` | `beta/external/industryData/years` |
| `beta/group-lifecycle-policies` | `beta/groupLifecyclePolicies` |
| `beta/groups/app-role-assignments` | `beta/groups/appRoleAssignments` |
| `beta/groups/calendar/calendar-permissions` | `beta/groups/calendar/calendarPermissions` |
| `beta/identity-governance` | `beta/identityGovernance` |
| `beta/identity-governance/access-reviews` | `beta/identityGovernance/accessReviews` |
| `beta/identity-governance/access-reviews/definitions` | `beta/identityGovernance/accessReviews/definitions` |
| `beta/identity-governance/catalogs` | `beta/identityGovernance/catalogs` |
| `beta/identity-governance/catalogs/access-package-resources` | `beta/identityGovernance/catalogs/accessPackageResources` |
| `beta/identity-governance/catalogs/access-package-resources/upload-sessions` | `beta/identityGovernance/catalogs/accessPackageResources/uploadSessions` |
| `beta/identity-governance/entitlement-management` | `beta/identityGovernance/entitlementManagement` |
| `beta/identity-governance/entitlement-management/access-package-assignment-policies` | `beta/identityGovernance/entitlementManagement/accessPackageAssignmentPolicies` |
| `beta/identity-governance/entitlement-management/access-package-assignment-requests` | `beta/identityGovernance/entitlementManagement/accessPackageAssignmentRequests` |
| `beta/identity-governance/entitlement-management/access-package-catalogs` | `beta/identityGovernance/entitlementManagement/accessPackageCatalogs` |
| `beta/identity-governance/entitlement-management/access-packages` | `beta/identityGovernance/entitlementManagement/accessPackages` |
| `beta/identity-governance/entitlement-management/access-packages/access-package-resource-role-scopes` | `beta/identityGovernance/entitlementManagement/accessPackages/accessPackageResourceRoleScopes` |
| `beta/identity-governance/entitlement-management/assignment-requests` | `beta/identityGovernance/entitlementManagement/assignmentRequests` |
| `beta/identity-governance/entitlement-management/connected-organizations` | `beta/identityGovernance/entitlementManagement/connectedOrganizations` |
| `beta/identity-governance/entitlement-management/external-origin-resource-connectors` | `beta/identityGovernance/entitlementManagement/externalOriginResourceConnectors` |
| `beta/identity-governance/lifecycle-workflows` | `beta/identityGovernance/lifecycleWorkflows` |
| `beta/identity-governance/lifecycle-workflows/custom-task-extensions` | `beta/identityGovernance/lifecycleWorkflows/customTaskExtensions` |
| `beta/identity-governance/lifecycle-workflows/workflows` | `beta/identityGovernance/lifecycleWorkflows/workflows` |
| `beta/identity-governance/terms-of-use` | `beta/identityGovernance/termsOfUse` |
| `beta/identity-governance/terms-of-use/agreements` | `beta/identityGovernance/termsOfUse/agreements` |
| `beta/identity-providers` | `beta/identityProviders` |
| `beta/identity/api-connectors` | `beta/identity/apiConnectors` |
| `beta/identity/authentication-event-listeners` | `beta/identity/authenticationEventListeners` |
| `beta/identity/authentication-events-flows` | `beta/identity/authenticationEventsFlows` |
| `beta/identity/b2c-user-flows` | `beta/identity/b2cUserFlows` |
| `beta/identity/b2c-user-flows/user-attribute-assignments` | `beta/identity/b2cUserFlows/userAttributeAssignments` |
| `beta/identity/b2x-user-flows` | `beta/identity/b2xUserFlows` |
| `beta/identity/b2x-user-flows/user-attribute-assignments` | `beta/identity/b2xUserFlows/userAttributeAssignments` |
| `beta/identity/conditional-access` | `beta/identity/conditionalAccess` |
| `beta/identity/conditional-access/authentication-context-class-references` | `beta/identity/conditionalAccess/authenticationContextClassReferences` |
| `beta/identity/conditional-access/authentication-strength` | `beta/identity/conditionalAccess/authenticationStrength` |
| `beta/identity/conditional-access/authentication-strength/policies` | `beta/identity/conditionalAccess/authenticationStrength/policies` |
| `beta/identity/conditional-access/authentication-strength/policies/combination-configurations` | `beta/identity/conditionalAccess/authenticationStrength/policies/combinationConfigurations` |
| `beta/identity/conditional-access/policies` | `beta/identity/conditionalAccess/policies` |
| `beta/identity/custom-authentication-extensions` | `beta/identity/customAuthenticationExtensions` |
| `beta/identity/identity-providers` | `beta/identity/identityProviders` |
| `beta/identity/risk-prevention` | `beta/identity/riskPrevention` |
| `beta/identity/risk-prevention/fraud-protection-providers` | `beta/identity/riskPrevention/fraudProtectionProviders` |
| `beta/identity/risk-prevention/web-application-firewall-providers` | `beta/identity/riskPrevention/webApplicationFirewallProviders` |
| `beta/identity/user-flow-attributes` | `beta/identity/userFlowAttributes` |
| `beta/identity/user-flows` | `beta/identity/userFlows` |
| `beta/identity/verified-id` | `beta/identity/verifiedId` |
| `beta/identity/verified-id/profiles` | `beta/identity/verifiedId/profiles` |
| `beta/me/calendar-groups` | `beta/me/calendarGroups` |
| `beta/me/calendar-groups/calendars` | `beta/me/calendarGroups/calendars` |
| `beta/me/calendar-groups/calendars/events` | `beta/me/calendarGroups/calendars/events` |
| `beta/me/contact-folders` | `beta/me/contactFolders` |
| `beta/me/contact-folders/contacts` | `beta/me/contactFolders/contacts` |
| `beta/me/distribution-lists` | `beta/me/distributionLists` |
| `beta/me/inference-classification` | `beta/me/inferenceClassification` |
| `beta/me/inference-classification/overrides` | `beta/me/inferenceClassification/overrides` |
| `beta/me/mail-folders` | `beta/me/mailFolders` |
| `beta/me/mail-folders/messages` | `beta/me/mailFolders/messages` |
| `beta/me/online-meetings` | `beta/me/onlineMeetings` |
| `beta/me/online-meetings/registration` | `beta/me/onlineMeetings/registration` |
| `beta/me/online-meetings/registration/registrants` | `beta/me/onlineMeetings/registration/registrants` |
| `beta/me/outlook/master-categories` | `beta/me/outlook/masterCategories` |
| `beta/me/outlook/task-folders` | `beta/me/outlook/taskFolders` |
| `beta/me/outlook/task-groups` | `beta/me/outlook/taskGroups` |
| `beta/me/outlook/task-groups/task-folders` | `beta/me/outlook/taskGroups/taskFolders` |
| `beta/me/profile/educational-activities` | `beta/me/profile/educationalActivities` |
| `beta/me/profile/web-accounts` | `beta/me/profile/webAccounts` |
| `beta/me/settings/work-hours-and-locations` | `beta/me/settings/workHoursAndLocations` |
| `beta/me/settings/work-hours-and-locations/occurrences` | `beta/me/settings/workHoursAndLocations/occurrences` |
| `beta/me/settings/work-hours-and-locations/recurrences` | `beta/me/settings/workHoursAndLocations/recurrences` |
| `beta/me/todo/lists/tasks/checklist-items` | `beta/me/todo/lists/tasks/checklistItems` |
| `beta/me/todo/lists/tasks/linked-resources` | `beta/me/todo/lists/tasks/linkedResources` |
| `beta/network-access` | `beta/networkAccess` |
| `beta/network-access/cloud-firewall-policies` | `beta/networkAccess/cloudFirewallPolicies` |
| `beta/network-access/cloud-firewall-policies/policy-rules` | `beta/networkAccess/cloudFirewallPolicies/policyRules` |
| `beta/network-access/connectivity` | `beta/networkAccess/connectivity` |
| `beta/network-access/connectivity/branches` | `beta/networkAccess/connectivity/branches` |
| `beta/network-access/connectivity/branches/device-links` | `beta/networkAccess/connectivity/branches/deviceLinks` |
| `beta/network-access/connectivity/remote-networks` | `beta/networkAccess/connectivity/remoteNetworks` |
| `beta/network-access/connectivity/remote-networks/device-links` | `beta/networkAccess/connectivity/remoteNetworks/deviceLinks` |
| `beta/network-access/filtering-policies` | `beta/networkAccess/filteringPolicies` |
| `beta/network-access/filtering-policies/policy-rules` | `beta/networkAccess/filteringPolicies/policyRules` |
| `beta/network-access/threat-intelligence-policies` | `beta/networkAccess/threatIntelligencePolicies` |
| `beta/network-access/tls` | `beta/networkAccess/tls` |
| `beta/network-access/tls-inspection-policies` | `beta/networkAccess/tlsInspectionPolicies` |
| `beta/network-access/tls-inspection-policies/policy-rules` | `beta/networkAccess/tlsInspectionPolicies/policyRules` |
| `beta/network-access/tls/external-certificate-authority-certificates` | `beta/networkAccess/tls/externalCertificateAuthorityCertificates` |
| `beta/oauth2-permission-grants` | `beta/oauth2PermissionGrants` |
| `beta/policies/activity-based-timeout-policies` | `beta/policies/activityBasedTimeoutPolicies` |
| `beta/policies/app-management-policies` | `beta/policies/appManagementPolicies` |
| `beta/policies/authentication-strength-policies` | `beta/policies/authenticationStrengthPolicies` |
| `beta/policies/b2b-management-policies` | `beta/policies/b2bManagementPolicies` |
| `beta/policies/claims-mapping-policies` | `beta/policies/claimsMappingPolicies` |
| `beta/policies/cross-tenant-access-policy` | `beta/policies/crossTenantAccessPolicy` |
| `beta/policies/cross-tenant-access-policy/partners` | `beta/policies/crossTenantAccessPolicy/partners` |
| `beta/policies/cross-tenant-access-policy/partners/m365-capabilities` | `beta/policies/crossTenantAccessPolicy/partners/m365Capabilities` |
| `beta/policies/feature-rollout-policies` | `beta/policies/featureRolloutPolicies` |
| `beta/policies/home-realm-discovery-policies` | `beta/policies/homeRealmDiscoveryPolicies` |
| `beta/policies/on-prem-authentication-policies` | `beta/policies/onPremAuthenticationPolicies` |
| `beta/policies/permission-grant-policies` | `beta/policies/permissionGrantPolicies` |
| `beta/policies/permission-grant-policies/excludes` | `beta/policies/permissionGrantPolicies/excludes` |
| `beta/policies/permission-grant-policies/includes` | `beta/policies/permissionGrantPolicies/includes` |
| `beta/policies/permission-grant-pre-approval-policies` | `beta/policies/permissionGrantPreApprovalPolicies` |
| `beta/policies/token-issuance-policies` | `beta/policies/tokenIssuancePolicies` |
| `beta/policies/token-lifetime-policies` | `beta/policies/tokenLifetimePolicies` |
| `beta/print/printers/task-triggers` | `beta/print/printers/taskTriggers` |
| `beta/print/task-definitions` | `beta/print/taskDefinitions` |
| `beta/program-controls` | `beta/programControls` |
| `beta/role-management` | `beta/roleManagement` |
| `beta/role-management/cloud-pc` | `beta/roleManagement/cloudPC` |
| `beta/role-management/cloud-pc/role-assignments` | `beta/roleManagement/cloudPC/roleAssignments` |
| `beta/role-management/cloud-pc/role-definitions` | `beta/roleManagement/cloudPC/roleDefinitions` |
| `beta/role-management/defender` | `beta/roleManagement/defender` |
| `beta/role-management/defender/role-assignments` | `beta/roleManagement/defender/roleAssignments` |
| `beta/role-management/defender/role-definitions` | `beta/roleManagement/defender/roleDefinitions` |
| `beta/role-management/device-management` | `beta/roleManagement/deviceManagement` |
| `beta/role-management/device-management/role-assignments` | `beta/roleManagement/deviceManagement/roleAssignments` |
| `beta/role-management/device-management/role-definitions` | `beta/roleManagement/deviceManagement/roleDefinitions` |
| `beta/role-management/directory` | `beta/roleManagement/directory` |
| `beta/role-management/directory/role-assignments` | `beta/roleManagement/directory/roleAssignments` |
| `beta/role-management/directory/role-definitions` | `beta/roleManagement/directory/roleDefinitions` |
| `beta/role-management/entitlement-management` | `beta/roleManagement/entitlementManagement` |
| `beta/role-management/entitlement-management/role-assignments` | `beta/roleManagement/entitlementManagement/roleAssignments` |
| `beta/role-management/exchange` | `beta/roleManagement/exchange` |
| `beta/role-management/exchange/custom-app-scopes` | `beta/roleManagement/exchange/customAppScopes` |
| `beta/role-management/exchange/role-assignments` | `beta/roleManagement/exchange/roleAssignments` |
| `beta/schema-extensions` | `beta/schemaExtensions` |
| `beta/security/attack-simulation` | `beta/security/attackSimulation` |
| `beta/security/attack-simulation/simulations` | `beta/security/attackSimulation/simulations` |
| `beta/security/case-management` | `beta/security/caseManagement` |
| `beta/security/case-management/cases` | `beta/security/caseManagement/cases` |
| `beta/security/case-management/cases/activities` | `beta/security/caseManagement/cases/activities` |
| `beta/security/case-management/cases/relations` | `beta/security/caseManagement/cases/relations` |
| `beta/security/case-management/cases/tasks` | `beta/security/caseManagement/cases/tasks` |
| `beta/security/cases/ediscovery-cases` | `beta/security/cases/ediscoveryCases` |
| `beta/security/cases/ediscovery-cases/case-members` | `beta/security/cases/ediscoveryCases/caseMembers` |
| `beta/security/cases/ediscovery-cases/custodians` | `beta/security/cases/ediscoveryCases/custodians` |
| `beta/security/cases/ediscovery-cases/custodians/site-sources` | `beta/security/cases/ediscoveryCases/custodians/siteSources` |
| `beta/security/cases/ediscovery-cases/custodians/unified-group-sources` | `beta/security/cases/ediscoveryCases/custodians/unifiedGroupSources` |
| `beta/security/cases/ediscovery-cases/custodians/user-sources` | `beta/security/cases/ediscoveryCases/custodians/userSources` |
| `beta/security/cases/ediscovery-cases/legal-holds` | `beta/security/cases/ediscoveryCases/legalHolds` |
| `beta/security/cases/ediscovery-cases/legal-holds/site-sources` | `beta/security/cases/ediscoveryCases/legalHolds/siteSources` |
| `beta/security/cases/ediscovery-cases/legal-holds/user-sources` | `beta/security/cases/ediscoveryCases/legalHolds/userSources` |
| `beta/security/cases/ediscovery-cases/review-sets` | `beta/security/cases/ediscoveryCases/reviewSets` |
| `beta/security/cases/ediscovery-cases/review-sets/queries` | `beta/security/cases/ediscoveryCases/reviewSets/queries` |
| `beta/security/cases/ediscovery-cases/searches` | `beta/security/cases/ediscoveryCases/searches` |
| `beta/security/cases/ediscovery-cases/tags` | `beta/security/cases/ediscoveryCases/tags` |
| `beta/security/labels/file-plan-references` | `beta/security/labels/filePlanReferences` |
| `beta/security/labels/retention-labels` | `beta/security/labels/retentionLabels` |
| `beta/security/rules/detection-rules` | `beta/security/rules/detectionRules` |
| `beta/security/threat-submission` | `beta/security/threatSubmission` |
| `beta/security/threat-submission/email-threat-submission-policies` | `beta/security/threatSubmission/emailThreatSubmissionPolicies` |
| `beta/security/ti-indicators` | `beta/security/tiIndicators` |
| `beta/security/triggers/retention-events` | `beta/security/triggers/retentionEvents` |
| `beta/service-principals` | `beta/servicePrincipals` |
| `beta/service-principals/app-role-assigned-to` | `beta/servicePrincipals/appRoleAssignedTo` |
| `beta/service-principals/app-role-assignments` | `beta/servicePrincipals/appRoleAssignments` |
| `beta/service-principals/delegated-permission-classifications` | `beta/servicePrincipals/delegatedPermissionClassifications` |
| `beta/service-principals/remote-desktop-security-configuration` | `beta/servicePrincipals/remoteDesktopSecurityConfiguration` |
| `beta/service-principals/remote-desktop-security-configuration/approved-client-apps` | `beta/servicePrincipals/remoteDesktopSecurityConfiguration/approvedClientApps` |
| `beta/service-principals/synchronization` | `beta/servicePrincipals/synchronization` |
| `beta/service-principals/synchronization/jobs` | `beta/servicePrincipals/synchronization/jobs` |
| `beta/sites/content-types` | `beta/sites/contentTypes` |
| `beta/sites/content-types/columns` | `beta/sites/contentTypes/columns` |
| `beta/sites/lists/content-types` | `beta/sites/lists/contentTypes` |
| `beta/sites/lists/content-types/columns` | `beta/sites/lists/contentTypes/columns` |
| `beta/sites/lists/items/document-set-versions` | `beta/sites/lists/items/documentSetVersions` |
| `beta/solutions/backup-restore` | `beta/solutions/backupRestore` |
| `beta/solutions/backup-restore/exchange-restore-sessions` | `beta/solutions/backupRestore/exchangeRestoreSessions` |
| `beta/solutions/backup-restore/exchange-restore-sessions/mailbox-restore-artifacts-bulk-addition-requests` | `beta/solutions/backupRestore/exchangeRestoreSessions/mailboxRestoreArtifactsBulkAdditionRequests` |
| `beta/solutions/backup-restore/one-drive-for-business-restore-sessions` | `beta/solutions/backupRestore/oneDriveForBusinessRestoreSessions` |
| `beta/solutions/backup-restore/one-drive-for-business-restore-sessions/drive-restore-artifacts-bulk-addition-requests` | `beta/solutions/backupRestore/oneDriveForBusinessRestoreSessions/driveRestoreArtifactsBulkAdditionRequests` |
| `beta/solutions/backup-restore/service-apps` | `beta/solutions/backupRestore/serviceApps` |
| `beta/solutions/backup-restore/share-point-restore-sessions` | `beta/solutions/backupRestore/sharePointRestoreSessions` |
| `beta/solutions/backup-restore/share-point-restore-sessions/site-restore-artifacts-bulk-addition-requests` | `beta/solutions/backupRestore/sharePointRestoreSessions/siteRestoreArtifactsBulkAdditionRequests` |
| `beta/solutions/booking-businesses` | `beta/solutions/bookingBusinesses` |
| `beta/solutions/booking-businesses/appointments` | `beta/solutions/bookingBusinesses/appointments` |
| `beta/solutions/booking-businesses/custom-questions` | `beta/solutions/bookingBusinesses/customQuestions` |
| `beta/solutions/booking-businesses/customers` | `beta/solutions/bookingBusinesses/customers` |
| `beta/solutions/booking-businesses/services` | `beta/solutions/bookingBusinesses/services` |
| `beta/solutions/booking-businesses/staff-members` | `beta/solutions/bookingBusinesses/staffMembers` |
| `beta/solutions/business-scenarios` | `beta/solutions/businessScenarios` |
| `beta/solutions/migrations/cross-tenant-migration-jobs` | `beta/solutions/migrations/crossTenantMigrationJobs` |
| `beta/solutions/virtual-events` | `beta/solutions/virtualEvents` |
| `beta/solutions/virtual-events/townhalls` | `beta/solutions/virtualEvents/townhalls` |
| `beta/solutions/virtual-events/townhalls/presenters` | `beta/solutions/virtualEvents/townhalls/presenters` |
| `beta/solutions/virtual-events/townhalls/registration-configuration` | `beta/solutions/virtualEvents/townhalls/registrationConfiguration` |
| `beta/solutions/virtual-events/townhalls/registration-configuration/questions` | `beta/solutions/virtualEvents/townhalls/registrationConfiguration/questions` |
| `beta/solutions/virtual-events/webinars` | `beta/solutions/virtualEvents/webinars` |
| `beta/solutions/virtual-events/webinars/presenters` | `beta/solutions/virtualEvents/webinars/presenters` |
| `beta/solutions/virtual-events/webinars/registration-configuration` | `beta/solutions/virtualEvents/webinars/registrationConfiguration` |
| `beta/solutions/virtual-events/webinars/registration-configuration/questions` | `beta/solutions/virtualEvents/webinars/registrationConfiguration/questions` |
| `beta/storage/file-storage` | `beta/storage/fileStorage` |
| `beta/storage/file-storage/container-types` | `beta/storage/fileStorage/containerTypes` |
| `beta/storage/file-storage/container-types/permissions` | `beta/storage/fileStorage/containerTypes/permissions` |
| `beta/storage/file-storage/containers` | `beta/storage/fileStorage/containers` |
| `beta/storage/file-storage/containers/columns` | `beta/storage/fileStorage/containers/columns` |
| `beta/storage/file-storage/containers/migration-jobs` | `beta/storage/fileStorage/containers/migrationJobs` |
| `beta/storage/file-storage/containers/permissions` | `beta/storage/fileStorage/containers/permissions` |
| `beta/storage/file-storage/containers/share-point-groups` | `beta/storage/fileStorage/containers/sharePointGroups` |
| `beta/storage/file-storage/containers/share-point-groups/members` | `beta/storage/fileStorage/containers/sharePointGroups/members` |
| `beta/teams/installed-apps` | `beta/teams/installedApps` |
| `beta/teams/schedule/time-off-requests` | `beta/teams/schedule/timeOffRequests` |
| `beta/teamwork/workforce-integrations` | `beta/teamwork/workforceIntegrations` |
| `beta/tenant-relationships` | `beta/tenantRelationships` |
| `beta/tenant-relationships/managed-tenants` | `beta/tenantRelationships/managedTenants` |
| `beta/tenant-relationships/managed-tenants/tenant-tags` | `beta/tenantRelationships/managedTenants/tenantTags` |
| `beta/tenant-relationships/multi-tenant-organization` | `beta/tenantRelationships/multiTenantOrganization` |
| `beta/tenant-relationships/multi-tenant-organization/tenants` | `beta/tenantRelationships/multiTenantOrganization/tenants` |
| `beta/term-store` | `beta/termStore` |
| `beta/term-store/groups` | `beta/termStore/groups` |
| `beta/term-store/sets` | `beta/termStore/sets` |
| `beta/trust-framework` | `beta/trustFramework` |
| `beta/trust-framework/policies` | `beta/trustFramework/policies` |
| `beta/users/app-role-assignments` | `beta/users/appRoleAssignments` |
| `beta/users/authentication/email-methods` | `beta/users/authentication/emailMethods` |
| `beta/users/authentication/phone-methods` | `beta/users/authentication/phoneMethods` |
| `beta/users/calendar-groups` | `beta/users/calendarGroups` |
| `beta/users/calendar-groups/calendars` | `beta/users/calendarGroups/calendars` |
| `beta/users/calendar-groups/calendars/events` | `beta/users/calendarGroups/calendars/events` |
| `beta/users/calendar/calendar-permissions` | `beta/users/calendar/calendarPermissions` |
| `beta/users/contact-folders` | `beta/users/contactFolders` |
| `beta/users/contact-folders/contacts` | `beta/users/contactFolders/contacts` |
| `beta/users/distribution-lists` | `beta/users/distributionLists` |
| `beta/users/inference-classification` | `beta/users/inferenceClassification` |
| `beta/users/inference-classification/overrides` | `beta/users/inferenceClassification/overrides` |
| `beta/users/mail-folders` | `beta/users/mailFolders` |
| `beta/users/mail-folders/messages` | `beta/users/mailFolders/messages` |
| `beta/users/mobile-app-intent-and-states` | `beta/users/mobileAppIntentAndStates` |
| `beta/users/mobile-app-troubleshooting-events` | `beta/users/mobileAppTroubleshootingEvents` |
| `beta/users/online-meetings` | `beta/users/onlineMeetings` |
| `beta/users/online-meetings/registration` | `beta/users/onlineMeetings/registration` |
| `beta/users/online-meetings/registration/registrants` | `beta/users/onlineMeetings/registration/registrants` |
| `beta/users/outlook/master-categories` | `beta/users/outlook/masterCategories` |
| `beta/users/outlook/task-folders` | `beta/users/outlook/taskFolders` |
| `beta/users/outlook/task-groups` | `beta/users/outlook/taskGroups` |
| `beta/users/outlook/task-groups/task-folders` | `beta/users/outlook/taskGroups/taskFolders` |
| `beta/users/profile/educational-activities` | `beta/users/profile/educationalActivities` |
| `beta/users/profile/web-accounts` | `beta/users/profile/webAccounts` |
| `beta/users/settings/work-hours-and-locations` | `beta/users/settings/workHoursAndLocations` |
| `beta/users/settings/work-hours-and-locations/occurrences` | `beta/users/settings/workHoursAndLocations/occurrences` |
| `beta/users/settings/work-hours-and-locations/recurrences` | `beta/users/settings/workHoursAndLocations/recurrences` |
| `beta/users/teamwork/installed-apps` | `beta/users/teamwork/installedApps` |
| `beta/users/todo/lists/tasks/checklist-items` | `beta/users/todo/lists/tasks/checklistItems` |
| `beta/users/todo/lists/tasks/linked-resources` | `beta/users/todo/lists/tasks/linkedResources` |
| `beta/workplace/sensor-devices` | `beta/workplace/sensorDevices` |
| `v1.0/admin/configuration-management` | `v1.0/admin/configurationManagement` |
| `v1.0/admin/configuration-management/configuration-monitors` | `v1.0/admin/configurationManagement/configurationMonitors` |
| `v1.0/admin/edge/internet-explorer-mode` | `v1.0/admin/edge/internetExplorerMode` |
| `v1.0/admin/edge/internet-explorer-mode/site-lists` | `v1.0/admin/edge/internetExplorerMode/siteLists` |
| `v1.0/admin/edge/internet-explorer-mode/site-lists/shared-cookies` | `v1.0/admin/edge/internetExplorerMode/siteLists/sharedCookies` |
| `v1.0/admin/edge/internet-explorer-mode/site-lists/sites` | `v1.0/admin/edge/internetExplorerMode/siteLists/sites` |
| `v1.0/admin/people/profile-card-properties` | `v1.0/admin/people/profileCardProperties` |
| `v1.0/admin/people/profile-property-settings` | `v1.0/admin/people/profilePropertySettings` |
| `v1.0/app-catalogs` | `v1.0/appCatalogs` |
| `v1.0/app-catalogs/teams-apps` | `v1.0/appCatalogs/teamsApps` |
| `v1.0/app-catalogs/teams-apps/app-definitions` | `v1.0/appCatalogs/teamsApps/appDefinitions` |
| `v1.0/applications/extension-properties` | `v1.0/applications/extensionProperties` |
| `v1.0/applications/federated-identity-credentials` | `v1.0/applications/federatedIdentityCredentials` |
| `v1.0/chats/installed-apps` | `v1.0/chats/installedApps` |
| `v1.0/chats/pinned-messages` | `v1.0/chats/pinnedMessages` |
| `v1.0/communications/calls/audio-routing-groups` | `v1.0/communications/calls/audioRoutingGroups` |
| `v1.0/device-app-management` | `v1.0/deviceAppManagement` |
| `v1.0/device-app-management/android-managed-app-protections` | `v1.0/deviceAppManagement/androidManagedAppProtections` |
| `v1.0/device-app-management/android-managed-app-protections/apps` | `v1.0/deviceAppManagement/androidManagedAppProtections/apps` |
| `v1.0/device-app-management/default-managed-app-protections` | `v1.0/deviceAppManagement/defaultManagedAppProtections` |
| `v1.0/device-app-management/default-managed-app-protections/apps` | `v1.0/deviceAppManagement/defaultManagedAppProtections/apps` |
| `v1.0/device-app-management/ios-managed-app-protections` | `v1.0/deviceAppManagement/iosManagedAppProtections` |
| `v1.0/device-app-management/ios-managed-app-protections/apps` | `v1.0/deviceAppManagement/iosManagedAppProtections/apps` |
| `v1.0/device-app-management/managed-app-registrations` | `v1.0/deviceAppManagement/managedAppRegistrations` |
| `v1.0/device-app-management/managed-app-registrations/operations` | `v1.0/deviceAppManagement/managedAppRegistrations/operations` |
| `v1.0/device-app-management/managed-e-books` | `v1.0/deviceAppManagement/managedEBooks` |
| `v1.0/device-app-management/managed-e-books/assignments` | `v1.0/deviceAppManagement/managedEBooks/assignments` |
| `v1.0/device-app-management/managed-e-books/device-states` | `v1.0/deviceAppManagement/managedEBooks/deviceStates` |
| `v1.0/device-app-management/managed-e-books/user-state-summary` | `v1.0/deviceAppManagement/managedEBooks/userStateSummary` |
| `v1.0/device-app-management/managed-e-books/user-state-summary/device-states` | `v1.0/deviceAppManagement/managedEBooks/userStateSummary/deviceStates` |
| `v1.0/device-app-management/mdm-windows-information-protection-policies` | `v1.0/deviceAppManagement/mdmWindowsInformationProtectionPolicies` |
| `v1.0/device-app-management/mdm-windows-information-protection-policies/exempt-app-locker-files` | `v1.0/deviceAppManagement/mdmWindowsInformationProtectionPolicies/exemptAppLockerFiles` |
| `v1.0/device-app-management/mdm-windows-information-protection-policies/protected-app-locker-files` | `v1.0/deviceAppManagement/mdmWindowsInformationProtectionPolicies/protectedAppLockerFiles` |
| `v1.0/device-app-management/mobile-app-categories` | `v1.0/deviceAppManagement/mobileAppCategories` |
| `v1.0/device-app-management/mobile-app-configurations` | `v1.0/deviceAppManagement/mobileAppConfigurations` |
| `v1.0/device-app-management/mobile-app-configurations/assignments` | `v1.0/deviceAppManagement/mobileAppConfigurations/assignments` |
| `v1.0/device-app-management/mobile-app-configurations/device-statuses` | `v1.0/deviceAppManagement/mobileAppConfigurations/deviceStatuses` |
| `v1.0/device-app-management/mobile-app-configurations/user-statuses` | `v1.0/deviceAppManagement/mobileAppConfigurations/userStatuses` |
| `v1.0/device-app-management/mobile-apps` | `v1.0/deviceAppManagement/mobileApps` |
| `v1.0/device-app-management/mobile-apps/assignments` | `v1.0/deviceAppManagement/mobileApps/assignments` |
| `v1.0/device-app-management/targeted-managed-app-configurations` | `v1.0/deviceAppManagement/targetedManagedAppConfigurations` |
| `v1.0/device-app-management/targeted-managed-app-configurations/apps` | `v1.0/deviceAppManagement/targetedManagedAppConfigurations/apps` |
| `v1.0/device-app-management/vpp-tokens` | `v1.0/deviceAppManagement/vppTokens` |
| `v1.0/device-app-management/windows-information-protection-policies` | `v1.0/deviceAppManagement/windowsInformationProtectionPolicies` |
| `v1.0/device-app-management/windows-information-protection-policies/exempt-app-locker-files` | `v1.0/deviceAppManagement/windowsInformationProtectionPolicies/exemptAppLockerFiles` |
| `v1.0/device-app-management/windows-information-protection-policies/protected-app-locker-files` | `v1.0/deviceAppManagement/windowsInformationProtectionPolicies/protectedAppLockerFiles` |
| `v1.0/device-management` | `v1.0/deviceManagement` |
| `v1.0/device-management/audit-events` | `v1.0/deviceManagement/auditEvents` |
| `v1.0/device-management/compliance-management-partners` | `v1.0/deviceManagement/complianceManagementPartners` |
| `v1.0/device-management/detected-apps` | `v1.0/deviceManagement/detectedApps` |
| `v1.0/device-management/device-categories` | `v1.0/deviceManagement/deviceCategories` |
| `v1.0/device-management/device-compliance-policies` | `v1.0/deviceManagement/deviceCompliancePolicies` |
| `v1.0/device-management/device-compliance-policies/assignments` | `v1.0/deviceManagement/deviceCompliancePolicies/assignments` |
| `v1.0/device-management/device-compliance-policies/device-setting-state-summaries` | `v1.0/deviceManagement/deviceCompliancePolicies/deviceSettingStateSummaries` |
| `v1.0/device-management/device-compliance-policies/device-statuses` | `v1.0/deviceManagement/deviceCompliancePolicies/deviceStatuses` |
| `v1.0/device-management/device-compliance-policies/scheduled-actions-for-rule` | `v1.0/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule` |
| `v1.0/device-management/device-compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations` | `v1.0/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/scheduledActionConfigurations` |
| `v1.0/device-management/device-compliance-policies/user-statuses` | `v1.0/deviceManagement/deviceCompliancePolicies/userStatuses` |
| `v1.0/device-management/device-compliance-policy-setting-state-summaries` | `v1.0/deviceManagement/deviceCompliancePolicySettingStateSummaries` |
| `v1.0/device-management/device-compliance-policy-setting-state-summaries/device-compliance-setting-states` | `v1.0/deviceManagement/deviceCompliancePolicySettingStateSummaries/deviceComplianceSettingStates` |
| `v1.0/device-management/device-configurations` | `v1.0/deviceManagement/deviceConfigurations` |
| `v1.0/device-management/device-configurations/assignments` | `v1.0/deviceManagement/deviceConfigurations/assignments` |
| `v1.0/device-management/device-configurations/device-setting-state-summaries` | `v1.0/deviceManagement/deviceConfigurations/deviceSettingStateSummaries` |
| `v1.0/device-management/device-configurations/device-statuses` | `v1.0/deviceManagement/deviceConfigurations/deviceStatuses` |
| `v1.0/device-management/device-configurations/user-statuses` | `v1.0/deviceManagement/deviceConfigurations/userStatuses` |
| `v1.0/device-management/device-enrollment-configurations` | `v1.0/deviceManagement/deviceEnrollmentConfigurations` |
| `v1.0/device-management/device-enrollment-configurations/assignments` | `v1.0/deviceManagement/deviceEnrollmentConfigurations/assignments` |
| `v1.0/device-management/device-management-partners` | `v1.0/deviceManagement/deviceManagementPartners` |
| `v1.0/device-management/exchange-connectors` | `v1.0/deviceManagement/exchangeConnectors` |
| `v1.0/device-management/imported-windows-autopilot-device-identities` | `v1.0/deviceManagement/importedWindowsAutopilotDeviceIdentities` |
| `v1.0/device-management/ios-update-statuses` | `v1.0/deviceManagement/iosUpdateStatuses` |
| `v1.0/device-management/managed-devices` | `v1.0/deviceManagement/managedDevices` |
| `v1.0/device-management/mobile-app-troubleshooting-events` | `v1.0/deviceManagement/mobileAppTroubleshootingEvents` |
| `v1.0/device-management/mobile-app-troubleshooting-events/app-log-collection-requests` | `v1.0/deviceManagement/mobileAppTroubleshootingEvents/appLogCollectionRequests` |
| `v1.0/device-management/mobile-threat-defense-connectors` | `v1.0/deviceManagement/mobileThreatDefenseConnectors` |
| `v1.0/device-management/notification-message-templates` | `v1.0/deviceManagement/notificationMessageTemplates` |
| `v1.0/device-management/notification-message-templates/localized-notification-messages` | `v1.0/deviceManagement/notificationMessageTemplates/localizedNotificationMessages` |
| `v1.0/device-management/remote-assistance-partners` | `v1.0/deviceManagement/remoteAssistancePartners` |
| `v1.0/device-management/reports` | `v1.0/deviceManagement/reports` |
| `v1.0/device-management/reports/export-jobs` | `v1.0/deviceManagement/reports/exportJobs` |
| `v1.0/device-management/resource-operations` | `v1.0/deviceManagement/resourceOperations` |
| `v1.0/device-management/role-assignments` | `v1.0/deviceManagement/roleAssignments` |
| `v1.0/device-management/role-definitions` | `v1.0/deviceManagement/roleDefinitions` |
| `v1.0/device-management/role-definitions/role-assignments` | `v1.0/deviceManagement/roleDefinitions/roleAssignments` |
| `v1.0/device-management/terms-and-conditions` | `v1.0/deviceManagement/termsAndConditions` |
| `v1.0/device-management/terms-and-conditions/acceptance-statuses` | `v1.0/deviceManagement/termsAndConditions/acceptanceStatuses` |
| `v1.0/device-management/terms-and-conditions/assignments` | `v1.0/deviceManagement/termsAndConditions/assignments` |
| `v1.0/device-management/troubleshooting-events` | `v1.0/deviceManagement/troubleshootingEvents` |
| `v1.0/device-management/virtual-endpoint` | `v1.0/deviceManagement/virtualEndpoint` |
| `v1.0/device-management/virtual-endpoint/device-images` | `v1.0/deviceManagement/virtualEndpoint/deviceImages` |
| `v1.0/device-management/virtual-endpoint/on-premises-connections` | `v1.0/deviceManagement/virtualEndpoint/onPremisesConnections` |
| `v1.0/device-management/virtual-endpoint/provisioning-policies` | `v1.0/deviceManagement/virtualEndpoint/provisioningPolicies` |
| `v1.0/device-management/virtual-endpoint/user-settings` | `v1.0/deviceManagement/virtualEndpoint/userSettings` |
| `v1.0/device-management/windows-autopilot-device-identities` | `v1.0/deviceManagement/windowsAutopilotDeviceIdentities` |
| `v1.0/device-management/windows-information-protection-app-learning-summaries` | `v1.0/deviceManagement/windowsInformationProtectionAppLearningSummaries` |
| `v1.0/device-management/windows-information-protection-network-learning-summaries` | `v1.0/deviceManagement/windowsInformationProtectionNetworkLearningSummaries` |
| `v1.0/device-management/windows-malware-information` | `v1.0/deviceManagement/windowsMalwareInformation` |
| `v1.0/device-management/windows-malware-information/device-malware-states` | `v1.0/deviceManagement/windowsMalwareInformation/deviceMalwareStates` |
| `v1.0/directory/administrative-units` | `v1.0/directory/administrativeUnits` |
| `v1.0/directory/administrative-units/scoped-role-members` | `v1.0/directory/administrativeUnits/scopedRoleMembers` |
| `v1.0/directory/public-key-infrastructure` | `v1.0/directory/publicKeyInfrastructure` |
| `v1.0/directory/public-key-infrastructure/certificate-based-auth-configurations` | `v1.0/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations` |
| `v1.0/directory/public-key-infrastructure/certificate-based-auth-configurations/certificate-authorities` | `v1.0/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/certificateAuthorities` |
| `v1.0/directory/tenant-governance` | `v1.0/directory/tenantGovernance` |
| `v1.0/directory/tenant-governance/governance-invitations` | `v1.0/directory/tenantGovernance/governanceInvitations` |
| `v1.0/directory/tenant-governance/governance-policy-templates` | `v1.0/directory/tenantGovernance/governancePolicyTemplates` |
| `v1.0/domains/federation-configuration` | `v1.0/domains/federationConfiguration` |
| `v1.0/education/classes/assignment-categories` | `v1.0/education/classes/assignmentCategories` |
| `v1.0/education/classes/assignment-settings` | `v1.0/education/classes/assignmentSettings` |
| `v1.0/education/classes/assignment-settings/grading-schemes` | `v1.0/education/classes/assignmentSettings/gradingSchemes` |
| `v1.0/employee-experience` | `v1.0/employeeExperience` |
| `v1.0/employee-experience/communities` | `v1.0/employeeExperience/communities` |
| `v1.0/employee-experience/learning-providers` | `v1.0/employeeExperience/learningProviders` |
| `v1.0/employee-experience/learning-providers/learning-course-activities` | `v1.0/employeeExperience/learningProviders/learningCourseActivities` |
| `v1.0/group-lifecycle-policies` | `v1.0/groupLifecyclePolicies` |
| `v1.0/group-settings` | `v1.0/groupSettings` |
| `v1.0/groups/app-role-assignments` | `v1.0/groups/appRoleAssignments` |
| `v1.0/groups/calendar/calendar-permissions` | `v1.0/groups/calendar/calendarPermissions` |
| `v1.0/identity-governance` | `v1.0/identityGovernance` |
| `v1.0/identity-governance/access-reviews` | `v1.0/identityGovernance/accessReviews` |
| `v1.0/identity-governance/access-reviews/definitions` | `v1.0/identityGovernance/accessReviews/definitions` |
| `v1.0/identity-governance/entitlement-management` | `v1.0/identityGovernance/entitlementManagement` |
| `v1.0/identity-governance/entitlement-management/access-packages` | `v1.0/identityGovernance/entitlementManagement/accessPackages` |
| `v1.0/identity-governance/entitlement-management/access-packages/resource-role-scopes` | `v1.0/identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes` |
| `v1.0/identity-governance/entitlement-management/assignment-policies` | `v1.0/identityGovernance/entitlementManagement/assignmentPolicies` |
| `v1.0/identity-governance/entitlement-management/assignment-requests` | `v1.0/identityGovernance/entitlementManagement/assignmentRequests` |
| `v1.0/identity-governance/entitlement-management/catalogs` | `v1.0/identityGovernance/entitlementManagement/catalogs` |
| `v1.0/identity-governance/entitlement-management/catalogs/resources` | `v1.0/identityGovernance/entitlementManagement/catalogs/resources` |
| `v1.0/identity-governance/entitlement-management/catalogs/resources/upload-sessions` | `v1.0/identityGovernance/entitlementManagement/catalogs/resources/uploadSessions` |
| `v1.0/identity-governance/entitlement-management/connected-organizations` | `v1.0/identityGovernance/entitlementManagement/connectedOrganizations` |
| `v1.0/identity-governance/entitlement-management/external-origin-resource-connectors` | `v1.0/identityGovernance/entitlementManagement/externalOriginResourceConnectors` |
| `v1.0/identity-governance/lifecycle-workflows` | `v1.0/identityGovernance/lifecycleWorkflows` |
| `v1.0/identity-governance/lifecycle-workflows/custom-task-extensions` | `v1.0/identityGovernance/lifecycleWorkflows/customTaskExtensions` |
| `v1.0/identity-governance/lifecycle-workflows/workflows` | `v1.0/identityGovernance/lifecycleWorkflows/workflows` |
| `v1.0/identity-governance/privileged-access` | `v1.0/identityGovernance/privilegedAccess` |
| `v1.0/identity-governance/privileged-access/custom-extensions` | `v1.0/identityGovernance/privilegedAccess/customExtensions` |
| `v1.0/identity-governance/terms-of-use` | `v1.0/identityGovernance/termsOfUse` |
| `v1.0/identity-governance/terms-of-use/agreements` | `v1.0/identityGovernance/termsOfUse/agreements` |
| `v1.0/identity-providers` | `v1.0/identityProviders` |
| `v1.0/identity/api-connectors` | `v1.0/identity/apiConnectors` |
| `v1.0/identity/authentication-event-listeners` | `v1.0/identity/authenticationEventListeners` |
| `v1.0/identity/authentication-events-flows` | `v1.0/identity/authenticationEventsFlows` |
| `v1.0/identity/b2x-user-flows` | `v1.0/identity/b2xUserFlows` |
| `v1.0/identity/b2x-user-flows/user-attribute-assignments` | `v1.0/identity/b2xUserFlows/userAttributeAssignments` |
| `v1.0/identity/conditional-access` | `v1.0/identity/conditionalAccess` |
| `v1.0/identity/conditional-access/authentication-strength` | `v1.0/identity/conditionalAccess/authenticationStrength` |
| `v1.0/identity/conditional-access/authentication-strength/policies` | `v1.0/identity/conditionalAccess/authenticationStrength/policies` |
| `v1.0/identity/conditional-access/authentication-strength/policies/combination-configurations` | `v1.0/identity/conditionalAccess/authenticationStrength/policies/combinationConfigurations` |
| `v1.0/identity/conditional-access/policies` | `v1.0/identity/conditionalAccess/policies` |
| `v1.0/identity/custom-authentication-extensions` | `v1.0/identity/customAuthenticationExtensions` |
| `v1.0/identity/identity-providers` | `v1.0/identity/identityProviders` |
| `v1.0/identity/risk-prevention` | `v1.0/identity/riskPrevention` |
| `v1.0/identity/risk-prevention/fraud-protection-providers` | `v1.0/identity/riskPrevention/fraudProtectionProviders` |
| `v1.0/identity/risk-prevention/web-application-firewall-providers` | `v1.0/identity/riskPrevention/webApplicationFirewallProviders` |
| `v1.0/identity/user-flow-attributes` | `v1.0/identity/userFlowAttributes` |
| `v1.0/identity/verified-id` | `v1.0/identity/verifiedId` |
| `v1.0/identity/verified-id/profiles` | `v1.0/identity/verifiedId/profiles` |
| `v1.0/me/calendar-groups` | `v1.0/me/calendarGroups` |
| `v1.0/me/calendar-groups/calendars` | `v1.0/me/calendarGroups/calendars` |
| `v1.0/me/calendar-groups/calendars/events` | `v1.0/me/calendarGroups/calendars/events` |
| `v1.0/me/contact-folders` | `v1.0/me/contactFolders` |
| `v1.0/me/contact-folders/contacts` | `v1.0/me/contactFolders/contacts` |
| `v1.0/me/inference-classification` | `v1.0/me/inferenceClassification` |
| `v1.0/me/inference-classification/overrides` | `v1.0/me/inferenceClassification/overrides` |
| `v1.0/me/mail-folders` | `v1.0/me/mailFolders` |
| `v1.0/me/mail-folders/messages` | `v1.0/me/mailFolders/messages` |
| `v1.0/me/online-meetings` | `v1.0/me/onlineMeetings` |
| `v1.0/me/outlook/master-categories` | `v1.0/me/outlook/masterCategories` |
| `v1.0/me/settings/work-hours-and-locations` | `v1.0/me/settings/workHoursAndLocations` |
| `v1.0/me/settings/work-hours-and-locations/occurrences` | `v1.0/me/settings/workHoursAndLocations/occurrences` |
| `v1.0/me/settings/work-hours-and-locations/recurrences` | `v1.0/me/settings/workHoursAndLocations/recurrences` |
| `v1.0/me/todo/lists/tasks/checklist-items` | `v1.0/me/todo/lists/tasks/checklistItems` |
| `v1.0/me/todo/lists/tasks/linked-resources` | `v1.0/me/todo/lists/tasks/linkedResources` |
| `v1.0/oauth2-permission-grants` | `v1.0/oauth2PermissionGrants` |
| `v1.0/policies/activity-based-timeout-policies` | `v1.0/policies/activityBasedTimeoutPolicies` |
| `v1.0/policies/app-management-policies` | `v1.0/policies/appManagementPolicies` |
| `v1.0/policies/authentication-strength-policies` | `v1.0/policies/authenticationStrengthPolicies` |
| `v1.0/policies/claims-mapping-policies` | `v1.0/policies/claimsMappingPolicies` |
| `v1.0/policies/cross-tenant-access-policy` | `v1.0/policies/crossTenantAccessPolicy` |
| `v1.0/policies/cross-tenant-access-policy/partners` | `v1.0/policies/crossTenantAccessPolicy/partners` |
| `v1.0/policies/cross-tenant-access-policy/partners/m365-capabilities` | `v1.0/policies/crossTenantAccessPolicy/partners/m365Capabilities` |
| `v1.0/policies/feature-rollout-policies` | `v1.0/policies/featureRolloutPolicies` |
| `v1.0/policies/home-realm-discovery-policies` | `v1.0/policies/homeRealmDiscoveryPolicies` |
| `v1.0/policies/permission-grant-policies` | `v1.0/policies/permissionGrantPolicies` |
| `v1.0/policies/permission-grant-policies/excludes` | `v1.0/policies/permissionGrantPolicies/excludes` |
| `v1.0/policies/permission-grant-policies/includes` | `v1.0/policies/permissionGrantPolicies/includes` |
| `v1.0/policies/token-issuance-policies` | `v1.0/policies/tokenIssuancePolicies` |
| `v1.0/policies/token-lifetime-policies` | `v1.0/policies/tokenLifetimePolicies` |
| `v1.0/print/printers/task-triggers` | `v1.0/print/printers/taskTriggers` |
| `v1.0/print/task-definitions` | `v1.0/print/taskDefinitions` |
| `v1.0/role-management` | `v1.0/roleManagement` |
| `v1.0/role-management/directory` | `v1.0/roleManagement/directory` |
| `v1.0/role-management/directory/role-assignments` | `v1.0/roleManagement/directory/roleAssignments` |
| `v1.0/role-management/directory/role-definitions` | `v1.0/roleManagement/directory/roleDefinitions` |
| `v1.0/role-management/entitlement-management` | `v1.0/roleManagement/entitlementManagement` |
| `v1.0/role-management/entitlement-management/role-assignments` | `v1.0/roleManagement/entitlementManagement/roleAssignments` |
| `v1.0/schema-extensions` | `v1.0/schemaExtensions` |
| `v1.0/security/attack-simulation` | `v1.0/security/attackSimulation` |
| `v1.0/security/attack-simulation/simulations` | `v1.0/security/attackSimulation/simulations` |
| `v1.0/security/cases/ediscovery-cases` | `v1.0/security/cases/ediscoveryCases` |
| `v1.0/security/cases/ediscovery-cases/case-members` | `v1.0/security/cases/ediscoveryCases/caseMembers` |
| `v1.0/security/cases/ediscovery-cases/custodians` | `v1.0/security/cases/ediscoveryCases/custodians` |
| `v1.0/security/cases/ediscovery-cases/custodians/site-sources` | `v1.0/security/cases/ediscoveryCases/custodians/siteSources` |
| `v1.0/security/cases/ediscovery-cases/custodians/unified-group-sources` | `v1.0/security/cases/ediscoveryCases/custodians/unifiedGroupSources` |
| `v1.0/security/cases/ediscovery-cases/custodians/user-sources` | `v1.0/security/cases/ediscoveryCases/custodians/userSources` |
| `v1.0/security/cases/ediscovery-cases/review-sets` | `v1.0/security/cases/ediscoveryCases/reviewSets` |
| `v1.0/security/cases/ediscovery-cases/review-sets/queries` | `v1.0/security/cases/ediscoveryCases/reviewSets/queries` |
| `v1.0/security/cases/ediscovery-cases/searches` | `v1.0/security/cases/ediscoveryCases/searches` |
| `v1.0/security/cases/ediscovery-cases/tags` | `v1.0/security/cases/ediscoveryCases/tags` |
| `v1.0/security/labels/retention-labels` | `v1.0/security/labels/retentionLabels` |
| `v1.0/security/triggers/retention-events` | `v1.0/security/triggers/retentionEvents` |
| `v1.0/service-principals` | `v1.0/servicePrincipals` |
| `v1.0/service-principals/app-role-assigned-to` | `v1.0/servicePrincipals/appRoleAssignedTo` |
| `v1.0/service-principals/app-role-assignments` | `v1.0/servicePrincipals/appRoleAssignments` |
| `v1.0/service-principals/delegated-permission-classifications` | `v1.0/servicePrincipals/delegatedPermissionClassifications` |
| `v1.0/service-principals/remote-desktop-security-configuration` | `v1.0/servicePrincipals/remoteDesktopSecurityConfiguration` |
| `v1.0/service-principals/remote-desktop-security-configuration/approved-client-apps` | `v1.0/servicePrincipals/remoteDesktopSecurityConfiguration/approvedClientApps` |
| `v1.0/service-principals/synchronization` | `v1.0/servicePrincipals/synchronization` |
| `v1.0/service-principals/synchronization/jobs` | `v1.0/servicePrincipals/synchronization/jobs` |
| `v1.0/sites/content-types` | `v1.0/sites/contentTypes` |
| `v1.0/sites/content-types/columns` | `v1.0/sites/contentTypes/columns` |
| `v1.0/sites/lists/content-types` | `v1.0/sites/lists/contentTypes` |
| `v1.0/sites/lists/content-types/columns` | `v1.0/sites/lists/contentTypes/columns` |
| `v1.0/sites/lists/items/document-set-versions` | `v1.0/sites/lists/items/documentSetVersions` |
| `v1.0/sites/term-store` | `v1.0/sites/termStore` |
| `v1.0/sites/term-store/groups` | `v1.0/sites/termStore/groups` |
| `v1.0/sites/term-store/sets` | `v1.0/sites/termStore/sets` |
| `v1.0/solutions/backup-restore` | `v1.0/solutions/backupRestore` |
| `v1.0/solutions/backup-restore/exchange-restore-sessions` | `v1.0/solutions/backupRestore/exchangeRestoreSessions` |
| `v1.0/solutions/backup-restore/exchange-restore-sessions/mailbox-restore-artifacts-bulk-addition-requests` | `v1.0/solutions/backupRestore/exchangeRestoreSessions/mailboxRestoreArtifactsBulkAdditionRequests` |
| `v1.0/solutions/backup-restore/one-drive-for-business-restore-sessions` | `v1.0/solutions/backupRestore/oneDriveForBusinessRestoreSessions` |
| `v1.0/solutions/backup-restore/one-drive-for-business-restore-sessions/drive-restore-artifacts-bulk-addition-requests` | `v1.0/solutions/backupRestore/oneDriveForBusinessRestoreSessions/driveRestoreArtifactsBulkAdditionRequests` |
| `v1.0/solutions/backup-restore/service-apps` | `v1.0/solutions/backupRestore/serviceApps` |
| `v1.0/solutions/backup-restore/share-point-restore-sessions` | `v1.0/solutions/backupRestore/sharePointRestoreSessions` |
| `v1.0/solutions/backup-restore/share-point-restore-sessions/site-restore-artifacts-bulk-addition-requests` | `v1.0/solutions/backupRestore/sharePointRestoreSessions/siteRestoreArtifactsBulkAdditionRequests` |
| `v1.0/solutions/booking-businesses` | `v1.0/solutions/bookingBusinesses` |
| `v1.0/solutions/booking-businesses/appointments` | `v1.0/solutions/bookingBusinesses/appointments` |
| `v1.0/solutions/booking-businesses/custom-questions` | `v1.0/solutions/bookingBusinesses/customQuestions` |
| `v1.0/solutions/booking-businesses/customers` | `v1.0/solutions/bookingBusinesses/customers` |
| `v1.0/solutions/booking-businesses/services` | `v1.0/solutions/bookingBusinesses/services` |
| `v1.0/solutions/booking-businesses/staff-members` | `v1.0/solutions/bookingBusinesses/staffMembers` |
| `v1.0/solutions/virtual-events` | `v1.0/solutions/virtualEvents` |
| `v1.0/solutions/virtual-events/townhalls` | `v1.0/solutions/virtualEvents/townhalls` |
| `v1.0/solutions/virtual-events/townhalls/presenters` | `v1.0/solutions/virtualEvents/townhalls/presenters` |
| `v1.0/solutions/virtual-events/townhalls/registration-configuration` | `v1.0/solutions/virtualEvents/townhalls/registrationConfiguration` |
| `v1.0/solutions/virtual-events/townhalls/registration-configuration/questions` | `v1.0/solutions/virtualEvents/townhalls/registrationConfiguration/questions` |
| `v1.0/solutions/virtual-events/webinars` | `v1.0/solutions/virtualEvents/webinars` |
| `v1.0/solutions/virtual-events/webinars/presenters` | `v1.0/solutions/virtualEvents/webinars/presenters` |
| `v1.0/solutions/virtual-events/webinars/registration-configuration` | `v1.0/solutions/virtualEvents/webinars/registrationConfiguration` |
| `v1.0/solutions/virtual-events/webinars/registration-configuration/questions` | `v1.0/solutions/virtualEvents/webinars/registrationConfiguration/questions` |
| `v1.0/storage/file-storage` | `v1.0/storage/fileStorage` |
| `v1.0/storage/file-storage/container-types` | `v1.0/storage/fileStorage/containerTypes` |
| `v1.0/storage/file-storage/containers` | `v1.0/storage/fileStorage/containers` |
| `v1.0/storage/file-storage/containers/columns` | `v1.0/storage/fileStorage/containers/columns` |
| `v1.0/storage/file-storage/containers/migration-jobs` | `v1.0/storage/fileStorage/containers/migrationJobs` |
| `v1.0/storage/file-storage/containers/permissions` | `v1.0/storage/fileStorage/containers/permissions` |
| `v1.0/storage/file-storage/containers/share-point-groups` | `v1.0/storage/fileStorage/containers/sharePointGroups` |
| `v1.0/storage/file-storage/containers/share-point-groups/members` | `v1.0/storage/fileStorage/containers/sharePointGroups/members` |
| `v1.0/teams/installed-apps` | `v1.0/teams/installedApps` |
| `v1.0/teams/schedule/time-off-requests` | `v1.0/teams/schedule/timeOffRequests` |
| `v1.0/teamwork/workforce-integrations` | `v1.0/teamwork/workforceIntegrations` |
| `v1.0/tenant-relationships` | `v1.0/tenantRelationships` |
| `v1.0/tenant-relationships/multi-tenant-organization` | `v1.0/tenantRelationships/multiTenantOrganization` |
| `v1.0/tenant-relationships/multi-tenant-organization/tenants` | `v1.0/tenantRelationships/multiTenantOrganization/tenants` |
| `v1.0/users/app-role-assignments` | `v1.0/users/appRoleAssignments` |
| `v1.0/users/authentication/email-methods` | `v1.0/users/authentication/emailMethods` |
| `v1.0/users/authentication/phone-methods` | `v1.0/users/authentication/phoneMethods` |
| `v1.0/users/calendar-groups` | `v1.0/users/calendarGroups` |
| `v1.0/users/calendar-groups/calendars` | `v1.0/users/calendarGroups/calendars` |
| `v1.0/users/calendar-groups/calendars/events` | `v1.0/users/calendarGroups/calendars/events` |
| `v1.0/users/calendar/calendar-permissions` | `v1.0/users/calendar/calendarPermissions` |
| `v1.0/users/contact-folders` | `v1.0/users/contactFolders` |
| `v1.0/users/contact-folders/contacts` | `v1.0/users/contactFolders/contacts` |
| `v1.0/users/inference-classification` | `v1.0/users/inferenceClassification` |
| `v1.0/users/inference-classification/overrides` | `v1.0/users/inferenceClassification/overrides` |
| `v1.0/users/mail-folders` | `v1.0/users/mailFolders` |
| `v1.0/users/mail-folders/messages` | `v1.0/users/mailFolders/messages` |
| `v1.0/users/online-meetings` | `v1.0/users/onlineMeetings` |
| `v1.0/users/outlook/master-categories` | `v1.0/users/outlook/masterCategories` |
| `v1.0/users/settings/work-hours-and-locations` | `v1.0/users/settings/workHoursAndLocations` |
| `v1.0/users/settings/work-hours-and-locations/occurrences` | `v1.0/users/settings/workHoursAndLocations/occurrences` |
| `v1.0/users/settings/work-hours-and-locations/recurrences` | `v1.0/users/settings/workHoursAndLocations/recurrences` |
| `v1.0/users/teamwork/installed-apps` | `v1.0/users/teamwork/installedApps` |
| `v1.0/users/todo/lists/tasks/checklist-items` | `v1.0/users/todo/lists/tasks/checklistItems` |
| `v1.0/users/todo/lists/tasks/linked-resources` | `v1.0/users/todo/lists/tasks/linkedResources` |

## Module sources and arguments

Paths are relative to the generated catalog root. Each arrow is old → new.

### `v1.0/admin/configuration-management/configuration-monitors` → `v1.0/admin/configurationManagement/configurationMonitors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/admin/edge/internet-explorer-mode/site-lists` → `v1.0/admin/edge/internetExplorerMode/siteLists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `published_by` → `publishedBy` (Graph `publishedBy`, property, renamed).
- `published_date_time` → `publishedDateTime` (Graph `publishedDateTime`, property, renamed).
- `shared_cookies` → `sharedCookies` (Graph `sharedCookies`, property, renamed).

### `v1.0/admin/edge/internet-explorer-mode/site-lists/shared-cookies` → `v1.0/admin/edge/internetExplorerMode/siteLists/sharedCookies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `host_only` → `hostOnly` (Graph `hostOnly`, property, renamed).
- `host_or_domain` → `hostOrDomain` (Graph `hostOrDomain`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `source_environment` → `sourceEnvironment` (Graph `sourceEnvironment`, property, renamed).
- `browser_site_list_id` → `browserSiteList-id` (Graph `browserSiteList-id`, url_parameter, renamed).

### `v1.0/admin/edge/internet-explorer-mode/site-lists/sites` → `v1.0/admin/edge/internetExplorerMode/siteLists/sites`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_redirect` → `allowRedirect` (Graph `allowRedirect`, property, renamed).
- `compatibility_mode` → `compatibilityMode` (Graph `compatibilityMode`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `merge_type` → `mergeType` (Graph `mergeType`, property, renamed).
- `target_environment` → `targetEnvironment` (Graph `targetEnvironment`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `browser_site_list_id` → `browserSiteList-id` (Graph `browserSiteList-id`, url_parameter, renamed).

### `v1.0/admin/people/profile-card-properties` → `v1.0/admin/people/profileCardProperties`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `directory_property_name` → `directoryPropertyName` (Graph `directoryPropertyName`, property, renamed).
- `is_visible` → `isVisible` (Graph `isVisible`, property, renamed).

### `v1.0/admin/people/profile-property-settings` → `v1.0/admin/people/profilePropertySettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `prioritized_source_urls` → `prioritizedSourceUrls` (Graph `prioritizedSourceUrls`, property, renamed).

### `v1.0/app-catalogs/teams-apps` → `v1.0/appCatalogs/teamsApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_definitions` → `appDefinitions` (Graph `appDefinitions`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).

### `v1.0/app-catalogs/teams-apps/app-definitions` → `v1.0/appCatalogs/teamsApps/appDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `publishing_state` → `publishingState` (Graph `publishingState`, property, renamed).
- `short_description` → `shortDescription` (Graph `shortDescription`, property, renamed).
- `teams_app_id_2` → `teamsAppId` (Graph `teamsAppId`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `teams_app_id` → `teamsApp-id` (Graph `teamsApp-id`, url_parameter, renamed).

### `v1.0/applications` → `v1.0/applications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `add_ins` → `addIns` (Graph `addIns`, property, renamed).
- `app_management_policies` → `appManagementPolicies` (Graph `appManagementPolicies`, property, renamed).
- `app_roles` → `appRoles` (Graph `appRoles`, property, renamed).
- `authentication_behaviors` → `authenticationBehaviors` (Graph `authenticationBehaviors`, property, renamed).
- `default_redirect_uri` → `defaultRedirectUri` (Graph `defaultRedirectUri`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `disabled_by_microsoft_status` → `disabledByMicrosoftStatus` (Graph `disabledByMicrosoftStatus`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `federated_identity_credentials` → `federatedIdentityCredentials` (Graph `federatedIdentityCredentials`, property, renamed).
- `group_membership_claims` → `groupMembershipClaims` (Graph `groupMembershipClaims`, property, renamed).
- `home_realm_discovery_policies` → `homeRealmDiscoveryPolicies` (Graph `homeRealmDiscoveryPolicies`, property, renamed).
- `identifier_uris` → `identifierUris` (Graph `identifierUris`, property, renamed).
- `is_device_only_auth_supported` → `isDeviceOnlyAuthSupported` (Graph `isDeviceOnlyAuthSupported`, property, renamed).
- `is_disabled` → `isDisabled` (Graph `isDisabled`, property, renamed).
- `is_fallback_public_client` → `isFallbackPublicClient` (Graph `isFallbackPublicClient`, property, renamed).
- `key_credentials` → `keyCredentials` (Graph `keyCredentials`, property, renamed).
- `manager_applications` → `managerApplications` (Graph `managerApplications`, property, renamed).
- `native_authentication_apis_enabled` → `nativeAuthenticationApisEnabled` (Graph `nativeAuthenticationApisEnabled`, property, renamed).
- `oauth2_require_post_response` → `oauth2RequirePostResponse` (Graph `oauth2RequirePostResponse`, property, renamed).
- `optional_claims` → `optionalClaims` (Graph `optionalClaims`, property, renamed).
- `parental_control_settings` → `parentalControlSettings` (Graph `parentalControlSettings`, property, renamed).
- `password_credentials` → `passwordCredentials` (Graph `passwordCredentials`, property, renamed).
- `public_client` → `publicClient` (Graph `publicClient`, property, renamed).
- `request_signature_verification` → `requestSignatureVerification` (Graph `requestSignatureVerification`, property, renamed).
- `required_resource_access` → `requiredResourceAccess` (Graph `requiredResourceAccess`, property, renamed).
- `saml_metadata_url` → `samlMetadataUrl` (Graph `samlMetadataUrl`, property, renamed).
- `service_management_reference` → `serviceManagementReference` (Graph `serviceManagementReference`, property, renamed).
- `service_principal_lock_configuration` → `servicePrincipalLockConfiguration` (Graph `servicePrincipalLockConfiguration`, property, renamed).
- `sign_in_audience` → `signInAudience` (Graph `signInAudience`, property, renamed).
- `token_encryption_key_id` → `tokenEncryptionKeyId` (Graph `tokenEncryptionKeyId`, property, renamed).
- `token_issuance_policies` → `tokenIssuancePolicies` (Graph `tokenIssuancePolicies`, property, renamed).
- `token_lifetime_policies` → `tokenLifetimePolicies` (Graph `tokenLifetimePolicies`, property, renamed).
- `verified_publisher` → `verifiedPublisher` (Graph `verifiedPublisher`, property, renamed).

### `v1.0/applications/extension-properties` → `v1.0/applications/extensionProperties`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `data_type` → `dataType` (Graph `dataType`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `is_multi_valued` → `isMultiValued` (Graph `isMultiValued`, property, renamed).
- `target_objects` → `targetObjects` (Graph `targetObjects`, property, renamed).
- `application_id` → `application-id` (Graph `application-id`, url_parameter, renamed).

### `v1.0/applications/federated-identity-credentials` → `v1.0/applications/federatedIdentityCredentials`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `application_id` → `application-id` (Graph `application-id`, url_parameter, renamed).

### `v1.0/chats` → `v1.0/chats`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `chat_type` → `chatType` (Graph `chatType`, property, renamed).
- `installed_apps` → `installedApps` (Graph `installedApps`, property, renamed).
- `last_message_preview` → `lastMessagePreview` (Graph `lastMessagePreview`, property, renamed).
- `migration_mode` → `migrationMode` (Graph `migrationMode`, property, renamed).
- `original_created_date_time` → `originalCreatedDateTime` (Graph `originalCreatedDateTime`, property, renamed).
- `permission_grants` → `permissionGrants` (Graph `permissionGrants`, property, renamed).
- `pinned_messages` → `pinnedMessages` (Graph `pinnedMessages`, property, renamed).
- `targeted_messages` → `targetedMessages` (Graph `targetedMessages`, property, renamed).

### `v1.0/chats/installed-apps` → `v1.0/chats/installedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `consented_permission_set` → `consentedPermissionSet` (Graph `consentedPermissionSet`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_definition` → `teamsAppDefinition` (Graph `teamsAppDefinition`, property, renamed).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `v1.0/chats/members` → `v1.0/chats/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `visible_history_start_date_time` → `visibleHistoryStartDateTime` (Graph `visibleHistoryStartDateTime`, property, renamed).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `v1.0/chats/pinned-messages` → `v1.0/chats/pinnedMessages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `v1.0/chats/tabs` → `v1.0/chats/tabs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `v1.0/communications/calls` → `v1.0/communications/calls`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `audio_routing_groups` → `audioRoutingGroups` (Graph `audioRoutingGroups`, property, renamed).
- `call_chain_id` → `callChainId` (Graph `callChainId`, property, renamed).
- `call_options` → `callOptions` (Graph `callOptions`, property, renamed).
- `callback_uri` → `callbackUri` (Graph `callbackUri`, property, renamed).
- `chat_info` → `chatInfo` (Graph `chatInfo`, property, renamed).
- `content_sharing_sessions` → `contentSharingSessions` (Graph `contentSharingSessions`, property, renamed).
- `incoming_context` → `incomingContext` (Graph `incomingContext`, property, renamed).
- `media_config` → `mediaConfig` (Graph `mediaConfig`, property, renamed).
- `meeting_info` → `meetingInfo` (Graph `meetingInfo`, property, renamed).
- `my_participant_id` → `myParticipantId` (Graph `myParticipantId`, property, renamed).
- `requested_modalities` → `requestedModalities` (Graph `requestedModalities`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).
- `tone_info` → `toneInfo` (Graph `toneInfo`, property, renamed).

### `v1.0/communications/calls/audio-routing-groups` → `v1.0/communications/calls/audioRoutingGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `routing_mode` → `routingMode` (Graph `routingMode`, property, renamed).
- `call_id` → `call-id` (Graph `call-id`, url_parameter, renamed).

### `v1.0/device-app-management/android-managed-app-protections` → `v1.0/deviceAppManagement/androidManagedAppProtections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_data_storage_locations` → `allowedDataStorageLocations` (Graph `allowedDataStorageLocations`, property, renamed).
- `allowed_inbound_data_transfer_sources` → `allowedInboundDataTransferSources` (Graph `allowedInboundDataTransferSources`, property, renamed).
- `allowed_outbound_clipboard_sharing_level` → `allowedOutboundClipboardSharingLevel` (Graph `allowedOutboundClipboardSharingLevel`, property, renamed).
- `allowed_outbound_data_transfer_destinations` → `allowedOutboundDataTransferDestinations` (Graph `allowedOutboundDataTransferDestinations`, property, renamed).
- `contact_sync_blocked` → `contactSyncBlocked` (Graph `contactSyncBlocked`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_browser_display_name` → `customBrowserDisplayName` (Graph `customBrowserDisplayName`, property, renamed).
- `custom_browser_package_id` → `customBrowserPackageId` (Graph `customBrowserPackageId`, property, renamed).
- `data_backup_blocked` → `dataBackupBlocked` (Graph `dataBackupBlocked`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `device_compliance_required` → `deviceComplianceRequired` (Graph `deviceComplianceRequired`, property, renamed).
- `disable_app_encryption_if_device_encryption_is_enabled` → `disableAppEncryptionIfDeviceEncryptionIsEnabled` (Graph `disableAppEncryptionIfDeviceEncryptionIsEnabled`, property, renamed).
- `disable_app_pin_if_device_pin_is_set` → `disableAppPinIfDevicePinIsSet` (Graph `disableAppPinIfDevicePinIsSet`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `encrypt_app_data` → `encryptAppData` (Graph `encryptAppData`, property, renamed).
- `fingerprint_blocked` → `fingerprintBlocked` (Graph `fingerprintBlocked`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_browser` → `managedBrowser` (Graph `managedBrowser`, property, renamed).
- `managed_browser_to_open_links_required` → `managedBrowserToOpenLinksRequired` (Graph `managedBrowserToOpenLinksRequired`, property, renamed).
- `maximum_pin_retries` → `maximumPinRetries` (Graph `maximumPinRetries`, property, renamed).
- `minimum_pin_length` → `minimumPinLength` (Graph `minimumPinLength`, property, renamed).
- `minimum_required_app_version` → `minimumRequiredAppVersion` (Graph `minimumRequiredAppVersion`, property, renamed).
- `minimum_required_os_version` → `minimumRequiredOsVersion` (Graph `minimumRequiredOsVersion`, property, renamed).
- `minimum_required_patch_version` → `minimumRequiredPatchVersion` (Graph `minimumRequiredPatchVersion`, property, renamed).
- `minimum_warning_app_version` → `minimumWarningAppVersion` (Graph `minimumWarningAppVersion`, property, renamed).
- `minimum_warning_os_version` → `minimumWarningOsVersion` (Graph `minimumWarningOsVersion`, property, renamed).
- `minimum_warning_patch_version` → `minimumWarningPatchVersion` (Graph `minimumWarningPatchVersion`, property, renamed).
- `organizational_credentials_required` → `organizationalCredentialsRequired` (Graph `organizationalCredentialsRequired`, property, renamed).
- `period_before_pin_reset` → `periodBeforePinReset` (Graph `periodBeforePinReset`, property, renamed).
- `period_offline_before_access_check` → `periodOfflineBeforeAccessCheck` (Graph `periodOfflineBeforeAccessCheck`, property, renamed).
- `period_offline_before_wipe_is_enforced` → `periodOfflineBeforeWipeIsEnforced` (Graph `periodOfflineBeforeWipeIsEnforced`, property, renamed).
- `period_online_before_access_check` → `periodOnlineBeforeAccessCheck` (Graph `periodOnlineBeforeAccessCheck`, property, renamed).
- `pin_character_set` → `pinCharacterSet` (Graph `pinCharacterSet`, property, renamed).
- `pin_required` → `pinRequired` (Graph `pinRequired`, property, renamed).
- `print_blocked` → `printBlocked` (Graph `printBlocked`, property, renamed).
- `save_as_blocked` → `saveAsBlocked` (Graph `saveAsBlocked`, property, renamed).
- `screen_capture_blocked` → `screenCaptureBlocked` (Graph `screenCaptureBlocked`, property, renamed).
- `simple_pin_blocked` → `simplePinBlocked` (Graph `simplePinBlocked`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-app-management/android-managed-app-protections/apps` → `v1.0/deviceAppManagement/androidManagedAppProtections/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `android_managed_app_protection_id` → `androidManagedAppProtection-id` (Graph `androidManagedAppProtection-id`, url_parameter, renamed).

### `v1.0/device-app-management/default-managed-app-protections` → `v1.0/deviceAppManagement/defaultManagedAppProtections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_data_storage_locations` → `allowedDataStorageLocations` (Graph `allowedDataStorageLocations`, property, renamed).
- `allowed_inbound_data_transfer_sources` → `allowedInboundDataTransferSources` (Graph `allowedInboundDataTransferSources`, property, renamed).
- `allowed_outbound_clipboard_sharing_level` → `allowedOutboundClipboardSharingLevel` (Graph `allowedOutboundClipboardSharingLevel`, property, renamed).
- `allowed_outbound_data_transfer_destinations` → `allowedOutboundDataTransferDestinations` (Graph `allowedOutboundDataTransferDestinations`, property, renamed).
- `app_data_encryption_type` → `appDataEncryptionType` (Graph `appDataEncryptionType`, property, renamed).
- `contact_sync_blocked` → `contactSyncBlocked` (Graph `contactSyncBlocked`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_settings` → `customSettings` (Graph `customSettings`, property, renamed).
- `data_backup_blocked` → `dataBackupBlocked` (Graph `dataBackupBlocked`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `device_compliance_required` → `deviceComplianceRequired` (Graph `deviceComplianceRequired`, property, renamed).
- `disable_app_encryption_if_device_encryption_is_enabled` → `disableAppEncryptionIfDeviceEncryptionIsEnabled` (Graph `disableAppEncryptionIfDeviceEncryptionIsEnabled`, property, renamed).
- `disable_app_pin_if_device_pin_is_set` → `disableAppPinIfDevicePinIsSet` (Graph `disableAppPinIfDevicePinIsSet`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `encrypt_app_data` → `encryptAppData` (Graph `encryptAppData`, property, renamed).
- `face_id_blocked` → `faceIdBlocked` (Graph `faceIdBlocked`, property, renamed).
- `fingerprint_blocked` → `fingerprintBlocked` (Graph `fingerprintBlocked`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_browser` → `managedBrowser` (Graph `managedBrowser`, property, renamed).
- `managed_browser_to_open_links_required` → `managedBrowserToOpenLinksRequired` (Graph `managedBrowserToOpenLinksRequired`, property, renamed).
- `maximum_pin_retries` → `maximumPinRetries` (Graph `maximumPinRetries`, property, renamed).
- `minimum_pin_length` → `minimumPinLength` (Graph `minimumPinLength`, property, renamed).
- `minimum_required_app_version` → `minimumRequiredAppVersion` (Graph `minimumRequiredAppVersion`, property, renamed).
- `minimum_required_os_version` → `minimumRequiredOsVersion` (Graph `minimumRequiredOsVersion`, property, renamed).
- `minimum_required_patch_version` → `minimumRequiredPatchVersion` (Graph `minimumRequiredPatchVersion`, property, renamed).
- `minimum_required_sdk_version` → `minimumRequiredSdkVersion` (Graph `minimumRequiredSdkVersion`, property, renamed).
- `minimum_warning_app_version` → `minimumWarningAppVersion` (Graph `minimumWarningAppVersion`, property, renamed).
- `minimum_warning_os_version` → `minimumWarningOsVersion` (Graph `minimumWarningOsVersion`, property, renamed).
- `minimum_warning_patch_version` → `minimumWarningPatchVersion` (Graph `minimumWarningPatchVersion`, property, renamed).
- `organizational_credentials_required` → `organizationalCredentialsRequired` (Graph `organizationalCredentialsRequired`, property, renamed).
- `period_before_pin_reset` → `periodBeforePinReset` (Graph `periodBeforePinReset`, property, renamed).
- `period_offline_before_access_check` → `periodOfflineBeforeAccessCheck` (Graph `periodOfflineBeforeAccessCheck`, property, renamed).
- `period_offline_before_wipe_is_enforced` → `periodOfflineBeforeWipeIsEnforced` (Graph `periodOfflineBeforeWipeIsEnforced`, property, renamed).
- `period_online_before_access_check` → `periodOnlineBeforeAccessCheck` (Graph `periodOnlineBeforeAccessCheck`, property, renamed).
- `pin_character_set` → `pinCharacterSet` (Graph `pinCharacterSet`, property, renamed).
- `pin_required` → `pinRequired` (Graph `pinRequired`, property, renamed).
- `print_blocked` → `printBlocked` (Graph `printBlocked`, property, renamed).
- `save_as_blocked` → `saveAsBlocked` (Graph `saveAsBlocked`, property, renamed).
- `screen_capture_blocked` → `screenCaptureBlocked` (Graph `screenCaptureBlocked`, property, renamed).
- `simple_pin_blocked` → `simplePinBlocked` (Graph `simplePinBlocked`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-app-management/default-managed-app-protections/apps` → `v1.0/deviceAppManagement/defaultManagedAppProtections/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `default_managed_app_protection_id` → `defaultManagedAppProtection-id` (Graph `defaultManagedAppProtection-id`, url_parameter, renamed).

### `v1.0/device-app-management/ios-managed-app-protections` → `v1.0/deviceAppManagement/iosManagedAppProtections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_data_storage_locations` → `allowedDataStorageLocations` (Graph `allowedDataStorageLocations`, property, renamed).
- `allowed_inbound_data_transfer_sources` → `allowedInboundDataTransferSources` (Graph `allowedInboundDataTransferSources`, property, renamed).
- `allowed_outbound_clipboard_sharing_level` → `allowedOutboundClipboardSharingLevel` (Graph `allowedOutboundClipboardSharingLevel`, property, renamed).
- `allowed_outbound_data_transfer_destinations` → `allowedOutboundDataTransferDestinations` (Graph `allowedOutboundDataTransferDestinations`, property, renamed).
- `app_data_encryption_type` → `appDataEncryptionType` (Graph `appDataEncryptionType`, property, renamed).
- `contact_sync_blocked` → `contactSyncBlocked` (Graph `contactSyncBlocked`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_browser_protocol` → `customBrowserProtocol` (Graph `customBrowserProtocol`, property, renamed).
- `data_backup_blocked` → `dataBackupBlocked` (Graph `dataBackupBlocked`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `device_compliance_required` → `deviceComplianceRequired` (Graph `deviceComplianceRequired`, property, renamed).
- `disable_app_pin_if_device_pin_is_set` → `disableAppPinIfDevicePinIsSet` (Graph `disableAppPinIfDevicePinIsSet`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `face_id_blocked` → `faceIdBlocked` (Graph `faceIdBlocked`, property, renamed).
- `fingerprint_blocked` → `fingerprintBlocked` (Graph `fingerprintBlocked`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_browser` → `managedBrowser` (Graph `managedBrowser`, property, renamed).
- `managed_browser_to_open_links_required` → `managedBrowserToOpenLinksRequired` (Graph `managedBrowserToOpenLinksRequired`, property, renamed).
- `maximum_pin_retries` → `maximumPinRetries` (Graph `maximumPinRetries`, property, renamed).
- `minimum_pin_length` → `minimumPinLength` (Graph `minimumPinLength`, property, renamed).
- `minimum_required_app_version` → `minimumRequiredAppVersion` (Graph `minimumRequiredAppVersion`, property, renamed).
- `minimum_required_os_version` → `minimumRequiredOsVersion` (Graph `minimumRequiredOsVersion`, property, renamed).
- `minimum_required_sdk_version` → `minimumRequiredSdkVersion` (Graph `minimumRequiredSdkVersion`, property, renamed).
- `minimum_warning_app_version` → `minimumWarningAppVersion` (Graph `minimumWarningAppVersion`, property, renamed).
- `minimum_warning_os_version` → `minimumWarningOsVersion` (Graph `minimumWarningOsVersion`, property, renamed).
- `organizational_credentials_required` → `organizationalCredentialsRequired` (Graph `organizationalCredentialsRequired`, property, renamed).
- `period_before_pin_reset` → `periodBeforePinReset` (Graph `periodBeforePinReset`, property, renamed).
- `period_offline_before_access_check` → `periodOfflineBeforeAccessCheck` (Graph `periodOfflineBeforeAccessCheck`, property, renamed).
- `period_offline_before_wipe_is_enforced` → `periodOfflineBeforeWipeIsEnforced` (Graph `periodOfflineBeforeWipeIsEnforced`, property, renamed).
- `period_online_before_access_check` → `periodOnlineBeforeAccessCheck` (Graph `periodOnlineBeforeAccessCheck`, property, renamed).
- `pin_character_set` → `pinCharacterSet` (Graph `pinCharacterSet`, property, renamed).
- `pin_required` → `pinRequired` (Graph `pinRequired`, property, renamed).
- `print_blocked` → `printBlocked` (Graph `printBlocked`, property, renamed).
- `save_as_blocked` → `saveAsBlocked` (Graph `saveAsBlocked`, property, renamed).
- `simple_pin_blocked` → `simplePinBlocked` (Graph `simplePinBlocked`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-app-management/ios-managed-app-protections/apps` → `v1.0/deviceAppManagement/iosManagedAppProtections/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `ios_managed_app_protection_id` → `iosManagedAppProtection-id` (Graph `iosManagedAppProtection-id`, url_parameter, renamed).

### `v1.0/device-app-management/managed-app-registrations/operations` → `v1.0/deviceAppManagement/managedAppRegistrations/operations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `managed_app_registration_id` → `managedAppRegistration-id` (Graph `managedAppRegistration-id`, url_parameter, renamed).

### `v1.0/device-app-management/managed-e-books` → `v1.0/deviceAppManagement/managedEBooks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_states` → `deviceStates` (Graph `deviceStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `information_url` → `informationUrl` (Graph `informationUrl`, property, renamed).
- `install_summary` → `installSummary` (Graph `installSummary`, property, renamed).
- `large_cover` → `largeCover` (Graph `largeCover`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `privacy_information_url` → `privacyInformationUrl` (Graph `privacyInformationUrl`, property, renamed).
- `published_date_time` → `publishedDateTime` (Graph `publishedDateTime`, property, renamed).
- `user_state_summary` → `userStateSummary` (Graph `userStateSummary`, property, renamed).

### `v1.0/device-app-management/managed-e-books/assignments` → `v1.0/deviceAppManagement/managedEBooks/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `install_intent` → `installIntent` (Graph `installIntent`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).

### `v1.0/device-app-management/managed-e-books/device-states` → `v1.0/deviceAppManagement/managedEBooks/deviceStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `install_state` → `installState` (Graph `installState`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `os_description` → `osDescription` (Graph `osDescription`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).

### `v1.0/device-app-management/managed-e-books/user-state-summary` → `v1.0/deviceAppManagement/managedEBooks/userStateSummary`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_states` → `deviceStates` (Graph `deviceStates`, property, renamed).
- `failed_device_count` → `failedDeviceCount` (Graph `failedDeviceCount`, property, renamed).
- `installed_device_count` → `installedDeviceCount` (Graph `installedDeviceCount`, property, renamed).
- `not_installed_device_count` → `notInstalledDeviceCount` (Graph `notInstalledDeviceCount`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).

### `v1.0/device-app-management/managed-e-books/user-state-summary/device-states` → `v1.0/deviceAppManagement/managedEBooks/userStateSummary/deviceStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `install_state` → `installState` (Graph `installState`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `os_description` → `osDescription` (Graph `osDescription`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).
- `user_install_state_summary_id` → `userInstallStateSummary-id` (Graph `userInstallStateSummary-id`, url_parameter, renamed).

### `v1.0/device-app-management/mdm-windows-information-protection-policies` → `v1.0/deviceAppManagement/mdmWindowsInformationProtectionPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `azure_rights_management_services_allowed` → `azureRightsManagementServicesAllowed` (Graph `azureRightsManagementServicesAllowed`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `data_recovery_certificate` → `dataRecoveryCertificate` (Graph `dataRecoveryCertificate`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforcement_level` → `enforcementLevel` (Graph `enforcementLevel`, property, renamed).
- `enterprise_domain` → `enterpriseDomain` (Graph `enterpriseDomain`, property, renamed).
- `enterprise_ip_ranges` → `enterpriseIPRanges` (Graph `enterpriseIPRanges`, property, renamed).
- `enterprise_ip_ranges_are_authoritative` → `enterpriseIPRangesAreAuthoritative` (Graph `enterpriseIPRangesAreAuthoritative`, property, renamed).
- `enterprise_internal_proxy_servers` → `enterpriseInternalProxyServers` (Graph `enterpriseInternalProxyServers`, property, renamed).
- `enterprise_network_domain_names` → `enterpriseNetworkDomainNames` (Graph `enterpriseNetworkDomainNames`, property, renamed).
- `enterprise_protected_domain_names` → `enterpriseProtectedDomainNames` (Graph `enterpriseProtectedDomainNames`, property, renamed).
- `enterprise_proxied_domains` → `enterpriseProxiedDomains` (Graph `enterpriseProxiedDomains`, property, renamed).
- `enterprise_proxy_servers` → `enterpriseProxyServers` (Graph `enterpriseProxyServers`, property, renamed).
- `enterprise_proxy_servers_are_authoritative` → `enterpriseProxyServersAreAuthoritative` (Graph `enterpriseProxyServersAreAuthoritative`, property, renamed).
- `exempt_app_locker_files` → `exemptAppLockerFiles` (Graph `exemptAppLockerFiles`, property, renamed).
- `exempt_apps` → `exemptApps` (Graph `exemptApps`, property, renamed).
- `icons_visible` → `iconsVisible` (Graph `iconsVisible`, property, renamed).
- `indexing_encrypted_stores_or_items_blocked` → `indexingEncryptedStoresOrItemsBlocked` (Graph `indexingEncryptedStoresOrItemsBlocked`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `neutral_domain_resources` → `neutralDomainResources` (Graph `neutralDomainResources`, property, renamed).
- `protected_app_locker_files` → `protectedAppLockerFiles` (Graph `protectedAppLockerFiles`, property, renamed).
- `protected_apps` → `protectedApps` (Graph `protectedApps`, property, renamed).
- `protection_under_lock_config_required` → `protectionUnderLockConfigRequired` (Graph `protectionUnderLockConfigRequired`, property, renamed).
- `revoke_on_unenroll_disabled` → `revokeOnUnenrollDisabled` (Graph `revokeOnUnenrollDisabled`, property, renamed).
- `rights_management_services_template_id` → `rightsManagementServicesTemplateId` (Graph `rightsManagementServicesTemplateId`, property, renamed).
- `smb_auto_encrypted_file_extensions` → `smbAutoEncryptedFileExtensions` (Graph `smbAutoEncryptedFileExtensions`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-app-management/mdm-windows-information-protection-policies/exempt-app-locker-files` → `v1.0/deviceAppManagement/mdmWindowsInformationProtectionPolicies/exemptAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `mdm_windows_information_protection_policy_id` → `mdmWindowsInformationProtectionPolicy-id` (Graph `mdmWindowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `v1.0/device-app-management/mdm-windows-information-protection-policies/protected-app-locker-files` → `v1.0/deviceAppManagement/mdmWindowsInformationProtectionPolicies/protectedAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `mdm_windows_information_protection_policy_id` → `mdmWindowsInformationProtectionPolicy-id` (Graph `mdmWindowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `v1.0/device-app-management/mobile-app-categories` → `v1.0/deviceAppManagement/mobileAppCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/device-app-management/mobile-app-configurations` → `v1.0/deviceAppManagement/mobileAppConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_status_summary` → `deviceStatusSummary` (Graph `deviceStatusSummary`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `targeted_mobile_apps` → `targetedMobileApps` (Graph `targetedMobileApps`, property, renamed).
- `user_status_summary` → `userStatusSummary` (Graph `userStatusSummary`, property, renamed).
- `user_statuses` → `userStatuses` (Graph `userStatuses`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-app-management/mobile-app-configurations/assignments` → `v1.0/deviceAppManagement/mobileAppConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `managed_device_mobile_app_configuration_id` → `managedDeviceMobileAppConfiguration-id` (Graph `managedDeviceMobileAppConfiguration-id`, url_parameter, renamed).

### `v1.0/device-app-management/mobile-app-configurations/device-statuses` → `v1.0/deviceAppManagement/mobileAppConfigurations/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `managed_device_mobile_app_configuration_id` → `managedDeviceMobileAppConfiguration-id` (Graph `managedDeviceMobileAppConfiguration-id`, url_parameter, renamed).

### `v1.0/device-app-management/mobile-app-configurations/user-statuses` → `v1.0/deviceAppManagement/mobileAppConfigurations/userStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `devices_count` → `devicesCount` (Graph `devicesCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `managed_device_mobile_app_configuration_id` → `managedDeviceMobileAppConfiguration-id` (Graph `managedDeviceMobileAppConfiguration-id`, url_parameter, renamed).

### `v1.0/device-app-management/mobile-apps` → `v1.0/deviceAppManagement/mobileApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `information_url` → `informationUrl` (Graph `informationUrl`, property, renamed).
- `is_featured` → `isFeatured` (Graph `isFeatured`, property, renamed).
- `large_icon` → `largeIcon` (Graph `largeIcon`, property, renamed).
- `privacy_information_url` → `privacyInformationUrl` (Graph `privacyInformationUrl`, property, renamed).

### `v1.0/device-app-management/mobile-apps/assignments` → `v1.0/deviceAppManagement/mobileApps/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_id` → `mobileApp-id` (Graph `mobileApp-id`, url_parameter, renamed).

### `v1.0/device-app-management/targeted-managed-app-configurations` → `v1.0/deviceAppManagement/targetedManagedAppConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_settings` → `customSettings` (Graph `customSettings`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-app-management/targeted-managed-app-configurations/apps` → `v1.0/deviceAppManagement/targetedManagedAppConfigurations/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `targeted_managed_app_configuration_id` → `targetedManagedAppConfiguration-id` (Graph `targetedManagedAppConfiguration-id`, url_parameter, renamed).

### `v1.0/device-app-management/vpp-tokens` → `v1.0/deviceAppManagement/vppTokens`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `apple_id` → `appleId` (Graph `appleId`, property, renamed).
- `automatically_update_apps` → `automaticallyUpdateApps` (Graph `automaticallyUpdateApps`, property, renamed).
- `country_or_region` → `countryOrRegion` (Graph `countryOrRegion`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `last_sync_status` → `lastSyncStatus` (Graph `lastSyncStatus`, property, renamed).
- `organization_name` → `organizationName` (Graph `organizationName`, property, renamed).
- `vpp_token_account_type` → `vppTokenAccountType` (Graph `vppTokenAccountType`, property, renamed).

### `v1.0/device-app-management/windows-information-protection-policies` → `v1.0/deviceAppManagement/windowsInformationProtectionPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `azure_rights_management_services_allowed` → `azureRightsManagementServicesAllowed` (Graph `azureRightsManagementServicesAllowed`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `data_recovery_certificate` → `dataRecoveryCertificate` (Graph `dataRecoveryCertificate`, property, renamed).
- `days_without_contact_before_unenroll` → `daysWithoutContactBeforeUnenroll` (Graph `daysWithoutContactBeforeUnenroll`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforcement_level` → `enforcementLevel` (Graph `enforcementLevel`, property, renamed).
- `enterprise_domain` → `enterpriseDomain` (Graph `enterpriseDomain`, property, renamed).
- `enterprise_ip_ranges` → `enterpriseIPRanges` (Graph `enterpriseIPRanges`, property, renamed).
- `enterprise_ip_ranges_are_authoritative` → `enterpriseIPRangesAreAuthoritative` (Graph `enterpriseIPRangesAreAuthoritative`, property, renamed).
- `enterprise_internal_proxy_servers` → `enterpriseInternalProxyServers` (Graph `enterpriseInternalProxyServers`, property, renamed).
- `enterprise_network_domain_names` → `enterpriseNetworkDomainNames` (Graph `enterpriseNetworkDomainNames`, property, renamed).
- `enterprise_protected_domain_names` → `enterpriseProtectedDomainNames` (Graph `enterpriseProtectedDomainNames`, property, renamed).
- `enterprise_proxied_domains` → `enterpriseProxiedDomains` (Graph `enterpriseProxiedDomains`, property, renamed).
- `enterprise_proxy_servers` → `enterpriseProxyServers` (Graph `enterpriseProxyServers`, property, renamed).
- `enterprise_proxy_servers_are_authoritative` → `enterpriseProxyServersAreAuthoritative` (Graph `enterpriseProxyServersAreAuthoritative`, property, renamed).
- `exempt_app_locker_files` → `exemptAppLockerFiles` (Graph `exemptAppLockerFiles`, property, renamed).
- `exempt_apps` → `exemptApps` (Graph `exemptApps`, property, renamed).
- `icons_visible` → `iconsVisible` (Graph `iconsVisible`, property, renamed).
- `indexing_encrypted_stores_or_items_blocked` → `indexingEncryptedStoresOrItemsBlocked` (Graph `indexingEncryptedStoresOrItemsBlocked`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `mdm_enrollment_url` → `mdmEnrollmentUrl` (Graph `mdmEnrollmentUrl`, property, renamed).
- `minutes_of_inactivity_before_device_lock` → `minutesOfInactivityBeforeDeviceLock` (Graph `minutesOfInactivityBeforeDeviceLock`, property, renamed).
- `neutral_domain_resources` → `neutralDomainResources` (Graph `neutralDomainResources`, property, renamed).
- `number_of_past_pins_remembered` → `numberOfPastPinsRemembered` (Graph `numberOfPastPinsRemembered`, property, renamed).
- `password_maximum_attempt_count` → `passwordMaximumAttemptCount` (Graph `passwordMaximumAttemptCount`, property, renamed).
- `pin_expiration_days` → `pinExpirationDays` (Graph `pinExpirationDays`, property, renamed).
- `pin_lowercase_letters` → `pinLowercaseLetters` (Graph `pinLowercaseLetters`, property, renamed).
- `pin_minimum_length` → `pinMinimumLength` (Graph `pinMinimumLength`, property, renamed).
- `pin_special_characters` → `pinSpecialCharacters` (Graph `pinSpecialCharacters`, property, renamed).
- `pin_uppercase_letters` → `pinUppercaseLetters` (Graph `pinUppercaseLetters`, property, renamed).
- `protected_app_locker_files` → `protectedAppLockerFiles` (Graph `protectedAppLockerFiles`, property, renamed).
- `protected_apps` → `protectedApps` (Graph `protectedApps`, property, renamed).
- `protection_under_lock_config_required` → `protectionUnderLockConfigRequired` (Graph `protectionUnderLockConfigRequired`, property, renamed).
- `revoke_on_mdm_handoff_disabled` → `revokeOnMdmHandoffDisabled` (Graph `revokeOnMdmHandoffDisabled`, property, renamed).
- `revoke_on_unenroll_disabled` → `revokeOnUnenrollDisabled` (Graph `revokeOnUnenrollDisabled`, property, renamed).
- `rights_management_services_template_id` → `rightsManagementServicesTemplateId` (Graph `rightsManagementServicesTemplateId`, property, renamed).
- `smb_auto_encrypted_file_extensions` → `smbAutoEncryptedFileExtensions` (Graph `smbAutoEncryptedFileExtensions`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_hello_for_business_blocked` → `windowsHelloForBusinessBlocked` (Graph `windowsHelloForBusinessBlocked`, property, renamed).

### `v1.0/device-app-management/windows-information-protection-policies/exempt-app-locker-files` → `v1.0/deviceAppManagement/windowsInformationProtectionPolicies/exemptAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_information_protection_policy_id` → `windowsInformationProtectionPolicy-id` (Graph `windowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `v1.0/device-app-management/windows-information-protection-policies/protected-app-locker-files` → `v1.0/deviceAppManagement/windowsInformationProtectionPolicies/protectedAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_information_protection_policy_id` → `windowsInformationProtectionPolicy-id` (Graph `windowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `v1.0/device-management/audit-events` → `v1.0/deviceManagement/auditEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `activity_date_time` → `activityDateTime` (Graph `activityDateTime`, property, renamed).
- `activity_operation_type` → `activityOperationType` (Graph `activityOperationType`, property, renamed).
- `activity_result` → `activityResult` (Graph `activityResult`, property, renamed).
- `activity_type` → `activityType` (Graph `activityType`, property, renamed).
- `component_name` → `componentName` (Graph `componentName`, property, renamed).
- `correlation_id` → `correlationId` (Graph `correlationId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/device-management/compliance-management-partners` → `v1.0/deviceManagement/complianceManagementPartners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `android_enrollment_assignments` → `androidEnrollmentAssignments` (Graph `androidEnrollmentAssignments`, property, renamed).
- `android_onboarded` → `androidOnboarded` (Graph `androidOnboarded`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `ios_enrollment_assignments` → `iosEnrollmentAssignments` (Graph `iosEnrollmentAssignments`, property, renamed).
- `ios_onboarded` → `iosOnboarded` (Graph `iosOnboarded`, property, renamed).
- `last_heartbeat_date_time` → `lastHeartbeatDateTime` (Graph `lastHeartbeatDateTime`, property, renamed).
- `mac_os_enrollment_assignments` → `macOsEnrollmentAssignments` (Graph `macOsEnrollmentAssignments`, property, renamed).
- `mac_os_onboarded` → `macOsOnboarded` (Graph `macOsOnboarded`, property, renamed).
- `partner_state` → `partnerState` (Graph `partnerState`, property, renamed).

### `v1.0/device-management/detected-apps` → `v1.0/deviceManagement/detectedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_count` → `deviceCount` (Graph `deviceCount`, property, renamed).
- `managed_devices` → `managedDevices` (Graph `managedDevices`, property, renamed).

### `v1.0/device-management/device-categories` → `v1.0/deviceManagement/deviceCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/device-management/device-compliance-policies` → `v1.0/deviceManagement/deviceCompliancePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_setting_state_summaries` → `deviceSettingStateSummaries` (Graph `deviceSettingStateSummaries`, property, renamed).
- `device_status_overview` → `deviceStatusOverview` (Graph `deviceStatusOverview`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `scheduled_actions_for_rule` → `scheduledActionsForRule` (Graph `scheduledActionsForRule`, property, renamed).
- `user_status_overview` → `userStatusOverview` (Graph `userStatusOverview`, property, renamed).
- `user_statuses` → `userStatuses` (Graph `userStatuses`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-management/device-compliance-policies/assignments` → `v1.0/deviceManagement/deviceCompliancePolicies/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `v1.0/device-management/device-compliance-policies/device-setting-state-summaries` → `v1.0/deviceManagement/deviceCompliancePolicies/deviceSettingStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliant_device_count` → `compliantDeviceCount` (Graph `compliantDeviceCount`, property, renamed).
- `conflict_device_count` → `conflictDeviceCount` (Graph `conflictDeviceCount`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `instance_path` → `instancePath` (Graph `instancePath`, property, renamed).
- `non_compliant_device_count` → `nonCompliantDeviceCount` (Graph `nonCompliantDeviceCount`, property, renamed).
- `not_applicable_device_count` → `notApplicableDeviceCount` (Graph `notApplicableDeviceCount`, property, renamed).
- `remediated_device_count` → `remediatedDeviceCount` (Graph `remediatedDeviceCount`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `unknown_device_count` → `unknownDeviceCount` (Graph `unknownDeviceCount`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `v1.0/device-management/device-compliance-policies/device-statuses` → `v1.0/deviceManagement/deviceCompliancePolicies/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `v1.0/device-management/device-compliance-policies/scheduled-actions-for-rule` → `v1.0/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `rule_name` → `ruleName` (Graph `ruleName`, property, renamed).
- `scheduled_action_configurations` → `scheduledActionConfigurations` (Graph `scheduledActionConfigurations`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `v1.0/device-management/device-compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations` → `v1.0/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/scheduledActionConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_type` → `actionType` (Graph `actionType`, property, renamed).
- `grace_period_hours` → `gracePeriodHours` (Graph `gracePeriodHours`, property, renamed).
- `notification_message_cc_list` → `notificationMessageCCList` (Graph `notificationMessageCCList`, property, renamed).
- `notification_template_id` → `notificationTemplateId` (Graph `notificationTemplateId`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).
- `device_compliance_scheduled_action_for_rule_id` → `deviceComplianceScheduledActionForRule-id` (Graph `deviceComplianceScheduledActionForRule-id`, url_parameter, renamed).

### `v1.0/device-management/device-compliance-policies/user-statuses` → `v1.0/deviceManagement/deviceCompliancePolicies/userStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `devices_count` → `devicesCount` (Graph `devicesCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `v1.0/device-management/device-compliance-policy-setting-state-summaries` → `v1.0/deviceManagement/deviceCompliancePolicySettingStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliant_device_count` → `compliantDeviceCount` (Graph `compliantDeviceCount`, property, renamed).
- `conflict_device_count` → `conflictDeviceCount` (Graph `conflictDeviceCount`, property, renamed).
- `device_compliance_setting_states` → `deviceComplianceSettingStates` (Graph `deviceComplianceSettingStates`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `non_compliant_device_count` → `nonCompliantDeviceCount` (Graph `nonCompliantDeviceCount`, property, renamed).
- `not_applicable_device_count` → `notApplicableDeviceCount` (Graph `notApplicableDeviceCount`, property, renamed).
- `platform_type` → `platformType` (Graph `platformType`, property, renamed).
- `remediated_device_count` → `remediatedDeviceCount` (Graph `remediatedDeviceCount`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `unknown_device_count` → `unknownDeviceCount` (Graph `unknownDeviceCount`, property, renamed).

### `v1.0/device-management/device-compliance-policy-setting-state-summaries/device-compliance-setting-states` → `v1.0/deviceManagement/deviceCompliancePolicySettingStateSummaries/deviceComplianceSettingStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `user_email` → `userEmail` (Graph `userEmail`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_compliance_policy_setting_state_summary_id` → `deviceCompliancePolicySettingStateSummary-id` (Graph `deviceCompliancePolicySettingStateSummary-id`, url_parameter, renamed).

### `v1.0/device-management/device-configurations` → `v1.0/deviceManagement/deviceConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_setting_state_summaries` → `deviceSettingStateSummaries` (Graph `deviceSettingStateSummaries`, property, renamed).
- `device_status_overview` → `deviceStatusOverview` (Graph `deviceStatusOverview`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `user_status_overview` → `userStatusOverview` (Graph `userStatusOverview`, property, renamed).
- `user_statuses` → `userStatuses` (Graph `userStatuses`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-management/device-configurations/assignments` → `v1.0/deviceManagement/deviceConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `v1.0/device-management/device-configurations/device-setting-state-summaries` → `v1.0/deviceManagement/deviceConfigurations/deviceSettingStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliant_device_count` → `compliantDeviceCount` (Graph `compliantDeviceCount`, property, renamed).
- `conflict_device_count` → `conflictDeviceCount` (Graph `conflictDeviceCount`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `instance_path` → `instancePath` (Graph `instancePath`, property, renamed).
- `non_compliant_device_count` → `nonCompliantDeviceCount` (Graph `nonCompliantDeviceCount`, property, renamed).
- `not_applicable_device_count` → `notApplicableDeviceCount` (Graph `notApplicableDeviceCount`, property, renamed).
- `remediated_device_count` → `remediatedDeviceCount` (Graph `remediatedDeviceCount`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `unknown_device_count` → `unknownDeviceCount` (Graph `unknownDeviceCount`, property, renamed).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `v1.0/device-management/device-configurations/device-statuses` → `v1.0/deviceManagement/deviceConfigurations/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `v1.0/device-management/device-configurations/user-statuses` → `v1.0/deviceManagement/deviceConfigurations/userStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `devices_count` → `devicesCount` (Graph `devicesCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `v1.0/device-management/device-enrollment-configurations` → `v1.0/deviceManagement/deviceEnrollmentConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-management/device-enrollment-configurations/assignments` → `v1.0/deviceManagement/deviceEnrollmentConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_enrollment_configuration_id` → `deviceEnrollmentConfiguration-id` (Graph `deviceEnrollmentConfiguration-id`, url_parameter, renamed).

### `v1.0/device-management/device-management-partners` → `v1.0/deviceManagement/deviceManagementPartners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `groups_requiring_partner_enrollment` → `groupsRequiringPartnerEnrollment` (Graph `groupsRequiringPartnerEnrollment`, property, renamed).
- `is_configured` → `isConfigured` (Graph `isConfigured`, property, renamed).
- `last_heartbeat_date_time` → `lastHeartbeatDateTime` (Graph `lastHeartbeatDateTime`, property, renamed).
- `partner_app_type` → `partnerAppType` (Graph `partnerAppType`, property, renamed).
- `partner_state` → `partnerState` (Graph `partnerState`, property, renamed).
- `single_tenant_app_id` → `singleTenantAppId` (Graph `singleTenantAppId`, property, renamed).
- `when_partner_devices_will_be_marked_as_non_compliant_date_time` → `whenPartnerDevicesWillBeMarkedAsNonCompliantDateTime` (Graph `whenPartnerDevicesWillBeMarkedAsNonCompliantDateTime`, property, renamed).
- `when_partner_devices_will_be_removed_date_time` → `whenPartnerDevicesWillBeRemovedDateTime` (Graph `whenPartnerDevicesWillBeRemovedDateTime`, property, renamed).

### `v1.0/device-management/exchange-connectors` → `v1.0/deviceManagement/exchangeConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `connector_server_name` → `connectorServerName` (Graph `connectorServerName`, property, renamed).
- `exchange_alias` → `exchangeAlias` (Graph `exchangeAlias`, property, renamed).
- `exchange_connector_type` → `exchangeConnectorType` (Graph `exchangeConnectorType`, property, renamed).
- `exchange_organization` → `exchangeOrganization` (Graph `exchangeOrganization`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `primary_smtp_address` → `primarySmtpAddress` (Graph `primarySmtpAddress`, property, renamed).
- `server_name` → `serverName` (Graph `serverName`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-management/imported-windows-autopilot-device-identities` → `v1.0/deviceManagement/importedWindowsAutopilotDeviceIdentities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_user_principal_name` → `assignedUserPrincipalName` (Graph `assignedUserPrincipalName`, property, renamed).
- `group_tag` → `groupTag` (Graph `groupTag`, property, renamed).
- `hardware_identifier` → `hardwareIdentifier` (Graph `hardwareIdentifier`, property, renamed).
- `import_id` → `importId` (Graph `importId`, property, renamed).
- `product_key` → `productKey` (Graph `productKey`, property, renamed).
- `serial_number` → `serialNumber` (Graph `serialNumber`, property, renamed).

### `v1.0/device-management/ios-update-statuses` → `v1.0/deviceManagement/iosUpdateStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `install_status` → `installStatus` (Graph `installStatus`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `v1.0/device-management/managed-devices` → `v1.0/deviceManagement/managedDevices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_category` → `deviceCategory` (Graph `deviceCategory`, property, renamed).
- `device_compliance_policy_states` → `deviceCompliancePolicyStates` (Graph `deviceCompliancePolicyStates`, property, renamed).
- `device_configuration_states` → `deviceConfigurationStates` (Graph `deviceConfigurationStates`, property, renamed).
- `log_collection_requests` → `logCollectionRequests` (Graph `logCollectionRequests`, property, renamed).
- `managed_device_name` → `managedDeviceName` (Graph `managedDeviceName`, property, renamed).
- `managed_device_owner_type` → `managedDeviceOwnerType` (Graph `managedDeviceOwnerType`, property, renamed).

### `v1.0/device-management/mobile-app-troubleshooting-events` → `v1.0/deviceManagement/mobileAppTroubleshootingEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_log_collection_requests` → `appLogCollectionRequests` (Graph `appLogCollectionRequests`, property, renamed).

### `v1.0/device-management/mobile-app-troubleshooting-events/app-log-collection-requests` → `v1.0/deviceManagement/mobileAppTroubleshootingEvents/appLogCollectionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `custom_log_folders` → `customLogFolders` (Graph `customLogFolders`, property, renamed).
- `error_message` → `errorMessage` (Graph `errorMessage`, property, renamed).
- `mobile_app_troubleshooting_event_id` → `mobileAppTroubleshootingEvent-id` (Graph `mobileAppTroubleshootingEvent-id`, url_parameter, renamed).

### `v1.0/device-management/mobile-threat-defense-connectors` → `v1.0/deviceManagement/mobileThreatDefenseConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_partner_to_collect_ios_application_metadata` → `allowPartnerToCollectIOSApplicationMetadata` (Graph `allowPartnerToCollectIOSApplicationMetadata`, property, renamed).
- `allow_partner_to_collect_ios_personal_application_metadata` → `allowPartnerToCollectIOSPersonalApplicationMetadata` (Graph `allowPartnerToCollectIOSPersonalApplicationMetadata`, property, renamed).
- `android_device_blocked_on_missing_partner_data` → `androidDeviceBlockedOnMissingPartnerData` (Graph `androidDeviceBlockedOnMissingPartnerData`, property, renamed).
- `android_enabled` → `androidEnabled` (Graph `androidEnabled`, property, renamed).
- `android_mobile_application_management_enabled` → `androidMobileApplicationManagementEnabled` (Graph `androidMobileApplicationManagementEnabled`, property, renamed).
- `ios_device_blocked_on_missing_partner_data` → `iosDeviceBlockedOnMissingPartnerData` (Graph `iosDeviceBlockedOnMissingPartnerData`, property, renamed).
- `ios_enabled` → `iosEnabled` (Graph `iosEnabled`, property, renamed).
- `ios_mobile_application_management_enabled` → `iosMobileApplicationManagementEnabled` (Graph `iosMobileApplicationManagementEnabled`, property, renamed).
- `last_heartbeat_date_time` → `lastHeartbeatDateTime` (Graph `lastHeartbeatDateTime`, property, renamed).
- `microsoft_defender_for_endpoint_attach_enabled` → `microsoftDefenderForEndpointAttachEnabled` (Graph `microsoftDefenderForEndpointAttachEnabled`, property, renamed).
- `partner_state` → `partnerState` (Graph `partnerState`, property, renamed).
- `partner_unresponsiveness_threshold_in_days` → `partnerUnresponsivenessThresholdInDays` (Graph `partnerUnresponsivenessThresholdInDays`, property, renamed).
- `partner_unsupported_os_version_blocked` → `partnerUnsupportedOsVersionBlocked` (Graph `partnerUnsupportedOsVersionBlocked`, property, renamed).
- `windows_device_blocked_on_missing_partner_data` → `windowsDeviceBlockedOnMissingPartnerData` (Graph `windowsDeviceBlockedOnMissingPartnerData`, property, renamed).
- `windows_enabled` → `windowsEnabled` (Graph `windowsEnabled`, property, renamed).

### `v1.0/device-management/notification-message-templates` → `v1.0/deviceManagement/notificationMessageTemplates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `branding_options` → `brandingOptions` (Graph `brandingOptions`, property, renamed).
- `default_locale` → `defaultLocale` (Graph `defaultLocale`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `localized_notification_messages` → `localizedNotificationMessages` (Graph `localizedNotificationMessages`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `v1.0/device-management/notification-message-templates/localized-notification-messages` → `v1.0/deviceManagement/notificationMessageTemplates/localizedNotificationMessages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `is_default` → `isDefault` (Graph `isDefault`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `message_template` → `messageTemplate` (Graph `messageTemplate`, property, renamed).
- `notification_message_template_id` → `notificationMessageTemplate-id` (Graph `notificationMessageTemplate-id`, url_parameter, renamed).

### `v1.0/device-management/remote-assistance-partners` → `v1.0/deviceManagement/remoteAssistancePartners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_connection_date_time` → `lastConnectionDateTime` (Graph `lastConnectionDateTime`, property, renamed).
- `onboarding_status` → `onboardingStatus` (Graph `onboardingStatus`, property, renamed).
- `onboarding_url` → `onboardingUrl` (Graph `onboardingUrl`, property, renamed).

### `v1.0/device-management/reports/export-jobs` → `v1.0/deviceManagement/reports/exportJobs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `localization_type` → `localizationType` (Graph `localizationType`, property, renamed).
- `report_name` → `reportName` (Graph `reportName`, property, renamed).
- `request_date_time` → `requestDateTime` (Graph `requestDateTime`, property, renamed).
- `snapshot_id` → `snapshotId` (Graph `snapshotId`, property, renamed).

### `v1.0/device-management/resource-operations` → `v1.0/deviceManagement/resourceOperations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_name` → `actionName` (Graph `actionName`, property, renamed).
- `resource_name` → `resourceName` (Graph `resourceName`, property, renamed).

### `v1.0/device-management/role-assignments` → `v1.0/deviceManagement/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `resource_scopes` → `resourceScopes` (Graph `resourceScopes`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).

### `v1.0/device-management/role-definitions` → `v1.0/deviceManagement/roleDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_built_in` → `isBuiltIn` (Graph `isBuiltIn`, property, renamed).
- `role_assignments` → `roleAssignments` (Graph `roleAssignments`, property, renamed).
- `role_permissions` → `rolePermissions` (Graph `rolePermissions`, property, renamed).

### `v1.0/device-management/role-definitions/role-assignments` → `v1.0/deviceManagement/roleDefinitions/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `resource_scopes` → `resourceScopes` (Graph `resourceScopes`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).
- `role_definition_id` → `roleDefinition-id` (Graph `roleDefinition-id`, url_parameter, renamed).

### `v1.0/device-management/terms-and-conditions` → `v1.0/deviceManagement/termsAndConditions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `acceptance_statement` → `acceptanceStatement` (Graph `acceptanceStatement`, property, renamed).
- `acceptance_statuses` → `acceptanceStatuses` (Graph `acceptanceStatuses`, property, renamed).
- `body_text` → `bodyText` (Graph `bodyText`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/device-management/terms-and-conditions/acceptance-statuses` → `v1.0/deviceManagement/termsAndConditions/acceptanceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `accepted_date_time` → `acceptedDateTime` (Graph `acceptedDateTime`, property, renamed).
- `accepted_version` → `acceptedVersion` (Graph `acceptedVersion`, property, renamed).
- `terms_and_conditions` → `termsAndConditions` (Graph `termsAndConditions`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `terms_and_conditions_id` → `termsAndConditions-id` (Graph `termsAndConditions-id`, url_parameter, renamed).

### `v1.0/device-management/terms-and-conditions/assignments` → `v1.0/deviceManagement/termsAndConditions/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `terms_and_conditions_id` → `termsAndConditions-id` (Graph `termsAndConditions-id`, url_parameter, renamed).

### `v1.0/device-management/troubleshooting-events` → `v1.0/deviceManagement/troubleshootingEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `correlation_id` → `correlationId` (Graph `correlationId`, property, renamed).
- `event_date_time` → `eventDateTime` (Graph `eventDateTime`, property, renamed).

### `v1.0/device-management/virtual-endpoint/device-images` → `v1.0/deviceManagement/virtualEndpoint/deviceImages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `v1.0/device-management/virtual-endpoint/on-premises-connections` → `v1.0/deviceManagement/virtualEndpoint/onPremisesConnections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `ad_domain_name` → `adDomainName` (Graph `adDomainName`, property, renamed).
- `ad_domain_password` → `adDomainPassword` (Graph `adDomainPassword`, property, renamed).
- `ad_domain_username` → `adDomainUsername` (Graph `adDomainUsername`, property, renamed).
- `alternate_resource_url` → `alternateResourceUrl` (Graph `alternateResourceUrl`, property, renamed).
- `connection_type` → `connectionType` (Graph `connectionType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `health_check_status` → `healthCheckStatus` (Graph `healthCheckStatus`, property, renamed).
- `organizational_unit` → `organizationalUnit` (Graph `organizationalUnit`, property, renamed).
- `resource_group_id` → `resourceGroupId` (Graph `resourceGroupId`, property, renamed).
- `scope_ids` → `scopeIds` (Graph `scopeIds`, property, renamed).
- `subnet_id` → `subnetId` (Graph `subnetId`, property, renamed).
- `subscription_id` → `subscriptionId` (Graph `subscriptionId`, property, renamed).
- `virtual_network_id` → `virtualNetworkId` (Graph `virtualNetworkId`, property, renamed).

### `v1.0/device-management/virtual-endpoint/provisioning-policies` → `v1.0/deviceManagement/virtualEndpoint/provisioningPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cloud_pc_naming_template` → `cloudPcNamingTemplate` (Graph `cloudPcNamingTemplate`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `domain_join_configurations` → `domainJoinConfigurations` (Graph `domainJoinConfigurations`, property, renamed).
- `enable_single_sign_on` → `enableSingleSignOn` (Graph `enableSingleSignOn`, property, renamed).
- `image_display_name` → `imageDisplayName` (Graph `imageDisplayName`, property, renamed).
- `image_id` → `imageId` (Graph `imageId`, property, renamed).
- `image_type` → `imageType` (Graph `imageType`, property, renamed).
- `local_admin_enabled` → `localAdminEnabled` (Graph `localAdminEnabled`, property, renamed).
- `microsoft_managed_desktop` → `microsoftManagedDesktop` (Graph `microsoftManagedDesktop`, property, renamed).
- `provisioning_type` → `provisioningType` (Graph `provisioningType`, property, renamed).
- `windows_setting` → `windowsSetting` (Graph `windowsSetting`, property, renamed).

### `v1.0/device-management/virtual-endpoint/user-settings` → `v1.0/deviceManagement/virtualEndpoint/userSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `local_admin_enabled` → `localAdminEnabled` (Graph `localAdminEnabled`, property, renamed).
- `reset_enabled` → `resetEnabled` (Graph `resetEnabled`, property, renamed).
- `restore_point_setting` → `restorePointSetting` (Graph `restorePointSetting`, property, renamed).

### `v1.0/device-management/windows-autopilot-device-identities` → `v1.0/deviceManagement/windowsAutopilotDeviceIdentities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `addressable_user_name` → `addressableUserName` (Graph `addressableUserName`, property, renamed).
- `azure_active_directory_device_id` → `azureActiveDirectoryDeviceId` (Graph `azureActiveDirectoryDeviceId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrollment_state` → `enrollmentState` (Graph `enrollmentState`, property, renamed).
- `group_tag` → `groupTag` (Graph `groupTag`, property, renamed).
- `last_contacted_date_time` → `lastContactedDateTime` (Graph `lastContactedDateTime`, property, renamed).
- `managed_device_id` → `managedDeviceId` (Graph `managedDeviceId`, property, renamed).
- `product_key` → `productKey` (Graph `productKey`, property, renamed).
- `purchase_order_identifier` → `purchaseOrderIdentifier` (Graph `purchaseOrderIdentifier`, property, renamed).
- `resource_name` → `resourceName` (Graph `resourceName`, property, renamed).
- `serial_number` → `serialNumber` (Graph `serialNumber`, property, renamed).
- `sku_number` → `skuNumber` (Graph `skuNumber`, property, renamed).
- `system_family` → `systemFamily` (Graph `systemFamily`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `v1.0/device-management/windows-information-protection-app-learning-summaries` → `v1.0/deviceManagement/windowsInformationProtectionAppLearningSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `application_name` → `applicationName` (Graph `applicationName`, property, renamed).
- `application_type` → `applicationType` (Graph `applicationType`, property, renamed).
- `device_count` → `deviceCount` (Graph `deviceCount`, property, renamed).

### `v1.0/device-management/windows-information-protection-network-learning-summaries` → `v1.0/deviceManagement/windowsInformationProtectionNetworkLearningSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_count` → `deviceCount` (Graph `deviceCount`, property, renamed).

### `v1.0/device-management/windows-malware-information` → `v1.0/deviceManagement/windowsMalwareInformation`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information_url` → `additionalInformationUrl` (Graph `additionalInformationUrl`, property, renamed).
- `device_malware_states` → `deviceMalwareStates` (Graph `deviceMalwareStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_detection_date_time` → `lastDetectionDateTime` (Graph `lastDetectionDateTime`, property, renamed).

### `v1.0/device-management/windows-malware-information/device-malware-states` → `v1.0/deviceManagement/windowsMalwareInformation/deviceMalwareStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `detection_count` → `detectionCount` (Graph `detectionCount`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `execution_state` → `executionState` (Graph `executionState`, property, renamed).
- `initial_detection_date_time` → `initialDetectionDateTime` (Graph `initialDetectionDateTime`, property, renamed).
- `last_state_change_date_time` → `lastStateChangeDateTime` (Graph `lastStateChangeDateTime`, property, renamed).
- `threat_state` → `threatState` (Graph `threatState`, property, renamed).
- `windows_malware_information_id` → `windowsMalwareInformation-id` (Graph `windowsMalwareInformation-id`, url_parameter, renamed).

### `v1.0/devices` → `v1.0/devices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `alternative_security_ids` → `alternativeSecurityIds` (Graph `alternativeSecurityIds`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `device_category` → `deviceCategory` (Graph `deviceCategory`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_metadata` → `deviceMetadata` (Graph `deviceMetadata`, property, renamed).
- `device_ownership` → `deviceOwnership` (Graph `deviceOwnership`, property, renamed).
- `device_version` → `deviceVersion` (Graph `deviceVersion`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrollment_profile_name` → `enrollmentProfileName` (Graph `enrollmentProfileName`, property, renamed).
- `enrollment_type` → `enrollmentType` (Graph `enrollmentType`, property, renamed).
- `is_managed` → `isManaged` (Graph `isManaged`, property, renamed).
- `is_rooted` → `isRooted` (Graph `isRooted`, property, renamed).
- `management_type` → `managementType` (Graph `managementType`, property, renamed).
- `operating_system` → `operatingSystem` (Graph `operatingSystem`, property, renamed).
- `operating_system_version` → `operatingSystemVersion` (Graph `operatingSystemVersion`, property, renamed).
- `physical_ids` → `physicalIds` (Graph `physicalIds`, property, renamed).
- `profile_type` → `profileType` (Graph `profileType`, property, renamed).
- `system_labels` → `systemLabels` (Graph `systemLabels`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).

### `v1.0/devices/extensions` → `v1.0/devices/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `device-id` (Graph `device-id`, url_parameter, renamed).

### `v1.0/directory/administrative-units` → `v1.0/directory/administrativeUnits`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_member_management_restricted` → `isMemberManagementRestricted` (Graph `isMemberManagementRestricted`, property, renamed).
- `membership_rule` → `membershipRule` (Graph `membershipRule`, property, renamed).
- `membership_rule_processing_state` → `membershipRuleProcessingState` (Graph `membershipRuleProcessingState`, property, renamed).
- `membership_type` → `membershipType` (Graph `membershipType`, property, renamed).
- `scoped_role_members` → `scopedRoleMembers` (Graph `scopedRoleMembers`, property, renamed).

### `v1.0/directory/administrative-units/scoped-role-members` → `v1.0/directory/administrativeUnits/scopedRoleMembers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `administrative_unit_id_2` → `administrativeUnitId` (Graph `administrativeUnitId`, property, renamed).
- `role_id` → `roleId` (Graph `roleId`, property, renamed).
- `role_member_info` → `roleMemberInfo` (Graph `roleMemberInfo`, property, renamed).
- `administrative_unit_id` → `administrativeUnit-id` (Graph `administrativeUnit-id`, url_parameter, renamed).

### `v1.0/directory/public-key-infrastructure/certificate-based-auth-configurations` → `v1.0/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_authorities` → `certificateAuthorities` (Graph `certificateAuthorities`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `status_details` → `statusDetails` (Graph `statusDetails`, property, renamed).

### `v1.0/directory/public-key-infrastructure/certificate-based-auth-configurations/certificate-authorities` → `v1.0/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/certificateAuthorities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_authority_type` → `certificateAuthorityType` (Graph `certificateAuthorityType`, property, renamed).
- `certificate_revocation_list_url` → `certificateRevocationListUrl` (Graph `certificateRevocationListUrl`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `delta_certificate_revocation_list_url` → `deltaCertificateRevocationListUrl` (Graph `deltaCertificateRevocationListUrl`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `is_issuer_hint_enabled` → `isIssuerHintEnabled` (Graph `isIssuerHintEnabled`, property, renamed).
- `issuer_subject_key_identifier` → `issuerSubjectKeyIdentifier` (Graph `issuerSubjectKeyIdentifier`, property, renamed).
- `certificate_based_auth_pki_id` → `certificateBasedAuthPki-id` (Graph `certificateBasedAuthPki-id`, url_parameter, renamed).

### `v1.0/directory/tenant-governance/governance-invitations` → `v1.0/directory/tenantGovernance/governanceInvitations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `governed_tenant_id` → `governedTenantId` (Graph `governedTenantId`, property, renamed).
- `governed_tenant_name` → `governedTenantName` (Graph `governedTenantName`, property, renamed).
- `governing_tenant_id` → `governingTenantId` (Graph `governingTenantId`, property, renamed).
- `governing_tenant_name` → `governingTenantName` (Graph `governingTenantName`, property, renamed).

### `v1.0/directory/tenant-governance/governance-policy-templates` → `v1.0/directory/tenantGovernance/governancePolicyTemplates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `delegated_administration_role_assignments` → `delegatedAdministrationRoleAssignments` (Graph `delegatedAdministrationRoleAssignments`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `governed_tenant_can_terminate` → `governedTenantCanTerminate` (Graph `governedTenantCanTerminate`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_tenant_applications_to_provision` → `multiTenantApplicationsToProvision` (Graph `multiTenantApplicationsToProvision`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/domains` → `v1.0/domains`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_type` → `authenticationType` (Graph `authenticationType`, property, renamed).
- `availability_status` → `availabilityStatus` (Graph `availabilityStatus`, property, renamed).
- `federation_configuration` → `federationConfiguration` (Graph `federationConfiguration`, property, renamed).
- `is_admin_managed` → `isAdminManaged` (Graph `isAdminManaged`, property, renamed).
- `is_default` → `isDefault` (Graph `isDefault`, property, renamed).
- `is_initial` → `isInitial` (Graph `isInitial`, property, renamed).
- `is_root` → `isRoot` (Graph `isRoot`, property, renamed).
- `is_verified` → `isVerified` (Graph `isVerified`, property, renamed).
- `password_notification_window_in_days` → `passwordNotificationWindowInDays` (Graph `passwordNotificationWindowInDays`, property, renamed).
- `password_validity_period_in_days` → `passwordValidityPeriodInDays` (Graph `passwordValidityPeriodInDays`, property, renamed).
- `supported_services` → `supportedServices` (Graph `supportedServices`, property, renamed).

### `v1.0/domains/federation-configuration` → `v1.0/domains/federationConfiguration`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `active_sign_in_uri` → `activeSignInUri` (Graph `activeSignInUri`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `federated_idp_mfa_behavior` → `federatedIdpMfaBehavior` (Graph `federatedIdpMfaBehavior`, property, renamed).
- `is_signed_authentication_request_required` → `isSignedAuthenticationRequestRequired` (Graph `isSignedAuthenticationRequestRequired`, property, renamed).
- `issuer_uri` → `issuerUri` (Graph `issuerUri`, property, renamed).
- `metadata_exchange_uri` → `metadataExchangeUri` (Graph `metadataExchangeUri`, property, renamed).
- `next_signing_certificate` → `nextSigningCertificate` (Graph `nextSigningCertificate`, property, renamed).
- `passive_sign_in_uri` → `passiveSignInUri` (Graph `passiveSignInUri`, property, renamed).
- `password_reset_uri` → `passwordResetUri` (Graph `passwordResetUri`, property, renamed).
- `preferred_authentication_protocol` → `preferredAuthenticationProtocol` (Graph `preferredAuthenticationProtocol`, property, renamed).
- `prompt_login_behavior` → `promptLoginBehavior` (Graph `promptLoginBehavior`, property, renamed).
- `sign_out_uri` → `signOutUri` (Graph `signOutUri`, property, renamed).
- `signing_certificate` → `signingCertificate` (Graph `signingCertificate`, property, renamed).
- `signing_certificate_update_status` → `signingCertificateUpdateStatus` (Graph `signingCertificateUpdateStatus`, property, renamed).
- `system_browser_enabled_on` → `systemBrowserEnabledOn` (Graph `systemBrowserEnabledOn`, property, renamed).
- `domain_id` → `domain-id` (Graph `domain-id`, url_parameter, renamed).

### `v1.0/drives/items/permissions` → `v1.0/drives/items/permissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `drive_id` → `drive-id` (Graph `drive-id`, url_parameter, renamed).
- `drive_item_id` → `driveItem-id` (Graph `driveItem-id`, url_parameter, renamed).

### `v1.0/education/classes` → `v1.0/education/classes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_categories` → `assignmentCategories` (Graph `assignmentCategories`, property, renamed).
- `assignment_defaults` → `assignmentDefaults` (Graph `assignmentDefaults`, property, renamed).
- `assignment_settings` → `assignmentSettings` (Graph `assignmentSettings`, property, renamed).
- `class_code` → `classCode` (Graph `classCode`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `external_name` → `externalName` (Graph `externalName`, property, renamed).
- `external_source` → `externalSource` (Graph `externalSource`, property, renamed).
- `external_source_detail` → `externalSourceDetail` (Graph `externalSourceDetail`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).

### `v1.0/education/classes/assignment-categories` → `v1.0/education/classes/assignmentCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `v1.0/education/classes/assignment-settings/grading-schemes` → `v1.0/education/classes/assignmentSettings/gradingSchemes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hide_points_during_grading` → `hidePointsDuringGrading` (Graph `hidePointsDuringGrading`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `v1.0/education/classes/assignments` → `v1.0/education/classes/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `add_to_calendar_action` → `addToCalendarAction` (Graph `addToCalendarAction`, property, renamed).
- `added_student_action` → `addedStudentAction` (Graph `addedStudentAction`, property, renamed).
- `allow_late_submissions` → `allowLateSubmissions` (Graph `allowLateSubmissions`, property, renamed).
- `allow_students_to_add_resources_to_submission` → `allowStudentsToAddResourcesToSubmission` (Graph `allowStudentsToAddResourcesToSubmission`, property, renamed).
- `assign_to` → `assignTo` (Graph `assignTo`, property, renamed).
- `class_id` → `classId` (Graph `classId`, property, renamed).
- `close_date_time` → `closeDateTime` (Graph `closeDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `grading_category` → `gradingCategory` (Graph `gradingCategory`, property, renamed).
- `grading_scheme` → `gradingScheme` (Graph `gradingScheme`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `module_url` → `moduleUrl` (Graph `moduleUrl`, property, renamed).
- `notification_channel_url` → `notificationChannelUrl` (Graph `notificationChannelUrl`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `v1.0/education/classes/assignments/resources` → `v1.0/education/classes/assignments/resources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `dependent_resources` → `dependentResources` (Graph `dependentResources`, property, renamed).
- `distribute_for_student_work` → `distributeForStudentWork` (Graph `distributeForStudentWork`, property, renamed).
- `education_assignment_id` → `educationAssignment-id` (Graph `educationAssignment-id`, url_parameter, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `v1.0/education/classes/assignments/submissions/outcomes` → `v1.0/education/classes/assignments/submissions/outcomes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `education_assignment_id` → `educationAssignment-id` (Graph `educationAssignment-id`, url_parameter, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).
- `education_submission_id` → `educationSubmission-id` (Graph `educationSubmission-id`, url_parameter, renamed).

### `v1.0/education/classes/assignments/submissions/resources` → `v1.0/education/classes/assignments/submissions/resources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_resource_url` → `assignmentResourceUrl` (Graph `assignmentResourceUrl`, property, renamed).
- `dependent_resources` → `dependentResources` (Graph `dependentResources`, property, renamed).
- `education_assignment_id` → `educationAssignment-id` (Graph `educationAssignment-id`, url_parameter, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).
- `education_submission_id` → `educationSubmission-id` (Graph `educationSubmission-id`, url_parameter, renamed).

### `v1.0/education/classes/modules` → `v1.0/education/classes/modules`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_pinned` → `isPinned` (Graph `isPinned`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `v1.0/education/classes/modules/resources` → `v1.0/education/classes/modules/resources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).
- `education_module_id` → `educationModule-id` (Graph `educationModule-id`, url_parameter, renamed).

### `v1.0/education/me/rubrics` → `v1.0/education/me/rubrics`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/education/schools` → `v1.0/education/schools`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `administrative_unit` → `administrativeUnit` (Graph `administrativeUnit`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `external_principal_id` → `externalPrincipalId` (Graph `externalPrincipalId`, property, renamed).
- `external_source` → `externalSource` (Graph `externalSource`, property, renamed).
- `external_source_detail` → `externalSourceDetail` (Graph `externalSourceDetail`, property, renamed).
- `highest_grade` → `highestGrade` (Graph `highestGrade`, property, renamed).
- `lowest_grade` → `lowestGrade` (Graph `lowestGrade`, property, renamed).
- `principal_email` → `principalEmail` (Graph `principalEmail`, property, renamed).
- `principal_name` → `principalName` (Graph `principalName`, property, renamed).
- `school_number` → `schoolNumber` (Graph `schoolNumber`, property, renamed).

### `v1.0/education/users` → `v1.0/education/users`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `assigned_licenses` → `assignedLicenses` (Graph `assignedLicenses`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_source` → `externalSource` (Graph `externalSource`, property, renamed).
- `external_source_detail` → `externalSourceDetail` (Graph `externalSourceDetail`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).
- `mailing_address` → `mailingAddress` (Graph `mailingAddress`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `on_premises_info` → `onPremisesInfo` (Graph `onPremisesInfo`, property, renamed).
- `password_policies` → `passwordPolicies` (Graph `passwordPolicies`, property, renamed).
- `password_profile` → `passwordProfile` (Graph `passwordProfile`, property, renamed).
- `preferred_language` → `preferredLanguage` (Graph `preferredLanguage`, property, renamed).
- `primary_role` → `primaryRole` (Graph `primaryRole`, property, renamed).
- `residence_address` → `residenceAddress` (Graph `residenceAddress`, property, renamed).
- `show_in_address_list` → `showInAddressList` (Graph `showInAddressList`, property, renamed).
- `taught_classes` → `taughtClasses` (Graph `taughtClasses`, property, renamed).
- `usage_location` → `usageLocation` (Graph `usageLocation`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `user_type` → `userType` (Graph `userType`, property, renamed).

### `v1.0/employee-experience/communities` → `v1.0/employeeExperience/communities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/employee-experience/learning-providers/learning-course-activities` → `v1.0/employeeExperience/learningProviders/learningCourseActivities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `completion_percentage` → `completionPercentage` (Graph `completionPercentage`, property, renamed).
- `externalcourse_activity_id` → `externalcourseActivityId` (Graph `externalcourseActivityId`, property, renamed).
- `learner_user_id` → `learnerUserId` (Graph `learnerUserId`, property, renamed).
- `learning_content_id` → `learningContentId` (Graph `learningContentId`, property, renamed).
- `learning_provider_id_2` → `learningProviderId` (Graph `learningProviderId`, property, renamed).
- `learning_provider_id` → `learningProvider-id` (Graph `learningProvider-id`, url_parameter, renamed).

### `v1.0/external/connections` → `v1.0/external/connections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `activity_settings` → `activitySettings` (Graph `activitySettings`, property, renamed).
- `connector_id` → `connectorId` (Graph `connectorId`, property, renamed).
- `content_category` → `contentCategory` (Graph `contentCategory`, property, renamed).
- `search_settings` → `searchSettings` (Graph `searchSettings`, property, renamed).

### `v1.0/external/connections/groups` → `v1.0/external/connections/groups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_connection_id` → `externalConnection-id` (Graph `externalConnection-id`, url_parameter, renamed).

### `v1.0/external/connections/groups/members` → `v1.0/external/connections/groups/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `external_connection_id` → `externalConnection-id` (Graph `externalConnection-id`, url_parameter, renamed).
- `external_group_id` → `externalGroup-id` (Graph `externalGroup-id`, url_parameter, renamed).

### `v1.0/group-lifecycle-policies` → `v1.0/groupLifecyclePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `alternate_notification_emails` → `alternateNotificationEmails` (Graph `alternateNotificationEmails`, property, renamed).
- `group_lifetime_in_days` → `groupLifetimeInDays` (Graph `groupLifetimeInDays`, property, renamed).
- `managed_group_types` → `managedGroupTypes` (Graph `managedGroupTypes`, property, renamed).

### `v1.0/group-settings` → `v1.0/groupSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/groups` → `v1.0/groups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `accepted_senders` → `acceptedSenders` (Graph `acceptedSenders`, property, renamed).
- `app_role_assignments` → `appRoleAssignments` (Graph `appRoleAssignments`, property, renamed).
- `assigned_labels` → `assignedLabels` (Graph `assignedLabels`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_types` → `groupTypes` (Graph `groupTypes`, property, renamed).
- `has_members_with_license_errors` → `hasMembersWithLicenseErrors` (Graph `hasMembersWithLicenseErrors`, property, renamed).
- `info_catalogs` → `infoCatalogs` (Graph `infoCatalogs`, property, renamed).
- `is_assignable_to_role` → `isAssignableToRole` (Graph `isAssignableToRole`, property, renamed).
- `mail_enabled` → `mailEnabled` (Graph `mailEnabled`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).
- `membership_rule` → `membershipRule` (Graph `membershipRule`, property, renamed).
- `membership_rule_processing_state` → `membershipRuleProcessingState` (Graph `membershipRuleProcessingState`, property, renamed).
- `on_premises_extension_attributes` → `onPremisesExtensionAttributes` (Graph `onPremisesExtensionAttributes`, property, renamed).
- `on_premises_provisioning_errors` → `onPremisesProvisioningErrors` (Graph `onPremisesProvisioningErrors`, property, renamed).
- `on_premises_sync_behavior` → `onPremisesSyncBehavior` (Graph `onPremisesSyncBehavior`, property, renamed).
- `organization_id` → `organizationId` (Graph `organizationId`, property, renamed).
- `permission_grants` → `permissionGrants` (Graph `permissionGrants`, property, renamed).
- `preferred_data_location` → `preferredDataLocation` (Graph `preferredDataLocation`, property, renamed).
- `preferred_language` → `preferredLanguage` (Graph `preferredLanguage`, property, renamed).
- `rejected_senders` → `rejectedSenders` (Graph `rejectedSenders`, property, renamed).
- `resource_behavior_options` → `resourceBehaviorOptions` (Graph `resourceBehaviorOptions`, property, renamed).
- `resource_provisioning_options` → `resourceProvisioningOptions` (Graph `resourceProvisioningOptions`, property, renamed).
- `security_enabled` → `securityEnabled` (Graph `securityEnabled`, property, renamed).
- `service_provisioning_errors` → `serviceProvisioningErrors` (Graph `serviceProvisioningErrors`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).
- `transitive_members` → `transitiveMembers` (Graph `transitiveMembers`, property, renamed).
- `welcome_message_enabled` → `welcomeMessageEnabled` (Graph `welcomeMessageEnabled`, property, renamed).

### `v1.0/groups/app-role-assignments` → `v1.0/groups/appRoleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/calendar/calendar-permissions` → `v1.0/groups/calendar/calendarPermissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_roles` → `allowedRoles` (Graph `allowedRoles`, property, renamed).
- `is_inside_organization` → `isInsideOrganization` (Graph `isInsideOrganization`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/calendar/events` → `v1.0/groups/calendar/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/conversations/threads` → `v1.0/groups/conversations/threads`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_locked` → `isLocked` (Graph `isLocked`, property, renamed).
- `last_delivered_date_time` → `lastDeliveredDateTime` (Graph `lastDeliveredDateTime`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_senders` → `uniqueSenders` (Graph `uniqueSenders`, property, renamed).
- `conversation_id` → `conversation-id` (Graph `conversation-id`, url_parameter, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/events` → `v1.0/groups/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/events/extensions` → `v1.0/groups/events/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `event_id` → `event-id` (Graph `event-id`, url_parameter, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/extensions` → `v1.0/groups/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/onenote/pages` → `v1.0/groups/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/settings` → `v1.0/groups/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/threads` → `v1.0/groups/threads`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_locked` → `isLocked` (Graph `isLocked`, property, renamed).
- `last_delivered_date_time` → `lastDeliveredDateTime` (Graph `lastDeliveredDateTime`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_senders` → `uniqueSenders` (Graph `uniqueSenders`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `v1.0/groups/threads/posts/extensions` → `v1.0/groups/threads/posts/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `conversation_thread_id` → `conversationThread-id` (Graph `conversationThread-id`, url_parameter, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).
- `post_id` → `post-id` (Graph `post-id`, url_parameter, renamed).

### `v1.0/identity-governance/access-reviews/definitions` → `v1.0/identityGovernance/accessReviews/definitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_notification_recipients` → `additionalNotificationRecipients` (Graph `additionalNotificationRecipients`, property, renamed).
- `description_for_admins` → `descriptionForAdmins` (Graph `descriptionForAdmins`, property, renamed).
- `description_for_reviewers` → `descriptionForReviewers` (Graph `descriptionForReviewers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `fallback_reviewers` → `fallbackReviewers` (Graph `fallbackReviewers`, property, renamed).
- `instance_enumeration_scope` → `instanceEnumerationScope` (Graph `instanceEnumerationScope`, property, renamed).
- `stage_settings` → `stageSettings` (Graph `stageSettings`, property, renamed).

### `v1.0/identity-governance/entitlement-management/access-packages` → `v1.0/identityGovernance/entitlementManagement/accessPackages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `incompatible_access_packages` → `incompatibleAccessPackages` (Graph `incompatibleAccessPackages`, property, renamed).
- `incompatible_groups` → `incompatibleGroups` (Graph `incompatibleGroups`, property, renamed).
- `is_hidden` → `isHidden` (Graph `isHidden`, property, renamed).
- `resource_role_scopes` → `resourceRoleScopes` (Graph `resourceRoleScopes`, property, renamed).

### `v1.0/identity-governance/entitlement-management/access-packages/resource-role-scopes` → `v1.0/identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `access_package_id` → `accessPackage-id` (Graph `accessPackage-id`, url_parameter, renamed).

### `v1.0/identity-governance/entitlement-management/assignment-policies` → `v1.0/identityGovernance/entitlementManagement/assignmentPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_target_scope` → `allowedTargetScope` (Graph `allowedTargetScope`, property, renamed).
- `automatic_request_settings` → `automaticRequestSettings` (Graph `automaticRequestSettings`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_extension_stage_settings` → `customExtensionStageSettings` (Graph `customExtensionStageSettings`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).
- `notification_settings` → `notificationSettings` (Graph `notificationSettings`, property, renamed).
- `request_approval_settings` → `requestApprovalSettings` (Graph `requestApprovalSettings`, property, renamed).
- `requestor_settings` → `requestorSettings` (Graph `requestorSettings`, property, renamed).
- `review_settings` → `reviewSettings` (Graph `reviewSettings`, property, renamed).
- `specific_allowed_targets` → `specificAllowedTargets` (Graph `specificAllowedTargets`, property, renamed).

### `v1.0/identity-governance/entitlement-management/assignment-requests` → `v1.0/identityGovernance/entitlementManagement/assignmentRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `custom_extension_callout_instances` → `customExtensionCalloutInstances` (Graph `customExtensionCalloutInstances`, property, renamed).
- `request_type` → `requestType` (Graph `requestType`, property, renamed).

### `v1.0/identity-governance/entitlement-management/catalogs` → `v1.0/identityGovernance/entitlementManagement/catalogs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `catalog_type` → `catalogType` (Graph `catalogType`, property, renamed).
- `custom_workflow_extensions` → `customWorkflowExtensions` (Graph `customWorkflowExtensions`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_externally_visible` → `isExternallyVisible` (Graph `isExternallyVisible`, property, renamed).
- `resource_roles` → `resourceRoles` (Graph `resourceRoles`, property, renamed).
- `resource_scopes` → `resourceScopes` (Graph `resourceScopes`, property, renamed).

### `v1.0/identity-governance/entitlement-management/catalogs/resources/upload-sessions` → `v1.0/identityGovernance/entitlementManagement/catalogs/resources/uploadSessions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `is_upload_done` → `isUploadDone` (Graph `isUploadDone`, property, renamed).
- `reference_id` → `referenceId` (Graph `referenceId`, property, renamed).
- `access_package_catalog_id` → `accessPackageCatalog-id` (Graph `accessPackageCatalog-id`, url_parameter, renamed).
- `access_package_resource_id` → `accessPackageResource-id` (Graph `accessPackageResource-id`, url_parameter, renamed).

### `v1.0/identity-governance/entitlement-management/connected-organizations` → `v1.0/identityGovernance/entitlementManagement/connectedOrganizations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_sponsors` → `externalSponsors` (Graph `externalSponsors`, property, renamed).
- `identity_sources` → `identitySources` (Graph `identitySources`, property, renamed).
- `internal_sponsors` → `internalSponsors` (Graph `internalSponsors`, property, renamed).

### `v1.0/identity-governance/entitlement-management/external-origin-resource-connectors` → `v1.0/identityGovernance/entitlementManagement/externalOriginResourceConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `connection_info` → `connectionInfo` (Graph `connectionInfo`, property, renamed).
- `connector_type` → `connectorType` (Graph `connectorType`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `modified_by` → `modifiedBy` (Graph `modifiedBy`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).

### `v1.0/identity-governance/lifecycle-workflows/custom-task-extensions` → `v1.0/identityGovernance/lifecycleWorkflows/customTaskExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_configuration` → `authenticationConfiguration` (Graph `authenticationConfiguration`, property, renamed).
- `callback_configuration` → `callbackConfiguration` (Graph `callbackConfiguration`, property, renamed).
- `client_configuration` → `clientConfiguration` (Graph `clientConfiguration`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `endpoint_configuration` → `endpointConfiguration` (Graph `endpointConfiguration`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `reply_mode` → `replyMode` (Graph `replyMode`, property, renamed).

### `v1.0/identity-governance/lifecycle-workflows/workflows` → `v1.0/identityGovernance/lifecycleWorkflows/workflows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `administration_scope_targets` → `administrationScopeTargets` (Graph `administrationScopeTargets`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `execution_conditions` → `executionConditions` (Graph `executionConditions`, property, renamed).
- `execution_scope` → `executionScope` (Graph `executionScope`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `is_scheduling_enabled` → `isSchedulingEnabled` (Graph `isSchedulingEnabled`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `next_schedule_run_date_time` → `nextScheduleRunDateTime` (Graph `nextScheduleRunDateTime`, property, renamed).
- `preview_scope` → `previewScope` (Graph `previewScope`, property, renamed).
- `quarantine_details` → `quarantineDetails` (Graph `quarantineDetails`, property, renamed).
- `subject_processing_results` → `subjectProcessingResults` (Graph `subjectProcessingResults`, property, renamed).
- `target_subject_type` → `targetSubjectType` (Graph `targetSubjectType`, property, renamed).
- `task_reports` → `taskReports` (Graph `taskReports`, property, renamed).
- `user_processing_results` → `userProcessingResults` (Graph `userProcessingResults`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/identity-governance/privileged-access/custom-extensions` → `v1.0/identityGovernance/privilegedAccess/customExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_configuration` → `authenticationConfiguration` (Graph `authenticationConfiguration`, property, renamed).
- `client_configuration` → `clientConfiguration` (Graph `clientConfiguration`, property, renamed).
- `custom_attributes` → `customAttributes` (Graph `customAttributes`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `endpoint_configuration` → `endpointConfiguration` (Graph `endpointConfiguration`, property, renamed).
- `resource_type` → `resourceType` (Graph `resourceType`, property, renamed).

### `v1.0/identity-governance/terms-of-use/agreements` → `v1.0/identityGovernance/termsOfUse/agreements`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_per_device_acceptance_required` → `isPerDeviceAcceptanceRequired` (Graph `isPerDeviceAcceptanceRequired`, property, renamed).
- `is_viewing_before_acceptance_required` → `isViewingBeforeAcceptanceRequired` (Graph `isViewingBeforeAcceptanceRequired`, property, renamed).
- `terms_expiration` → `termsExpiration` (Graph `termsExpiration`, property, renamed).
- `user_reaccept_required_frequency` → `userReacceptRequiredFrequency` (Graph `userReacceptRequiredFrequency`, property, renamed).

### `v1.0/identity-providers` → `v1.0/identityProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `client_id` → `clientId` (Graph `clientId`, property, renamed).
- `client_secret` → `clientSecret` (Graph `clientSecret`, property, renamed).

### `v1.0/identity/api-connectors` → `v1.0/identity/apiConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_configuration` → `authenticationConfiguration` (Graph `authenticationConfiguration`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `target_url` → `targetUrl` (Graph `targetUrl`, property, renamed).

### `v1.0/identity/authentication-event-listeners` → `v1.0/identity/authenticationEventListeners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_events_flow_id` → `authenticationEventsFlowId` (Graph `authenticationEventsFlowId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/identity/authentication-events-flows` → `v1.0/identity/authenticationEventsFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/identity/b2x-user-flows` → `v1.0/identity/b2xUserFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `api_connector_configuration` → `apiConnectorConfiguration` (Graph `apiConnectorConfiguration`, property, renamed).
- `identity_providers` → `identityProviders` (Graph `identityProviders`, property, renamed).
- `user_attribute_assignments` → `userAttributeAssignments` (Graph `userAttributeAssignments`, property, renamed).
- `user_flow_identity_providers` → `userFlowIdentityProviders` (Graph `userFlowIdentityProviders`, property, renamed).
- `user_flow_type` → `userFlowType` (Graph `userFlowType`, property, renamed).
- `user_flow_type_version` → `userFlowTypeVersion` (Graph `userFlowTypeVersion`, property, renamed).

### `v1.0/identity/b2x-user-flows/user-attribute-assignments` → `v1.0/identity/b2xUserFlows/userAttributeAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_optional` → `isOptional` (Graph `isOptional`, property, renamed).
- `requires_verification` → `requiresVerification` (Graph `requiresVerification`, property, renamed).
- `user_attribute` → `userAttribute` (Graph `userAttribute`, property, renamed).
- `user_attribute_values` → `userAttributeValues` (Graph `userAttributeValues`, property, renamed).
- `user_input_type` → `userInputType` (Graph `userInputType`, property, renamed).
- `b2x_identity_user_flow_id` → `b2xIdentityUserFlow-id` (Graph `b2xIdentityUserFlow-id`, url_parameter, renamed).

### `v1.0/identity/conditional-access/authentication-strength/policies/combination-configurations` → `v1.0/identity/conditionalAccess/authenticationStrength/policies/combinationConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to_combinations` → `appliesToCombinations` (Graph `appliesToCombinations`, property, renamed).
- `authentication_strength_policy_id` → `authenticationStrengthPolicy-id` (Graph `authenticationStrengthPolicy-id`, url_parameter, renamed).

### `v1.0/identity/conditional-access/policies` → `v1.0/identity/conditionalAccess/policies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `grant_controls` → `grantControls` (Graph `grantControls`, property, renamed).
- `session_controls` → `sessionControls` (Graph `sessionControls`, property, renamed).
- `template_id` → `templateId` (Graph `templateId`, property, renamed).

### `v1.0/identity/custom-authentication-extensions` → `v1.0/identity/customAuthenticationExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_configuration` → `authenticationConfiguration` (Graph `authenticationConfiguration`, property, renamed).
- `behavior_on_error` → `behaviorOnError` (Graph `behaviorOnError`, property, renamed).
- `client_configuration` → `clientConfiguration` (Graph `clientConfiguration`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `endpoint_configuration` → `endpointConfiguration` (Graph `endpointConfiguration`, property, renamed).

### `v1.0/identity/identity-providers` → `v1.0/identity/identityProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/identity/risk-prevention/fraud-protection-providers` → `v1.0/identity/riskPrevention/fraudProtectionProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/identity/risk-prevention/web-application-firewall-providers` → `v1.0/identity/riskPrevention/webApplicationFirewallProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/identity/user-flow-attributes` → `v1.0/identity/userFlowAttributes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `data_type` → `dataType` (Graph `dataType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `user_flow_attribute_type` → `userFlowAttributeType` (Graph `userFlowAttributeType`, property, renamed).

### `v1.0/identity/verified-id/profiles` → `v1.0/identity/verifiedId/profiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `face_check_configuration` → `faceCheckConfiguration` (Graph `faceCheckConfiguration`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `verified_id_profile_configuration` → `verifiedIdProfileConfiguration` (Graph `verifiedIdProfileConfiguration`, property, renamed).
- `verified_id_usage_configurations` → `verifiedIdUsageConfigurations` (Graph `verifiedIdUsageConfigurations`, property, renamed).
- `verifier_did` → `verifierDid` (Graph `verifierDid`, property, renamed).

### `v1.0/me/calendar-groups` → `v1.0/me/calendarGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `v1.0/me/calendar-groups/calendars` → `v1.0/me/calendarGroups/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `can_edit` → `canEdit` (Graph `canEdit`, property, renamed).
- `can_share` → `canShare` (Graph `canShare`, property, renamed).
- `can_view_private_items` → `canViewPrivateItems` (Graph `canViewPrivateItems`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).

### `v1.0/me/calendar-groups/calendars/events` → `v1.0/me/calendarGroups/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).

### `v1.0/me/calendar/events` → `v1.0/me/calendar/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).

### `v1.0/me/calendars` → `v1.0/me/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `can_edit` → `canEdit` (Graph `canEdit`, property, renamed).
- `can_share` → `canShare` (Graph `canShare`, property, renamed).
- `can_view_private_items` → `canViewPrivateItems` (Graph `canViewPrivateItems`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).

### `v1.0/me/calendars/events` → `v1.0/me/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).

### `v1.0/me/contact-folders` → `v1.0/me/contactFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).

### `v1.0/me/contact-folders/contacts` → `v1.0/me/contactFolders/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `business_address` → `businessAddress` (Graph `businessAddress`, property, renamed).
- `business_home_page` → `businessHomePage` (Graph `businessHomePage`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `home_address` → `homeAddress` (Graph `homeAddress`, property, renamed).
- `home_phones` → `homePhones` (Graph `homePhones`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `other_address` → `otherAddress` (Graph `otherAddress`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).
- `contact_folder_id` → `contactFolder-id` (Graph `contactFolder-id`, url_parameter, renamed).

### `v1.0/me/contacts` → `v1.0/me/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `business_address` → `businessAddress` (Graph `businessAddress`, property, renamed).
- `business_home_page` → `businessHomePage` (Graph `businessHomePage`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `home_address` → `homeAddress` (Graph `homeAddress`, property, renamed).
- `home_phones` → `homePhones` (Graph `homePhones`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `other_address` → `otherAddress` (Graph `otherAddress`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).

### `v1.0/me/events` → `v1.0/me/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).

### `v1.0/me/inference-classification/overrides` → `v1.0/me/inferenceClassification/overrides`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `classify_as` → `classifyAs` (Graph `classifyAs`, property, renamed).
- `sender_email_address` → `senderEmailAddress` (Graph `senderEmailAddress`, property, renamed).

### `v1.0/me/mail-folders` → `v1.0/me/mailFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `child_folder_count` → `childFolderCount` (Graph `childFolderCount`, property, renamed).
- `child_folders` → `childFolders` (Graph `childFolders`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_hidden` → `isHidden` (Graph `isHidden`, property, renamed).
- `message_rules` → `messageRules` (Graph `messageRules`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `total_item_count` → `totalItemCount` (Graph `totalItemCount`, property, renamed).
- `unread_item_count` → `unreadItemCount` (Graph `unreadItemCount`, property, renamed).

### `v1.0/me/mail-folders/messages` → `v1.0/me/mailFolders/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `mail_folder_id` → `mailFolder-id` (Graph `mailFolder-id`, url_parameter, renamed).

### `v1.0/me/messages` → `v1.0/me/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).

### `v1.0/me/notes` → `v1.0/me/notes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).

### `v1.0/me/onenote/pages` → `v1.0/me/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).

### `v1.0/me/online-meetings` → `v1.0/me/onlineMeetings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_attendee_to_enable_camera` → `allowAttendeeToEnableCamera` (Graph `allowAttendeeToEnableCamera`, property, renamed).
- `allow_attendee_to_enable_mic` → `allowAttendeeToEnableMic` (Graph `allowAttendeeToEnableMic`, property, renamed).
- `allow_breakout_rooms` → `allowBreakoutRooms` (Graph `allowBreakoutRooms`, property, renamed).
- `allow_copying_and_sharing_meeting_content` → `allowCopyingAndSharingMeetingContent` (Graph `allowCopyingAndSharingMeetingContent`, property, renamed).
- `allow_live_share` → `allowLiveShare` (Graph `allowLiveShare`, property, renamed).
- `allow_meeting_chat` → `allowMeetingChat` (Graph `allowMeetingChat`, property, renamed).
- `allow_participants_to_change_name` → `allowParticipantsToChangeName` (Graph `allowParticipantsToChangeName`, property, renamed).
- `allow_power_point_sharing` → `allowPowerPointSharing` (Graph `allowPowerPointSharing`, property, renamed).
- `allow_recording` → `allowRecording` (Graph `allowRecording`, property, renamed).
- `allow_teamwork_reactions` → `allowTeamworkReactions` (Graph `allowTeamworkReactions`, property, renamed).
- `allow_transcription` → `allowTranscription` (Graph `allowTranscription`, property, renamed).
- `allow_whiteboard` → `allowWhiteboard` (Graph `allowWhiteboard`, property, renamed).
- `allowed_lobby_admitters` → `allowedLobbyAdmitters` (Graph `allowedLobbyAdmitters`, property, renamed).
- `allowed_presenters` → `allowedPresenters` (Graph `allowedPresenters`, property, renamed).
- `broadcast_settings` → `broadcastSettings` (Graph `broadcastSettings`, property, renamed).
- `chat_info` → `chatInfo` (Graph `chatInfo`, property, renamed).
- `chat_restrictions` → `chatRestrictions` (Graph `chatRestrictions`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `expiry_date_time` → `expiryDateTime` (Graph `expiryDateTime`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `is_broadcast` → `isBroadcast` (Graph `isBroadcast`, property, renamed).
- `is_end_to_end_encryption_enabled` → `isEndToEndEncryptionEnabled` (Graph `isEndToEndEncryptionEnabled`, property, renamed).
- `is_entry_exit_announced` → `isEntryExitAnnounced` (Graph `isEntryExitAnnounced`, property, renamed).
- `join_meeting_id_settings` → `joinMeetingIdSettings` (Graph `joinMeetingIdSettings`, property, renamed).
- `lobby_bypass_settings` → `lobbyBypassSettings` (Graph `lobbyBypassSettings`, property, renamed).
- `meeting_options_web_url` → `meetingOptionsWebUrl` (Graph `meetingOptionsWebUrl`, property, renamed).
- `meeting_spoken_language_tag` → `meetingSpokenLanguageTag` (Graph `meetingSpokenLanguageTag`, property, renamed).
- `meeting_template_id` → `meetingTemplateId` (Graph `meetingTemplateId`, property, renamed).
- `record_automatically` → `recordAutomatically` (Graph `recordAutomatically`, property, renamed).
- `sensitivity_label_assignment` → `sensitivityLabelAssignment` (Graph `sensitivityLabelAssignment`, property, renamed).
- `share_meeting_chat_history_default` → `shareMeetingChatHistoryDefault` (Graph `shareMeetingChatHistoryDefault`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `watermark_protection` → `watermarkProtection` (Graph `watermarkProtection`, property, renamed).

### `v1.0/me/outlook/master-categories` → `v1.0/me/outlook/masterCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `v1.0/me/settings/work-hours-and-locations/occurrences` → `v1.0/me/settings/workHoursAndLocations/occurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `recurrence_id` → `recurrenceId` (Graph `recurrenceId`, property, renamed).
- `time_off_details` → `timeOffDetails` (Graph `timeOffDetails`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).

### `v1.0/me/settings/work-hours-and-locations/recurrences` → `v1.0/me/settings/workHoursAndLocations/recurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).

### `v1.0/me/todo/lists` → `v1.0/me/todo/lists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_owner` → `isOwner` (Graph `isOwner`, property, renamed).
- `is_shared` → `isShared` (Graph `isShared`, property, renamed).
- `wellknown_list_name` → `wellknownListName` (Graph `wellknownListName`, property, renamed).

### `v1.0/me/todo/lists/tasks` → `v1.0/me/todo/lists/tasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `attachment_sessions` → `attachmentSessions` (Graph `attachmentSessions`, property, renamed).
- `body_last_modified_date_time` → `bodyLastModifiedDateTime` (Graph `bodyLastModifiedDateTime`, property, renamed).
- `checklist_items` → `checklistItems` (Graph `checklistItems`, property, renamed).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `linked_resources` → `linkedResources` (Graph `linkedResources`, property, renamed).
- `reminder_date_time` → `reminderDateTime` (Graph `reminderDateTime`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).

### `v1.0/me/todo/lists/tasks/checklist-items` → `v1.0/me/todo/lists/tasks/checklistItems`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `checked_date_time` → `checkedDateTime` (Graph `checkedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_checked` → `isChecked` (Graph `isChecked`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).

### `v1.0/me/todo/lists/tasks/linked-resources` → `v1.0/me/todo/lists/tasks/linkedResources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `application_name` → `applicationName` (Graph `applicationName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).

### `v1.0/oauth2-permission-grants` → `v1.0/oauth2PermissionGrants`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `client_id` → `clientId` (Graph `clientId`, property, renamed).
- `consent_type` → `consentType` (Graph `consentType`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).

### `v1.0/organization/branding/localizations` → `v1.0/organization/branding/localizations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `background_color` → `backgroundColor` (Graph `backgroundColor`, property, renamed).
- `background_image` → `backgroundImage` (Graph `backgroundImage`, property, renamed).
- `banner_logo` → `bannerLogo` (Graph `bannerLogo`, property, renamed).
- `content_customization` → `contentCustomization` (Graph `contentCustomization`, property, renamed).
- `custom_account_reset_credentials_url` → `customAccountResetCredentialsUrl` (Graph `customAccountResetCredentialsUrl`, property, renamed).
- `custom_css` → `customCSS` (Graph `customCSS`, property, renamed).
- `custom_cannot_access_your_account_text` → `customCannotAccessYourAccountText` (Graph `customCannotAccessYourAccountText`, property, renamed).
- `custom_cannot_access_your_account_url` → `customCannotAccessYourAccountUrl` (Graph `customCannotAccessYourAccountUrl`, property, renamed).
- `custom_forgot_my_password_text` → `customForgotMyPasswordText` (Graph `customForgotMyPasswordText`, property, renamed).
- `custom_privacy_and_cookies_text` → `customPrivacyAndCookiesText` (Graph `customPrivacyAndCookiesText`, property, renamed).
- `custom_privacy_and_cookies_url` → `customPrivacyAndCookiesUrl` (Graph `customPrivacyAndCookiesUrl`, property, renamed).
- `custom_reset_it_now_text` → `customResetItNowText` (Graph `customResetItNowText`, property, renamed).
- `custom_terms_of_use_text` → `customTermsOfUseText` (Graph `customTermsOfUseText`, property, renamed).
- `custom_terms_of_use_url` → `customTermsOfUseUrl` (Graph `customTermsOfUseUrl`, property, renamed).
- `header_background_color` → `headerBackgroundColor` (Graph `headerBackgroundColor`, property, renamed).
- `header_logo` → `headerLogo` (Graph `headerLogo`, property, renamed).
- `login_page_layout_configuration` → `loginPageLayoutConfiguration` (Graph `loginPageLayoutConfiguration`, property, renamed).
- `login_page_text_visibility_settings` → `loginPageTextVisibilitySettings` (Graph `loginPageTextVisibilitySettings`, property, renamed).
- `sign_in_page_text` → `signInPageText` (Graph `signInPageText`, property, renamed).
- `square_logo` → `squareLogo` (Graph `squareLogo`, property, renamed).
- `square_logo_dark` → `squareLogoDark` (Graph `squareLogoDark`, property, renamed).
- `username_hint_text` → `usernameHintText` (Graph `usernameHintText`, property, renamed).
- `organization_id` → `organization-id` (Graph `organization-id`, url_parameter, renamed).

### `v1.0/organization/extensions` → `v1.0/organization/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `organization_id` → `organization-id` (Graph `organization-id`, url_parameter, renamed).

### `v1.0/policies/activity-based-timeout-policies` → `v1.0/policies/activityBasedTimeoutPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `v1.0/policies/app-management-policies` → `v1.0/policies/appManagementPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).

### `v1.0/policies/authentication-strength-policies` → `v1.0/policies/authenticationStrengthPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_combinations` → `allowedCombinations` (Graph `allowedCombinations`, property, renamed).
- `combination_configurations` → `combinationConfigurations` (Graph `combinationConfigurations`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).
- `policy_type` → `policyType` (Graph `policyType`, property, renamed).
- `requirements_satisfied` → `requirementsSatisfied` (Graph `requirementsSatisfied`, property, renamed).

### `v1.0/policies/claims-mapping-policies` → `v1.0/policies/claimsMappingPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `v1.0/policies/cross-tenant-access-policy/partners/m365-capabilities` → `v1.0/policies/crossTenantAccessPolicy/partners/m365Capabilities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `inbound_access` → `inboundAccess` (Graph `inboundAccess`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `cross_tenant_access_policy_configuration_partner_tenant_id` → `crossTenantAccessPolicyConfigurationPartner-tenantId` (Graph `crossTenantAccessPolicyConfigurationPartner-tenantId`, url_parameter, renamed).

### `v1.0/policies/feature-rollout-policies` → `v1.0/policies/featureRolloutPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_applied_to_organization` → `isAppliedToOrganization` (Graph `isAppliedToOrganization`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).

### `v1.0/policies/home-realm-discovery-policies` → `v1.0/policies/homeRealmDiscoveryPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `v1.0/policies/permission-grant-policies` → `v1.0/policies/permissionGrantPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/policies/permission-grant-policies/excludes` → `v1.0/policies/permissionGrantPolicies/excludes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `client_application_ids` → `clientApplicationIds` (Graph `clientApplicationIds`, property, renamed).
- `client_application_publisher_ids` → `clientApplicationPublisherIds` (Graph `clientApplicationPublisherIds`, property, renamed).
- `client_application_tenant_ids` → `clientApplicationTenantIds` (Graph `clientApplicationTenantIds`, property, renamed).
- `client_applications_from_verified_publisher_only` → `clientApplicationsFromVerifiedPublisherOnly` (Graph `clientApplicationsFromVerifiedPublisherOnly`, property, renamed).
- `permission_classification` → `permissionClassification` (Graph `permissionClassification`, property, renamed).
- `permission_type` → `permissionType` (Graph `permissionType`, property, renamed).
- `resource_application` → `resourceApplication` (Graph `resourceApplication`, property, renamed).
- `permission_grant_policy_id` → `permissionGrantPolicy-id` (Graph `permissionGrantPolicy-id`, url_parameter, renamed).

### `v1.0/policies/permission-grant-policies/includes` → `v1.0/policies/permissionGrantPolicies/includes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `client_application_ids` → `clientApplicationIds` (Graph `clientApplicationIds`, property, renamed).
- `client_application_publisher_ids` → `clientApplicationPublisherIds` (Graph `clientApplicationPublisherIds`, property, renamed).
- `client_application_tenant_ids` → `clientApplicationTenantIds` (Graph `clientApplicationTenantIds`, property, renamed).
- `client_applications_from_verified_publisher_only` → `clientApplicationsFromVerifiedPublisherOnly` (Graph `clientApplicationsFromVerifiedPublisherOnly`, property, renamed).
- `permission_classification` → `permissionClassification` (Graph `permissionClassification`, property, renamed).
- `permission_type` → `permissionType` (Graph `permissionType`, property, renamed).
- `resource_application` → `resourceApplication` (Graph `resourceApplication`, property, renamed).
- `permission_grant_policy_id` → `permissionGrantPolicy-id` (Graph `permissionGrantPolicy-id`, url_parameter, renamed).

### `v1.0/policies/token-issuance-policies` → `v1.0/policies/tokenIssuancePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `v1.0/policies/token-lifetime-policies` → `v1.0/policies/tokenLifetimePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `v1.0/print/printers/task-triggers` → `v1.0/print/printers/taskTriggers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `printer_id` → `printer-id` (Graph `printer-id`, url_parameter, renamed).

### `v1.0/print/shares` → `v1.0/print/shares`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_all_users` → `allowAllUsers` (Graph `allowAllUsers`, property, renamed).
- `allowed_groups` → `allowedGroups` (Graph `allowedGroups`, property, renamed).
- `allowed_users` → `allowedUsers` (Graph `allowedUsers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_accepting_jobs` → `isAcceptingJobs` (Graph `isAcceptingJobs`, property, renamed).
- `view_point` → `viewPoint` (Graph `viewPoint`, property, renamed).

### `v1.0/print/task-definitions` → `v1.0/print/taskDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `v1.0/role-management/directory/role-assignments` → `v1.0/roleManagement/directory/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_id` → `appScopeId` (Graph `appScopeId`, property, renamed).
- `directory_scope_id` → `directoryScopeId` (Graph `directoryScopeId`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `principal_organization_id` → `principalOrganizationId` (Graph `principalOrganizationId`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).

### `v1.0/role-management/directory/role-definitions` → `v1.0/roleManagement/directory/roleDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `role_permissions` → `rolePermissions` (Graph `rolePermissions`, property, renamed).
- `template_id` → `templateId` (Graph `templateId`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `v1.0/role-management/entitlement-management/role-assignments` → `v1.0/roleManagement/entitlementManagement/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_id` → `appScopeId` (Graph `appScopeId`, property, renamed).
- `directory_scope_id` → `directoryScopeId` (Graph `directoryScopeId`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `principal_organization_id` → `principalOrganizationId` (Graph `principalOrganizationId`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).

### `v1.0/schema-extensions` → `v1.0/schemaExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `target_types` → `targetTypes` (Graph `targetTypes`, property, renamed).

### `v1.0/search/acronyms` → `v1.0/search/acronyms`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `stands_for` → `standsFor` (Graph `standsFor`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `v1.0/search/bookmarks` → `v1.0/search/bookmarks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `availability_end_date_time` → `availabilityEndDateTime` (Graph `availabilityEndDateTime`, property, renamed).
- `availability_start_date_time` → `availabilityStartDateTime` (Graph `availabilityStartDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_ids` → `groupIds` (Graph `groupIds`, property, renamed).
- `language_tags` → `languageTags` (Graph `languageTags`, property, renamed).
- `power_app_ids` → `powerAppIds` (Graph `powerAppIds`, property, renamed).
- `targeted_variations` → `targetedVariations` (Graph `targetedVariations`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `v1.0/search/qnas` → `v1.0/search/qnas`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `availability_end_date_time` → `availabilityEndDateTime` (Graph `availabilityEndDateTime`, property, renamed).
- `availability_start_date_time` → `availabilityStartDateTime` (Graph `availabilityStartDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_ids` → `groupIds` (Graph `groupIds`, property, renamed).
- `language_tags` → `languageTags` (Graph `languageTags`, property, renamed).
- `targeted_variations` → `targetedVariations` (Graph `targetedVariations`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `v1.0/security/attack-simulation/simulations` → `v1.0/security/attackSimulation/simulations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `attack_technique` → `attackTechnique` (Graph `attackTechnique`, property, renamed).
- `attack_type` → `attackType` (Graph `attackType`, property, renamed).
- `automation_id` → `automationId` (Graph `automationId`, property, renamed).
- `completion_date_time` → `completionDateTime` (Graph `completionDateTime`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `duration_in_days` → `durationInDays` (Graph `durationInDays`, property, renamed).
- `end_user_notification_setting` → `endUserNotificationSetting` (Graph `endUserNotificationSetting`, property, renamed).
- `excluded_account_target` → `excludedAccountTarget` (Graph `excludedAccountTarget`, property, renamed).
- `included_account_target` → `includedAccountTarget` (Graph `includedAccountTarget`, property, renamed).
- `is_automated` → `isAutomated` (Graph `isAutomated`, property, renamed).
- `landing_page` → `landingPage` (Graph `landingPage`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `launch_date_time` → `launchDateTime` (Graph `launchDateTime`, property, renamed).
- `login_page` → `loginPage` (Graph `loginPage`, property, renamed).
- `o_auth_consent_app_detail` → `oAuthConsentAppDetail` (Graph `oAuthConsentAppDetail`, property, renamed).
- `payload_delivery_platform` → `payloadDeliveryPlatform` (Graph `payloadDeliveryPlatform`, property, renamed).
- `training_setting` → `trainingSetting` (Graph `trainingSetting`, property, renamed).

### `v1.0/security/cases/ediscovery-cases` → `v1.0/security/cases/ediscoveryCases`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `case_members` → `caseMembers` (Graph `caseMembers`, property, renamed).
- `closed_by` → `closedBy` (Graph `closedBy`, property, renamed).
- `closed_date_time` → `closedDateTime` (Graph `closedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `noncustodial_data_sources` → `noncustodialDataSources` (Graph `noncustodialDataSources`, property, renamed).
- `review_sets` → `reviewSets` (Graph `reviewSets`, property, renamed).

### `v1.0/security/cases/ediscovery-cases/case-members` → `v1.0/security/cases/ediscoveryCases/caseMembers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `recipient_type` → `recipientType` (Graph `recipientType`, property, renamed).
- `smtp_address` → `smtpAddress` (Graph `smtpAddress`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).

### `v1.0/security/cases/ediscovery-cases/custodians/site-sources` → `v1.0/security/cases/ediscoveryCases/custodians/siteSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_custodian_id` → `ediscoveryCustodian-id` (Graph `ediscoveryCustodian-id`, url_parameter, renamed).

### `v1.0/security/cases/ediscovery-cases/custodians/unified-group-sources` → `v1.0/security/cases/ediscoveryCases/custodians/unifiedGroupSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `included_sources` → `includedSources` (Graph `includedSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_custodian_id` → `ediscoveryCustodian-id` (Graph `ediscoveryCustodian-id`, url_parameter, renamed).

### `v1.0/security/cases/ediscovery-cases/custodians/user-sources` → `v1.0/security/cases/ediscoveryCases/custodians/userSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `included_sources` → `includedSources` (Graph `includedSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_custodian_id` → `ediscoveryCustodian-id` (Graph `ediscoveryCustodian-id`, url_parameter, renamed).

### `v1.0/security/cases/ediscovery-cases/review-sets/queries` → `v1.0/security/cases/ediscoveryCases/reviewSets/queries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `content_query` → `contentQuery` (Graph `contentQuery`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_review_set_id` → `ediscoveryReviewSet-id` (Graph `ediscoveryReviewSet-id`, url_parameter, renamed).

### `v1.0/security/cases/ediscovery-cases/searches` → `v1.0/security/cases/ediscoveryCases/searches`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `add_to_review_set_operation` → `addToReviewSetOperation` (Graph `addToReviewSetOperation`, property, renamed).
- `additional_sources` → `additionalSources` (Graph `additionalSources`, property, renamed).
- `content_query` → `contentQuery` (Graph `contentQuery`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custodian_sources` → `custodianSources` (Graph `custodianSources`, property, renamed).
- `data_source_scopes` → `dataSourceScopes` (Graph `dataSourceScopes`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_estimate_statistics_operation` → `lastEstimateStatisticsOperation` (Graph `lastEstimateStatisticsOperation`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `noncustodial_sources` → `noncustodialSources` (Graph `noncustodialSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).

### `v1.0/security/cases/ediscovery-cases/tags` → `v1.0/security/cases/ediscoveryCases/tags`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `child_selectability` → `childSelectability` (Graph `childSelectability`, property, renamed).
- `child_tags` → `childTags` (Graph `childTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).

### `v1.0/security/labels/retention-labels` → `v1.0/security/labels/retentionLabels`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_after_retention_period` → `actionAfterRetentionPeriod` (Graph `actionAfterRetentionPeriod`, property, renamed).
- `behavior_during_retention_period` → `behaviorDuringRetentionPeriod` (Graph `behaviorDuringRetentionPeriod`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `default_record_behavior` → `defaultRecordBehavior` (Graph `defaultRecordBehavior`, property, renamed).
- `description_for_admins` → `descriptionForAdmins` (Graph `descriptionForAdmins`, property, renamed).
- `description_for_users` → `descriptionForUsers` (Graph `descriptionForUsers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `disposition_review_stages` → `dispositionReviewStages` (Graph `dispositionReviewStages`, property, renamed).
- `is_in_use` → `isInUse` (Graph `isInUse`, property, renamed).
- `label_to_be_applied` → `labelToBeApplied` (Graph `labelToBeApplied`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `retention_duration` → `retentionDuration` (Graph `retentionDuration`, property, renamed).
- `retention_event_type` → `retentionEventType` (Graph `retentionEventType`, property, renamed).
- `retention_trigger` → `retentionTrigger` (Graph `retentionTrigger`, property, renamed).

### `v1.0/security/triggers/retention-events` → `v1.0/security/triggers/retentionEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `event_propagation_results` → `eventPropagationResults` (Graph `eventPropagationResults`, property, renamed).
- `event_queries` → `eventQueries` (Graph `eventQueries`, property, renamed).
- `event_status` → `eventStatus` (Graph `eventStatus`, property, renamed).
- `event_trigger_date_time` → `eventTriggerDateTime` (Graph `eventTriggerDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `last_status_update_date_time` → `lastStatusUpdateDateTime` (Graph `lastStatusUpdateDateTime`, property, renamed).
- `retention_event_type` → `retentionEventType` (Graph `retentionEventType`, property, renamed).

### `v1.0/service-principals` → `v1.0/servicePrincipals`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `add_ins` → `addIns` (Graph `addIns`, property, renamed).
- `alternative_names` → `alternativeNames` (Graph `alternativeNames`, property, renamed).
- `app_description` → `appDescription` (Graph `appDescription`, property, renamed).
- `app_display_name` → `appDisplayName` (Graph `appDisplayName`, property, renamed).
- `app_id` → `appId` (Graph `appId`, property, renamed).
- `app_management_policies` → `appManagementPolicies` (Graph `appManagementPolicies`, property, renamed).
- `app_owner_organization_id` → `appOwnerOrganizationId` (Graph `appOwnerOrganizationId`, property, renamed).
- `app_role_assigned_to` → `appRoleAssignedTo` (Graph `appRoleAssignedTo`, property, renamed).
- `app_role_assignment_required` → `appRoleAssignmentRequired` (Graph `appRoleAssignmentRequired`, property, renamed).
- `app_role_assignments` → `appRoleAssignments` (Graph `appRoleAssignments`, property, renamed).
- `app_roles` → `appRoles` (Graph `appRoles`, property, renamed).
- `claims_mapping_policies` → `claimsMappingPolicies` (Graph `claimsMappingPolicies`, property, renamed).
- `custom_security_attributes` → `customSecurityAttributes` (Graph `customSecurityAttributes`, property, renamed).
- `delegated_permission_classifications` → `delegatedPermissionClassifications` (Graph `delegatedPermissionClassifications`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `disabled_by_microsoft_status` → `disabledByMicrosoftStatus` (Graph `disabledByMicrosoftStatus`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `federated_identity_credentials` → `federatedIdentityCredentials` (Graph `federatedIdentityCredentials`, property, renamed).
- `home_realm_discovery_policies` → `homeRealmDiscoveryPolicies` (Graph `homeRealmDiscoveryPolicies`, property, renamed).
- `is_disabled` → `isDisabled` (Graph `isDisabled`, property, renamed).
- `key_credentials` → `keyCredentials` (Graph `keyCredentials`, property, renamed).
- `login_url` → `loginUrl` (Graph `loginUrl`, property, renamed).
- `logout_url` → `logoutUrl` (Graph `logoutUrl`, property, renamed).
- `notification_email_addresses` → `notificationEmailAddresses` (Graph `notificationEmailAddresses`, property, renamed).
- `oauth2_permission_scopes` → `oauth2PermissionScopes` (Graph `oauth2PermissionScopes`, property, renamed).
- `password_credentials` → `passwordCredentials` (Graph `passwordCredentials`, property, renamed).
- `preferred_single_sign_on_mode` → `preferredSingleSignOnMode` (Graph `preferredSingleSignOnMode`, property, renamed).
- `preferred_token_signing_key_thumbprint` → `preferredTokenSigningKeyThumbprint` (Graph `preferredTokenSigningKeyThumbprint`, property, renamed).
- `remote_desktop_security_configuration` → `remoteDesktopSecurityConfiguration` (Graph `remoteDesktopSecurityConfiguration`, property, renamed).
- `reply_urls` → `replyUrls` (Graph `replyUrls`, property, renamed).
- `saml_single_sign_on_settings` → `samlSingleSignOnSettings` (Graph `samlSingleSignOnSettings`, property, renamed).
- `service_principal_names` → `servicePrincipalNames` (Graph `servicePrincipalNames`, property, renamed).
- `service_principal_type` → `servicePrincipalType` (Graph `servicePrincipalType`, property, renamed).
- `token_encryption_key_id` → `tokenEncryptionKeyId` (Graph `tokenEncryptionKeyId`, property, renamed).
- `token_issuance_policies` → `tokenIssuancePolicies` (Graph `tokenIssuancePolicies`, property, renamed).
- `token_lifetime_policies` → `tokenLifetimePolicies` (Graph `tokenLifetimePolicies`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).
- `verified_publisher` → `verifiedPublisher` (Graph `verifiedPublisher`, property, renamed).

### `v1.0/service-principals/app-role-assigned-to` → `v1.0/servicePrincipals/appRoleAssignedTo`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `v1.0/service-principals/app-role-assignments` → `v1.0/servicePrincipals/appRoleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `v1.0/service-principals/delegated-permission-classifications` → `v1.0/servicePrincipals/delegatedPermissionClassifications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `permission_id` → `permissionId` (Graph `permissionId`, property, renamed).
- `permission_name` → `permissionName` (Graph `permissionName`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `v1.0/service-principals/remote-desktop-security-configuration/approved-client-apps` → `v1.0/servicePrincipals/remoteDesktopSecurityConfiguration/approvedClientApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `v1.0/service-principals/synchronization/jobs` → `v1.0/servicePrincipals/synchronization/jobs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bulk_upload` → `bulkUpload` (Graph `bulkUpload`, property, renamed).
- `synchronization_job_settings` → `synchronizationJobSettings` (Graph `synchronizationJobSettings`, property, renamed).
- `template_id` → `templateId` (Graph `templateId`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `v1.0/sites/columns` → `v1.0/sites/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/content-types` → `v1.0/sites/contentTypes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `associated_hubs_urls` → `associatedHubsUrls` (Graph `associatedHubsUrls`, property, renamed).
- `base_types` → `baseTypes` (Graph `baseTypes`, property, renamed).
- `column_links` → `columnLinks` (Graph `columnLinks`, property, renamed).
- `column_positions` → `columnPositions` (Graph `columnPositions`, property, renamed).
- `document_set` → `documentSet` (Graph `documentSet`, property, renamed).
- `document_template` → `documentTemplate` (Graph `documentTemplate`, property, renamed).
- `inherited_from` → `inheritedFrom` (Graph `inheritedFrom`, property, renamed).
- `is_built_in` → `isBuiltIn` (Graph `isBuiltIn`, property, renamed).
- `parent_id` → `parentId` (Graph `parentId`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/content-types/columns` → `v1.0/sites/contentTypes/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `content_type_id` → `contentType-id` (Graph `contentType-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/lists/columns` → `v1.0/sites/lists/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/lists/content-types/columns` → `v1.0/sites/lists/contentTypes/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `content_type_id` → `contentType-id` (Graph `contentType-id`, url_parameter, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/lists/items` → `v1.0/sites/lists/items`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `content_type` → `contentType` (Graph `contentType`, property, renamed).
- `document_set_versions` → `documentSetVersions` (Graph `documentSetVersions`, property, renamed).
- `drive_item` → `driveItem` (Graph `driveItem`, property, renamed).
- `parent_reference` → `parentReference` (Graph `parentReference`, property, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/lists/items/document-set-versions` → `v1.0/sites/lists/items/documentSetVersions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `should_capture_minor_version` → `shouldCaptureMinorVersion` (Graph `shouldCaptureMinorVersion`, property, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `list_item_id` → `listItem-id` (Graph `listItem-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/onenote/pages` → `v1.0/sites/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/pages` → `v1.0/sites/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `page_layout` → `pageLayout` (Graph `pageLayout`, property, renamed).
- `parent_reference` → `parentReference` (Graph `parentReference`, property, renamed).
- `publishing_state` → `publishingState` (Graph `publishingState`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/permissions` → `v1.0/sites/permissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/term-store/groups` → `v1.0/sites/termStore/groups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `parent_site_id` → `parentSiteId` (Graph `parentSiteId`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/sites/term-store/sets` → `v1.0/sites/termStore/sets`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `localized_names` → `localizedNames` (Graph `localizedNames`, property, renamed).
- `parent_group` → `parentGroup` (Graph `parentGroup`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `v1.0/solutions/backup-restore/exchange-restore-sessions/mailbox-restore-artifacts-bulk-addition-requests` → `v1.0/solutions/backupRestore/exchangeRestoreSessions/mailboxRestoreArtifactsBulkAdditionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `destination_type` → `destinationType` (Graph `destinationType`, property, renamed).
- `directory_object_ids` → `directoryObjectIds` (Graph `directoryObjectIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `protection_time_period` → `protectionTimePeriod` (Graph `protectionTimePeriod`, property, renamed).
- `protection_unit_ids` → `protectionUnitIds` (Graph `protectionUnitIds`, property, renamed).
- `restore_point_preference` → `restorePointPreference` (Graph `restorePointPreference`, property, renamed).
- `exchange_restore_session_id` → `exchangeRestoreSession-id` (Graph `exchangeRestoreSession-id`, url_parameter, renamed).

### `v1.0/solutions/backup-restore/one-drive-for-business-restore-sessions/drive-restore-artifacts-bulk-addition-requests` → `v1.0/solutions/backupRestore/oneDriveForBusinessRestoreSessions/driveRestoreArtifactsBulkAdditionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `destination_type` → `destinationType` (Graph `destinationType`, property, renamed).
- `directory_object_ids` → `directoryObjectIds` (Graph `directoryObjectIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `protection_time_period` → `protectionTimePeriod` (Graph `protectionTimePeriod`, property, renamed).
- `protection_unit_ids` → `protectionUnitIds` (Graph `protectionUnitIds`, property, renamed).
- `restore_point_preference` → `restorePointPreference` (Graph `restorePointPreference`, property, renamed).
- `one_drive_for_business_restore_session_id` → `oneDriveForBusinessRestoreSession-id` (Graph `oneDriveForBusinessRestoreSession-id`, url_parameter, renamed).

### `v1.0/solutions/backup-restore/service-apps` → `v1.0/solutions/backupRestore/serviceApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `effective_date_time` → `effectiveDateTime` (Graph `effectiveDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `registration_date_time` → `registrationDateTime` (Graph `registrationDateTime`, property, renamed).

### `v1.0/solutions/backup-restore/share-point-restore-sessions/site-restore-artifacts-bulk-addition-requests` → `v1.0/solutions/backupRestore/sharePointRestoreSessions/siteRestoreArtifactsBulkAdditionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `destination_type` → `destinationType` (Graph `destinationType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `protection_time_period` → `protectionTimePeriod` (Graph `protectionTimePeriod`, property, renamed).
- `protection_unit_ids` → `protectionUnitIds` (Graph `protectionUnitIds`, property, renamed).
- `restore_point_preference` → `restorePointPreference` (Graph `restorePointPreference`, property, renamed).
- `site_ids` → `siteIds` (Graph `siteIds`, property, renamed).
- `site_web_urls` → `siteWebUrls` (Graph `siteWebUrls`, property, renamed).
- `share_point_restore_session_id` → `sharePointRestoreSession-id` (Graph `sharePointRestoreSession-id`, url_parameter, renamed).

### `v1.0/solutions/booking-businesses` → `v1.0/solutions/bookingBusinesses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `booking_page_settings` → `bookingPageSettings` (Graph `bookingPageSettings`, property, renamed).
- `business_hours` → `businessHours` (Graph `businessHours`, property, renamed).
- `business_type` → `businessType` (Graph `businessType`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `default_currency_iso` → `defaultCurrencyIso` (Graph `defaultCurrencyIso`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `scheduling_policy` → `schedulingPolicy` (Graph `schedulingPolicy`, property, renamed).
- `web_site_url` → `webSiteUrl` (Graph `webSiteUrl`, property, renamed).

### `v1.0/solutions/booking-businesses/appointments` → `v1.0/solutions/bookingBusinesses/appointments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `anonymous_join_web_url` → `anonymousJoinWebUrl` (Graph `anonymousJoinWebUrl`, property, renamed).
- `appointment_label` → `appointmentLabel` (Graph `appointmentLabel`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `customer_email_address` → `customerEmailAddress` (Graph `customerEmailAddress`, property, renamed).
- `customer_name` → `customerName` (Graph `customerName`, property, renamed).
- `customer_notes` → `customerNotes` (Graph `customerNotes`, property, renamed).
- `customer_phone` → `customerPhone` (Graph `customerPhone`, property, renamed).
- `customer_time_zone` → `customerTimeZone` (Graph `customerTimeZone`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `is_customer_allowed_to_manage_booking` → `isCustomerAllowedToManageBooking` (Graph `isCustomerAllowedToManageBooking`, property, renamed).
- `is_location_online` → `isLocationOnline` (Graph `isLocationOnline`, property, renamed).
- `join_web_url` → `joinWebUrl` (Graph `joinWebUrl`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `maximum_attendees_count` → `maximumAttendeesCount` (Graph `maximumAttendeesCount`, property, renamed).
- `opt_out_of_customer_email` → `optOutOfCustomerEmail` (Graph `optOutOfCustomerEmail`, property, renamed).
- `post_buffer` → `postBuffer` (Graph `postBuffer`, property, renamed).
- `pre_buffer` → `preBuffer` (Graph `preBuffer`, property, renamed).
- `price_type` → `priceType` (Graph `priceType`, property, renamed).
- `self_service_appointment_id` → `selfServiceAppointmentId` (Graph `selfServiceAppointmentId`, property, renamed).
- `service_id` → `serviceId` (Graph `serviceId`, property, renamed).
- `service_location` → `serviceLocation` (Graph `serviceLocation`, property, renamed).
- `service_name` → `serviceName` (Graph `serviceName`, property, renamed).
- `service_notes` → `serviceNotes` (Graph `serviceNotes`, property, renamed).
- `sms_notifications_enabled` → `smsNotificationsEnabled` (Graph `smsNotificationsEnabled`, property, renamed).
- `staff_member_ids` → `staffMemberIds` (Graph `staffMemberIds`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `v1.0/solutions/booking-businesses/custom-questions` → `v1.0/solutions/bookingBusinesses/customQuestions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `answer_input_type` → `answerInputType` (Graph `answerInputType`, property, renamed).
- `answer_options` → `answerOptions` (Graph `answerOptions`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `v1.0/solutions/booking-businesses/customers` → `v1.0/solutions/bookingBusinesses/customers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `v1.0/solutions/booking-businesses/services` → `v1.0/solutions/bookingBusinesses/services`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_questions` → `customQuestions` (Graph `customQuestions`, property, renamed).
- `default_duration` → `defaultDuration` (Graph `defaultDuration`, property, renamed).
- `default_location` → `defaultLocation` (Graph `defaultLocation`, property, renamed).
- `default_price` → `defaultPrice` (Graph `defaultPrice`, property, renamed).
- `default_price_type` → `defaultPriceType` (Graph `defaultPriceType`, property, renamed).
- `default_reminders` → `defaultReminders` (Graph `defaultReminders`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_anonymous_join_enabled` → `isAnonymousJoinEnabled` (Graph `isAnonymousJoinEnabled`, property, renamed).
- `is_customer_allowed_to_manage_booking` → `isCustomerAllowedToManageBooking` (Graph `isCustomerAllowedToManageBooking`, property, renamed).
- `is_hidden_from_customers` → `isHiddenFromCustomers` (Graph `isHiddenFromCustomers`, property, renamed).
- `is_location_online` → `isLocationOnline` (Graph `isLocationOnline`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `maximum_attendees_count` → `maximumAttendeesCount` (Graph `maximumAttendeesCount`, property, renamed).
- `post_buffer` → `postBuffer` (Graph `postBuffer`, property, renamed).
- `pre_buffer` → `preBuffer` (Graph `preBuffer`, property, renamed).
- `scheduling_policy` → `schedulingPolicy` (Graph `schedulingPolicy`, property, renamed).
- `sms_notifications_enabled` → `smsNotificationsEnabled` (Graph `smsNotificationsEnabled`, property, renamed).
- `staff_member_ids` → `staffMemberIds` (Graph `staffMemberIds`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `v1.0/solutions/booking-businesses/staff-members` → `v1.0/solutions/bookingBusinesses/staffMembers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `v1.0/solutions/virtual-events/townhalls/presenters` → `v1.0/solutions/virtualEvents/townhalls/presenters`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `presenter_details` → `presenterDetails` (Graph `presenterDetails`, property, renamed).
- `virtual_event_townhall_id` → `virtualEventTownhall-id` (Graph `virtualEventTownhall-id`, url_parameter, renamed).

### `v1.0/solutions/virtual-events/townhalls/registration-configuration/questions` → `v1.0/solutions/virtualEvents/townhalls/registrationConfiguration/questions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_required` → `isRequired` (Graph `isRequired`, property, renamed).
- `virtual_event_townhall_id` → `virtualEventTownhall-id` (Graph `virtualEventTownhall-id`, url_parameter, renamed).

### `v1.0/solutions/virtual-events/webinars/presenters` → `v1.0/solutions/virtualEvents/webinars/presenters`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `presenter_details` → `presenterDetails` (Graph `presenterDetails`, property, renamed).
- `virtual_event_webinar_id` → `virtualEventWebinar-id` (Graph `virtualEventWebinar-id`, url_parameter, renamed).

### `v1.0/solutions/virtual-events/webinars/registration-configuration/questions` → `v1.0/solutions/virtualEvents/webinars/registrationConfiguration/questions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_required` → `isRequired` (Graph `isRequired`, property, renamed).
- `virtual_event_webinar_id` → `virtualEventWebinar-id` (Graph `virtualEventWebinar-id`, url_parameter, renamed).

### `v1.0/storage/file-storage/container-types` → `v1.0/storage/fileStorage/containerTypes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `billing_classification` → `billingClassification` (Graph `billingClassification`, property, renamed).
- `billing_status` → `billingStatus` (Graph `billingStatus`, property, renamed).
- `owning_app_id` → `owningAppId` (Graph `owningAppId`, property, renamed).

### `v1.0/storage/file-storage/containers` → `v1.0/storage/fileStorage/containers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_sensitivity_label` → `assignedSensitivityLabel` (Graph `assignedSensitivityLabel`, property, renamed).
- `custom_properties` → `customProperties` (Graph `customProperties`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `migration_jobs` → `migrationJobs` (Graph `migrationJobs`, property, renamed).
- `share_point_groups` → `sharePointGroups` (Graph `sharePointGroups`, property, renamed).

### `v1.0/storage/file-storage/containers/columns` → `v1.0/storage/fileStorage/containers/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `v1.0/storage/file-storage/containers/migration-jobs` → `v1.0/storage/fileStorage/containers/migrationJobs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `container_info` → `containerInfo` (Graph `containerInfo`, property, renamed).
- `progress_events` → `progressEvents` (Graph `progressEvents`, property, renamed).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `v1.0/storage/file-storage/containers/permissions` → `v1.0/storage/fileStorage/containers/permissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `v1.0/storage/file-storage/containers/share-point-groups` → `v1.0/storage/fileStorage/containers/sharePointGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `v1.0/storage/file-storage/containers/share-point-groups/members` → `v1.0/storage/fileStorage/containers/sharePointGroups/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).
- `share_point_group_id` → `sharePointGroup-id` (Graph `sharePointGroup-id`, url_parameter, renamed).

### `v1.0/subscriptions` → `v1.0/subscriptions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_type` → `changeType` (Graph `changeType`, property, renamed).
- `client_state` → `clientState` (Graph `clientState`, property, renamed).
- `encryption_certificate` → `encryptionCertificate` (Graph `encryptionCertificate`, property, renamed).
- `encryption_certificate_id` → `encryptionCertificateId` (Graph `encryptionCertificateId`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `include_resource_data` → `includeResourceData` (Graph `includeResourceData`, property, renamed).
- `latest_supported_tls_version` → `latestSupportedTlsVersion` (Graph `latestSupportedTlsVersion`, property, renamed).
- `lifecycle_notification_url` → `lifecycleNotificationUrl` (Graph `lifecycleNotificationUrl`, property, renamed).
- `notification_query_options` → `notificationQueryOptions` (Graph `notificationQueryOptions`, property, renamed).
- `notification_url` → `notificationUrl` (Graph `notificationUrl`, property, renamed).
- `notification_url_app_id` → `notificationUrlAppId` (Graph `notificationUrlAppId`, property, renamed).
- `vapid_public_key` → `vapidPublicKey` (Graph `vapidPublicKey`, property, renamed).
- `web_push_encryption_p256dh_public_key` → `webPushEncryptionP256dhPublicKey` (Graph `webPushEncryptionP256dhPublicKey`, property, renamed).
- `web_push_encryption_secret` → `webPushEncryptionSecret` (Graph `webPushEncryptionSecret`, property, renamed).

### `v1.0/teams/channels` → `v1.0/teams/channels`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `all_members` → `allMembers` (Graph `allMembers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enabled_apps` → `enabledApps` (Graph `enabledApps`, property, renamed).
- `files_folder` → `filesFolder` (Graph `filesFolder`, property, renamed).
- `is_favorite_by_default` → `isFavoriteByDefault` (Graph `isFavoriteByDefault`, property, renamed).
- `layout_type` → `layoutType` (Graph `layoutType`, property, renamed).
- `membership_type` → `membershipType` (Graph `membershipType`, property, renamed).
- `migration_mode` → `migrationMode` (Graph `migrationMode`, property, renamed).
- `original_created_date_time` → `originalCreatedDateTime` (Graph `originalCreatedDateTime`, property, renamed).
- `shared_with_teams` → `sharedWithTeams` (Graph `sharedWithTeams`, property, renamed).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `v1.0/teams/channels/members` → `v1.0/teams/channels/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `visible_history_start_date_time` → `visibleHistoryStartDateTime` (Graph `visibleHistoryStartDateTime`, property, renamed).
- `channel_id` → `channel-id` (Graph `channel-id`, url_parameter, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `v1.0/teams/channels/tabs` → `v1.0/teams/channels/tabs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `channel_id` → `channel-id` (Graph `channel-id`, url_parameter, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `v1.0/teams/installed-apps` → `v1.0/teams/installedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `consented_permission_set` → `consentedPermissionSet` (Graph `consentedPermissionSet`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_definition` → `teamsAppDefinition` (Graph `teamsAppDefinition`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `v1.0/teams/members` → `v1.0/teams/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `visible_history_start_date_time` → `visibleHistoryStartDateTime` (Graph `visibleHistoryStartDateTime`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `v1.0/teams/schedule/time-off-requests` → `v1.0/teams/schedule/timeOffRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_to` → `assignedTo` (Graph `assignedTo`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `manager_action_message` → `managerActionMessage` (Graph `managerActionMessage`, property, renamed).
- `sender_message` → `senderMessage` (Graph `senderMessage`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `time_off_reason_id` → `timeOffReasonId` (Graph `timeOffReasonId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `v1.0/teams/tags` → `v1.0/teams/tags`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `member_count` → `memberCount` (Graph `memberCount`, property, renamed).
- `tag_type` → `tagType` (Graph `tagType`, property, renamed).
- `team_id_2` → `teamId` (Graph `teamId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `v1.0/teams/tags/members` → `v1.0/teams/tags/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).
- `teamwork_tag_id` → `teamworkTag-id` (Graph `teamworkTag-id`, url_parameter, renamed).

### `v1.0/teamwork/workforce-integrations` → `v1.0/teamwork/workforceIntegrations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `api_version` → `apiVersion` (Graph `apiVersion`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `eligibility_filtering_enabled_entities` → `eligibilityFilteringEnabledEntities` (Graph `eligibilityFilteringEnabledEntities`, property, renamed).
- `is_active` → `isActive` (Graph `isActive`, property, renamed).
- `supported_entities` → `supportedEntities` (Graph `supportedEntities`, property, renamed).

### `v1.0/tenant-relationships/multi-tenant-organization/tenants` → `v1.0/tenantRelationships/multiTenantOrganization/tenants`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).

### `v1.0/users` → `v1.0/users`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `about_me` → `aboutMe` (Graph `aboutMe`, property, renamed).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `age_group` → `ageGroup` (Graph `ageGroup`, property, renamed).
- `app_role_assignments` → `appRoleAssignments` (Graph `appRoleAssignments`, property, renamed).
- `assigned_licenses` → `assignedLicenses` (Graph `assignedLicenses`, property, renamed).
- `authorization_info` → `authorizationInfo` (Graph `authorizationInfo`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `cloud_clipboard` → `cloudClipboard` (Graph `cloudClipboard`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `consent_provided_for_minor` → `consentProvidedForMinor` (Graph `consentProvidedForMinor`, property, renamed).
- `custom_security_attributes` → `customSecurityAttributes` (Graph `customSecurityAttributes`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `device_enrollment_limit` → `deviceEnrollmentLimit` (Graph `deviceEnrollmentLimit`, property, renamed).
- `device_management_troubleshooting_events` → `deviceManagementTroubleshootingEvents` (Graph `deviceManagementTroubleshootingEvents`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `employee_experience` → `employeeExperience` (Graph `employeeExperience`, property, renamed).
- `employee_hire_date` → `employeeHireDate` (Graph `employeeHireDate`, property, renamed).
- `employee_id` → `employeeId` (Graph `employeeId`, property, renamed).
- `employee_leave_date_time` → `employeeLeaveDateTime` (Graph `employeeLeaveDateTime`, property, renamed).
- `employee_org_data` → `employeeOrgData` (Graph `employeeOrgData`, property, renamed).
- `employee_type` → `employeeType` (Graph `employeeType`, property, renamed).
- `external_user_state` → `externalUserState` (Graph `externalUserState`, property, renamed).
- `external_user_state_change_date_time` → `externalUserStateChangeDateTime` (Graph `externalUserStateChangeDateTime`, property, renamed).
- `fax_number` → `faxNumber` (Graph `faxNumber`, property, renamed).
- `followed_sites` → `followedSites` (Graph `followedSites`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `hire_date` → `hireDate` (Graph `hireDate`, property, renamed).
- `identity_parent_id` → `identityParentId` (Graph `identityParentId`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `is_resource_account` → `isResourceAccount` (Graph `isResourceAccount`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `joined_teams` → `joinedTeams` (Graph `joinedTeams`, property, renamed).
- `last_password_change_date_time` → `lastPasswordChangeDateTime` (Graph `lastPasswordChangeDateTime`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).
- `mailbox_settings` → `mailboxSettings` (Graph `mailboxSettings`, property, renamed).
- `managed_app_registrations` → `managedAppRegistrations` (Graph `managedAppRegistrations`, property, renamed).
- `managed_devices` → `managedDevices` (Graph `managedDevices`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `my_site` → `mySite` (Graph `mySite`, property, renamed).
- `oauth2_permission_grants` → `oauth2PermissionGrants` (Graph `oauth2PermissionGrants`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `on_premises_extension_attributes` → `onPremisesExtensionAttributes` (Graph `onPremisesExtensionAttributes`, property, renamed).
- `on_premises_immutable_id` → `onPremisesImmutableId` (Graph `onPremisesImmutableId`, property, renamed).
- `on_premises_provisioning_errors` → `onPremisesProvisioningErrors` (Graph `onPremisesProvisioningErrors`, property, renamed).
- `on_premises_sync_behavior` → `onPremisesSyncBehavior` (Graph `onPremisesSyncBehavior`, property, renamed).
- `online_meetings` → `onlineMeetings` (Graph `onlineMeetings`, property, renamed).
- `other_mails` → `otherMails` (Graph `otherMails`, property, renamed).
- `password_policies` → `passwordPolicies` (Graph `passwordPolicies`, property, renamed).
- `password_profile` → `passwordProfile` (Graph `passwordProfile`, property, renamed).
- `past_projects` → `pastProjects` (Graph `pastProjects`, property, renamed).
- `permission_grants` → `permissionGrants` (Graph `permissionGrants`, property, renamed).
- `postal_code` → `postalCode` (Graph `postalCode`, property, renamed).
- `preferred_data_location` → `preferredDataLocation` (Graph `preferredDataLocation`, property, renamed).
- `preferred_language` → `preferredLanguage` (Graph `preferredLanguage`, property, renamed).
- `preferred_name` → `preferredName` (Graph `preferredName`, property, renamed).
- `scoped_role_member_of` → `scopedRoleMemberOf` (Graph `scopedRoleMemberOf`, property, renamed).
- `service_provisioning_errors` → `serviceProvisioningErrors` (Graph `serviceProvisioningErrors`, property, renamed).
- `show_in_address_list` → `showInAddressList` (Graph `showInAddressList`, property, renamed).
- `street_address` → `streetAddress` (Graph `streetAddress`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).
- `usage_location` → `usageLocation` (Graph `usageLocation`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `user_type` → `userType` (Graph `userType`, property, renamed).

### `v1.0/users/app-role-assignments` → `v1.0/users/appRoleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/authentication/email-methods` → `v1.0/users/authentication/emailMethods`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `email_address` → `emailAddress` (Graph `emailAddress`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/authentication/phone-methods` → `v1.0/users/authentication/phoneMethods`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `phone_number` → `phoneNumber` (Graph `phoneNumber`, property, renamed).
- `phone_type` → `phoneType` (Graph `phoneType`, property, renamed).
- `sms_sign_in_state` → `smsSignInState` (Graph `smsSignInState`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/calendar-groups` → `v1.0/users/calendarGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/calendar-groups/calendars` → `v1.0/users/calendarGroups/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `can_edit` → `canEdit` (Graph `canEdit`, property, renamed).
- `can_share` → `canShare` (Graph `canShare`, property, renamed).
- `can_view_private_items` → `canViewPrivateItems` (Graph `canViewPrivateItems`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/calendar-groups/calendars/events` → `v1.0/users/calendarGroups/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/calendar/calendar-permissions` → `v1.0/users/calendar/calendarPermissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_roles` → `allowedRoles` (Graph `allowedRoles`, property, renamed).
- `is_inside_organization` → `isInsideOrganization` (Graph `isInsideOrganization`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/calendar/events` → `v1.0/users/calendar/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/calendars` → `v1.0/users/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `can_edit` → `canEdit` (Graph `canEdit`, property, renamed).
- `can_share` → `canShare` (Graph `canShare`, property, renamed).
- `can_view_private_items` → `canViewPrivateItems` (Graph `canViewPrivateItems`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/calendars/events` → `v1.0/users/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/contact-folders` → `v1.0/users/contactFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/contact-folders/contacts` → `v1.0/users/contactFolders/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `business_address` → `businessAddress` (Graph `businessAddress`, property, renamed).
- `business_home_page` → `businessHomePage` (Graph `businessHomePage`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `home_address` → `homeAddress` (Graph `homeAddress`, property, renamed).
- `home_phones` → `homePhones` (Graph `homePhones`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `other_address` → `otherAddress` (Graph `otherAddress`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).
- `contact_folder_id` → `contactFolder-id` (Graph `contactFolder-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/contacts` → `v1.0/users/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `business_address` → `businessAddress` (Graph `businessAddress`, property, renamed).
- `business_home_page` → `businessHomePage` (Graph `businessHomePage`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `home_address` → `homeAddress` (Graph `homeAddress`, property, renamed).
- `home_phones` → `homePhones` (Graph `homePhones`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `other_address` → `otherAddress` (Graph `otherAddress`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/contacts/extensions` → `v1.0/users/contacts/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `contact_id` → `contact-id` (Graph `contact-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/events` → `v1.0/users/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/events/extensions` → `v1.0/users/events/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `event_id` → `event-id` (Graph `event-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/extensions` → `v1.0/users/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/inference-classification/overrides` → `v1.0/users/inferenceClassification/overrides`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `classify_as` → `classifyAs` (Graph `classifyAs`, property, renamed).
- `sender_email_address` → `senderEmailAddress` (Graph `senderEmailAddress`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/mail-folders` → `v1.0/users/mailFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `child_folder_count` → `childFolderCount` (Graph `childFolderCount`, property, renamed).
- `child_folders` → `childFolders` (Graph `childFolders`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_hidden` → `isHidden` (Graph `isHidden`, property, renamed).
- `message_rules` → `messageRules` (Graph `messageRules`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `total_item_count` → `totalItemCount` (Graph `totalItemCount`, property, renamed).
- `unread_item_count` → `unreadItemCount` (Graph `unreadItemCount`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/mail-folders/messages` → `v1.0/users/mailFolders/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `mail_folder_id` → `mailFolder-id` (Graph `mailFolder-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/messages` → `v1.0/users/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/messages/extensions` → `v1.0/users/messages/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `message_id` → `message-id` (Graph `message-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/notes` → `v1.0/users/notes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/notes/extensions` → `v1.0/users/notes/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `note_id` → `note-id` (Graph `note-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/onenote/pages` → `v1.0/users/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/online-meetings` → `v1.0/users/onlineMeetings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_attendee_to_enable_camera` → `allowAttendeeToEnableCamera` (Graph `allowAttendeeToEnableCamera`, property, renamed).
- `allow_attendee_to_enable_mic` → `allowAttendeeToEnableMic` (Graph `allowAttendeeToEnableMic`, property, renamed).
- `allow_breakout_rooms` → `allowBreakoutRooms` (Graph `allowBreakoutRooms`, property, renamed).
- `allow_copying_and_sharing_meeting_content` → `allowCopyingAndSharingMeetingContent` (Graph `allowCopyingAndSharingMeetingContent`, property, renamed).
- `allow_live_share` → `allowLiveShare` (Graph `allowLiveShare`, property, renamed).
- `allow_meeting_chat` → `allowMeetingChat` (Graph `allowMeetingChat`, property, renamed).
- `allow_participants_to_change_name` → `allowParticipantsToChangeName` (Graph `allowParticipantsToChangeName`, property, renamed).
- `allow_power_point_sharing` → `allowPowerPointSharing` (Graph `allowPowerPointSharing`, property, renamed).
- `allow_recording` → `allowRecording` (Graph `allowRecording`, property, renamed).
- `allow_teamwork_reactions` → `allowTeamworkReactions` (Graph `allowTeamworkReactions`, property, renamed).
- `allow_transcription` → `allowTranscription` (Graph `allowTranscription`, property, renamed).
- `allow_whiteboard` → `allowWhiteboard` (Graph `allowWhiteboard`, property, renamed).
- `allowed_lobby_admitters` → `allowedLobbyAdmitters` (Graph `allowedLobbyAdmitters`, property, renamed).
- `allowed_presenters` → `allowedPresenters` (Graph `allowedPresenters`, property, renamed).
- `broadcast_settings` → `broadcastSettings` (Graph `broadcastSettings`, property, renamed).
- `chat_info` → `chatInfo` (Graph `chatInfo`, property, renamed).
- `chat_restrictions` → `chatRestrictions` (Graph `chatRestrictions`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `expiry_date_time` → `expiryDateTime` (Graph `expiryDateTime`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `is_broadcast` → `isBroadcast` (Graph `isBroadcast`, property, renamed).
- `is_end_to_end_encryption_enabled` → `isEndToEndEncryptionEnabled` (Graph `isEndToEndEncryptionEnabled`, property, renamed).
- `is_entry_exit_announced` → `isEntryExitAnnounced` (Graph `isEntryExitAnnounced`, property, renamed).
- `join_meeting_id_settings` → `joinMeetingIdSettings` (Graph `joinMeetingIdSettings`, property, renamed).
- `lobby_bypass_settings` → `lobbyBypassSettings` (Graph `lobbyBypassSettings`, property, renamed).
- `meeting_options_web_url` → `meetingOptionsWebUrl` (Graph `meetingOptionsWebUrl`, property, renamed).
- `meeting_spoken_language_tag` → `meetingSpokenLanguageTag` (Graph `meetingSpokenLanguageTag`, property, renamed).
- `meeting_template_id` → `meetingTemplateId` (Graph `meetingTemplateId`, property, renamed).
- `record_automatically` → `recordAutomatically` (Graph `recordAutomatically`, property, renamed).
- `sensitivity_label_assignment` → `sensitivityLabelAssignment` (Graph `sensitivityLabelAssignment`, property, renamed).
- `share_meeting_chat_history_default` → `shareMeetingChatHistoryDefault` (Graph `shareMeetingChatHistoryDefault`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `watermark_protection` → `watermarkProtection` (Graph `watermarkProtection`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/outlook/master-categories` → `v1.0/users/outlook/masterCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/settings/work-hours-and-locations/occurrences` → `v1.0/users/settings/workHoursAndLocations/occurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `recurrence_id` → `recurrenceId` (Graph `recurrenceId`, property, renamed).
- `time_off_details` → `timeOffDetails` (Graph `timeOffDetails`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/settings/work-hours-and-locations/recurrences` → `v1.0/users/settings/workHoursAndLocations/recurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/teamwork/installed-apps` → `v1.0/users/teamwork/installedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `consented_permission_set` → `consentedPermissionSet` (Graph `consentedPermissionSet`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_definition` → `teamsAppDefinition` (Graph `teamsAppDefinition`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/todo/lists` → `v1.0/users/todo/lists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_owner` → `isOwner` (Graph `isOwner`, property, renamed).
- `is_shared` → `isShared` (Graph `isShared`, property, renamed).
- `wellknown_list_name` → `wellknownListName` (Graph `wellknownListName`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/todo/lists/extensions` → `v1.0/users/todo/lists/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/todo/lists/tasks` → `v1.0/users/todo/lists/tasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `attachment_sessions` → `attachmentSessions` (Graph `attachmentSessions`, property, renamed).
- `body_last_modified_date_time` → `bodyLastModifiedDateTime` (Graph `bodyLastModifiedDateTime`, property, renamed).
- `checklist_items` → `checklistItems` (Graph `checklistItems`, property, renamed).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `linked_resources` → `linkedResources` (Graph `linkedResources`, property, renamed).
- `reminder_date_time` → `reminderDateTime` (Graph `reminderDateTime`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/todo/lists/tasks/checklist-items` → `v1.0/users/todo/lists/tasks/checklistItems`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `checked_date_time` → `checkedDateTime` (Graph `checkedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_checked` → `isChecked` (Graph `isChecked`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/todo/lists/tasks/extensions` → `v1.0/users/todo/lists/tasks/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `v1.0/users/todo/lists/tasks/linked-resources` → `v1.0/users/todo/lists/tasks/linkedResources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `application_name` → `applicationName` (Graph `applicationName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/access-reviews` → `beta/accessReviews`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `business_flow_template_id` → `businessFlowTemplateId` (Graph `businessFlowTemplateId`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `my_decisions` → `myDecisions` (Graph `myDecisions`, property, renamed).
- `reviewed_entity` → `reviewedEntity` (Graph `reviewedEntity`, property, renamed).
- `reviewer_type` → `reviewerType` (Graph `reviewerType`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).

### `beta/access-reviews/reviewers` → `beta/accessReviews/reviewers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `access_review_id` → `accessReview-id` (Graph `accessReview-id`, url_parameter, renamed).

### `beta/admin/cloud-licensing/assignments` → `beta/admin/cloudLicensing/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_to` → `assignedTo` (Graph `assignedTo`, property, renamed).
- `disabled_service_plan_ids` → `disabledServicePlanIds` (Graph `disabledServicePlanIds`, property, renamed).

### `beta/admin/configuration-management/configuration-monitors` → `beta/admin/configurationManagement/configurationMonitors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/admin/edge/internet-explorer-mode/site-lists` → `beta/admin/edge/internetExplorerMode/siteLists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `published_by` → `publishedBy` (Graph `publishedBy`, property, renamed).
- `published_date_time` → `publishedDateTime` (Graph `publishedDateTime`, property, renamed).
- `shared_cookies` → `sharedCookies` (Graph `sharedCookies`, property, renamed).

### `beta/admin/edge/internet-explorer-mode/site-lists/shared-cookies` → `beta/admin/edge/internetExplorerMode/siteLists/sharedCookies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `host_only` → `hostOnly` (Graph `hostOnly`, property, renamed).
- `host_or_domain` → `hostOrDomain` (Graph `hostOrDomain`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `source_environment` → `sourceEnvironment` (Graph `sourceEnvironment`, property, renamed).
- `browser_site_list_id` → `browserSiteList-id` (Graph `browserSiteList-id`, url_parameter, renamed).

### `beta/admin/edge/internet-explorer-mode/site-lists/sites` → `beta/admin/edge/internetExplorerMode/siteLists/sites`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_redirect` → `allowRedirect` (Graph `allowRedirect`, property, renamed).
- `compatibility_mode` → `compatibilityMode` (Graph `compatibilityMode`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `merge_type` → `mergeType` (Graph `mergeType`, property, renamed).
- `target_environment` → `targetEnvironment` (Graph `targetEnvironment`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `browser_site_list_id` → `browserSiteList-id` (Graph `browserSiteList-id`, url_parameter, renamed).

### `beta/admin/people/profile-card-properties` → `beta/admin/people/profileCardProperties`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `directory_property_name` → `directoryPropertyName` (Graph `directoryPropertyName`, property, renamed).
- `is_visible` → `isVisible` (Graph `isVisible`, property, renamed).

### `beta/admin/people/profile-property-settings` → `beta/admin/people/profilePropertySettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `prioritized_source_urls` → `prioritizedSourceUrls` (Graph `prioritizedSourceUrls`, property, renamed).

### `beta/admin/windows/updates/deployment-audiences` → `beta/admin/windows/updates/deploymentAudiences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/admin/windows/updates/deployments` → `beta/admin/windows/updates/deployments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/admin/windows/updates/policies` → `beta/admin/windows/updates/policies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applicable_content` → `applicableContent` (Graph `applicableContent`, property, renamed).
- `approval_rules` → `approvalRules` (Graph `approvalRules`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/admin/windows/updates/policies/approvals` → `beta/admin/windows/updates/policies/approvals`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `catalog_entry_id` → `catalogEntryId` (Graph `catalogEntryId`, property, renamed).
- `policy_id` → `policy-id` (Graph `policy-id`, url_parameter, renamed).

### `beta/admin/windows/updates/policies/rings` → `beta/admin/windows/updates/policies/rings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deferral_in_days` → `deferralInDays` (Graph `deferralInDays`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `excluded_group_assignment` → `excludedGroupAssignment` (Graph `excludedGroupAssignment`, property, renamed).
- `included_group_assignment` → `includedGroupAssignment` (Graph `includedGroupAssignment`, property, renamed).
- `is_paused` → `isPaused` (Graph `isPaused`, property, renamed).
- `policy_id` → `policy-id` (Graph `policy-id`, url_parameter, renamed).

### `beta/admin/windows/updates/resource-connections` → `beta/admin/windows/updates/resourceConnections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/admin/windows/updates/updatable-assets` → `beta/admin/windows/updates/updatableAssets`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/admin/windows/updates/update-policies` → `beta/admin/windows/updates/updatePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_change_rules` → `complianceChangeRules` (Graph `complianceChangeRules`, property, renamed).
- `compliance_changes` → `complianceChanges` (Graph `complianceChanges`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deployment_settings` → `deploymentSettings` (Graph `deploymentSettings`, property, renamed).

### `beta/admin/windows/updates/update-policies/compliance-changes` → `beta/admin/windows/updates/updatePolicies/complianceChanges`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `is_revoked` → `isRevoked` (Graph `isRevoked`, property, renamed).
- `revoked_date_time` → `revokedDateTime` (Graph `revokedDateTime`, property, renamed).
- `update_policy` → `updatePolicy` (Graph `updatePolicy`, property, renamed).
- `update_policy_id` → `updatePolicy-id` (Graph `updatePolicy-id`, url_parameter, renamed).

### `beta/administrative-units` → `beta/administrativeUnits`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `deleted_members` → `deletedMembers` (Graph `deletedMembers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_member_management_restricted` → `isMemberManagementRestricted` (Graph `isMemberManagementRestricted`, property, renamed).
- `membership_rule` → `membershipRule` (Graph `membershipRule`, property, renamed).
- `membership_rule_processing_state` → `membershipRuleProcessingState` (Graph `membershipRuleProcessingState`, property, renamed).
- `membership_type` → `membershipType` (Graph `membershipType`, property, renamed).
- `scoped_role_members` → `scopedRoleMembers` (Graph `scopedRoleMembers`, property, renamed).

### `beta/administrative-units/extensions` → `beta/administrativeUnits/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `administrative_unit_id` → `administrativeUnit-id` (Graph `administrativeUnit-id`, url_parameter, renamed).

### `beta/administrative-units/scoped-role-members` → `beta/administrativeUnits/scopedRoleMembers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `administrative_unit_id_2` → `administrativeUnitId` (Graph `administrativeUnitId`, property, renamed).
- `role_id` → `roleId` (Graph `roleId`, property, renamed).
- `role_member_info` → `roleMemberInfo` (Graph `roleMemberInfo`, property, renamed).
- `administrative_unit_id` → `administrativeUnit-id` (Graph `administrativeUnit-id`, url_parameter, renamed).

### `beta/agent-registry/agent-collections` → `beta/agentRegistry/agentCollections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_by` → `managedBy` (Graph `managedBy`, property, renamed).
- `originating_store` → `originatingStore` (Graph `originatingStore`, property, renamed).
- `owner_ids` → `ownerIds` (Graph `ownerIds`, property, renamed).

### `beta/agent-registry/agent-instances` → `beta/agentRegistry/agentInstances`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_interfaces` → `additionalInterfaces` (Graph `additionalInterfaces`, property, renamed).
- `agent_card_manifest` → `agentCardManifest` (Graph `agentCardManifest`, property, renamed).
- `agent_identity_blueprint_id` → `agentIdentityBlueprintId` (Graph `agentIdentityBlueprintId`, property, renamed).
- `agent_identity_id` → `agentIdentityId` (Graph `agentIdentityId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_by` → `managedBy` (Graph `managedBy`, property, renamed).
- `originating_store` → `originatingStore` (Graph `originatingStore`, property, renamed).
- `owner_ids` → `ownerIds` (Graph `ownerIds`, property, renamed).
- `preferred_transport` → `preferredTransport` (Graph `preferredTransport`, property, renamed).
- `source_agent_id` → `sourceAgentId` (Graph `sourceAgentId`, property, renamed).

### `beta/app-catalogs/teams-apps` → `beta/appCatalogs/teamsApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_definitions` → `appDefinitions` (Graph `appDefinitions`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).

### `beta/app-catalogs/teams-apps/app-definitions` → `beta/appCatalogs/teamsApps/appDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_installation_scopes` → `allowedInstallationScopes` (Graph `allowedInstallationScopes`, property, renamed).
- `azure_ad_app_id` → `azureADAppId` (Graph `azureADAppId`, property, renamed).
- `color_icon` → `colorIcon` (Graph `colorIcon`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `dashboard_cards` → `dashboardCards` (Graph `dashboardCards`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `outline_icon` → `outlineIcon` (Graph `outlineIcon`, property, renamed).
- `publishing_state` → `publishingState` (Graph `publishingState`, property, renamed).
- `teams_app_id_2` → `teamsAppId` (Graph `teamsAppId`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `teams_app_id` → `teamsApp-id` (Graph `teamsApp-id`, url_parameter, renamed).

### `beta/app/calls` → `beta/app/calls`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `audio_routing_groups` → `audioRoutingGroups` (Graph `audioRoutingGroups`, property, renamed).
- `call_chain_id` → `callChainId` (Graph `callChainId`, property, renamed).
- `call_options` → `callOptions` (Graph `callOptions`, property, renamed).
- `callback_uri` → `callbackUri` (Graph `callbackUri`, property, renamed).
- `chat_info` → `chatInfo` (Graph `chatInfo`, property, renamed).
- `content_sharing_sessions` → `contentSharingSessions` (Graph `contentSharingSessions`, property, renamed).
- `media_config` → `mediaConfig` (Graph `mediaConfig`, property, renamed).
- `meeting_info` → `meetingInfo` (Graph `meetingInfo`, property, renamed).
- `my_participant_id` → `myParticipantId` (Graph `myParticipantId`, property, renamed).
- `requested_modalities` → `requestedModalities` (Graph `requestedModalities`, property, renamed).
- `ringing_timeout_in_seconds` → `ringingTimeoutInSeconds` (Graph `ringingTimeoutInSeconds`, property, renamed).
- `routing_policies` → `routingPolicies` (Graph `routingPolicies`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `termination_reason` → `terminationReason` (Graph `terminationReason`, property, renamed).
- `tone_info` → `toneInfo` (Graph `toneInfo`, property, renamed).

### `beta/app/calls/audio-routing-groups` → `beta/app/calls/audioRoutingGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `routing_mode` → `routingMode` (Graph `routingMode`, property, renamed).
- `call_id` → `call-id` (Graph `call-id`, url_parameter, renamed).

### `beta/applications` → `beta/applications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_management_policies` → `appManagementPolicies` (Graph `appManagementPolicies`, property, renamed).
- `app_roles` → `appRoles` (Graph `appRoles`, property, renamed).
- `authentication_behaviors` → `authenticationBehaviors` (Graph `authenticationBehaviors`, property, renamed).
- `connector_group` → `connectorGroup` (Graph `connectorGroup`, property, renamed).
- `default_redirect_uri` → `defaultRedirectUri` (Graph `defaultRedirectUri`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `disabled_by_microsoft_status` → `disabledByMicrosoftStatus` (Graph `disabledByMicrosoftStatus`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `federated_identity_credentials` → `federatedIdentityCredentials` (Graph `federatedIdentityCredentials`, property, renamed).
- `group_membership_claims` → `groupMembershipClaims` (Graph `groupMembershipClaims`, property, renamed).
- `home_realm_discovery_policies` → `homeRealmDiscoveryPolicies` (Graph `homeRealmDiscoveryPolicies`, property, renamed).
- `identifier_uris` → `identifierUris` (Graph `identifierUris`, property, renamed).
- `is_device_only_auth_supported` → `isDeviceOnlyAuthSupported` (Graph `isDeviceOnlyAuthSupported`, property, renamed).
- `is_disabled` → `isDisabled` (Graph `isDisabled`, property, renamed).
- `is_fallback_public_client` → `isFallbackPublicClient` (Graph `isFallbackPublicClient`, property, renamed).
- `key_credentials` → `keyCredentials` (Graph `keyCredentials`, property, renamed).
- `native_authentication_apis_enabled` → `nativeAuthenticationApisEnabled` (Graph `nativeAuthenticationApisEnabled`, property, renamed).
- `on_premises_publishing` → `onPremisesPublishing` (Graph `onPremisesPublishing`, property, renamed).
- `optional_claims` → `optionalClaims` (Graph `optionalClaims`, property, renamed).
- `parental_control_settings` → `parentalControlSettings` (Graph `parentalControlSettings`, property, renamed).
- `password_credentials` → `passwordCredentials` (Graph `passwordCredentials`, property, renamed).
- `public_client` → `publicClient` (Graph `publicClient`, property, renamed).
- `request_signature_verification` → `requestSignatureVerification` (Graph `requestSignatureVerification`, property, renamed).
- `required_resource_access` → `requiredResourceAccess` (Graph `requiredResourceAccess`, property, renamed).
- `saml_metadata_url` → `samlMetadataUrl` (Graph `samlMetadataUrl`, property, renamed).
- `service_management_reference` → `serviceManagementReference` (Graph `serviceManagementReference`, property, renamed).
- `service_principal_lock_configuration` → `servicePrincipalLockConfiguration` (Graph `servicePrincipalLockConfiguration`, property, renamed).
- `sign_in_audience` → `signInAudience` (Graph `signInAudience`, property, renamed).
- `sign_in_audience_restrictions` → `signInAudienceRestrictions` (Graph `signInAudienceRestrictions`, property, renamed).
- `token_encryption_key_id` → `tokenEncryptionKeyId` (Graph `tokenEncryptionKeyId`, property, renamed).
- `token_issuance_policies` → `tokenIssuancePolicies` (Graph `tokenIssuancePolicies`, property, renamed).
- `token_lifetime_policies` → `tokenLifetimePolicies` (Graph `tokenLifetimePolicies`, property, renamed).
- `verified_publisher` → `verifiedPublisher` (Graph `verifiedPublisher`, property, renamed).

### `beta/applications/extension-properties` → `beta/applications/extensionProperties`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `data_type` → `dataType` (Graph `dataType`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `is_multi_valued` → `isMultiValued` (Graph `isMultiValued`, property, renamed).
- `target_objects` → `targetObjects` (Graph `targetObjects`, property, renamed).
- `application_id` → `application-id` (Graph `application-id`, url_parameter, renamed).

### `beta/applications/federated-identity-credentials` → `beta/applications/federatedIdentityCredentials`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `claims_matching_expression` → `claimsMatchingExpression` (Graph `claimsMatchingExpression`, property, renamed).
- `application_id` → `application-id` (Graph `application-id`, url_parameter, renamed).

### `beta/chats` → `beta/chats`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `chat_type` → `chatType` (Graph `chatType`, property, renamed).
- `installed_apps` → `installedApps` (Graph `installedApps`, property, renamed).
- `last_message_preview` → `lastMessagePreview` (Graph `lastMessagePreview`, property, renamed).
- `migration_mode` → `migrationMode` (Graph `migrationMode`, property, renamed).
- `original_created_date_time` → `originalCreatedDateTime` (Graph `originalCreatedDateTime`, property, renamed).
- `permission_grants` → `permissionGrants` (Graph `permissionGrants`, property, renamed).
- `pinned_messages` → `pinnedMessages` (Graph `pinnedMessages`, property, renamed).
- `targeted_messages` → `targetedMessages` (Graph `targetedMessages`, property, renamed).

### `beta/chats/installed-apps` → `beta/chats/installedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `consented_permission_set` → `consentedPermissionSet` (Graph `consentedPermissionSet`, property, renamed).
- `scope_info` → `scopeInfo` (Graph `scopeInfo`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_definition` → `teamsAppDefinition` (Graph `teamsAppDefinition`, property, renamed).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `beta/chats/members` → `beta/chats/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `visible_history_start_date_time` → `visibleHistoryStartDateTime` (Graph `visibleHistoryStartDateTime`, property, renamed).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `beta/chats/pinned-messages` → `beta/chats/pinnedMessages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `beta/chats/tabs` → `beta/chats/tabs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `message_id` → `messageId` (Graph `messageId`, property, renamed).
- `sort_order_index` → `sortOrderIndex` (Graph `sortOrderIndex`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_id` → `teamsAppId` (Graph `teamsAppId`, property, renamed).
- `chat_id` → `chat-id` (Graph `chat-id`, url_parameter, renamed).

### `beta/communications/calls` → `beta/communications/calls`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `audio_routing_groups` → `audioRoutingGroups` (Graph `audioRoutingGroups`, property, renamed).
- `call_chain_id` → `callChainId` (Graph `callChainId`, property, renamed).
- `call_options` → `callOptions` (Graph `callOptions`, property, renamed).
- `callback_uri` → `callbackUri` (Graph `callbackUri`, property, renamed).
- `chat_info` → `chatInfo` (Graph `chatInfo`, property, renamed).
- `content_sharing_sessions` → `contentSharingSessions` (Graph `contentSharingSessions`, property, renamed).
- `media_config` → `mediaConfig` (Graph `mediaConfig`, property, renamed).
- `meeting_info` → `meetingInfo` (Graph `meetingInfo`, property, renamed).
- `my_participant_id` → `myParticipantId` (Graph `myParticipantId`, property, renamed).
- `requested_modalities` → `requestedModalities` (Graph `requestedModalities`, property, renamed).
- `ringing_timeout_in_seconds` → `ringingTimeoutInSeconds` (Graph `ringingTimeoutInSeconds`, property, renamed).
- `routing_policies` → `routingPolicies` (Graph `routingPolicies`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `termination_reason` → `terminationReason` (Graph `terminationReason`, property, renamed).
- `tone_info` → `toneInfo` (Graph `toneInfo`, property, renamed).

### `beta/communications/calls/audio-routing-groups` → `beta/communications/calls/audioRoutingGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `routing_mode` → `routingMode` (Graph `routingMode`, property, renamed).
- `call_id` → `call-id` (Graph `call-id`, url_parameter, renamed).

### `beta/compliance/ediscovery/cases` → `beta/compliance/ediscovery/cases`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `closed_by` → `closedBy` (Graph `closedBy`, property, renamed).
- `closed_date_time` → `closedDateTime` (Graph `closedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `legal_holds` → `legalHolds` (Graph `legalHolds`, property, renamed).
- `noncustodial_data_sources` → `noncustodialDataSources` (Graph `noncustodialDataSources`, property, renamed).
- `source_collections` → `sourceCollections` (Graph `sourceCollections`, property, renamed).

### `beta/compliance/ediscovery/cases/custodians/site-sources` → `beta/compliance/ediscovery/cases/custodians/siteSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).
- `custodian_id` → `custodian-id` (Graph `custodian-id`, url_parameter, renamed).

### `beta/compliance/ediscovery/cases/custodians/unified-group-sources` → `beta/compliance/ediscovery/cases/custodians/unifiedGroupSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `included_sources` → `includedSources` (Graph `includedSources`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).
- `custodian_id` → `custodian-id` (Graph `custodian-id`, url_parameter, renamed).

### `beta/compliance/ediscovery/cases/custodians/user-sources` → `beta/compliance/ediscovery/cases/custodians/userSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `included_sources` → `includedSources` (Graph `includedSources`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).
- `custodian_id` → `custodian-id` (Graph `custodian-id`, url_parameter, renamed).

### `beta/compliance/ediscovery/cases/legal-holds` → `beta/compliance/ediscovery/cases/legalHolds`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `content_query` → `contentQuery` (Graph `contentQuery`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `site_sources` → `siteSources` (Graph `siteSources`, property, renamed).
- `unified_group_sources` → `unifiedGroupSources` (Graph `unifiedGroupSources`, property, renamed).
- `user_sources` → `userSources` (Graph `userSources`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).

### `beta/compliance/ediscovery/cases/review-sets/queries` → `beta/compliance/ediscovery/cases/reviewSets/queries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).
- `review_set_id` → `reviewSet-id` (Graph `reviewSet-id`, url_parameter, renamed).

### `beta/compliance/ediscovery/cases/source-collections` → `beta/compliance/ediscovery/cases/sourceCollections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `add_to_review_set_operation` → `addToReviewSetOperation` (Graph `addToReviewSetOperation`, property, renamed).
- `additional_sources` → `additionalSources` (Graph `additionalSources`, property, renamed).
- `content_query` → `contentQuery` (Graph `contentQuery`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custodian_sources` → `custodianSources` (Graph `custodianSources`, property, renamed).
- `data_source_scopes` → `dataSourceScopes` (Graph `dataSourceScopes`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_estimate_statistics_operation` → `lastEstimateStatisticsOperation` (Graph `lastEstimateStatisticsOperation`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `noncustodial_sources` → `noncustodialSources` (Graph `noncustodialSources`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).

### `beta/compliance/ediscovery/cases/tags` → `beta/compliance/ediscovery/cases/tags`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `child_selectability` → `childSelectability` (Graph `childSelectability`, property, renamed).
- `child_tags` → `childTags` (Graph `childTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).

### `beta/device-app-management/android-managed-app-protections` → `beta/deviceAppManagement/androidManagedAppProtections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_android_device_manufacturers` → `allowedAndroidDeviceManufacturers` (Graph `allowedAndroidDeviceManufacturers`, property, renamed).
- `allowed_android_device_models` → `allowedAndroidDeviceModels` (Graph `allowedAndroidDeviceModels`, property, renamed).
- `allowed_data_ingestion_locations` → `allowedDataIngestionLocations` (Graph `allowedDataIngestionLocations`, property, renamed).
- `allowed_data_storage_locations` → `allowedDataStorageLocations` (Graph `allowedDataStorageLocations`, property, renamed).
- `allowed_inbound_data_transfer_sources` → `allowedInboundDataTransferSources` (Graph `allowedInboundDataTransferSources`, property, renamed).
- `allowed_outbound_clipboard_sharing_exception_length` → `allowedOutboundClipboardSharingExceptionLength` (Graph `allowedOutboundClipboardSharingExceptionLength`, property, renamed).
- `allowed_outbound_clipboard_sharing_level` → `allowedOutboundClipboardSharingLevel` (Graph `allowedOutboundClipboardSharingLevel`, property, renamed).
- `allowed_outbound_data_transfer_destinations` → `allowedOutboundDataTransferDestinations` (Graph `allowedOutboundDataTransferDestinations`, property, renamed).
- `app_action_if_account_is_clocked_out` → `appActionIfAccountIsClockedOut` (Graph `appActionIfAccountIsClockedOut`, property, renamed).
- `app_action_if_android_device_manufacturer_not_allowed` → `appActionIfAndroidDeviceManufacturerNotAllowed` (Graph `appActionIfAndroidDeviceManufacturerNotAllowed`, property, renamed).
- `app_action_if_android_device_model_not_allowed` → `appActionIfAndroidDeviceModelNotAllowed` (Graph `appActionIfAndroidDeviceModelNotAllowed`, property, renamed).
- `app_action_if_android_safety_net_apps_verification_failed` → `appActionIfAndroidSafetyNetAppsVerificationFailed` (Graph `appActionIfAndroidSafetyNetAppsVerificationFailed`, property, renamed).
- `app_action_if_android_safety_net_device_attestation_failed` → `appActionIfAndroidSafetyNetDeviceAttestationFailed` (Graph `appActionIfAndroidSafetyNetDeviceAttestationFailed`, property, renamed).
- `app_action_if_developer_options_enabled` → `appActionIfDeveloperOptionsEnabled` (Graph `appActionIfDeveloperOptionsEnabled`, property, renamed).
- `app_action_if_device_compliance_required` → `appActionIfDeviceComplianceRequired` (Graph `appActionIfDeviceComplianceRequired`, property, renamed).
- `app_action_if_device_lock_not_set` → `appActionIfDeviceLockNotSet` (Graph `appActionIfDeviceLockNotSet`, property, renamed).
- `app_action_if_device_passcode_complexity_less_than_high` → `appActionIfDevicePasscodeComplexityLessThanHigh` (Graph `appActionIfDevicePasscodeComplexityLessThanHigh`, property, renamed).
- `app_action_if_device_passcode_complexity_less_than_low` → `appActionIfDevicePasscodeComplexityLessThanLow` (Graph `appActionIfDevicePasscodeComplexityLessThanLow`, property, renamed).
- `app_action_if_device_passcode_complexity_less_than_medium` → `appActionIfDevicePasscodeComplexityLessThanMedium` (Graph `appActionIfDevicePasscodeComplexityLessThanMedium`, property, renamed).
- `app_action_if_maximum_pin_retries_exceeded` → `appActionIfMaximumPinRetriesExceeded` (Graph `appActionIfMaximumPinRetriesExceeded`, property, renamed).
- `app_action_if_samsung_knox_attestation_required` → `appActionIfSamsungKnoxAttestationRequired` (Graph `appActionIfSamsungKnoxAttestationRequired`, property, renamed).
- `app_action_if_unable_to_authenticate_user` → `appActionIfUnableToAuthenticateUser` (Graph `appActionIfUnableToAuthenticateUser`, property, renamed).
- `app_group_type` → `appGroupType` (Graph `appGroupType`, property, renamed).
- `approved_keyboards` → `approvedKeyboards` (Graph `approvedKeyboards`, property, renamed).
- `biometric_authentication_blocked` → `biometricAuthenticationBlocked` (Graph `biometricAuthenticationBlocked`, property, renamed).
- `block_after_company_portal_update_deferral_in_days` → `blockAfterCompanyPortalUpdateDeferralInDays` (Graph `blockAfterCompanyPortalUpdateDeferralInDays`, property, renamed).
- `block_data_ingestion_into_organization_documents` → `blockDataIngestionIntoOrganizationDocuments` (Graph `blockDataIngestionIntoOrganizationDocuments`, property, renamed).
- `connect_to_vpn_on_launch` → `connectToVpnOnLaunch` (Graph `connectToVpnOnLaunch`, property, renamed).
- `contact_sync_blocked` → `contactSyncBlocked` (Graph `contactSyncBlocked`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_browser_display_name` → `customBrowserDisplayName` (Graph `customBrowserDisplayName`, property, renamed).
- `custom_browser_package_id` → `customBrowserPackageId` (Graph `customBrowserPackageId`, property, renamed).
- `custom_dialer_app_display_name` → `customDialerAppDisplayName` (Graph `customDialerAppDisplayName`, property, renamed).
- `custom_dialer_app_package_id` → `customDialerAppPackageId` (Graph `customDialerAppPackageId`, property, renamed).
- `data_backup_blocked` → `dataBackupBlocked` (Graph `dataBackupBlocked`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `device_compliance_required` → `deviceComplianceRequired` (Graph `deviceComplianceRequired`, property, renamed).
- `device_lock_required` → `deviceLockRequired` (Graph `deviceLockRequired`, property, renamed).
- `dialer_restriction_level` → `dialerRestrictionLevel` (Graph `dialerRestrictionLevel`, property, renamed).
- `disable_app_encryption_if_device_encryption_is_enabled` → `disableAppEncryptionIfDeviceEncryptionIsEnabled` (Graph `disableAppEncryptionIfDeviceEncryptionIsEnabled`, property, renamed).
- `disable_app_pin_if_device_pin_is_set` → `disableAppPinIfDevicePinIsSet` (Graph `disableAppPinIfDevicePinIsSet`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `encrypt_app_data` → `encryptAppData` (Graph `encryptAppData`, property, renamed).
- `exempted_app_packages` → `exemptedAppPackages` (Graph `exemptedAppPackages`, property, renamed).
- `fingerprint_and_biometric_enabled` → `fingerprintAndBiometricEnabled` (Graph `fingerprintAndBiometricEnabled`, property, renamed).
- `fingerprint_blocked` → `fingerprintBlocked` (Graph `fingerprintBlocked`, property, renamed).
- `grace_period_to_block_apps_during_off_clock_hours` → `gracePeriodToBlockAppsDuringOffClockHours` (Graph `gracePeriodToBlockAppsDuringOffClockHours`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `keyboards_restricted` → `keyboardsRestricted` (Graph `keyboardsRestricted`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_browser` → `managedBrowser` (Graph `managedBrowser`, property, renamed).
- `managed_browser_to_open_links_required` → `managedBrowserToOpenLinksRequired` (Graph `managedBrowserToOpenLinksRequired`, property, renamed).
- `maximum_allowed_device_threat_level` → `maximumAllowedDeviceThreatLevel` (Graph `maximumAllowedDeviceThreatLevel`, property, renamed).
- `maximum_pin_retries` → `maximumPinRetries` (Graph `maximumPinRetries`, property, renamed).
- `maximum_required_os_version` → `maximumRequiredOsVersion` (Graph `maximumRequiredOsVersion`, property, renamed).
- `maximum_warning_os_version` → `maximumWarningOsVersion` (Graph `maximumWarningOsVersion`, property, renamed).
- `maximum_wipe_os_version` → `maximumWipeOsVersion` (Graph `maximumWipeOsVersion`, property, renamed).
- `messaging_redirect_app_display_name` → `messagingRedirectAppDisplayName` (Graph `messagingRedirectAppDisplayName`, property, renamed).
- `messaging_redirect_app_package_id` → `messagingRedirectAppPackageId` (Graph `messagingRedirectAppPackageId`, property, renamed).
- `minimum_pin_length` → `minimumPinLength` (Graph `minimumPinLength`, property, renamed).
- `minimum_required_app_version` → `minimumRequiredAppVersion` (Graph `minimumRequiredAppVersion`, property, renamed).
- `minimum_required_company_portal_version` → `minimumRequiredCompanyPortalVersion` (Graph `minimumRequiredCompanyPortalVersion`, property, renamed).
- `minimum_required_os_version` → `minimumRequiredOsVersion` (Graph `minimumRequiredOsVersion`, property, renamed).
- `minimum_required_patch_version` → `minimumRequiredPatchVersion` (Graph `minimumRequiredPatchVersion`, property, renamed).
- `minimum_warning_app_version` → `minimumWarningAppVersion` (Graph `minimumWarningAppVersion`, property, renamed).
- `minimum_warning_company_portal_version` → `minimumWarningCompanyPortalVersion` (Graph `minimumWarningCompanyPortalVersion`, property, renamed).
- `minimum_warning_os_version` → `minimumWarningOsVersion` (Graph `minimumWarningOsVersion`, property, renamed).
- `minimum_warning_patch_version` → `minimumWarningPatchVersion` (Graph `minimumWarningPatchVersion`, property, renamed).
- `minimum_wipe_app_version` → `minimumWipeAppVersion` (Graph `minimumWipeAppVersion`, property, renamed).
- `minimum_wipe_company_portal_version` → `minimumWipeCompanyPortalVersion` (Graph `minimumWipeCompanyPortalVersion`, property, renamed).
- `minimum_wipe_os_version` → `minimumWipeOsVersion` (Graph `minimumWipeOsVersion`, property, renamed).
- `minimum_wipe_patch_version` → `minimumWipePatchVersion` (Graph `minimumWipePatchVersion`, property, renamed).
- `mobile_threat_defense_partner_priority` → `mobileThreatDefensePartnerPriority` (Graph `mobileThreatDefensePartnerPriority`, property, renamed).
- `mobile_threat_defense_remediation_action` → `mobileThreatDefenseRemediationAction` (Graph `mobileThreatDefenseRemediationAction`, property, renamed).
- `notification_restriction` → `notificationRestriction` (Graph `notificationRestriction`, property, renamed).
- `organizational_credentials_required` → `organizationalCredentialsRequired` (Graph `organizationalCredentialsRequired`, property, renamed).
- `period_before_pin_reset` → `periodBeforePinReset` (Graph `periodBeforePinReset`, property, renamed).
- `period_offline_before_access_check` → `periodOfflineBeforeAccessCheck` (Graph `periodOfflineBeforeAccessCheck`, property, renamed).
- `period_offline_before_wipe_is_enforced` → `periodOfflineBeforeWipeIsEnforced` (Graph `periodOfflineBeforeWipeIsEnforced`, property, renamed).
- `period_online_before_access_check` → `periodOnlineBeforeAccessCheck` (Graph `periodOnlineBeforeAccessCheck`, property, renamed).
- `pin_character_set` → `pinCharacterSet` (Graph `pinCharacterSet`, property, renamed).
- `pin_required` → `pinRequired` (Graph `pinRequired`, property, renamed).
- `pin_required_instead_of_biometric_timeout` → `pinRequiredInsteadOfBiometricTimeout` (Graph `pinRequiredInsteadOfBiometricTimeout`, property, renamed).
- `previous_pin_block_count` → `previousPinBlockCount` (Graph `previousPinBlockCount`, property, renamed).
- `print_blocked` → `printBlocked` (Graph `printBlocked`, property, renamed).
- `protected_messaging_redirect_app_type` → `protectedMessagingRedirectAppType` (Graph `protectedMessagingRedirectAppType`, property, renamed).
- `purview_content_evaluation_required` → `purviewContentEvaluationRequired` (Graph `purviewContentEvaluationRequired`, property, renamed).
- `require_class3_biometrics` → `requireClass3Biometrics` (Graph `requireClass3Biometrics`, property, renamed).
- `require_pin_after_biometric_change` → `requirePinAfterBiometricChange` (Graph `requirePinAfterBiometricChange`, property, renamed).
- `required_android_safety_net_apps_verification_type` → `requiredAndroidSafetyNetAppsVerificationType` (Graph `requiredAndroidSafetyNetAppsVerificationType`, property, renamed).
- `required_android_safety_net_device_attestation_type` → `requiredAndroidSafetyNetDeviceAttestationType` (Graph `requiredAndroidSafetyNetDeviceAttestationType`, property, renamed).
- `required_android_safety_net_evaluation_type` → `requiredAndroidSafetyNetEvaluationType` (Graph `requiredAndroidSafetyNetEvaluationType`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `save_as_blocked` → `saveAsBlocked` (Graph `saveAsBlocked`, property, renamed).
- `screen_capture_blocked` → `screenCaptureBlocked` (Graph `screenCaptureBlocked`, property, renamed).
- `simple_pin_blocked` → `simplePinBlocked` (Graph `simplePinBlocked`, property, renamed).
- `targeted_app_management_levels` → `targetedAppManagementLevels` (Graph `targetedAppManagementLevels`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `warn_after_company_portal_update_deferral_in_days` → `warnAfterCompanyPortalUpdateDeferralInDays` (Graph `warnAfterCompanyPortalUpdateDeferralInDays`, property, renamed).
- `wipe_after_company_portal_update_deferral_in_days` → `wipeAfterCompanyPortalUpdateDeferralInDays` (Graph `wipeAfterCompanyPortalUpdateDeferralInDays`, property, renamed).

### `beta/device-app-management/android-managed-app-protections/apps` → `beta/deviceAppManagement/androidManagedAppProtections/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `android_managed_app_protection_id` → `androidManagedAppProtection-id` (Graph `androidManagedAppProtection-id`, url_parameter, renamed).

### `beta/device-app-management/default-managed-app-protections` → `beta/deviceAppManagement/defaultManagedAppProtections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_widget_content_sync` → `allowWidgetContentSync` (Graph `allowWidgetContentSync`, property, renamed).
- `allowed_android_device_manufacturers` → `allowedAndroidDeviceManufacturers` (Graph `allowedAndroidDeviceManufacturers`, property, renamed).
- `allowed_android_device_models` → `allowedAndroidDeviceModels` (Graph `allowedAndroidDeviceModels`, property, renamed).
- `allowed_data_ingestion_locations` → `allowedDataIngestionLocations` (Graph `allowedDataIngestionLocations`, property, renamed).
- `allowed_data_storage_locations` → `allowedDataStorageLocations` (Graph `allowedDataStorageLocations`, property, renamed).
- `allowed_inbound_data_transfer_sources` → `allowedInboundDataTransferSources` (Graph `allowedInboundDataTransferSources`, property, renamed).
- `allowed_ios_device_models` → `allowedIosDeviceModels` (Graph `allowedIosDeviceModels`, property, renamed).
- `allowed_outbound_clipboard_sharing_exception_length` → `allowedOutboundClipboardSharingExceptionLength` (Graph `allowedOutboundClipboardSharingExceptionLength`, property, renamed).
- `allowed_outbound_clipboard_sharing_level` → `allowedOutboundClipboardSharingLevel` (Graph `allowedOutboundClipboardSharingLevel`, property, renamed).
- `allowed_outbound_data_transfer_destinations` → `allowedOutboundDataTransferDestinations` (Graph `allowedOutboundDataTransferDestinations`, property, renamed).
- `app_action_if_account_is_clocked_out` → `appActionIfAccountIsClockedOut` (Graph `appActionIfAccountIsClockedOut`, property, renamed).
- `app_action_if_android_device_manufacturer_not_allowed` → `appActionIfAndroidDeviceManufacturerNotAllowed` (Graph `appActionIfAndroidDeviceManufacturerNotAllowed`, property, renamed).
- `app_action_if_android_device_model_not_allowed` → `appActionIfAndroidDeviceModelNotAllowed` (Graph `appActionIfAndroidDeviceModelNotAllowed`, property, renamed).
- `app_action_if_android_safety_net_apps_verification_failed` → `appActionIfAndroidSafetyNetAppsVerificationFailed` (Graph `appActionIfAndroidSafetyNetAppsVerificationFailed`, property, renamed).
- `app_action_if_android_safety_net_device_attestation_failed` → `appActionIfAndroidSafetyNetDeviceAttestationFailed` (Graph `appActionIfAndroidSafetyNetDeviceAttestationFailed`, property, renamed).
- `app_action_if_device_compliance_required` → `appActionIfDeviceComplianceRequired` (Graph `appActionIfDeviceComplianceRequired`, property, renamed).
- `app_action_if_device_lock_not_set` → `appActionIfDeviceLockNotSet` (Graph `appActionIfDeviceLockNotSet`, property, renamed).
- `app_action_if_device_passcode_complexity_less_than_high` → `appActionIfDevicePasscodeComplexityLessThanHigh` (Graph `appActionIfDevicePasscodeComplexityLessThanHigh`, property, renamed).
- `app_action_if_device_passcode_complexity_less_than_low` → `appActionIfDevicePasscodeComplexityLessThanLow` (Graph `appActionIfDevicePasscodeComplexityLessThanLow`, property, renamed).
- `app_action_if_device_passcode_complexity_less_than_medium` → `appActionIfDevicePasscodeComplexityLessThanMedium` (Graph `appActionIfDevicePasscodeComplexityLessThanMedium`, property, renamed).
- `app_action_if_ios_device_model_not_allowed` → `appActionIfIosDeviceModelNotAllowed` (Graph `appActionIfIosDeviceModelNotAllowed`, property, renamed).
- `app_action_if_maximum_pin_retries_exceeded` → `appActionIfMaximumPinRetriesExceeded` (Graph `appActionIfMaximumPinRetriesExceeded`, property, renamed).
- `app_action_if_unable_to_authenticate_user` → `appActionIfUnableToAuthenticateUser` (Graph `appActionIfUnableToAuthenticateUser`, property, renamed).
- `app_data_encryption_type` → `appDataEncryptionType` (Graph `appDataEncryptionType`, property, renamed).
- `biometric_authentication_blocked` → `biometricAuthenticationBlocked` (Graph `biometricAuthenticationBlocked`, property, renamed).
- `block_after_company_portal_update_deferral_in_days` → `blockAfterCompanyPortalUpdateDeferralInDays` (Graph `blockAfterCompanyPortalUpdateDeferralInDays`, property, renamed).
- `block_data_ingestion_into_organization_documents` → `blockDataIngestionIntoOrganizationDocuments` (Graph `blockDataIngestionIntoOrganizationDocuments`, property, renamed).
- `connect_to_vpn_on_launch` → `connectToVpnOnLaunch` (Graph `connectToVpnOnLaunch`, property, renamed).
- `contact_sync_blocked` → `contactSyncBlocked` (Graph `contactSyncBlocked`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_browser_display_name` → `customBrowserDisplayName` (Graph `customBrowserDisplayName`, property, renamed).
- `custom_browser_package_id` → `customBrowserPackageId` (Graph `customBrowserPackageId`, property, renamed).
- `custom_browser_protocol` → `customBrowserProtocol` (Graph `customBrowserProtocol`, property, renamed).
- `custom_dialer_app_display_name` → `customDialerAppDisplayName` (Graph `customDialerAppDisplayName`, property, renamed).
- `custom_dialer_app_package_id` → `customDialerAppPackageId` (Graph `customDialerAppPackageId`, property, renamed).
- `custom_dialer_app_protocol` → `customDialerAppProtocol` (Graph `customDialerAppProtocol`, property, renamed).
- `custom_settings` → `customSettings` (Graph `customSettings`, property, renamed).
- `data_backup_blocked` → `dataBackupBlocked` (Graph `dataBackupBlocked`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `device_compliance_required` → `deviceComplianceRequired` (Graph `deviceComplianceRequired`, property, renamed).
- `device_lock_required` → `deviceLockRequired` (Graph `deviceLockRequired`, property, renamed).
- `dialer_restriction_level` → `dialerRestrictionLevel` (Graph `dialerRestrictionLevel`, property, renamed).
- `disable_app_encryption_if_device_encryption_is_enabled` → `disableAppEncryptionIfDeviceEncryptionIsEnabled` (Graph `disableAppEncryptionIfDeviceEncryptionIsEnabled`, property, renamed).
- `disable_app_pin_if_device_pin_is_set` → `disableAppPinIfDevicePinIsSet` (Graph `disableAppPinIfDevicePinIsSet`, property, renamed).
- `disable_protection_of_managed_outbound_open_in_data` → `disableProtectionOfManagedOutboundOpenInData` (Graph `disableProtectionOfManagedOutboundOpenInData`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `encrypt_app_data` → `encryptAppData` (Graph `encryptAppData`, property, renamed).
- `exempted_app_packages` → `exemptedAppPackages` (Graph `exemptedAppPackages`, property, renamed).
- `exempted_app_protocols` → `exemptedAppProtocols` (Graph `exemptedAppProtocols`, property, renamed).
- `face_id_blocked` → `faceIdBlocked` (Graph `faceIdBlocked`, property, renamed).
- `filter_open_in_to_only_managed_apps` → `filterOpenInToOnlyManagedApps` (Graph `filterOpenInToOnlyManagedApps`, property, renamed).
- `fingerprint_and_biometric_enabled` → `fingerprintAndBiometricEnabled` (Graph `fingerprintAndBiometricEnabled`, property, renamed).
- `fingerprint_blocked` → `fingerprintBlocked` (Graph `fingerprintBlocked`, property, renamed).
- `grace_period_to_block_apps_during_off_clock_hours` → `gracePeriodToBlockAppsDuringOffClockHours` (Graph `gracePeriodToBlockAppsDuringOffClockHours`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_browser` → `managedBrowser` (Graph `managedBrowser`, property, renamed).
- `managed_browser_to_open_links_required` → `managedBrowserToOpenLinksRequired` (Graph `managedBrowserToOpenLinksRequired`, property, renamed).
- `maximum_allowed_device_threat_level` → `maximumAllowedDeviceThreatLevel` (Graph `maximumAllowedDeviceThreatLevel`, property, renamed).
- `maximum_pin_retries` → `maximumPinRetries` (Graph `maximumPinRetries`, property, renamed).
- `maximum_required_os_version` → `maximumRequiredOsVersion` (Graph `maximumRequiredOsVersion`, property, renamed).
- `maximum_warning_os_version` → `maximumWarningOsVersion` (Graph `maximumWarningOsVersion`, property, renamed).
- `maximum_wipe_os_version` → `maximumWipeOsVersion` (Graph `maximumWipeOsVersion`, property, renamed).
- `messaging_redirect_app_display_name` → `messagingRedirectAppDisplayName` (Graph `messagingRedirectAppDisplayName`, property, renamed).
- `messaging_redirect_app_package_id` → `messagingRedirectAppPackageId` (Graph `messagingRedirectAppPackageId`, property, renamed).
- `messaging_redirect_app_url_scheme` → `messagingRedirectAppUrlScheme` (Graph `messagingRedirectAppUrlScheme`, property, renamed).
- `minimum_pin_length` → `minimumPinLength` (Graph `minimumPinLength`, property, renamed).
- `minimum_required_app_version` → `minimumRequiredAppVersion` (Graph `minimumRequiredAppVersion`, property, renamed).
- `minimum_required_company_portal_version` → `minimumRequiredCompanyPortalVersion` (Graph `minimumRequiredCompanyPortalVersion`, property, renamed).
- `minimum_required_os_version` → `minimumRequiredOsVersion` (Graph `minimumRequiredOsVersion`, property, renamed).
- `minimum_required_patch_version` → `minimumRequiredPatchVersion` (Graph `minimumRequiredPatchVersion`, property, renamed).
- `minimum_required_sdk_version` → `minimumRequiredSdkVersion` (Graph `minimumRequiredSdkVersion`, property, renamed).
- `minimum_warning_app_version` → `minimumWarningAppVersion` (Graph `minimumWarningAppVersion`, property, renamed).
- `minimum_warning_company_portal_version` → `minimumWarningCompanyPortalVersion` (Graph `minimumWarningCompanyPortalVersion`, property, renamed).
- `minimum_warning_os_version` → `minimumWarningOsVersion` (Graph `minimumWarningOsVersion`, property, renamed).
- `minimum_warning_patch_version` → `minimumWarningPatchVersion` (Graph `minimumWarningPatchVersion`, property, renamed).
- `minimum_warning_sdk_version` → `minimumWarningSdkVersion` (Graph `minimumWarningSdkVersion`, property, renamed).
- `minimum_wipe_app_version` → `minimumWipeAppVersion` (Graph `minimumWipeAppVersion`, property, renamed).
- `minimum_wipe_company_portal_version` → `minimumWipeCompanyPortalVersion` (Graph `minimumWipeCompanyPortalVersion`, property, renamed).
- `minimum_wipe_os_version` → `minimumWipeOsVersion` (Graph `minimumWipeOsVersion`, property, renamed).
- `minimum_wipe_patch_version` → `minimumWipePatchVersion` (Graph `minimumWipePatchVersion`, property, renamed).
- `minimum_wipe_sdk_version` → `minimumWipeSdkVersion` (Graph `minimumWipeSdkVersion`, property, renamed).
- `mobile_threat_defense_partner_priority` → `mobileThreatDefensePartnerPriority` (Graph `mobileThreatDefensePartnerPriority`, property, renamed).
- `mobile_threat_defense_remediation_action` → `mobileThreatDefenseRemediationAction` (Graph `mobileThreatDefenseRemediationAction`, property, renamed).
- `notification_restriction` → `notificationRestriction` (Graph `notificationRestriction`, property, renamed).
- `organizational_credentials_required` → `organizationalCredentialsRequired` (Graph `organizationalCredentialsRequired`, property, renamed).
- `period_before_pin_reset` → `periodBeforePinReset` (Graph `periodBeforePinReset`, property, renamed).
- `period_offline_before_access_check` → `periodOfflineBeforeAccessCheck` (Graph `periodOfflineBeforeAccessCheck`, property, renamed).
- `period_offline_before_wipe_is_enforced` → `periodOfflineBeforeWipeIsEnforced` (Graph `periodOfflineBeforeWipeIsEnforced`, property, renamed).
- `period_online_before_access_check` → `periodOnlineBeforeAccessCheck` (Graph `periodOnlineBeforeAccessCheck`, property, renamed).
- `pin_character_set` → `pinCharacterSet` (Graph `pinCharacterSet`, property, renamed).
- `pin_required` → `pinRequired` (Graph `pinRequired`, property, renamed).
- `pin_required_instead_of_biometric_timeout` → `pinRequiredInsteadOfBiometricTimeout` (Graph `pinRequiredInsteadOfBiometricTimeout`, property, renamed).
- `previous_pin_block_count` → `previousPinBlockCount` (Graph `previousPinBlockCount`, property, renamed).
- `print_blocked` → `printBlocked` (Graph `printBlocked`, property, renamed).
- `protect_inbound_data_from_unknown_sources` → `protectInboundDataFromUnknownSources` (Graph `protectInboundDataFromUnknownSources`, property, renamed).
- `protected_messaging_redirect_app_type` → `protectedMessagingRedirectAppType` (Graph `protectedMessagingRedirectAppType`, property, renamed).
- `purview_content_evaluation_required` → `purviewContentEvaluationRequired` (Graph `purviewContentEvaluationRequired`, property, renamed).
- `require_class3_biometrics` → `requireClass3Biometrics` (Graph `requireClass3Biometrics`, property, renamed).
- `require_pin_after_biometric_change` → `requirePinAfterBiometricChange` (Graph `requirePinAfterBiometricChange`, property, renamed).
- `required_android_safety_net_apps_verification_type` → `requiredAndroidSafetyNetAppsVerificationType` (Graph `requiredAndroidSafetyNetAppsVerificationType`, property, renamed).
- `required_android_safety_net_device_attestation_type` → `requiredAndroidSafetyNetDeviceAttestationType` (Graph `requiredAndroidSafetyNetDeviceAttestationType`, property, renamed).
- `required_android_safety_net_evaluation_type` → `requiredAndroidSafetyNetEvaluationType` (Graph `requiredAndroidSafetyNetEvaluationType`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `save_as_blocked` → `saveAsBlocked` (Graph `saveAsBlocked`, property, renamed).
- `screen_capture_blocked` → `screenCaptureBlocked` (Graph `screenCaptureBlocked`, property, renamed).
- `simple_pin_blocked` → `simplePinBlocked` (Graph `simplePinBlocked`, property, renamed).
- `third_party_keyboards_blocked` → `thirdPartyKeyboardsBlocked` (Graph `thirdPartyKeyboardsBlocked`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `warn_after_company_portal_update_deferral_in_days` → `warnAfterCompanyPortalUpdateDeferralInDays` (Graph `warnAfterCompanyPortalUpdateDeferralInDays`, property, renamed).
- `wipe_after_company_portal_update_deferral_in_days` → `wipeAfterCompanyPortalUpdateDeferralInDays` (Graph `wipeAfterCompanyPortalUpdateDeferralInDays`, property, renamed).

### `beta/device-app-management/default-managed-app-protections/apps` → `beta/deviceAppManagement/defaultManagedAppProtections/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `default_managed_app_protection_id` → `defaultManagedAppProtection-id` (Graph `defaultManagedAppProtection-id`, url_parameter, renamed).

### `beta/device-app-management/device-app-management-tasks` → `beta/deviceAppManagement/deviceAppManagementTasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_to` → `assignedTo` (Graph `assignedTo`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `creator_notes` → `creatorNotes` (Graph `creatorNotes`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).

### `beta/device-app-management/enterprise-code-signing-certificates` → `beta/deviceAppManagement/enterpriseCodeSigningCertificates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `issuer_name` → `issuerName` (Graph `issuerName`, property, renamed).
- `subject_name` → `subjectName` (Graph `subjectName`, property, renamed).
- `upload_date_time` → `uploadDateTime` (Graph `uploadDateTime`, property, renamed).

### `beta/device-app-management/ios-lob-app-provisioning-configurations` → `beta/deviceAppManagement/iosLobAppProvisioningConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `group_assignments` → `groupAssignments` (Graph `groupAssignments`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `payload_file_name` → `payloadFileName` (Graph `payloadFileName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `user_statuses` → `userStatuses` (Graph `userStatuses`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-app-management/ios-lob-app-provisioning-configurations/assignments` → `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `ios_lob_app_provisioning_configuration_id` → `iosLobAppProvisioningConfiguration-id` (Graph `iosLobAppProvisioningConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/ios-lob-app-provisioning-configurations/device-statuses` → `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `ios_lob_app_provisioning_configuration_id` → `iosLobAppProvisioningConfiguration-id` (Graph `iosLobAppProvisioningConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/ios-lob-app-provisioning-configurations/group-assignments` → `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/groupAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `target_group_id` → `targetGroupId` (Graph `targetGroupId`, property, renamed).
- `ios_lob_app_provisioning_configuration_id` → `iosLobAppProvisioningConfiguration-id` (Graph `iosLobAppProvisioningConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/ios-lob-app-provisioning-configurations/user-statuses` → `beta/deviceAppManagement/iosLobAppProvisioningConfigurations/userStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `devices_count` → `devicesCount` (Graph `devicesCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `ios_lob_app_provisioning_configuration_id` → `iosLobAppProvisioningConfiguration-id` (Graph `iosLobAppProvisioningConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/ios-managed-app-protections` → `beta/deviceAppManagement/iosManagedAppProtections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_widget_content_sync` → `allowWidgetContentSync` (Graph `allowWidgetContentSync`, property, renamed).
- `allowed_data_ingestion_locations` → `allowedDataIngestionLocations` (Graph `allowedDataIngestionLocations`, property, renamed).
- `allowed_data_storage_locations` → `allowedDataStorageLocations` (Graph `allowedDataStorageLocations`, property, renamed).
- `allowed_inbound_data_transfer_sources` → `allowedInboundDataTransferSources` (Graph `allowedInboundDataTransferSources`, property, renamed).
- `allowed_ios_device_models` → `allowedIosDeviceModels` (Graph `allowedIosDeviceModels`, property, renamed).
- `allowed_outbound_clipboard_sharing_exception_length` → `allowedOutboundClipboardSharingExceptionLength` (Graph `allowedOutboundClipboardSharingExceptionLength`, property, renamed).
- `allowed_outbound_clipboard_sharing_level` → `allowedOutboundClipboardSharingLevel` (Graph `allowedOutboundClipboardSharingLevel`, property, renamed).
- `allowed_outbound_data_transfer_destinations` → `allowedOutboundDataTransferDestinations` (Graph `allowedOutboundDataTransferDestinations`, property, renamed).
- `app_action_if_account_is_clocked_out` → `appActionIfAccountIsClockedOut` (Graph `appActionIfAccountIsClockedOut`, property, renamed).
- `app_action_if_device_compliance_required` → `appActionIfDeviceComplianceRequired` (Graph `appActionIfDeviceComplianceRequired`, property, renamed).
- `app_action_if_ios_device_model_not_allowed` → `appActionIfIosDeviceModelNotAllowed` (Graph `appActionIfIosDeviceModelNotAllowed`, property, renamed).
- `app_action_if_maximum_pin_retries_exceeded` → `appActionIfMaximumPinRetriesExceeded` (Graph `appActionIfMaximumPinRetriesExceeded`, property, renamed).
- `app_action_if_unable_to_authenticate_user` → `appActionIfUnableToAuthenticateUser` (Graph `appActionIfUnableToAuthenticateUser`, property, renamed).
- `app_data_encryption_type` → `appDataEncryptionType` (Graph `appDataEncryptionType`, property, renamed).
- `app_group_type` → `appGroupType` (Graph `appGroupType`, property, renamed).
- `block_data_ingestion_into_organization_documents` → `blockDataIngestionIntoOrganizationDocuments` (Graph `blockDataIngestionIntoOrganizationDocuments`, property, renamed).
- `contact_sync_blocked` → `contactSyncBlocked` (Graph `contactSyncBlocked`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_browser_protocol` → `customBrowserProtocol` (Graph `customBrowserProtocol`, property, renamed).
- `custom_dialer_app_protocol` → `customDialerAppProtocol` (Graph `customDialerAppProtocol`, property, renamed).
- `data_backup_blocked` → `dataBackupBlocked` (Graph `dataBackupBlocked`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `device_compliance_required` → `deviceComplianceRequired` (Graph `deviceComplianceRequired`, property, renamed).
- `dialer_restriction_level` → `dialerRestrictionLevel` (Graph `dialerRestrictionLevel`, property, renamed).
- `disable_app_pin_if_device_pin_is_set` → `disableAppPinIfDevicePinIsSet` (Graph `disableAppPinIfDevicePinIsSet`, property, renamed).
- `disable_protection_of_managed_outbound_open_in_data` → `disableProtectionOfManagedOutboundOpenInData` (Graph `disableProtectionOfManagedOutboundOpenInData`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `exempted_app_protocols` → `exemptedAppProtocols` (Graph `exemptedAppProtocols`, property, renamed).
- `exempted_universal_links` → `exemptedUniversalLinks` (Graph `exemptedUniversalLinks`, property, renamed).
- `face_id_blocked` → `faceIdBlocked` (Graph `faceIdBlocked`, property, renamed).
- `filter_open_in_to_only_managed_apps` → `filterOpenInToOnlyManagedApps` (Graph `filterOpenInToOnlyManagedApps`, property, renamed).
- `fingerprint_blocked` → `fingerprintBlocked` (Graph `fingerprintBlocked`, property, renamed).
- `genmoji_configuration_state` → `genmojiConfigurationState` (Graph `genmojiConfigurationState`, property, renamed).
- `grace_period_to_block_apps_during_off_clock_hours` → `gracePeriodToBlockAppsDuringOffClockHours` (Graph `gracePeriodToBlockAppsDuringOffClockHours`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `managed_browser` → `managedBrowser` (Graph `managedBrowser`, property, renamed).
- `managed_browser_to_open_links_required` → `managedBrowserToOpenLinksRequired` (Graph `managedBrowserToOpenLinksRequired`, property, renamed).
- `managed_universal_links` → `managedUniversalLinks` (Graph `managedUniversalLinks`, property, renamed).
- `maximum_allowed_device_threat_level` → `maximumAllowedDeviceThreatLevel` (Graph `maximumAllowedDeviceThreatLevel`, property, renamed).
- `maximum_pin_retries` → `maximumPinRetries` (Graph `maximumPinRetries`, property, renamed).
- `maximum_required_os_version` → `maximumRequiredOsVersion` (Graph `maximumRequiredOsVersion`, property, renamed).
- `maximum_warning_os_version` → `maximumWarningOsVersion` (Graph `maximumWarningOsVersion`, property, renamed).
- `maximum_wipe_os_version` → `maximumWipeOsVersion` (Graph `maximumWipeOsVersion`, property, renamed).
- `messaging_redirect_app_url_scheme` → `messagingRedirectAppUrlScheme` (Graph `messagingRedirectAppUrlScheme`, property, renamed).
- `minimum_pin_length` → `minimumPinLength` (Graph `minimumPinLength`, property, renamed).
- `minimum_required_app_version` → `minimumRequiredAppVersion` (Graph `minimumRequiredAppVersion`, property, renamed).
- `minimum_required_os_version` → `minimumRequiredOsVersion` (Graph `minimumRequiredOsVersion`, property, renamed).
- `minimum_required_sdk_version` → `minimumRequiredSdkVersion` (Graph `minimumRequiredSdkVersion`, property, renamed).
- `minimum_warning_app_version` → `minimumWarningAppVersion` (Graph `minimumWarningAppVersion`, property, renamed).
- `minimum_warning_os_version` → `minimumWarningOsVersion` (Graph `minimumWarningOsVersion`, property, renamed).
- `minimum_warning_sdk_version` → `minimumWarningSdkVersion` (Graph `minimumWarningSdkVersion`, property, renamed).
- `minimum_wipe_app_version` → `minimumWipeAppVersion` (Graph `minimumWipeAppVersion`, property, renamed).
- `minimum_wipe_os_version` → `minimumWipeOsVersion` (Graph `minimumWipeOsVersion`, property, renamed).
- `minimum_wipe_sdk_version` → `minimumWipeSdkVersion` (Graph `minimumWipeSdkVersion`, property, renamed).
- `mobile_threat_defense_partner_priority` → `mobileThreatDefensePartnerPriority` (Graph `mobileThreatDefensePartnerPriority`, property, renamed).
- `mobile_threat_defense_remediation_action` → `mobileThreatDefenseRemediationAction` (Graph `mobileThreatDefenseRemediationAction`, property, renamed).
- `notification_restriction` → `notificationRestriction` (Graph `notificationRestriction`, property, renamed).
- `organizational_credentials_required` → `organizationalCredentialsRequired` (Graph `organizationalCredentialsRequired`, property, renamed).
- `period_before_pin_reset` → `periodBeforePinReset` (Graph `periodBeforePinReset`, property, renamed).
- `period_offline_before_access_check` → `periodOfflineBeforeAccessCheck` (Graph `periodOfflineBeforeAccessCheck`, property, renamed).
- `period_offline_before_wipe_is_enforced` → `periodOfflineBeforeWipeIsEnforced` (Graph `periodOfflineBeforeWipeIsEnforced`, property, renamed).
- `period_online_before_access_check` → `periodOnlineBeforeAccessCheck` (Graph `periodOnlineBeforeAccessCheck`, property, renamed).
- `pin_character_set` → `pinCharacterSet` (Graph `pinCharacterSet`, property, renamed).
- `pin_required` → `pinRequired` (Graph `pinRequired`, property, renamed).
- `pin_required_instead_of_biometric_timeout` → `pinRequiredInsteadOfBiometricTimeout` (Graph `pinRequiredInsteadOfBiometricTimeout`, property, renamed).
- `previous_pin_block_count` → `previousPinBlockCount` (Graph `previousPinBlockCount`, property, renamed).
- `print_blocked` → `printBlocked` (Graph `printBlocked`, property, renamed).
- `protect_inbound_data_from_unknown_sources` → `protectInboundDataFromUnknownSources` (Graph `protectInboundDataFromUnknownSources`, property, renamed).
- `protected_messaging_redirect_app_type` → `protectedMessagingRedirectAppType` (Graph `protectedMessagingRedirectAppType`, property, renamed).
- `purview_content_evaluation_required` → `purviewContentEvaluationRequired` (Graph `purviewContentEvaluationRequired`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `save_as_blocked` → `saveAsBlocked` (Graph `saveAsBlocked`, property, renamed).
- `screen_capture_configuration_state` → `screenCaptureConfigurationState` (Graph `screenCaptureConfigurationState`, property, renamed).
- `simple_pin_blocked` → `simplePinBlocked` (Graph `simplePinBlocked`, property, renamed).
- `targeted_app_management_levels` → `targetedAppManagementLevels` (Graph `targetedAppManagementLevels`, property, renamed).
- `third_party_keyboards_blocked` → `thirdPartyKeyboardsBlocked` (Graph `thirdPartyKeyboardsBlocked`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `writing_tools_configuration_state` → `writingToolsConfigurationState` (Graph `writingToolsConfigurationState`, property, renamed).

### `beta/device-app-management/ios-managed-app-protections/apps` → `beta/deviceAppManagement/iosManagedAppProtections/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `ios_managed_app_protection_id` → `iosManagedAppProtection-id` (Graph `iosManagedAppProtection-id`, url_parameter, renamed).

### `beta/device-app-management/managed-app-registrations` → `beta/deviceAppManagement/managedAppRegistrations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_identifier` → `appIdentifier` (Graph `appIdentifier`, property, renamed).
- `application_version` → `applicationVersion` (Graph `applicationVersion`, property, renamed).
- `applied_policies` → `appliedPolicies` (Graph `appliedPolicies`, property, renamed).
- `azure_ad_device_id` → `azureADDeviceId` (Graph `azureADDeviceId`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_manufacturer` → `deviceManufacturer` (Graph `deviceManufacturer`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `device_tag` → `deviceTag` (Graph `deviceTag`, property, renamed).
- `device_type` → `deviceType` (Graph `deviceType`, property, renamed).
- `flagged_reasons` → `flaggedReasons` (Graph `flaggedReasons`, property, renamed).
- `intended_policies` → `intendedPolicies` (Graph `intendedPolicies`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `managed_app_log_collection_requests` → `managedAppLogCollectionRequests` (Graph `managedAppLogCollectionRequests`, property, renamed).
- `managed_device_id` → `managedDeviceId` (Graph `managedDeviceId`, property, renamed).
- `management_sdk_version` → `managementSdkVersion` (Graph `managementSdkVersion`, property, renamed).
- `platform_version` → `platformVersion` (Graph `platformVersion`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-app-management/managed-app-registrations/managed-app-log-collection-requests` → `beta/deviceAppManagement/managedAppRegistrations/managedAppLogCollectionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_log_upload_consent` → `userLogUploadConsent` (Graph `userLogUploadConsent`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `managed_app_registration_id` → `managedAppRegistration-id` (Graph `managedAppRegistration-id`, url_parameter, renamed).

### `beta/device-app-management/managed-app-registrations/operations` → `beta/deviceAppManagement/managedAppRegistrations/operations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `managed_app_registration_id` → `managedAppRegistration-id` (Graph `managedAppRegistration-id`, url_parameter, renamed).

### `beta/device-app-management/managed-e-book-categories` → `beta/deviceAppManagement/managedEBookCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).

### `beta/device-app-management/managed-e-books` → `beta/deviceAppManagement/managedEBooks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_states` → `deviceStates` (Graph `deviceStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `information_url` → `informationUrl` (Graph `informationUrl`, property, renamed).
- `install_summary` → `installSummary` (Graph `installSummary`, property, renamed).
- `large_cover` → `largeCover` (Graph `largeCover`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `privacy_information_url` → `privacyInformationUrl` (Graph `privacyInformationUrl`, property, renamed).
- `published_date_time` → `publishedDateTime` (Graph `publishedDateTime`, property, renamed).
- `user_state_summary` → `userStateSummary` (Graph `userStateSummary`, property, renamed).

### `beta/device-app-management/managed-e-books/assignments` → `beta/deviceAppManagement/managedEBooks/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `install_intent` → `installIntent` (Graph `installIntent`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).

### `beta/device-app-management/managed-e-books/device-states` → `beta/deviceAppManagement/managedEBooks/deviceStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `install_state` → `installState` (Graph `installState`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `os_description` → `osDescription` (Graph `osDescription`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).

### `beta/device-app-management/managed-e-books/user-state-summary` → `beta/deviceAppManagement/managedEBooks/userStateSummary`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_states` → `deviceStates` (Graph `deviceStates`, property, renamed).
- `failed_device_count` → `failedDeviceCount` (Graph `failedDeviceCount`, property, renamed).
- `installed_device_count` → `installedDeviceCount` (Graph `installedDeviceCount`, property, renamed).
- `not_installed_device_count` → `notInstalledDeviceCount` (Graph `notInstalledDeviceCount`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).

### `beta/device-app-management/managed-e-books/user-state-summary/device-states` → `beta/deviceAppManagement/managedEBooks/userStateSummary/deviceStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `install_state` → `installState` (Graph `installState`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `os_description` → `osDescription` (Graph `osDescription`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `managed_e_book_id` → `managedEBook-id` (Graph `managedEBook-id`, url_parameter, renamed).
- `user_install_state_summary_id` → `userInstallStateSummary-id` (Graph `userInstallStateSummary-id`, url_parameter, renamed).

### `beta/device-app-management/mdm-windows-information-protection-policies` → `beta/deviceAppManagement/mdmWindowsInformationProtectionPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `azure_rights_management_services_allowed` → `azureRightsManagementServicesAllowed` (Graph `azureRightsManagementServicesAllowed`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `data_recovery_certificate` → `dataRecoveryCertificate` (Graph `dataRecoveryCertificate`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforcement_level` → `enforcementLevel` (Graph `enforcementLevel`, property, renamed).
- `enterprise_domain` → `enterpriseDomain` (Graph `enterpriseDomain`, property, renamed).
- `enterprise_ip_ranges` → `enterpriseIPRanges` (Graph `enterpriseIPRanges`, property, renamed).
- `enterprise_ip_ranges_are_authoritative` → `enterpriseIPRangesAreAuthoritative` (Graph `enterpriseIPRangesAreAuthoritative`, property, renamed).
- `enterprise_internal_proxy_servers` → `enterpriseInternalProxyServers` (Graph `enterpriseInternalProxyServers`, property, renamed).
- `enterprise_network_domain_names` → `enterpriseNetworkDomainNames` (Graph `enterpriseNetworkDomainNames`, property, renamed).
- `enterprise_protected_domain_names` → `enterpriseProtectedDomainNames` (Graph `enterpriseProtectedDomainNames`, property, renamed).
- `enterprise_proxied_domains` → `enterpriseProxiedDomains` (Graph `enterpriseProxiedDomains`, property, renamed).
- `enterprise_proxy_servers` → `enterpriseProxyServers` (Graph `enterpriseProxyServers`, property, renamed).
- `enterprise_proxy_servers_are_authoritative` → `enterpriseProxyServersAreAuthoritative` (Graph `enterpriseProxyServersAreAuthoritative`, property, renamed).
- `exempt_app_locker_files` → `exemptAppLockerFiles` (Graph `exemptAppLockerFiles`, property, renamed).
- `exempt_apps` → `exemptApps` (Graph `exemptApps`, property, renamed).
- `icons_visible` → `iconsVisible` (Graph `iconsVisible`, property, renamed).
- `indexing_encrypted_stores_or_items_blocked` → `indexingEncryptedStoresOrItemsBlocked` (Graph `indexingEncryptedStoresOrItemsBlocked`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `neutral_domain_resources` → `neutralDomainResources` (Graph `neutralDomainResources`, property, renamed).
- `protected_app_locker_files` → `protectedAppLockerFiles` (Graph `protectedAppLockerFiles`, property, renamed).
- `protected_apps` → `protectedApps` (Graph `protectedApps`, property, renamed).
- `protection_under_lock_config_required` → `protectionUnderLockConfigRequired` (Graph `protectionUnderLockConfigRequired`, property, renamed).
- `revoke_on_unenroll_disabled` → `revokeOnUnenrollDisabled` (Graph `revokeOnUnenrollDisabled`, property, renamed).
- `rights_management_services_template_id` → `rightsManagementServicesTemplateId` (Graph `rightsManagementServicesTemplateId`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `smb_auto_encrypted_file_extensions` → `smbAutoEncryptedFileExtensions` (Graph `smbAutoEncryptedFileExtensions`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-app-management/mdm-windows-information-protection-policies/exempt-app-locker-files` → `beta/deviceAppManagement/mdmWindowsInformationProtectionPolicies/exemptAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `mdm_windows_information_protection_policy_id` → `mdmWindowsInformationProtectionPolicy-id` (Graph `mdmWindowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `beta/device-app-management/mdm-windows-information-protection-policies/protected-app-locker-files` → `beta/deviceAppManagement/mdmWindowsInformationProtectionPolicies/protectedAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `mdm_windows_information_protection_policy_id` → `mdmWindowsInformationProtectionPolicy-id` (Graph `mdmWindowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `beta/device-app-management/mobile-app-categories` → `beta/deviceAppManagement/mobileAppCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/device-app-management/mobile-app-configurations` → `beta/deviceAppManagement/mobileAppConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_status_summary` → `deviceStatusSummary` (Graph `deviceStatusSummary`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `targeted_mobile_apps` → `targetedMobileApps` (Graph `targetedMobileApps`, property, renamed).
- `user_status_summary` → `userStatusSummary` (Graph `userStatusSummary`, property, renamed).
- `user_statuses` → `userStatuses` (Graph `userStatuses`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-app-management/mobile-app-configurations/assignments` → `beta/deviceAppManagement/mobileAppConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `managed_device_mobile_app_configuration_id` → `managedDeviceMobileAppConfiguration-id` (Graph `managedDeviceMobileAppConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/mobile-app-configurations/device-statuses` → `beta/deviceAppManagement/mobileAppConfigurations/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `managed_device_mobile_app_configuration_id` → `managedDeviceMobileAppConfiguration-id` (Graph `managedDeviceMobileAppConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/mobile-app-configurations/user-statuses` → `beta/deviceAppManagement/mobileAppConfigurations/userStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `devices_count` → `devicesCount` (Graph `devicesCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `managed_device_mobile_app_configuration_id` → `managedDeviceMobileAppConfiguration-id` (Graph `managedDeviceMobileAppConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/mobile-app-relationships` → `beta/deviceAppManagement/mobileAppRelationships`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/device-app-management/mobile-apps` → `beta/deviceAppManagement/mobileApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `information_url` → `informationUrl` (Graph `informationUrl`, property, renamed).
- `is_featured` → `isFeatured` (Graph `isFeatured`, property, renamed).
- `large_icon` → `largeIcon` (Graph `largeIcon`, property, renamed).
- `privacy_information_url` → `privacyInformationUrl` (Graph `privacyInformationUrl`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-app-management/mobile-apps/assignments` → `beta/deviceAppManagement/mobileApps/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_id` → `mobileApp-id` (Graph `mobileApp-id`, url_parameter, renamed).

### `beta/device-app-management/mobile-apps/relationships` → `beta/deviceAppManagement/mobileApps/relationships`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_id` → `mobileApp-id` (Graph `mobileApp-id`, url_parameter, renamed).

### `beta/device-app-management/policy-sets` → `beta/deviceAppManagement/policySets`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `guided_deployment_tags` → `guidedDeploymentTags` (Graph `guidedDeploymentTags`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tags` → `roleScopeTags` (Graph `roleScopeTags`, property, renamed).

### `beta/device-app-management/policy-sets/assignments` → `beta/deviceAppManagement/policySets/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `policy_set_id` → `policySet-id` (Graph `policySet-id`, url_parameter, renamed).

### `beta/device-app-management/policy-sets/items` → `beta/deviceAppManagement/policySets/items`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `guided_deployment_tags` → `guidedDeploymentTags` (Graph `guidedDeploymentTags`, property, renamed).
- `item_type` → `itemType` (Graph `itemType`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `payload_id` → `payloadId` (Graph `payloadId`, property, renamed).
- `policy_set_id` → `policySet-id` (Graph `policySet-id`, url_parameter, renamed).

### `beta/device-app-management/targeted-managed-app-configurations` → `beta/deviceAppManagement/targetedManagedAppConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_group_type` → `appGroupType` (Graph `appGroupType`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_settings` → `customSettings` (Graph `customSettings`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `targeted_app_management_levels` → `targetedAppManagementLevels` (Graph `targetedAppManagementLevels`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-app-management/targeted-managed-app-configurations/apps` → `beta/deviceAppManagement/targetedManagedAppConfigurations/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `targeted_managed_app_configuration_id` → `targetedManagedAppConfiguration-id` (Graph `targetedManagedAppConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/targeted-managed-app-configurations/settings` → `beta/deviceAppManagement/targetedManagedAppConfigurations/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `setting_instance` → `settingInstance` (Graph `settingInstance`, property, renamed).
- `targeted_managed_app_configuration_id` → `targetedManagedAppConfiguration-id` (Graph `targetedManagedAppConfiguration-id`, url_parameter, renamed).

### `beta/device-app-management/vpp-tokens` → `beta/deviceAppManagement/vppTokens`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `apple_device_app_delivery_protocol_type` → `appleDeviceAppDeliveryProtocolType` (Graph `appleDeviceAppDeliveryProtocolType`, property, renamed).
- `apple_id` → `appleId` (Graph `appleId`, property, renamed).
- `automatically_update_apps` → `automaticallyUpdateApps` (Graph `automaticallyUpdateApps`, property, renamed).
- `claim_token_management_from_external_mdm` → `claimTokenManagementFromExternalMdm` (Graph `claimTokenManagementFromExternalMdm`, property, renamed).
- `country_or_region` → `countryOrRegion` (Graph `countryOrRegion`, property, renamed).
- `data_sharing_consent_granted` → `dataSharingConsentGranted` (Graph `dataSharingConsentGranted`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `last_sync_status` → `lastSyncStatus` (Graph `lastSyncStatus`, property, renamed).
- `location_name` → `locationName` (Graph `locationName`, property, renamed).
- `organization_name` → `organizationName` (Graph `organizationName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `token_action_results` → `tokenActionResults` (Graph `tokenActionResults`, property, renamed).
- `vpp_token_account_type` → `vppTokenAccountType` (Graph `vppTokenAccountType`, property, renamed).

### `beta/device-app-management/wdac-supplemental-policies` → `beta/deviceAppManagement/wdacSupplementalPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `content_file_name` → `contentFileName` (Graph `contentFileName`, property, renamed).
- `creation_date_time` → `creationDateTime` (Graph `creationDateTime`, property, renamed).
- `deploy_summary` → `deploySummary` (Graph `deploySummary`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-app-management/wdac-supplemental-policies/assignments` → `beta/deviceAppManagement/wdacSupplementalPolicies/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `windows_defender_application_control_supplemental_policy_id` → `windowsDefenderApplicationControlSupplementalPolicy-id` (Graph `windowsDefenderApplicationControlSupplementalPolicy-id`, url_parameter, renamed).

### `beta/device-app-management/wdac-supplemental-policies/device-statuses` → `beta/deviceAppManagement/wdacSupplementalPolicies/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deployment_status` → `deploymentStatus` (Graph `deploymentStatus`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `os_description` → `osDescription` (Graph `osDescription`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `policy_version` → `policyVersion` (Graph `policyVersion`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `windows_defender_application_control_supplemental_policy_id` → `windowsDefenderApplicationControlSupplementalPolicy-id` (Graph `windowsDefenderApplicationControlSupplementalPolicy-id`, url_parameter, renamed).

### `beta/device-app-management/windows-information-protection-device-registrations` → `beta/deviceAppManagement/windowsInformationProtectionDeviceRegistrations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_mac_address` → `deviceMacAddress` (Graph `deviceMacAddress`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `device_registration_id` → `deviceRegistrationId` (Graph `deviceRegistrationId`, property, renamed).
- `device_type` → `deviceType` (Graph `deviceType`, property, renamed).
- `last_check_in_date_time` → `lastCheckInDateTime` (Graph `lastCheckInDateTime`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).

### `beta/device-app-management/windows-information-protection-policies` → `beta/deviceAppManagement/windowsInformationProtectionPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `azure_rights_management_services_allowed` → `azureRightsManagementServicesAllowed` (Graph `azureRightsManagementServicesAllowed`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `data_recovery_certificate` → `dataRecoveryCertificate` (Graph `dataRecoveryCertificate`, property, renamed).
- `days_without_contact_before_unenroll` → `daysWithoutContactBeforeUnenroll` (Graph `daysWithoutContactBeforeUnenroll`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforcement_level` → `enforcementLevel` (Graph `enforcementLevel`, property, renamed).
- `enterprise_domain` → `enterpriseDomain` (Graph `enterpriseDomain`, property, renamed).
- `enterprise_ip_ranges` → `enterpriseIPRanges` (Graph `enterpriseIPRanges`, property, renamed).
- `enterprise_ip_ranges_are_authoritative` → `enterpriseIPRangesAreAuthoritative` (Graph `enterpriseIPRangesAreAuthoritative`, property, renamed).
- `enterprise_internal_proxy_servers` → `enterpriseInternalProxyServers` (Graph `enterpriseInternalProxyServers`, property, renamed).
- `enterprise_network_domain_names` → `enterpriseNetworkDomainNames` (Graph `enterpriseNetworkDomainNames`, property, renamed).
- `enterprise_protected_domain_names` → `enterpriseProtectedDomainNames` (Graph `enterpriseProtectedDomainNames`, property, renamed).
- `enterprise_proxied_domains` → `enterpriseProxiedDomains` (Graph `enterpriseProxiedDomains`, property, renamed).
- `enterprise_proxy_servers` → `enterpriseProxyServers` (Graph `enterpriseProxyServers`, property, renamed).
- `enterprise_proxy_servers_are_authoritative` → `enterpriseProxyServersAreAuthoritative` (Graph `enterpriseProxyServersAreAuthoritative`, property, renamed).
- `exempt_app_locker_files` → `exemptAppLockerFiles` (Graph `exemptAppLockerFiles`, property, renamed).
- `exempt_apps` → `exemptApps` (Graph `exemptApps`, property, renamed).
- `icons_visible` → `iconsVisible` (Graph `iconsVisible`, property, renamed).
- `indexing_encrypted_stores_or_items_blocked` → `indexingEncryptedStoresOrItemsBlocked` (Graph `indexingEncryptedStoresOrItemsBlocked`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `mdm_enrollment_url` → `mdmEnrollmentUrl` (Graph `mdmEnrollmentUrl`, property, renamed).
- `minutes_of_inactivity_before_device_lock` → `minutesOfInactivityBeforeDeviceLock` (Graph `minutesOfInactivityBeforeDeviceLock`, property, renamed).
- `neutral_domain_resources` → `neutralDomainResources` (Graph `neutralDomainResources`, property, renamed).
- `number_of_past_pins_remembered` → `numberOfPastPinsRemembered` (Graph `numberOfPastPinsRemembered`, property, renamed).
- `password_maximum_attempt_count` → `passwordMaximumAttemptCount` (Graph `passwordMaximumAttemptCount`, property, renamed).
- `pin_expiration_days` → `pinExpirationDays` (Graph `pinExpirationDays`, property, renamed).
- `pin_lowercase_letters` → `pinLowercaseLetters` (Graph `pinLowercaseLetters`, property, renamed).
- `pin_minimum_length` → `pinMinimumLength` (Graph `pinMinimumLength`, property, renamed).
- `pin_special_characters` → `pinSpecialCharacters` (Graph `pinSpecialCharacters`, property, renamed).
- `pin_uppercase_letters` → `pinUppercaseLetters` (Graph `pinUppercaseLetters`, property, renamed).
- `protected_app_locker_files` → `protectedAppLockerFiles` (Graph `protectedAppLockerFiles`, property, renamed).
- `protected_apps` → `protectedApps` (Graph `protectedApps`, property, renamed).
- `protection_under_lock_config_required` → `protectionUnderLockConfigRequired` (Graph `protectionUnderLockConfigRequired`, property, renamed).
- `revoke_on_mdm_handoff_disabled` → `revokeOnMdmHandoffDisabled` (Graph `revokeOnMdmHandoffDisabled`, property, renamed).
- `revoke_on_unenroll_disabled` → `revokeOnUnenrollDisabled` (Graph `revokeOnUnenrollDisabled`, property, renamed).
- `rights_management_services_template_id` → `rightsManagementServicesTemplateId` (Graph `rightsManagementServicesTemplateId`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `smb_auto_encrypted_file_extensions` → `smbAutoEncryptedFileExtensions` (Graph `smbAutoEncryptedFileExtensions`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_hello_for_business_blocked` → `windowsHelloForBusinessBlocked` (Graph `windowsHelloForBusinessBlocked`, property, renamed).

### `beta/device-app-management/windows-information-protection-policies/exempt-app-locker-files` → `beta/deviceAppManagement/windowsInformationProtectionPolicies/exemptAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_information_protection_policy_id` → `windowsInformationProtectionPolicy-id` (Graph `windowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `beta/device-app-management/windows-information-protection-policies/protected-app-locker-files` → `beta/deviceAppManagement/windowsInformationProtectionPolicies/protectedAppLockerFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_hash` → `fileHash` (Graph `fileHash`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_information_protection_policy_id` → `windowsInformationProtectionPolicy-id` (Graph `windowsInformationProtectionPolicy-id`, url_parameter, renamed).

### `beta/device-app-management/windows-information-protection-wipe-actions` → `beta/deviceAppManagement/windowsInformationProtectionWipeActions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `last_check_in_date_time` → `lastCheckInDateTime` (Graph `lastCheckInDateTime`, property, renamed).
- `targeted_device_mac_address` → `targetedDeviceMacAddress` (Graph `targetedDeviceMacAddress`, property, renamed).
- `targeted_device_name` → `targetedDeviceName` (Graph `targetedDeviceName`, property, renamed).
- `targeted_device_registration_id` → `targetedDeviceRegistrationId` (Graph `targetedDeviceRegistrationId`, property, renamed).
- `targeted_user_id` → `targetedUserId` (Graph `targetedUserId`, property, renamed).

### `beta/device-app-management/windows-managed-app-protections` → `beta/deviceAppManagement/windowsManagedAppProtections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_inbound_data_transfer_source_apps` → `allowedInboundDataTransferSourceApps` (Graph `allowedInboundDataTransferSourceApps`, property, renamed).
- `allowed_inbound_data_transfer_sources` → `allowedInboundDataTransferSources` (Graph `allowedInboundDataTransferSources`, property, renamed).
- `allowed_outbound_clipboard_sharing_level` → `allowedOutboundClipboardSharingLevel` (Graph `allowedOutboundClipboardSharingLevel`, property, renamed).
- `allowed_outbound_data_transfer_destination_apps` → `allowedOutboundDataTransferDestinationApps` (Graph `allowedOutboundDataTransferDestinationApps`, property, renamed).
- `allowed_outbound_data_transfer_destinations` → `allowedOutboundDataTransferDestinations` (Graph `allowedOutboundDataTransferDestinations`, property, renamed).
- `app_action_if_unable_to_authenticate_user` → `appActionIfUnableToAuthenticateUser` (Graph `appActionIfUnableToAuthenticateUser`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deployed_app_count` → `deployedAppCount` (Graph `deployedAppCount`, property, renamed).
- `deployment_summary` → `deploymentSummary` (Graph `deploymentSummary`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `maximum_allowed_device_threat_level` → `maximumAllowedDeviceThreatLevel` (Graph `maximumAllowedDeviceThreatLevel`, property, renamed).
- `maximum_required_os_version` → `maximumRequiredOsVersion` (Graph `maximumRequiredOsVersion`, property, renamed).
- `maximum_warning_os_version` → `maximumWarningOsVersion` (Graph `maximumWarningOsVersion`, property, renamed).
- `maximum_wipe_os_version` → `maximumWipeOsVersion` (Graph `maximumWipeOsVersion`, property, renamed).
- `minimum_required_app_version` → `minimumRequiredAppVersion` (Graph `minimumRequiredAppVersion`, property, renamed).
- `minimum_required_os_version` → `minimumRequiredOsVersion` (Graph `minimumRequiredOsVersion`, property, renamed).
- `minimum_required_sdk_version` → `minimumRequiredSdkVersion` (Graph `minimumRequiredSdkVersion`, property, renamed).
- `minimum_warning_app_version` → `minimumWarningAppVersion` (Graph `minimumWarningAppVersion`, property, renamed).
- `minimum_warning_os_version` → `minimumWarningOsVersion` (Graph `minimumWarningOsVersion`, property, renamed).
- `minimum_wipe_app_version` → `minimumWipeAppVersion` (Graph `minimumWipeAppVersion`, property, renamed).
- `minimum_wipe_os_version` → `minimumWipeOsVersion` (Graph `minimumWipeOsVersion`, property, renamed).
- `minimum_wipe_sdk_version` → `minimumWipeSdkVersion` (Graph `minimumWipeSdkVersion`, property, renamed).
- `mobile_threat_defense_remediation_action` → `mobileThreatDefenseRemediationAction` (Graph `mobileThreatDefenseRemediationAction`, property, renamed).
- `period_offline_before_access_check` → `periodOfflineBeforeAccessCheck` (Graph `periodOfflineBeforeAccessCheck`, property, renamed).
- `period_offline_before_wipe_is_enforced` → `periodOfflineBeforeWipeIsEnforced` (Graph `periodOfflineBeforeWipeIsEnforced`, property, renamed).
- `print_blocked` → `printBlocked` (Graph `printBlocked`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-app-management/windows-managed-app-protections/apps` → `beta/deviceAppManagement/windowsManagedAppProtections/apps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `mobile_app_identifier` → `mobileAppIdentifier` (Graph `mobileAppIdentifier`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_managed_app_protection_id` → `windowsManagedAppProtection-id` (Graph `windowsManagedAppProtection-id`, url_parameter, renamed).

### `beta/device-management/advanced-threat-protection-onboarding-state-summary/advanced-threat-protection-onboarding-device-setting-states` → `beta/deviceManagement/advancedThreatProtectionOnboardingStateSummary/advancedThreatProtectionOnboardingDeviceSettingStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `platform_type` → `platformType` (Graph `platformType`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `user_email` → `userEmail` (Graph `userEmail`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `beta/device-management/android-device-owner-enrollment-profiles` → `beta/deviceManagement/androidDeviceOwnerEnrollmentProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_id` → `accountId` (Graph `accountId`, property, renamed).
- `configure_wifi` → `configureWifi` (Graph `configureWifi`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_name_template` → `deviceNameTemplate` (Graph `deviceNameTemplate`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrolled_device_count` → `enrolledDeviceCount` (Graph `enrolledDeviceCount`, property, renamed).
- `enrollment_mode` → `enrollmentMode` (Graph `enrollmentMode`, property, renamed).
- `enrollment_token_type` → `enrollmentTokenType` (Graph `enrollmentTokenType`, property, renamed).
- `enrollment_token_usage_count` → `enrollmentTokenUsageCount` (Graph `enrollmentTokenUsageCount`, property, renamed).
- `is_teams_device_profile` → `isTeamsDeviceProfile` (Graph `isTeamsDeviceProfile`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `qr_code_content` → `qrCodeContent` (Graph `qrCodeContent`, property, renamed).
- `qr_code_image` → `qrCodeImage` (Graph `qrCodeImage`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `token_creation_date_time` → `tokenCreationDateTime` (Graph `tokenCreationDateTime`, property, renamed).
- `token_expiration_date_time` → `tokenExpirationDateTime` (Graph `tokenExpirationDateTime`, property, renamed).
- `token_value` → `tokenValue` (Graph `tokenValue`, property, renamed).
- `wifi_hidden` → `wifiHidden` (Graph `wifiHidden`, property, renamed).
- `wifi_password` → `wifiPassword` (Graph `wifiPassword`, property, renamed).
- `wifi_security_type` → `wifiSecurityType` (Graph `wifiSecurityType`, property, renamed).
- `wifi_ssid` → `wifiSsid` (Graph `wifiSsid`, property, renamed).

### `beta/device-management/android-for-work-app-configuration-schemas` → `beta/deviceManagement/androidForWorkAppConfigurationSchemas`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `example_json` → `exampleJson` (Graph `exampleJson`, property, renamed).
- `schema_items` → `schemaItems` (Graph `schemaItems`, property, renamed).

### `beta/device-management/android-for-work-enrollment-profiles` → `beta/deviceManagement/androidForWorkEnrollmentProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_id` → `accountId` (Graph `accountId`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrolled_device_count` → `enrolledDeviceCount` (Graph `enrolledDeviceCount`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `qr_code_content` → `qrCodeContent` (Graph `qrCodeContent`, property, renamed).
- `qr_code_image` → `qrCodeImage` (Graph `qrCodeImage`, property, renamed).
- `token_expiration_date_time` → `tokenExpirationDateTime` (Graph `tokenExpirationDateTime`, property, renamed).
- `token_value` → `tokenValue` (Graph `tokenValue`, property, renamed).

### `beta/device-management/android-managed-store-app-configuration-schemas` → `beta/deviceManagement/androidManagedStoreAppConfigurationSchemas`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `example_json` → `exampleJson` (Graph `exampleJson`, property, renamed).
- `nested_schema_items` → `nestedSchemaItems` (Graph `nestedSchemaItems`, property, renamed).
- `schema_items` → `schemaItems` (Graph `schemaItems`, property, renamed).

### `beta/device-management/apple-user-initiated-enrollment-profiles` → `beta/deviceManagement/appleUserInitiatedEnrollmentProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `available_enrollment_type_options` → `availableEnrollmentTypeOptions` (Graph `availableEnrollmentTypeOptions`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `default_enrollment_type` → `defaultEnrollmentType` (Graph `defaultEnrollmentType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).

### `beta/device-management/apple-user-initiated-enrollment-profiles/assignments` → `beta/deviceManagement/appleUserInitiatedEnrollmentProfiles/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `apple_user_initiated_enrollment_profile_id` → `appleUserInitiatedEnrollmentProfile-id` (Graph `appleUserInitiatedEnrollmentProfile-id`, url_parameter, renamed).

### `beta/device-management/assignment-filters` → `beta/deviceManagement/assignmentFilters`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_filter_management_type` → `assignmentFilterManagementType` (Graph `assignmentFilterManagementType`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tags` → `roleScopeTags` (Graph `roleScopeTags`, property, renamed).

### `beta/device-management/audit-events` → `beta/deviceManagement/auditEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `activity_date_time` → `activityDateTime` (Graph `activityDateTime`, property, renamed).
- `activity_operation_type` → `activityOperationType` (Graph `activityOperationType`, property, renamed).
- `activity_result` → `activityResult` (Graph `activityResult`, property, renamed).
- `activity_type` → `activityType` (Graph `activityType`, property, renamed).
- `component_name` → `componentName` (Graph `componentName`, property, renamed).
- `correlation_id` → `correlationId` (Graph `correlationId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/device-management/autopilot-events` → `beta/deviceManagement/autopilotEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_setup_duration` → `accountSetupDuration` (Graph `accountSetupDuration`, property, renamed).
- `account_setup_status` → `accountSetupStatus` (Graph `accountSetupStatus`, property, renamed).
- `deployment_duration` → `deploymentDuration` (Graph `deploymentDuration`, property, renamed).
- `deployment_end_date_time` → `deploymentEndDateTime` (Graph `deploymentEndDateTime`, property, renamed).
- `deployment_start_date_time` → `deploymentStartDateTime` (Graph `deploymentStartDateTime`, property, renamed).
- `deployment_state` → `deploymentState` (Graph `deploymentState`, property, renamed).
- `deployment_total_duration` → `deploymentTotalDuration` (Graph `deploymentTotalDuration`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_registered_date_time` → `deviceRegisteredDateTime` (Graph `deviceRegisteredDateTime`, property, renamed).
- `device_serial_number` → `deviceSerialNumber` (Graph `deviceSerialNumber`, property, renamed).
- `device_setup_duration` → `deviceSetupDuration` (Graph `deviceSetupDuration`, property, renamed).
- `device_setup_status` → `deviceSetupStatus` (Graph `deviceSetupStatus`, property, renamed).
- `enrollment_failure_details` → `enrollmentFailureDetails` (Graph `enrollmentFailureDetails`, property, renamed).
- `enrollment_start_date_time` → `enrollmentStartDateTime` (Graph `enrollmentStartDateTime`, property, renamed).
- `enrollment_state` → `enrollmentState` (Graph `enrollmentState`, property, renamed).
- `enrollment_type` → `enrollmentType` (Graph `enrollmentType`, property, renamed).
- `event_date_time` → `eventDateTime` (Graph `eventDateTime`, property, renamed).
- `managed_device_name` → `managedDeviceName` (Graph `managedDeviceName`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `windows10_enrollment_completion_page_configuration_display_name` → `windows10EnrollmentCompletionPageConfigurationDisplayName` (Graph `windows10EnrollmentCompletionPageConfigurationDisplayName`, property, renamed).
- `windows10_enrollment_completion_page_configuration_id` → `windows10EnrollmentCompletionPageConfigurationId` (Graph `windows10EnrollmentCompletionPageConfigurationId`, property, renamed).
- `windows_autopilot_deployment_profile_display_name` → `windowsAutopilotDeploymentProfileDisplayName` (Graph `windowsAutopilotDeploymentProfileDisplayName`, property, renamed).

### `beta/device-management/cart-to-class-associations` → `beta/deviceManagement/cartToClassAssociations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `classroom_ids` → `classroomIds` (Graph `classroomIds`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_cart_ids` → `deviceCartIds` (Graph `deviceCartIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/categories` → `beta/deviceManagement/categories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `has_required_setting` → `hasRequiredSetting` (Graph `hasRequiredSetting`, property, renamed).
- `setting_definitions` → `settingDefinitions` (Graph `settingDefinitions`, property, renamed).

### `beta/device-management/categories/setting-definitions` → `beta/deviceManagement/categories/settingDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `documentation_url` → `documentationUrl` (Graph `documentationUrl`, property, renamed).
- `header_subtitle` → `headerSubtitle` (Graph `headerSubtitle`, property, renamed).
- `header_title` → `headerTitle` (Graph `headerTitle`, property, renamed).
- `is_top_level` → `isTopLevel` (Graph `isTopLevel`, property, renamed).
- `placeholder_text` → `placeholderText` (Graph `placeholderText`, property, renamed).
- `value_type` → `valueType` (Graph `valueType`, property, renamed).
- `device_management_setting_category_id` → `deviceManagementSettingCategory-id` (Graph `deviceManagementSettingCategory-id`, url_parameter, renamed).

### `beta/device-management/certificate-connector-details` → `beta/deviceManagement/certificateConnectorDetails`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `connector_name` → `connectorName` (Graph `connectorName`, property, renamed).
- `connector_version` → `connectorVersion` (Graph `connectorVersion`, property, renamed).
- `enrollment_date_time` → `enrollmentDateTime` (Graph `enrollmentDateTime`, property, renamed).
- `last_checkin_date_time` → `lastCheckinDateTime` (Graph `lastCheckinDateTime`, property, renamed).
- `machine_name` → `machineName` (Graph `machineName`, property, renamed).

### `beta/device-management/chrome-os-onboarding-settings` → `beta/deviceManagement/chromeOSOnboardingSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `last_directory_sync_date_time` → `lastDirectorySyncDateTime` (Graph `lastDirectorySyncDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `onboarding_status` → `onboardingStatus` (Graph `onboardingStatus`, property, renamed).
- `owner_user_principal_name` → `ownerUserPrincipalName` (Graph `ownerUserPrincipalName`, property, renamed).

### `beta/device-management/cloud-certification-authority` → `beta/deviceManagement/cloudCertificationAuthority`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_key_size` → `certificateKeySize` (Graph `certificateKeySize`, property, renamed).
- `certification_authority_status` → `certificationAuthorityStatus` (Graph `certificationAuthorityStatus`, property, renamed).
- `cloud_certification_authority_hashing_algorithm` → `cloudCertificationAuthorityHashingAlgorithm` (Graph `cloudCertificationAuthorityHashingAlgorithm`, property, renamed).
- `cloud_certification_authority_leaf_certificate` → `cloudCertificationAuthorityLeafCertificate` (Graph `cloudCertificationAuthorityLeafCertificate`, property, renamed).
- `cloud_certification_authority_type` → `cloudCertificationAuthorityType` (Graph `cloudCertificationAuthorityType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `e_tag` → `eTag` (Graph `eTag`, property, renamed).
- `issuer_common_name` → `issuerCommonName` (Graph `issuerCommonName`, property, renamed).
- `key_platform` → `keyPlatform` (Graph `keyPlatform`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `validity_period_in_years` → `validityPeriodInYears` (Graph `validityPeriodInYears`, property, renamed).

### `beta/device-management/cloud-certification-authority-leaf-certificate` → `beta/deviceManagement/cloudCertificationAuthorityLeafCertificate`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_status` → `certificateStatus` (Graph `certificateStatus`, property, renamed).

### `beta/device-management/cloud-pc-connectivity-issues` → `beta/deviceManagement/cloudPCConnectivityIssues`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `error_date_time` → `errorDateTime` (Graph `errorDateTime`, property, renamed).
- `error_description` → `errorDescription` (Graph `errorDescription`, property, renamed).
- `recommended_action` → `recommendedAction` (Graph `recommendedAction`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).

### `beta/device-management/comanaged-devices` → `beta/deviceManagement/comanagedDevices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_filter_evaluation_status_details` → `assignmentFilterEvaluationStatusDetails` (Graph `assignmentFilterEvaluationStatusDetails`, property, renamed).
- `chrome_os_device_info` → `chromeOSDeviceInfo` (Graph `chromeOSDeviceInfo`, property, renamed).
- `cloud_pc_remote_action_results` → `cloudPcRemoteActionResults` (Graph `cloudPcRemoteActionResults`, property, renamed).
- `configuration_manager_client_health_state` → `configurationManagerClientHealthState` (Graph `configurationManagerClientHealthState`, property, renamed).
- `configuration_manager_client_information` → `configurationManagerClientInformation` (Graph `configurationManagerClientInformation`, property, renamed).
- `detected_apps` → `detectedApps` (Graph `detectedApps`, property, renamed).
- `device_category` → `deviceCategory` (Graph `deviceCategory`, property, renamed).
- `device_compliance_policy_states` → `deviceCompliancePolicyStates` (Graph `deviceCompliancePolicyStates`, property, renamed).
- `device_configuration_states` → `deviceConfigurationStates` (Graph `deviceConfigurationStates`, property, renamed).
- `device_firmware_configuration_interface_managed` → `deviceFirmwareConfigurationInterfaceManaged` (Graph `deviceFirmwareConfigurationInterfaceManaged`, property, renamed).
- `join_type` → `joinType` (Graph `joinType`, property, renamed).
- `log_collection_requests` → `logCollectionRequests` (Graph `logCollectionRequests`, property, renamed).
- `managed_device_mobile_app_configuration_states` → `managedDeviceMobileAppConfigurationStates` (Graph `managedDeviceMobileAppConfigurationStates`, property, renamed).
- `managed_device_name` → `managedDeviceName` (Graph `managedDeviceName`, property, renamed).
- `managed_device_owner_type` → `managedDeviceOwnerType` (Graph `managedDeviceOwnerType`, property, renamed).
- `management_features` → `managementFeatures` (Graph `managementFeatures`, property, renamed).
- `owner_type` → `ownerType` (Graph `ownerType`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `security_baseline_states` → `securityBaselineStates` (Graph `securityBaselineStates`, property, renamed).
- `sku_family` → `skuFamily` (Graph `skuFamily`, property, renamed).

### `beta/device-management/comanagement-eligible-devices` → `beta/deviceManagement/comanagementEligibleDevices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `client_registration_status` → `clientRegistrationStatus` (Graph `clientRegistrationStatus`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `device_type` → `deviceType` (Graph `deviceType`, property, renamed).
- `entity_source` → `entitySource` (Graph `entitySource`, property, renamed).
- `management_agents` → `managementAgents` (Graph `managementAgents`, property, renamed).
- `management_state` → `managementState` (Graph `managementState`, property, renamed).
- `mdm_status` → `mdmStatus` (Graph `mdmStatus`, property, renamed).
- `os_description` → `osDescription` (Graph `osDescription`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `owner_type` → `ownerType` (Graph `ownerType`, property, renamed).
- `reference_id` → `referenceId` (Graph `referenceId`, property, renamed).
- `serial_number` → `serialNumber` (Graph `serialNumber`, property, renamed).
- `user_email` → `userEmail` (Graph `userEmail`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).

### `beta/device-management/compliance-categories` → `beta/deviceManagement/complianceCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `category_description` → `categoryDescription` (Graph `categoryDescription`, property, renamed).
- `child_category_ids` → `childCategoryIds` (Graph `childCategoryIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `help_text` → `helpText` (Graph `helpText`, property, renamed).
- `parent_category_id` → `parentCategoryId` (Graph `parentCategoryId`, property, renamed).
- `root_category_id` → `rootCategoryId` (Graph `rootCategoryId`, property, renamed).
- `setting_usage` → `settingUsage` (Graph `settingUsage`, property, renamed).

### `beta/device-management/compliance-management-partners` → `beta/deviceManagement/complianceManagementPartners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `android_enrollment_assignments` → `androidEnrollmentAssignments` (Graph `androidEnrollmentAssignments`, property, renamed).
- `android_onboarded` → `androidOnboarded` (Graph `androidOnboarded`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `ios_enrollment_assignments` → `iosEnrollmentAssignments` (Graph `iosEnrollmentAssignments`, property, renamed).
- `ios_onboarded` → `iosOnboarded` (Graph `iosOnboarded`, property, renamed).
- `last_heartbeat_date_time` → `lastHeartbeatDateTime` (Graph `lastHeartbeatDateTime`, property, renamed).
- `linux_enrollment_assignments` → `linuxEnrollmentAssignments` (Graph `linuxEnrollmentAssignments`, property, renamed).
- `linux_onboarded` → `linuxOnboarded` (Graph `linuxOnboarded`, property, renamed).
- `mac_os_enrollment_assignments` → `macOsEnrollmentAssignments` (Graph `macOsEnrollmentAssignments`, property, renamed).
- `mac_os_onboarded` → `macOsOnboarded` (Graph `macOsOnboarded`, property, renamed).
- `partner_state` → `partnerState` (Graph `partnerState`, property, renamed).

### `beta/device-management/compliance-policies` → `beta/deviceManagement/compliancePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `creation_source` → `creationSource` (Graph `creationSource`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `scheduled_actions_for_rule` → `scheduledActionsForRule` (Graph `scheduledActionsForRule`, property, renamed).

### `beta/device-management/compliance-policies/scheduled-actions-for-rule` → `beta/deviceManagement/compliancePolicies/scheduledActionsForRule`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `rule_name` → `ruleName` (Graph `ruleName`, property, renamed).
- `scheduled_action_configurations` → `scheduledActionConfigurations` (Graph `scheduledActionConfigurations`, property, renamed).
- `device_management_compliance_policy_id` → `deviceManagementCompliancePolicy-id` (Graph `deviceManagementCompliancePolicy-id`, url_parameter, renamed).

### `beta/device-management/compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations` → `beta/deviceManagement/compliancePolicies/scheduledActionsForRule/scheduledActionConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_type` → `actionType` (Graph `actionType`, property, renamed).
- `grace_period_hours` → `gracePeriodHours` (Graph `gracePeriodHours`, property, renamed).
- `notification_message_cc_list` → `notificationMessageCCList` (Graph `notificationMessageCCList`, property, renamed).
- `notification_template_id` → `notificationTemplateId` (Graph `notificationTemplateId`, property, renamed).
- `device_management_compliance_policy_id` → `deviceManagementCompliancePolicy-id` (Graph `deviceManagementCompliancePolicy-id`, url_parameter, renamed).
- `device_management_compliance_scheduled_action_for_rule_id` → `deviceManagementComplianceScheduledActionForRule-id` (Graph `deviceManagementComplianceScheduledActionForRule-id`, url_parameter, renamed).

### `beta/device-management/compliance-policies/settings` → `beta/deviceManagement/compliancePolicies/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `setting_instance` → `settingInstance` (Graph `settingInstance`, property, renamed).
- `device_management_compliance_policy_id` → `deviceManagementCompliancePolicy-id` (Graph `deviceManagementCompliancePolicy-id`, url_parameter, renamed).

### `beta/device-management/compliance-settings` → `beta/deviceManagement/complianceSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_types` → `accessTypes` (Graph `accessTypes`, property, renamed).
- `base_uri` → `baseUri` (Graph `baseUri`, property, renamed).
- `category_id` → `categoryId` (Graph `categoryId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `help_text` → `helpText` (Graph `helpText`, property, renamed).
- `info_urls` → `infoUrls` (Graph `infoUrls`, property, renamed).
- `offset_uri` → `offsetUri` (Graph `offsetUri`, property, renamed).
- `referred_setting_information_list` → `referredSettingInformationList` (Graph `referredSettingInformationList`, property, renamed).
- `risk_level` → `riskLevel` (Graph `riskLevel`, property, renamed).
- `root_definition_id` → `rootDefinitionId` (Graph `rootDefinitionId`, property, renamed).
- `setting_usage` → `settingUsage` (Graph `settingUsage`, property, renamed).
- `ux_behavior` → `uxBehavior` (Graph `uxBehavior`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/config-manager-collections` → `beta/deviceManagement/configManagerCollections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `collection_identifier` → `collectionIdentifier` (Graph `collectionIdentifier`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hierarchy_identifier` → `hierarchyIdentifier` (Graph `hierarchyIdentifier`, property, renamed).
- `hierarchy_name` → `hierarchyName` (Graph `hierarchyName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).

### `beta/device-management/configuration-categories` → `beta/deviceManagement/configurationCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `category_description` → `categoryDescription` (Graph `categoryDescription`, property, renamed).
- `child_category_ids` → `childCategoryIds` (Graph `childCategoryIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `help_text` → `helpText` (Graph `helpText`, property, renamed).
- `parent_category_id` → `parentCategoryId` (Graph `parentCategoryId`, property, renamed).
- `root_category_id` → `rootCategoryId` (Graph `rootCategoryId`, property, renamed).
- `setting_usage` → `settingUsage` (Graph `settingUsage`, property, renamed).

### `beta/device-management/configuration-policies` → `beta/deviceManagement/configurationPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `creation_source` → `creationSource` (Graph `creationSource`, property, renamed).
- `disable_entra_group_policy_assignment` → `disableEntraGroupPolicyAssignment` (Graph `disableEntraGroupPolicyAssignment`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `priority_meta_data` → `priorityMetaData` (Graph `priorityMetaData`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `setting_count` → `settingCount` (Graph `settingCount`, property, renamed).
- `template_reference` → `templateReference` (Graph `templateReference`, property, renamed).

### `beta/device-management/configuration-policies/settings` → `beta/deviceManagement/configurationPolicies/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `setting_instance` → `settingInstance` (Graph `settingInstance`, property, renamed).
- `device_management_configuration_policy_id` → `deviceManagementConfigurationPolicy-id` (Graph `deviceManagementConfigurationPolicy-id`, url_parameter, renamed).

### `beta/device-management/configuration-policy-templates` → `beta/deviceManagement/configurationPolicyTemplates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_unmanaged_settings` → `allowUnmanagedSettings` (Graph `allowUnmanagedSettings`, property, renamed).
- `base_id` → `baseId` (Graph `baseId`, property, renamed).
- `disable_entra_group_policy_assignment` → `disableEntraGroupPolicyAssignment` (Graph `disableEntraGroupPolicyAssignment`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `display_version` → `displayVersion` (Graph `displayVersion`, property, renamed).
- `lifecycle_state` → `lifecycleState` (Graph `lifecycleState`, property, renamed).
- `setting_templates` → `settingTemplates` (Graph `settingTemplates`, property, renamed).
- `template_family` → `templateFamily` (Graph `templateFamily`, property, renamed).

### `beta/device-management/configuration-policy-templates/setting-templates` → `beta/deviceManagement/configurationPolicyTemplates/settingTemplates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `setting_definitions` → `settingDefinitions` (Graph `settingDefinitions`, property, renamed).
- `setting_instance_template` → `settingInstanceTemplate` (Graph `settingInstanceTemplate`, property, renamed).
- `device_management_configuration_policy_template_id` → `deviceManagementConfigurationPolicyTemplate-id` (Graph `deviceManagementConfigurationPolicyTemplate-id`, url_parameter, renamed).

### `beta/device-management/configuration-policy-templates/setting-templates/setting-definitions` → `beta/deviceManagement/configurationPolicyTemplates/settingTemplates/settingDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_types` → `accessTypes` (Graph `accessTypes`, property, renamed).
- `base_uri` → `baseUri` (Graph `baseUri`, property, renamed).
- `category_id` → `categoryId` (Graph `categoryId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `help_text` → `helpText` (Graph `helpText`, property, renamed).
- `info_urls` → `infoUrls` (Graph `infoUrls`, property, renamed).
- `offset_uri` → `offsetUri` (Graph `offsetUri`, property, renamed).
- `referred_setting_information_list` → `referredSettingInformationList` (Graph `referredSettingInformationList`, property, renamed).
- `risk_level` → `riskLevel` (Graph `riskLevel`, property, renamed).
- `root_definition_id` → `rootDefinitionId` (Graph `rootDefinitionId`, property, renamed).
- `setting_usage` → `settingUsage` (Graph `settingUsage`, property, renamed).
- `ux_behavior` → `uxBehavior` (Graph `uxBehavior`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `device_management_configuration_policy_template_id` → `deviceManagementConfigurationPolicyTemplate-id` (Graph `deviceManagementConfigurationPolicyTemplate-id`, url_parameter, renamed).
- `device_management_configuration_setting_template_id` → `deviceManagementConfigurationSettingTemplate-id` (Graph `deviceManagementConfigurationSettingTemplate-id`, url_parameter, renamed).

### `beta/device-management/configuration-settings` → `beta/deviceManagement/configurationSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_types` → `accessTypes` (Graph `accessTypes`, property, renamed).
- `base_uri` → `baseUri` (Graph `baseUri`, property, renamed).
- `category_id` → `categoryId` (Graph `categoryId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `help_text` → `helpText` (Graph `helpText`, property, renamed).
- `info_urls` → `infoUrls` (Graph `infoUrls`, property, renamed).
- `offset_uri` → `offsetUri` (Graph `offsetUri`, property, renamed).
- `referred_setting_information_list` → `referredSettingInformationList` (Graph `referredSettingInformationList`, property, renamed).
- `risk_level` → `riskLevel` (Graph `riskLevel`, property, renamed).
- `root_definition_id` → `rootDefinitionId` (Graph `rootDefinitionId`, property, renamed).
- `setting_usage` → `settingUsage` (Graph `settingUsage`, property, renamed).
- `ux_behavior` → `uxBehavior` (Graph `uxBehavior`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/data-sharing-consents` → `beta/deviceManagement/dataSharingConsents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `grant_date_time` → `grantDateTime` (Graph `grantDateTime`, property, renamed).
- `granted_by_upn` → `grantedByUpn` (Graph `grantedByUpn`, property, renamed).
- `granted_by_user_id` → `grantedByUserId` (Graph `grantedByUserId`, property, renamed).
- `service_display_name` → `serviceDisplayName` (Graph `serviceDisplayName`, property, renamed).
- `terms_url` → `termsUrl` (Graph `termsUrl`, property, renamed).

### `beta/device-management/dep-onboarding-settings` → `beta/deviceManagement/depOnboardingSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `apple_identifier` → `appleIdentifier` (Graph `appleIdentifier`, property, renamed).
- `data_sharing_consent_granted` → `dataSharingConsentGranted` (Graph `dataSharingConsentGranted`, property, renamed).
- `default_ios_enrollment_profile` → `defaultIosEnrollmentProfile` (Graph `defaultIosEnrollmentProfile`, property, renamed).
- `default_mac_os_enrollment_profile` → `defaultMacOsEnrollmentProfile` (Graph `defaultMacOsEnrollmentProfile`, property, renamed).
- `default_tv_os_enrollment_profile` → `defaultTvOSEnrollmentProfile` (Graph `defaultTvOSEnrollmentProfile`, property, renamed).
- `default_vision_os_enrollment_profile` → `defaultVisionOSEnrollmentProfile` (Graph `defaultVisionOSEnrollmentProfile`, property, renamed).
- `enrollment_profiles` → `enrollmentProfiles` (Graph `enrollmentProfiles`, property, renamed).
- `imported_apple_device_identities` → `importedAppleDeviceIdentities` (Graph `importedAppleDeviceIdentities`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `last_successful_sync_date_time` → `lastSuccessfulSyncDateTime` (Graph `lastSuccessfulSyncDateTime`, property, renamed).
- `last_sync_error_code` → `lastSyncErrorCode` (Graph `lastSyncErrorCode`, property, renamed).
- `last_sync_triggered_date_time` → `lastSyncTriggeredDateTime` (Graph `lastSyncTriggeredDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `share_token_with_school_data_sync_service` → `shareTokenWithSchoolDataSyncService` (Graph `shareTokenWithSchoolDataSyncService`, property, renamed).
- `synced_device_count` → `syncedDeviceCount` (Graph `syncedDeviceCount`, property, renamed).
- `token_expiration_date_time` → `tokenExpirationDateTime` (Graph `tokenExpirationDateTime`, property, renamed).
- `token_name` → `tokenName` (Graph `tokenName`, property, renamed).
- `token_type` → `tokenType` (Graph `tokenType`, property, renamed).

### `beta/device-management/dep-onboarding-settings/enrollment-profiles` → `beta/deviceManagement/depOnboardingSettings/enrollmentProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `configuration_endpoint_url` → `configurationEndpointUrl` (Graph `configurationEndpointUrl`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enable_authentication_via_company_portal` → `enableAuthenticationViaCompanyPortal` (Graph `enableAuthenticationViaCompanyPortal`, property, renamed).
- `require_company_portal_on_setup_assistant_enrolled_devices` → `requireCompanyPortalOnSetupAssistantEnrolledDevices` (Graph `requireCompanyPortalOnSetupAssistantEnrolledDevices`, property, renamed).
- `requires_user_authentication` → `requiresUserAuthentication` (Graph `requiresUserAuthentication`, property, renamed).
- `dep_onboarding_setting_id` → `depOnboardingSetting-id` (Graph `depOnboardingSetting-id`, url_parameter, renamed).

### `beta/device-management/dep-onboarding-settings/imported-apple-device-identities` → `beta/deviceManagement/depOnboardingSettings/importedAppleDeviceIdentities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `discovery_source` → `discoverySource` (Graph `discoverySource`, property, renamed).
- `enrollment_state` → `enrollmentState` (Graph `enrollmentState`, property, renamed).
- `is_deleted` → `isDeleted` (Graph `isDeleted`, property, renamed).
- `is_supervised` → `isSupervised` (Graph `isSupervised`, property, renamed).
- `last_contacted_date_time` → `lastContactedDateTime` (Graph `lastContactedDateTime`, property, renamed).
- `requested_enrollment_profile_assignment_date_time` → `requestedEnrollmentProfileAssignmentDateTime` (Graph `requestedEnrollmentProfileAssignmentDateTime`, property, renamed).
- `requested_enrollment_profile_id` → `requestedEnrollmentProfileId` (Graph `requestedEnrollmentProfileId`, property, renamed).
- `serial_number` → `serialNumber` (Graph `serialNumber`, property, renamed).
- `dep_onboarding_setting_id` → `depOnboardingSetting-id` (Graph `depOnboardingSetting-id`, url_parameter, renamed).

### `beta/device-management/derived-credentials` → `beta/deviceManagement/derivedCredentials`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `help_url` → `helpUrl` (Graph `helpUrl`, property, renamed).
- `notification_type` → `notificationType` (Graph `notificationType`, property, renamed).
- `renewal_threshold_percentage` → `renewalThresholdPercentage` (Graph `renewalThresholdPercentage`, property, renamed).

### `beta/device-management/detected-apps` → `beta/deviceManagement/detectedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_count` → `deviceCount` (Graph `deviceCount`, property, renamed).
- `managed_devices` → `managedDevices` (Graph `managedDevices`, property, renamed).

### `beta/device-management/device-categories` → `beta/deviceManagement/deviceCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/device-compliance-policies` → `beta/deviceManagement/deviceCompliancePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_setting_state_summaries` → `deviceSettingStateSummaries` (Graph `deviceSettingStateSummaries`, property, renamed).
- `device_status_overview` → `deviceStatusOverview` (Graph `deviceStatusOverview`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `scheduled_actions_for_rule` → `scheduledActionsForRule` (Graph `scheduledActionsForRule`, property, renamed).
- `user_status_overview` → `userStatusOverview` (Graph `userStatusOverview`, property, renamed).
- `user_statuses` → `userStatuses` (Graph `userStatuses`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/device-compliance-policies/assignments` → `beta/deviceManagement/deviceCompliancePolicies/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `source_id` → `sourceId` (Graph `sourceId`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-policies/device-setting-state-summaries` → `beta/deviceManagement/deviceCompliancePolicies/deviceSettingStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliant_device_count` → `compliantDeviceCount` (Graph `compliantDeviceCount`, property, renamed).
- `conflict_device_count` → `conflictDeviceCount` (Graph `conflictDeviceCount`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `instance_path` → `instancePath` (Graph `instancePath`, property, renamed).
- `non_compliant_device_count` → `nonCompliantDeviceCount` (Graph `nonCompliantDeviceCount`, property, renamed).
- `not_applicable_device_count` → `notApplicableDeviceCount` (Graph `notApplicableDeviceCount`, property, renamed).
- `remediated_device_count` → `remediatedDeviceCount` (Graph `remediatedDeviceCount`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `unknown_device_count` → `unknownDeviceCount` (Graph `unknownDeviceCount`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-policies/device-statuses` → `beta/deviceManagement/deviceCompliancePolicies/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-policies/scheduled-actions-for-rule` → `beta/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `rule_name` → `ruleName` (Graph `ruleName`, property, renamed).
- `scheduled_action_configurations` → `scheduledActionConfigurations` (Graph `scheduledActionConfigurations`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations` → `beta/deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/scheduledActionConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_type` → `actionType` (Graph `actionType`, property, renamed).
- `grace_period_hours` → `gracePeriodHours` (Graph `gracePeriodHours`, property, renamed).
- `notification_message_cc_list` → `notificationMessageCCList` (Graph `notificationMessageCCList`, property, renamed).
- `notification_template_id` → `notificationTemplateId` (Graph `notificationTemplateId`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).
- `device_compliance_scheduled_action_for_rule_id` → `deviceComplianceScheduledActionForRule-id` (Graph `deviceComplianceScheduledActionForRule-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-policies/user-statuses` → `beta/deviceManagement/deviceCompliancePolicies/userStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `devices_count` → `devicesCount` (Graph `devicesCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_compliance_policy_id` → `deviceCompliancePolicy-id` (Graph `deviceCompliancePolicy-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-policy-setting-state-summaries` → `beta/deviceManagement/deviceCompliancePolicySettingStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliant_device_count` → `compliantDeviceCount` (Graph `compliantDeviceCount`, property, renamed).
- `conflict_device_count` → `conflictDeviceCount` (Graph `conflictDeviceCount`, property, renamed).
- `device_compliance_setting_states` → `deviceComplianceSettingStates` (Graph `deviceComplianceSettingStates`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `non_compliant_device_count` → `nonCompliantDeviceCount` (Graph `nonCompliantDeviceCount`, property, renamed).
- `not_applicable_device_count` → `notApplicableDeviceCount` (Graph `notApplicableDeviceCount`, property, renamed).
- `platform_type` → `platformType` (Graph `platformType`, property, renamed).
- `remediated_device_count` → `remediatedDeviceCount` (Graph `remediatedDeviceCount`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `unknown_device_count` → `unknownDeviceCount` (Graph `unknownDeviceCount`, property, renamed).

### `beta/device-management/device-compliance-policy-setting-state-summaries/device-compliance-setting-states` → `beta/deviceManagement/deviceCompliancePolicySettingStateSummaries/deviceComplianceSettingStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `platform_type` → `platformType` (Graph `platformType`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `user_email` → `userEmail` (Graph `userEmail`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_compliance_policy_setting_state_summary_id` → `deviceCompliancePolicySettingStateSummary-id` (Graph `deviceCompliancePolicySettingStateSummary-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-scripts` → `beta/deviceManagement/deviceComplianceScripts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `detection_script_content` → `detectionScriptContent` (Graph `detectionScriptContent`, property, renamed).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_signature_check` → `enforceSignatureCheck` (Graph `enforceSignatureCheck`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `run_as32_bit` → `runAs32Bit` (Graph `runAs32Bit`, property, renamed).
- `run_as_account` → `runAsAccount` (Graph `runAsAccount`, property, renamed).
- `run_summary` → `runSummary` (Graph `runSummary`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/device-compliance-scripts/assignments` → `beta/deviceManagement/deviceComplianceScripts/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `run_remediation_script` → `runRemediationScript` (Graph `runRemediationScript`, property, renamed).
- `run_schedule` → `runSchedule` (Graph `runSchedule`, property, renamed).
- `device_compliance_script_id` → `deviceComplianceScript-id` (Graph `deviceComplianceScript-id`, url_parameter, renamed).

### `beta/device-management/device-compliance-scripts/device-run-states` → `beta/deviceManagement/deviceComplianceScripts/deviceRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `detection_state` → `detectionState` (Graph `detectionState`, property, renamed).
- `expected_state_update_date_time` → `expectedStateUpdateDateTime` (Graph `expectedStateUpdateDateTime`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `managed_device` → `managedDevice` (Graph `managedDevice`, property, renamed).
- `script_error` → `scriptError` (Graph `scriptError`, property, renamed).
- `script_output` → `scriptOutput` (Graph `scriptOutput`, property, renamed).
- `device_compliance_script_id` → `deviceComplianceScript-id` (Graph `deviceComplianceScript-id`, url_parameter, renamed).

### `beta/device-management/device-configuration-conflict-summary` → `beta/deviceManagement/deviceConfigurationConflictSummary`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `conflicting_device_configurations` → `conflictingDeviceConfigurations` (Graph `conflictingDeviceConfigurations`, property, renamed).
- `contributing_settings` → `contributingSettings` (Graph `contributingSettings`, property, renamed).
- `device_checkins_impacted` → `deviceCheckinsImpacted` (Graph `deviceCheckinsImpacted`, property, renamed).

### `beta/device-management/device-configuration-restricted-apps-violations` → `beta/deviceManagement/deviceConfigurationRestrictedAppsViolations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_configuration_id` → `deviceConfigurationId` (Graph `deviceConfigurationId`, property, renamed).
- `device_configuration_name` → `deviceConfigurationName` (Graph `deviceConfigurationName`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `managed_device_id` → `managedDeviceId` (Graph `managedDeviceId`, property, renamed).
- `platform_type` → `platformType` (Graph `platformType`, property, renamed).
- `restricted_apps` → `restrictedApps` (Graph `restrictedApps`, property, renamed).
- `restricted_apps_state` → `restrictedAppsState` (Graph `restrictedAppsState`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).

### `beta/device-management/device-configurations` → `beta/deviceManagement/deviceConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_management_applicability_rule_device_mode` → `deviceManagementApplicabilityRuleDeviceMode` (Graph `deviceManagementApplicabilityRuleDeviceMode`, property, renamed).
- `device_management_applicability_rule_os_edition` → `deviceManagementApplicabilityRuleOsEdition` (Graph `deviceManagementApplicabilityRuleOsEdition`, property, renamed).
- `device_management_applicability_rule_os_version` → `deviceManagementApplicabilityRuleOsVersion` (Graph `deviceManagementApplicabilityRuleOsVersion`, property, renamed).
- `device_setting_state_summaries` → `deviceSettingStateSummaries` (Graph `deviceSettingStateSummaries`, property, renamed).
- `device_status_overview` → `deviceStatusOverview` (Graph `deviceStatusOverview`, property, renamed).
- `device_statuses` → `deviceStatuses` (Graph `deviceStatuses`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_assignments` → `groupAssignments` (Graph `groupAssignments`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `user_status_overview` → `userStatusOverview` (Graph `userStatusOverview`, property, renamed).
- `user_statuses` → `userStatuses` (Graph `userStatuses`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/device-configurations-all-managed-device-certificate-states` → `beta/deviceManagement/deviceConfigurationsAllManagedDeviceCertificateStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_expiration_date_time` → `certificateExpirationDateTime` (Graph `certificateExpirationDateTime`, property, renamed).
- `certificate_extended_key_usages` → `certificateExtendedKeyUsages` (Graph `certificateExtendedKeyUsages`, property, renamed).
- `certificate_issuance_date_time` → `certificateIssuanceDateTime` (Graph `certificateIssuanceDateTime`, property, renamed).
- `certificate_issuer_name` → `certificateIssuerName` (Graph `certificateIssuerName`, property, renamed).
- `certificate_key_usages` → `certificateKeyUsages` (Graph `certificateKeyUsages`, property, renamed).
- `certificate_revoke_status` → `certificateRevokeStatus` (Graph `certificateRevokeStatus`, property, renamed).
- `certificate_revoke_status_last_change_date_time` → `certificateRevokeStatusLastChangeDateTime` (Graph `certificateRevokeStatusLastChangeDateTime`, property, renamed).
- `certificate_serial_number` → `certificateSerialNumber` (Graph `certificateSerialNumber`, property, renamed).
- `certificate_subject_name` → `certificateSubjectName` (Graph `certificateSubjectName`, property, renamed).
- `certificate_thumbprint` → `certificateThumbprint` (Graph `certificateThumbprint`, property, renamed).
- `managed_device_display_name` → `managedDeviceDisplayName` (Graph `managedDeviceDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `beta/device-management/device-configurations/assignments` → `beta/deviceManagement/deviceConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `beta/device-management/device-configurations/device-setting-state-summaries` → `beta/deviceManagement/deviceConfigurations/deviceSettingStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliant_device_count` → `compliantDeviceCount` (Graph `compliantDeviceCount`, property, renamed).
- `conflict_device_count` → `conflictDeviceCount` (Graph `conflictDeviceCount`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `instance_path` → `instancePath` (Graph `instancePath`, property, renamed).
- `non_compliant_device_count` → `nonCompliantDeviceCount` (Graph `nonCompliantDeviceCount`, property, renamed).
- `not_applicable_device_count` → `notApplicableDeviceCount` (Graph `notApplicableDeviceCount`, property, renamed).
- `remediated_device_count` → `remediatedDeviceCount` (Graph `remediatedDeviceCount`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `unknown_device_count` → `unknownDeviceCount` (Graph `unknownDeviceCount`, property, renamed).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `beta/device-management/device-configurations/device-statuses` → `beta/deviceManagement/deviceConfigurations/deviceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `beta/device-management/device-configurations/group-assignments` → `beta/deviceManagement/deviceConfigurations/groupAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_configuration` → `deviceConfiguration` (Graph `deviceConfiguration`, property, renamed).
- `exclude_group` → `excludeGroup` (Graph `excludeGroup`, property, renamed).
- `target_group_id` → `targetGroupId` (Graph `targetGroupId`, property, renamed).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `beta/device-management/device-configurations/user-statuses` → `beta/deviceManagement/deviceConfigurations/userStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `devices_count` → `devicesCount` (Graph `devicesCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_configuration_id` → `deviceConfiguration-id` (Graph `deviceConfiguration-id`, url_parameter, renamed).

### `beta/device-management/device-custom-attribute-shell-scripts` → `beta/deviceManagement/deviceCustomAttributeShellScripts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `custom_attribute_name` → `customAttributeName` (Graph `customAttributeName`, property, renamed).
- `custom_attribute_type` → `customAttributeType` (Graph `customAttributeType`, property, renamed).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_name` → `fileName` (Graph `fileName`, property, renamed).
- `group_assignments` → `groupAssignments` (Graph `groupAssignments`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `run_as_account` → `runAsAccount` (Graph `runAsAccount`, property, renamed).
- `run_summary` → `runSummary` (Graph `runSummary`, property, renamed).
- `script_content` → `scriptContent` (Graph `scriptContent`, property, renamed).
- `user_run_states` → `userRunStates` (Graph `userRunStates`, property, renamed).

### `beta/device-management/device-custom-attribute-shell-scripts/assignments` → `beta/deviceManagement/deviceCustomAttributeShellScripts/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_custom_attribute_shell_script_id` → `deviceCustomAttributeShellScript-id` (Graph `deviceCustomAttributeShellScript-id`, url_parameter, renamed).

### `beta/device-management/device-custom-attribute-shell-scripts/device-run-states` → `beta/deviceManagement/deviceCustomAttributeShellScripts/deviceRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `error_description` → `errorDescription` (Graph `errorDescription`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `managed_device` → `managedDevice` (Graph `managedDevice`, property, renamed).
- `result_message` → `resultMessage` (Graph `resultMessage`, property, renamed).
- `run_state` → `runState` (Graph `runState`, property, renamed).
- `device_custom_attribute_shell_script_id` → `deviceCustomAttributeShellScript-id` (Graph `deviceCustomAttributeShellScript-id`, url_parameter, renamed).

### `beta/device-management/device-custom-attribute-shell-scripts/group-assignments` → `beta/deviceManagement/deviceCustomAttributeShellScripts/groupAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `target_group_id` → `targetGroupId` (Graph `targetGroupId`, property, renamed).
- `device_custom_attribute_shell_script_id` → `deviceCustomAttributeShellScript-id` (Graph `deviceCustomAttributeShellScript-id`, url_parameter, renamed).

### `beta/device-management/device-custom-attribute-shell-scripts/user-run-states` → `beta/deviceManagement/deviceCustomAttributeShellScripts/userRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `success_device_count` → `successDeviceCount` (Graph `successDeviceCount`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_custom_attribute_shell_script_id` → `deviceCustomAttributeShellScript-id` (Graph `deviceCustomAttributeShellScript-id`, url_parameter, renamed).

### `beta/device-management/device-enrollment-configurations` → `beta/deviceManagement/deviceEnrollmentConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_enrollment_configuration_type` → `deviceEnrollmentConfigurationType` (Graph `deviceEnrollmentConfigurationType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/device-enrollment-configurations/assignments` → `beta/deviceManagement/deviceEnrollmentConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `source_id` → `sourceId` (Graph `sourceId`, property, renamed).
- `device_enrollment_configuration_id` → `deviceEnrollmentConfiguration-id` (Graph `deviceEnrollmentConfiguration-id`, url_parameter, renamed).

### `beta/device-management/device-health-scripts` → `beta/deviceManagement/deviceHealthScripts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `detection_script_content` → `detectionScriptContent` (Graph `detectionScriptContent`, property, renamed).
- `detection_script_parameters` → `detectionScriptParameters` (Graph `detectionScriptParameters`, property, renamed).
- `device_health_script_type` → `deviceHealthScriptType` (Graph `deviceHealthScriptType`, property, renamed).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_signature_check` → `enforceSignatureCheck` (Graph `enforceSignatureCheck`, property, renamed).
- `highest_available_version` → `highestAvailableVersion` (Graph `highestAvailableVersion`, property, renamed).
- `remediation_script_content` → `remediationScriptContent` (Graph `remediationScriptContent`, property, renamed).
- `remediation_script_parameters` → `remediationScriptParameters` (Graph `remediationScriptParameters`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `run_as32_bit` → `runAs32Bit` (Graph `runAs32Bit`, property, renamed).
- `run_as_account` → `runAsAccount` (Graph `runAsAccount`, property, renamed).
- `run_summary` → `runSummary` (Graph `runSummary`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/device-health-scripts/assignments` → `beta/deviceManagement/deviceHealthScripts/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `run_remediation_script` → `runRemediationScript` (Graph `runRemediationScript`, property, renamed).
- `run_schedule` → `runSchedule` (Graph `runSchedule`, property, renamed).
- `device_health_script_id` → `deviceHealthScript-id` (Graph `deviceHealthScript-id`, url_parameter, renamed).

### `beta/device-management/device-health-scripts/device-run-states` → `beta/deviceManagement/deviceHealthScripts/deviceRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_filter_ids` → `assignmentFilterIds` (Graph `assignmentFilterIds`, property, renamed).
- `detection_state` → `detectionState` (Graph `detectionState`, property, renamed).
- `expected_state_update_date_time` → `expectedStateUpdateDateTime` (Graph `expectedStateUpdateDateTime`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `managed_device` → `managedDevice` (Graph `managedDevice`, property, renamed).
- `post_remediation_detection_script_error` → `postRemediationDetectionScriptError` (Graph `postRemediationDetectionScriptError`, property, renamed).
- `post_remediation_detection_script_output` → `postRemediationDetectionScriptOutput` (Graph `postRemediationDetectionScriptOutput`, property, renamed).
- `pre_remediation_detection_script_error` → `preRemediationDetectionScriptError` (Graph `preRemediationDetectionScriptError`, property, renamed).
- `pre_remediation_detection_script_output` → `preRemediationDetectionScriptOutput` (Graph `preRemediationDetectionScriptOutput`, property, renamed).
- `remediation_script_error` → `remediationScriptError` (Graph `remediationScriptError`, property, renamed).
- `remediation_state` → `remediationState` (Graph `remediationState`, property, renamed).
- `device_health_script_id` → `deviceHealthScript-id` (Graph `deviceHealthScript-id`, url_parameter, renamed).

### `beta/device-management/device-management-partners` → `beta/deviceManagement/deviceManagementPartners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `groups_requiring_partner_enrollment` → `groupsRequiringPartnerEnrollment` (Graph `groupsRequiringPartnerEnrollment`, property, renamed).
- `is_configured` → `isConfigured` (Graph `isConfigured`, property, renamed).
- `last_heartbeat_date_time` → `lastHeartbeatDateTime` (Graph `lastHeartbeatDateTime`, property, renamed).
- `partner_app_type` → `partnerAppType` (Graph `partnerAppType`, property, renamed).
- `partner_state` → `partnerState` (Graph `partnerState`, property, renamed).
- `single_tenant_app_id` → `singleTenantAppId` (Graph `singleTenantAppId`, property, renamed).
- `when_partner_devices_will_be_marked_as_non_compliant_date_time` → `whenPartnerDevicesWillBeMarkedAsNonCompliantDateTime` (Graph `whenPartnerDevicesWillBeMarkedAsNonCompliantDateTime`, property, renamed).
- `when_partner_devices_will_be_removed_date_time` → `whenPartnerDevicesWillBeRemovedDateTime` (Graph `whenPartnerDevicesWillBeRemovedDateTime`, property, renamed).

### `beta/device-management/device-management-scripts` → `beta/deviceManagement/deviceManagementScripts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_signature_check` → `enforceSignatureCheck` (Graph `enforceSignatureCheck`, property, renamed).
- `file_name` → `fileName` (Graph `fileName`, property, renamed).
- `group_assignments` → `groupAssignments` (Graph `groupAssignments`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `run_as32_bit` → `runAs32Bit` (Graph `runAs32Bit`, property, renamed).
- `run_as_account` → `runAsAccount` (Graph `runAsAccount`, property, renamed).
- `run_summary` → `runSummary` (Graph `runSummary`, property, renamed).
- `script_content` → `scriptContent` (Graph `scriptContent`, property, renamed).
- `user_run_states` → `userRunStates` (Graph `userRunStates`, property, renamed).

### `beta/device-management/device-management-scripts/assignments` → `beta/deviceManagement/deviceManagementScripts/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_management_script_id` → `deviceManagementScript-id` (Graph `deviceManagementScript-id`, url_parameter, renamed).

### `beta/device-management/device-management-scripts/device-run-states` → `beta/deviceManagement/deviceManagementScripts/deviceRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `error_description` → `errorDescription` (Graph `errorDescription`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `managed_device` → `managedDevice` (Graph `managedDevice`, property, renamed).
- `result_message` → `resultMessage` (Graph `resultMessage`, property, renamed).
- `run_state` → `runState` (Graph `runState`, property, renamed).
- `device_management_script_id` → `deviceManagementScript-id` (Graph `deviceManagementScript-id`, url_parameter, renamed).

### `beta/device-management/device-management-scripts/group-assignments` → `beta/deviceManagement/deviceManagementScripts/groupAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `target_group_id` → `targetGroupId` (Graph `targetGroupId`, property, renamed).
- `device_management_script_id` → `deviceManagementScript-id` (Graph `deviceManagementScript-id`, url_parameter, renamed).

### `beta/device-management/device-management-scripts/user-run-states` → `beta/deviceManagement/deviceManagementScripts/userRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `success_device_count` → `successDeviceCount` (Graph `successDeviceCount`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_management_script_id` → `deviceManagementScript-id` (Graph `deviceManagementScript-id`, url_parameter, renamed).

### `beta/device-management/device-management-scripts/user-run-states/device-run-states` → `beta/deviceManagement/deviceManagementScripts/userRunStates/deviceRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `error_description` → `errorDescription` (Graph `errorDescription`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `managed_device` → `managedDevice` (Graph `managedDevice`, property, renamed).
- `result_message` → `resultMessage` (Graph `resultMessage`, property, renamed).
- `run_state` → `runState` (Graph `runState`, property, renamed).
- `device_management_script_id` → `deviceManagementScript-id` (Graph `deviceManagementScript-id`, url_parameter, renamed).
- `device_management_script_user_state_id` → `deviceManagementScriptUserState-id` (Graph `deviceManagementScriptUserState-id`, url_parameter, renamed).

### `beta/device-management/device-shell-scripts` → `beta/deviceManagement/deviceShellScripts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `block_execution_notifications` → `blockExecutionNotifications` (Graph `blockExecutionNotifications`, property, renamed).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `execution_frequency` → `executionFrequency` (Graph `executionFrequency`, property, renamed).
- `file_name` → `fileName` (Graph `fileName`, property, renamed).
- `group_assignments` → `groupAssignments` (Graph `groupAssignments`, property, renamed).
- `retry_count` → `retryCount` (Graph `retryCount`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `run_as_account` → `runAsAccount` (Graph `runAsAccount`, property, renamed).
- `run_summary` → `runSummary` (Graph `runSummary`, property, renamed).
- `script_content` → `scriptContent` (Graph `scriptContent`, property, renamed).
- `user_run_states` → `userRunStates` (Graph `userRunStates`, property, renamed).

### `beta/device-management/device-shell-scripts/assignments` → `beta/deviceManagement/deviceShellScripts/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_shell_script_id` → `deviceShellScript-id` (Graph `deviceShellScript-id`, url_parameter, renamed).

### `beta/device-management/device-shell-scripts/device-run-states` → `beta/deviceManagement/deviceShellScripts/deviceRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `error_code` → `errorCode` (Graph `errorCode`, property, renamed).
- `error_description` → `errorDescription` (Graph `errorDescription`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `managed_device` → `managedDevice` (Graph `managedDevice`, property, renamed).
- `result_message` → `resultMessage` (Graph `resultMessage`, property, renamed).
- `run_state` → `runState` (Graph `runState`, property, renamed).
- `device_shell_script_id` → `deviceShellScript-id` (Graph `deviceShellScript-id`, url_parameter, renamed).

### `beta/device-management/device-shell-scripts/group-assignments` → `beta/deviceManagement/deviceShellScripts/groupAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `target_group_id` → `targetGroupId` (Graph `targetGroupId`, property, renamed).
- `device_shell_script_id` → `deviceShellScript-id` (Graph `deviceShellScript-id`, url_parameter, renamed).

### `beta/device-management/device-shell-scripts/user-run-states` → `beta/deviceManagement/deviceShellScripts/userRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_run_states` → `deviceRunStates` (Graph `deviceRunStates`, property, renamed).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `success_device_count` → `successDeviceCount` (Graph `successDeviceCount`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_shell_script_id` → `deviceShellScript-id` (Graph `deviceShellScript-id`, url_parameter, renamed).

### `beta/device-management/domain-join-connectors` → `beta/deviceManagement/domainJoinConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_connection_date_time` → `lastConnectionDateTime` (Graph `lastConnectionDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/elevation-requests` → `beta/deviceManagement/elevationRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `reviewer_justification` → `reviewerJustification` (Graph `reviewerJustification`, property, renamed).

### `beta/device-management/embedded-sim-activation-code-pools` → `beta/deviceManagement/embeddedSIMActivationCodePools`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `activation_code_count` → `activationCodeCount` (Graph `activationCodeCount`, property, renamed).
- `activation_codes` → `activationCodes` (Graph `activationCodes`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_states` → `deviceStates` (Graph `deviceStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).

### `beta/device-management/embedded-sim-activation-code-pools/assignments` → `beta/deviceManagement/embeddedSIMActivationCodePools/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `embedded_sim_activation_code_pool_id` → `embeddedSIMActivationCodePool-id` (Graph `embeddedSIMActivationCodePool-id`, url_parameter, renamed).

### `beta/device-management/embedded-sim-activation-code-pools/device-states` → `beta/deviceManagement/embeddedSIMActivationCodePools/deviceStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).
- `state_details` → `stateDetails` (Graph `stateDetails`, property, renamed).
- `universal_integrated_circuit_card_identifier` → `universalIntegratedCircuitCardIdentifier` (Graph `universalIntegratedCircuitCardIdentifier`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `embedded_sim_activation_code_pool_id` → `embeddedSIMActivationCodePool-id` (Graph `embeddedSIMActivationCodePool-id`, url_parameter, renamed).

### `beta/device-management/exchange-connectors` → `beta/deviceManagement/exchangeConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `connector_server_name` → `connectorServerName` (Graph `connectorServerName`, property, renamed).
- `exchange_alias` → `exchangeAlias` (Graph `exchangeAlias`, property, renamed).
- `exchange_connector_type` → `exchangeConnectorType` (Graph `exchangeConnectorType`, property, renamed).
- `exchange_organization` → `exchangeOrganization` (Graph `exchangeOrganization`, property, renamed).
- `last_sync_date_time` → `lastSyncDateTime` (Graph `lastSyncDateTime`, property, renamed).
- `primary_smtp_address` → `primarySmtpAddress` (Graph `primarySmtpAddress`, property, renamed).
- `server_name` → `serverName` (Graph `serverName`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/group-policy-categories` → `beta/deviceManagement/groupPolicyCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `definition_file` → `definitionFile` (Graph `definitionFile`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `ingestion_source` → `ingestionSource` (Graph `ingestionSource`, property, renamed).
- `is_root` → `isRoot` (Graph `isRoot`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).

### `beta/device-management/group-policy-configurations` → `beta/deviceManagement/groupPolicyConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `definition_values` → `definitionValues` (Graph `definitionValues`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `policy_configuration_ingestion_type` → `policyConfigurationIngestionType` (Graph `policyConfigurationIngestionType`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/group-policy-configurations/assignments` → `beta/deviceManagement/groupPolicyConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `group_policy_configuration_id` → `groupPolicyConfiguration-id` (Graph `groupPolicyConfiguration-id`, url_parameter, renamed).

### `beta/device-management/group-policy-configurations/definition-values` → `beta/deviceManagement/groupPolicyConfigurations/definitionValues`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `configuration_type` → `configurationType` (Graph `configurationType`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `presentation_values` → `presentationValues` (Graph `presentationValues`, property, renamed).
- `group_policy_configuration_id` → `groupPolicyConfiguration-id` (Graph `groupPolicyConfiguration-id`, url_parameter, renamed).

### `beta/device-management/group-policy-configurations/definition-values/presentation-values` → `beta/deviceManagement/groupPolicyConfigurations/definitionValues/presentationValues`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `definition_value` → `definitionValue` (Graph `definitionValue`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `group_policy_configuration_id` → `groupPolicyConfiguration-id` (Graph `groupPolicyConfiguration-id`, url_parameter, renamed).
- `group_policy_definition_value_id` → `groupPolicyDefinitionValue-id` (Graph `groupPolicyDefinitionValue-id`, url_parameter, renamed).

### `beta/device-management/group-policy-definitions` → `beta/deviceManagement/groupPolicyDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `category_path` → `categoryPath` (Graph `categoryPath`, property, renamed).
- `class_type` → `classType` (Graph `classType`, property, renamed).
- `definition_file` → `definitionFile` (Graph `definitionFile`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `explain_text` → `explainText` (Graph `explainText`, property, renamed).
- `group_policy_category_id` → `groupPolicyCategoryId` (Graph `groupPolicyCategoryId`, property, renamed).
- `has_related_definitions` → `hasRelatedDefinitions` (Graph `hasRelatedDefinitions`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `min_device_csp_version` → `minDeviceCspVersion` (Graph `minDeviceCspVersion`, property, renamed).
- `min_user_csp_version` → `minUserCspVersion` (Graph `minUserCspVersion`, property, renamed).
- `next_version_definition` → `nextVersionDefinition` (Graph `nextVersionDefinition`, property, renamed).
- `policy_type` → `policyType` (Graph `policyType`, property, renamed).
- `previous_version_definition` → `previousVersionDefinition` (Graph `previousVersionDefinition`, property, renamed).
- `supported_on` → `supportedOn` (Graph `supportedOn`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/group-policy-migration-reports` → `beta/deviceManagement/groupPolicyMigrationReports`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_policy_created_date_time` → `groupPolicyCreatedDateTime` (Graph `groupPolicyCreatedDateTime`, property, renamed).
- `group_policy_last_modified_date_time` → `groupPolicyLastModifiedDateTime` (Graph `groupPolicyLastModifiedDateTime`, property, renamed).
- `group_policy_object_id` → `groupPolicyObjectId` (Graph `groupPolicyObjectId`, property, renamed).
- `group_policy_setting_mappings` → `groupPolicySettingMappings` (Graph `groupPolicySettingMappings`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `migration_readiness` → `migrationReadiness` (Graph `migrationReadiness`, property, renamed).
- `ou_distinguished_name` → `ouDistinguishedName` (Graph `ouDistinguishedName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `supported_settings_count` → `supportedSettingsCount` (Graph `supportedSettingsCount`, property, renamed).
- `supported_settings_percent` → `supportedSettingsPercent` (Graph `supportedSettingsPercent`, property, renamed).
- `targeted_in_active_directory` → `targetedInActiveDirectory` (Graph `targetedInActiveDirectory`, property, renamed).
- `total_settings_count` → `totalSettingsCount` (Graph `totalSettingsCount`, property, renamed).
- `unsupported_group_policy_extensions` → `unsupportedGroupPolicyExtensions` (Graph `unsupportedGroupPolicyExtensions`, property, renamed).

### `beta/device-management/group-policy-migration-reports/group-policy-setting-mappings` → `beta/deviceManagement/groupPolicyMigrationReports/groupPolicySettingMappings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `admx_setting_definition_id` → `admxSettingDefinitionId` (Graph `admxSettingDefinitionId`, property, renamed).
- `child_id_list` → `childIdList` (Graph `childIdList`, property, renamed).
- `intune_setting_definition_id` → `intuneSettingDefinitionId` (Graph `intuneSettingDefinitionId`, property, renamed).
- `intune_setting_uri_list` → `intuneSettingUriList` (Graph `intuneSettingUriList`, property, renamed).
- `is_mdm_supported` → `isMdmSupported` (Graph `isMdmSupported`, property, renamed).
- `mdm_csp_name` → `mdmCspName` (Graph `mdmCspName`, property, renamed).
- `mdm_minimum_os_version` → `mdmMinimumOSVersion` (Graph `mdmMinimumOSVersion`, property, renamed).
- `mdm_setting_uri` → `mdmSettingUri` (Graph `mdmSettingUri`, property, renamed).
- `mdm_supported_state` → `mdmSupportedState` (Graph `mdmSupportedState`, property, renamed).
- `parent_id` → `parentId` (Graph `parentId`, property, renamed).
- `setting_category` → `settingCategory` (Graph `settingCategory`, property, renamed).
- `setting_display_name` → `settingDisplayName` (Graph `settingDisplayName`, property, renamed).
- `setting_display_value` → `settingDisplayValue` (Graph `settingDisplayValue`, property, renamed).
- `setting_display_value_type` → `settingDisplayValueType` (Graph `settingDisplayValueType`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `setting_scope` → `settingScope` (Graph `settingScope`, property, renamed).
- `setting_type` → `settingType` (Graph `settingType`, property, renamed).
- `setting_value` → `settingValue` (Graph `settingValue`, property, renamed).
- `setting_value_display_units` → `settingValueDisplayUnits` (Graph `settingValueDisplayUnits`, property, renamed).
- `setting_value_type` → `settingValueType` (Graph `settingValueType`, property, renamed).
- `group_policy_migration_report_id` → `groupPolicyMigrationReport-id` (Graph `groupPolicyMigrationReport-id`, url_parameter, renamed).

### `beta/device-management/group-policy-migration-reports/unsupported-group-policy-extensions` → `beta/deviceManagement/groupPolicyMigrationReports/unsupportedGroupPolicyExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `extension_type` → `extensionType` (Graph `extensionType`, property, renamed).
- `namespace_url` → `namespaceUrl` (Graph `namespaceUrl`, property, renamed).
- `node_name` → `nodeName` (Graph `nodeName`, property, renamed).
- `setting_scope` → `settingScope` (Graph `settingScope`, property, renamed).
- `group_policy_migration_report_id` → `groupPolicyMigrationReport-id` (Graph `groupPolicyMigrationReport-id`, url_parameter, renamed).

### `beta/device-management/group-policy-object-files` → `beta/deviceManagement/groupPolicyObjectFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `group_policy_object_id` → `groupPolicyObjectId` (Graph `groupPolicyObjectId`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `ou_distinguished_name` → `ouDistinguishedName` (Graph `ouDistinguishedName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/group-policy-uploaded-definition-files` → `beta/deviceManagement/groupPolicyUploadedDefinitionFiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `default_language_code` → `defaultLanguageCode` (Graph `defaultLanguageCode`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `file_name` → `fileName` (Graph `fileName`, property, renamed).
- `group_policy_operations` → `groupPolicyOperations` (Graph `groupPolicyOperations`, property, renamed).
- `group_policy_uploaded_language_files` → `groupPolicyUploadedLanguageFiles` (Graph `groupPolicyUploadedLanguageFiles`, property, renamed).
- `language_codes` → `languageCodes` (Graph `languageCodes`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `policy_type` → `policyType` (Graph `policyType`, property, renamed).
- `target_namespace` → `targetNamespace` (Graph `targetNamespace`, property, renamed).
- `target_prefix` → `targetPrefix` (Graph `targetPrefix`, property, renamed).
- `upload_date_time` → `uploadDateTime` (Graph `uploadDateTime`, property, renamed).

### `beta/device-management/hardware-configurations` → `beta/deviceManagement/hardwareConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `configuration_file_content` → `configurationFileContent` (Graph `configurationFileContent`, property, renamed).
- `file_name` → `fileName` (Graph `fileName`, property, renamed).
- `hardware_configuration_format` → `hardwareConfigurationFormat` (Graph `hardwareConfigurationFormat`, property, renamed).
- `per_device_password_disabled` → `perDevicePasswordDisabled` (Graph `perDevicePasswordDisabled`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/hardware-configurations/assignments` → `beta/deviceManagement/hardwareConfigurations/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `hardware_configuration_id` → `hardwareConfiguration-id` (Graph `hardwareConfiguration-id`, url_parameter, renamed).

### `beta/device-management/hardware-configurations/device-run-states` → `beta/deviceManagement/hardwareConfigurations/deviceRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_filter_ids` → `assignmentFilterIds` (Graph `assignmentFilterIds`, property, renamed).
- `configuration_error` → `configurationError` (Graph `configurationError`, property, renamed).
- `configuration_output` → `configurationOutput` (Graph `configurationOutput`, property, renamed).
- `configuration_state` → `configurationState` (Graph `configurationState`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `internal_version` → `internalVersion` (Graph `internalVersion`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `hardware_configuration_id` → `hardwareConfiguration-id` (Graph `hardwareConfiguration-id`, url_parameter, renamed).

### `beta/device-management/hardware-configurations/user-run-states` → `beta/deviceManagement/hardwareConfigurations/userRunStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `error_device_count` → `errorDeviceCount` (Graph `errorDeviceCount`, property, renamed).
- `failed_device_count` → `failedDeviceCount` (Graph `failedDeviceCount`, property, renamed).
- `last_state_update_date_time` → `lastStateUpdateDateTime` (Graph `lastStateUpdateDateTime`, property, renamed).
- `not_applicable_device_count` → `notApplicableDeviceCount` (Graph `notApplicableDeviceCount`, property, renamed).
- `pending_device_count` → `pendingDeviceCount` (Graph `pendingDeviceCount`, property, renamed).
- `successful_device_count` → `successfulDeviceCount` (Graph `successfulDeviceCount`, property, renamed).
- `unknown_device_count` → `unknownDeviceCount` (Graph `unknownDeviceCount`, property, renamed).
- `user_email` → `userEmail` (Graph `userEmail`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `hardware_configuration_id` → `hardwareConfiguration-id` (Graph `hardwareConfiguration-id`, url_parameter, renamed).

### `beta/device-management/hardware-password-details` → `beta/deviceManagement/hardwarePasswordDetails`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/device-management/hardware-password-info` → `beta/deviceManagement/hardwarePasswordInfo`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/device-management/imported-device-identities` → `beta/deviceManagement/importedDeviceIdentities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `enrollment_state` → `enrollmentState` (Graph `enrollmentState`, property, renamed).
- `imported_device_identifier` → `importedDeviceIdentifier` (Graph `importedDeviceIdentifier`, property, renamed).
- `imported_device_identity_type` → `importedDeviceIdentityType` (Graph `importedDeviceIdentityType`, property, renamed).
- `last_contacted_date_time` → `lastContactedDateTime` (Graph `lastContactedDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).

### `beta/device-management/imported-windows-autopilot-device-identities` → `beta/deviceManagement/importedWindowsAutopilotDeviceIdentities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_user_principal_name` → `assignedUserPrincipalName` (Graph `assignedUserPrincipalName`, property, renamed).
- `group_tag` → `groupTag` (Graph `groupTag`, property, renamed).
- `hardware_identifier` → `hardwareIdentifier` (Graph `hardwareIdentifier`, property, renamed).
- `import_id` → `importId` (Graph `importId`, property, renamed).
- `product_key` → `productKey` (Graph `productKey`, property, renamed).
- `serial_number` → `serialNumber` (Graph `serialNumber`, property, renamed).

### `beta/device-management/intents` → `beta/deviceManagement/intents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_setting_state_summaries` → `deviceSettingStateSummaries` (Graph `deviceSettingStateSummaries`, property, renamed).
- `device_state_summary` → `deviceStateSummary` (Graph `deviceStateSummary`, property, renamed).
- `device_states` → `deviceStates` (Graph `deviceStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_assigned` → `isAssigned` (Graph `isAssigned`, property, renamed).
- `is_migrating_to_configuration_policy` → `isMigratingToConfigurationPolicy` (Graph `isMigratingToConfigurationPolicy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `template_id` → `templateId` (Graph `templateId`, property, renamed).
- `user_state_summary` → `userStateSummary` (Graph `userStateSummary`, property, renamed).
- `user_states` → `userStates` (Graph `userStates`, property, renamed).

### `beta/device-management/intents/assignments` → `beta/deviceManagement/intents/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).

### `beta/device-management/intents/categories` → `beta/deviceManagement/intents/categories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `has_required_setting` → `hasRequiredSetting` (Graph `hasRequiredSetting`, property, renamed).
- `setting_definitions` → `settingDefinitions` (Graph `settingDefinitions`, property, renamed).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).

### `beta/device-management/intents/categories/setting-definitions` → `beta/deviceManagement/intents/categories/settingDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `documentation_url` → `documentationUrl` (Graph `documentationUrl`, property, renamed).
- `header_subtitle` → `headerSubtitle` (Graph `headerSubtitle`, property, renamed).
- `header_title` → `headerTitle` (Graph `headerTitle`, property, renamed).
- `is_top_level` → `isTopLevel` (Graph `isTopLevel`, property, renamed).
- `placeholder_text` → `placeholderText` (Graph `placeholderText`, property, renamed).
- `value_type` → `valueType` (Graph `valueType`, property, renamed).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).
- `device_management_intent_setting_category_id` → `deviceManagementIntentSettingCategory-id` (Graph `deviceManagementIntentSettingCategory-id`, url_parameter, renamed).

### `beta/device-management/intents/categories/settings` → `beta/deviceManagement/intents/categories/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `definition_id` → `definitionId` (Graph `definitionId`, property, renamed).
- `value_json` → `valueJson` (Graph `valueJson`, property, renamed).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).
- `device_management_intent_setting_category_id` → `deviceManagementIntentSettingCategory-id` (Graph `deviceManagementIntentSettingCategory-id`, url_parameter, renamed).

### `beta/device-management/intents/device-setting-state-summaries` → `beta/deviceManagement/intents/deviceSettingStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliant_count` → `compliantCount` (Graph `compliantCount`, property, renamed).
- `conflict_count` → `conflictCount` (Graph `conflictCount`, property, renamed).
- `error_count` → `errorCount` (Graph `errorCount`, property, renamed).
- `non_compliant_count` → `nonCompliantCount` (Graph `nonCompliantCount`, property, renamed).
- `not_applicable_count` → `notApplicableCount` (Graph `notApplicableCount`, property, renamed).
- `remediated_count` → `remediatedCount` (Graph `remediatedCount`, property, renamed).
- `setting_name` → `settingName` (Graph `settingName`, property, renamed).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).

### `beta/device-management/intents/device-states` → `beta/deviceManagement/intents/deviceStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).

### `beta/device-management/intents/settings` → `beta/deviceManagement/intents/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `definition_id` → `definitionId` (Graph `definitionId`, property, renamed).
- `value_json` → `valueJson` (Graph `valueJson`, property, renamed).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).

### `beta/device-management/intents/user-states` → `beta/deviceManagement/intents/userStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_count` → `deviceCount` (Graph `deviceCount`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `device_management_intent_id` → `deviceManagementIntent-id` (Graph `deviceManagementIntent-id`, url_parameter, renamed).

### `beta/device-management/intune-branding-profiles` → `beta/deviceManagement/intuneBrandingProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `company_portal_blocked_actions` → `companyPortalBlockedActions` (Graph `companyPortalBlockedActions`, property, renamed).
- `contact_it_email_address` → `contactITEmailAddress` (Graph `contactITEmailAddress`, property, renamed).
- `contact_it_name` → `contactITName` (Graph `contactITName`, property, renamed).
- `contact_it_notes` → `contactITNotes` (Graph `contactITNotes`, property, renamed).
- `contact_it_phone_number` → `contactITPhoneNumber` (Graph `contactITPhoneNumber`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_can_see_privacy_message` → `customCanSeePrivacyMessage` (Graph `customCanSeePrivacyMessage`, property, renamed).
- `custom_cant_see_privacy_message` → `customCantSeePrivacyMessage` (Graph `customCantSeePrivacyMessage`, property, renamed).
- `custom_privacy_message` → `customPrivacyMessage` (Graph `customPrivacyMessage`, property, renamed).
- `disable_client_telemetry` → `disableClientTelemetry` (Graph `disableClientTelemetry`, property, renamed).
- `disable_device_category_selection` → `disableDeviceCategorySelection` (Graph `disableDeviceCategorySelection`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrollment_availability` → `enrollmentAvailability` (Graph `enrollmentAvailability`, property, renamed).
- `is_default_profile` → `isDefaultProfile` (Graph `isDefaultProfile`, property, renamed).
- `is_factory_reset_disabled` → `isFactoryResetDisabled` (Graph `isFactoryResetDisabled`, property, renamed).
- `is_remove_device_disabled` → `isRemoveDeviceDisabled` (Graph `isRemoveDeviceDisabled`, property, renamed).
- `landing_page_customized_image` → `landingPageCustomizedImage` (Graph `landingPageCustomizedImage`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `light_background_logo` → `lightBackgroundLogo` (Graph `lightBackgroundLogo`, property, renamed).
- `online_support_site_name` → `onlineSupportSiteName` (Graph `onlineSupportSiteName`, property, renamed).
- `online_support_site_url` → `onlineSupportSiteUrl` (Graph `onlineSupportSiteUrl`, property, renamed).
- `privacy_url` → `privacyUrl` (Graph `privacyUrl`, property, renamed).
- `profile_description` → `profileDescription` (Graph `profileDescription`, property, renamed).
- `profile_name` → `profileName` (Graph `profileName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `show_azure_ad_enterprise_apps` → `showAzureADEnterpriseApps` (Graph `showAzureADEnterpriseApps`, property, renamed).
- `show_configuration_manager_apps` → `showConfigurationManagerApps` (Graph `showConfigurationManagerApps`, property, renamed).
- `show_display_name_next_to_logo` → `showDisplayNameNextToLogo` (Graph `showDisplayNameNextToLogo`, property, renamed).
- `show_logo` → `showLogo` (Graph `showLogo`, property, renamed).
- `show_office_web_apps` → `showOfficeWebApps` (Graph `showOfficeWebApps`, property, renamed).
- `theme_color` → `themeColor` (Graph `themeColor`, property, renamed).
- `theme_color_logo` → `themeColorLogo` (Graph `themeColorLogo`, property, renamed).

### `beta/device-management/intune-branding-profiles/assignments` → `beta/deviceManagement/intuneBrandingProfiles/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `intune_branding_profile_id` → `intuneBrandingProfile-id` (Graph `intuneBrandingProfile-id`, url_parameter, renamed).

### `beta/device-management/ios-update-statuses` → `beta/deviceManagement/iosUpdateStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `compliance_grace_period_expiration_date_time` → `complianceGracePeriodExpirationDateTime` (Graph `complianceGracePeriodExpirationDateTime`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `install_status` → `installStatus` (Graph `installStatus`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `beta/device-management/mac-os-software-update-account-summaries` → `beta/deviceManagement/macOSSoftwareUpdateAccountSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `category_summaries` → `categorySummaries` (Graph `categorySummaries`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `failed_update_count` → `failedUpdateCount` (Graph `failedUpdateCount`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `successful_update_count` → `successfulUpdateCount` (Graph `successfulUpdateCount`, property, renamed).
- `total_update_count` → `totalUpdateCount` (Graph `totalUpdateCount`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `beta/device-management/mac-os-software-update-account-summaries/category-summaries` → `beta/deviceManagement/macOSSoftwareUpdateAccountSummaries/categorySummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `failed_update_count` → `failedUpdateCount` (Graph `failedUpdateCount`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `successful_update_count` → `successfulUpdateCount` (Graph `successfulUpdateCount`, property, renamed).
- `total_update_count` → `totalUpdateCount` (Graph `totalUpdateCount`, property, renamed).
- `update_category` → `updateCategory` (Graph `updateCategory`, property, renamed).
- `update_state_summaries` → `updateStateSummaries` (Graph `updateStateSummaries`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `mac_os_software_update_account_summary_id` → `macOSSoftwareUpdateAccountSummary-id` (Graph `macOSSoftwareUpdateAccountSummary-id`, url_parameter, renamed).

### `beta/device-management/mac-os-software-update-account-summaries/category-summaries/update-state-summaries` → `beta/deviceManagement/macOSSoftwareUpdateAccountSummaries/categorySummaries/updateStateSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `product_key` → `productKey` (Graph `productKey`, property, renamed).
- `update_category` → `updateCategory` (Graph `updateCategory`, property, renamed).
- `update_version` → `updateVersion` (Graph `updateVersion`, property, renamed).
- `mac_os_software_update_account_summary_id` → `macOSSoftwareUpdateAccountSummary-id` (Graph `macOSSoftwareUpdateAccountSummary-id`, url_parameter, renamed).
- `mac_os_software_update_category_summary_id` → `macOSSoftwareUpdateCategorySummary-id` (Graph `macOSSoftwareUpdateCategorySummary-id`, url_parameter, renamed).

### `beta/device-management/managed-device-cleanup-rules` → `beta/deviceManagement/managedDeviceCleanupRules`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_cleanup_rule_platform_type` → `deviceCleanupRulePlatformType` (Graph `deviceCleanupRulePlatformType`, property, renamed).
- `device_inactivity_before_retirement_in_days` → `deviceInactivityBeforeRetirementInDays` (Graph `deviceInactivityBeforeRetirementInDays`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/device-management/managed-device-encryption-states` → `beta/deviceManagement/managedDeviceEncryptionStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `advanced_bit_locker_states` → `advancedBitLockerStates` (Graph `advancedBitLockerStates`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `device_type` → `deviceType` (Graph `deviceType`, property, renamed).
- `encryption_policy_setting_state` → `encryptionPolicySettingState` (Graph `encryptionPolicySettingState`, property, renamed).
- `encryption_readiness_state` → `encryptionReadinessState` (Graph `encryptionReadinessState`, property, renamed).
- `encryption_state` → `encryptionState` (Graph `encryptionState`, property, renamed).
- `file_vault_states` → `fileVaultStates` (Graph `fileVaultStates`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `policy_details` → `policyDetails` (Graph `policyDetails`, property, renamed).
- `tpm_specification_version` → `tpmSpecificationVersion` (Graph `tpmSpecificationVersion`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `beta/device-management/managed-devices` → `beta/deviceManagement/managedDevices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_filter_evaluation_status_details` → `assignmentFilterEvaluationStatusDetails` (Graph `assignmentFilterEvaluationStatusDetails`, property, renamed).
- `chrome_os_device_info` → `chromeOSDeviceInfo` (Graph `chromeOSDeviceInfo`, property, renamed).
- `cloud_pc_remote_action_results` → `cloudPcRemoteActionResults` (Graph `cloudPcRemoteActionResults`, property, renamed).
- `configuration_manager_client_health_state` → `configurationManagerClientHealthState` (Graph `configurationManagerClientHealthState`, property, renamed).
- `configuration_manager_client_information` → `configurationManagerClientInformation` (Graph `configurationManagerClientInformation`, property, renamed).
- `detected_apps` → `detectedApps` (Graph `detectedApps`, property, renamed).
- `device_category` → `deviceCategory` (Graph `deviceCategory`, property, renamed).
- `device_compliance_policy_states` → `deviceCompliancePolicyStates` (Graph `deviceCompliancePolicyStates`, property, renamed).
- `device_configuration_states` → `deviceConfigurationStates` (Graph `deviceConfigurationStates`, property, renamed).
- `device_firmware_configuration_interface_managed` → `deviceFirmwareConfigurationInterfaceManaged` (Graph `deviceFirmwareConfigurationInterfaceManaged`, property, renamed).
- `join_type` → `joinType` (Graph `joinType`, property, renamed).
- `log_collection_requests` → `logCollectionRequests` (Graph `logCollectionRequests`, property, renamed).
- `managed_device_mobile_app_configuration_states` → `managedDeviceMobileAppConfigurationStates` (Graph `managedDeviceMobileAppConfigurationStates`, property, renamed).
- `managed_device_name` → `managedDeviceName` (Graph `managedDeviceName`, property, renamed).
- `managed_device_owner_type` → `managedDeviceOwnerType` (Graph `managedDeviceOwnerType`, property, renamed).
- `management_features` → `managementFeatures` (Graph `managementFeatures`, property, renamed).
- `owner_type` → `ownerType` (Graph `ownerType`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `security_baseline_states` → `securityBaselineStates` (Graph `securityBaselineStates`, property, renamed).
- `sku_family` → `skuFamily` (Graph `skuFamily`, property, renamed).

### `beta/device-management/microsoft-tunnel-configurations` → `beta/deviceManagement/microsoftTunnelConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `advanced_settings` → `advancedSettings` (Graph `advancedSettings`, property, renamed).
- `default_domain_suffix` → `defaultDomainSuffix` (Graph `defaultDomainSuffix`, property, renamed).
- `disable_udp_connections` → `disableUdpConnections` (Graph `disableUdpConnections`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `dns_servers` → `dnsServers` (Graph `dnsServers`, property, renamed).
- `ipv6_network` → `ipv6Network` (Graph `ipv6Network`, property, renamed).
- `last_update_date_time` → `lastUpdateDateTime` (Graph `lastUpdateDateTime`, property, renamed).
- `listen_port` → `listenPort` (Graph `listenPort`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `route_excludes` → `routeExcludes` (Graph `routeExcludes`, property, renamed).
- `route_includes` → `routeIncludes` (Graph `routeIncludes`, property, renamed).
- `routes_exclude` → `routesExclude` (Graph `routesExclude`, property, renamed).
- `routes_include` → `routesInclude` (Graph `routesInclude`, property, renamed).
- `split_dns` → `splitDNS` (Graph `splitDNS`, property, renamed).

### `beta/device-management/microsoft-tunnel-health-thresholds` → `beta/deviceManagement/microsoftTunnelHealthThresholds`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `healthy_threshold` → `healthyThreshold` (Graph `healthyThreshold`, property, renamed).
- `unhealthy_threshold` → `unhealthyThreshold` (Graph `unhealthyThreshold`, property, renamed).

### `beta/device-management/microsoft-tunnel-server-log-collection-responses` → `beta/deviceManagement/microsoftTunnelServerLogCollectionResponses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `expiry_date_time` → `expiryDateTime` (Graph `expiryDateTime`, property, renamed).
- `request_date_time` → `requestDateTime` (Graph `requestDateTime`, property, renamed).
- `server_id` → `serverId` (Graph `serverId`, property, renamed).
- `size_in_bytes` → `sizeInBytes` (Graph `sizeInBytes`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).

### `beta/device-management/microsoft-tunnel-sites` → `beta/deviceManagement/microsoftTunnelSites`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `internal_network_probe_url` → `internalNetworkProbeUrl` (Graph `internalNetworkProbeUrl`, property, renamed).
- `microsoft_tunnel_configuration` → `microsoftTunnelConfiguration` (Graph `microsoftTunnelConfiguration`, property, renamed).
- `microsoft_tunnel_servers` → `microsoftTunnelServers` (Graph `microsoftTunnelServers`, property, renamed).
- `public_address` → `publicAddress` (Graph `publicAddress`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `upgrade_automatically` → `upgradeAutomatically` (Graph `upgradeAutomatically`, property, renamed).
- `upgrade_available` → `upgradeAvailable` (Graph `upgradeAvailable`, property, renamed).
- `upgrade_window_end_time` → `upgradeWindowEndTime` (Graph `upgradeWindowEndTime`, property, renamed).
- `upgrade_window_start_time` → `upgradeWindowStartTime` (Graph `upgradeWindowStartTime`, property, renamed).
- `upgrade_window_utc_offset_in_minutes` → `upgradeWindowUtcOffsetInMinutes` (Graph `upgradeWindowUtcOffsetInMinutes`, property, renamed).

### `beta/device-management/microsoft-tunnel-sites/microsoft-tunnel-servers` → `beta/deviceManagement/microsoftTunnelSites/microsoftTunnelServers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `tunnel_server_health_status` → `tunnelServerHealthStatus` (Graph `tunnelServerHealthStatus`, property, renamed).
- `microsoft_tunnel_site_id` → `microsoftTunnelSite-id` (Graph `microsoftTunnelSite-id`, url_parameter, renamed).

### `beta/device-management/mobile-app-troubleshooting-events` → `beta/deviceManagement/mobileAppTroubleshootingEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `app_log_collection_requests` → `appLogCollectionRequests` (Graph `appLogCollectionRequests`, property, renamed).
- `application_id` → `applicationId` (Graph `applicationId`, property, renamed).
- `correlation_id` → `correlationId` (Graph `correlationId`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `event_date_time` → `eventDateTime` (Graph `eventDateTime`, property, renamed).
- `event_name` → `eventName` (Graph `eventName`, property, renamed).
- `managed_device_identifier` → `managedDeviceIdentifier` (Graph `managedDeviceIdentifier`, property, renamed).
- `troubleshooting_error_details` → `troubleshootingErrorDetails` (Graph `troubleshootingErrorDetails`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).

### `beta/device-management/mobile-app-troubleshooting-events/app-log-collection-requests` → `beta/deviceManagement/mobileAppTroubleshootingEvents/appLogCollectionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `custom_log_folders` → `customLogFolders` (Graph `customLogFolders`, property, renamed).
- `error_message` → `errorMessage` (Graph `errorMessage`, property, renamed).
- `mobile_app_troubleshooting_event_id` → `mobileAppTroubleshootingEvent-id` (Graph `mobileAppTroubleshootingEvent-id`, url_parameter, renamed).

### `beta/device-management/mobile-threat-defense-connectors` → `beta/deviceManagement/mobileThreatDefenseConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_partner_to_collect_ios_application_metadata` → `allowPartnerToCollectIOSApplicationMetadata` (Graph `allowPartnerToCollectIOSApplicationMetadata`, property, renamed).
- `allow_partner_to_collect_ios_personal_application_metadata` → `allowPartnerToCollectIOSPersonalApplicationMetadata` (Graph `allowPartnerToCollectIOSPersonalApplicationMetadata`, property, renamed).
- `allow_partner_to_collect_ios_certificate_metadata` → `allowPartnerToCollectIosCertificateMetadata` (Graph `allowPartnerToCollectIosCertificateMetadata`, property, renamed).
- `allow_partner_to_collect_ios_personal_certificate_metadata` → `allowPartnerToCollectIosPersonalCertificateMetadata` (Graph `allowPartnerToCollectIosPersonalCertificateMetadata`, property, renamed).
- `android_device_blocked_on_missing_partner_data` → `androidDeviceBlockedOnMissingPartnerData` (Graph `androidDeviceBlockedOnMissingPartnerData`, property, renamed).
- `android_enabled` → `androidEnabled` (Graph `androidEnabled`, property, renamed).
- `android_mobile_application_management_enabled` → `androidMobileApplicationManagementEnabled` (Graph `androidMobileApplicationManagementEnabled`, property, renamed).
- `grant_mobile_threat_defense_partner_role` → `grantMobileThreatDefensePartnerRole` (Graph `grantMobileThreatDefensePartnerRole`, property, renamed).
- `ios_device_blocked_on_missing_partner_data` → `iosDeviceBlockedOnMissingPartnerData` (Graph `iosDeviceBlockedOnMissingPartnerData`, property, renamed).
- `ios_enabled` → `iosEnabled` (Graph `iosEnabled`, property, renamed).
- `ios_mobile_application_management_enabled` → `iosMobileApplicationManagementEnabled` (Graph `iosMobileApplicationManagementEnabled`, property, renamed).
- `last_heartbeat_date_time` → `lastHeartbeatDateTime` (Graph `lastHeartbeatDateTime`, property, renamed).
- `launch_mobile_threat_defense_partner_on_setup_enabled` → `launchMobileThreatDefensePartnerOnSetupEnabled` (Graph `launchMobileThreatDefensePartnerOnSetupEnabled`, property, renamed).
- `mac_device_blocked_on_missing_partner_data` → `macDeviceBlockedOnMissingPartnerData` (Graph `macDeviceBlockedOnMissingPartnerData`, property, renamed).
- `mac_enabled` → `macEnabled` (Graph `macEnabled`, property, renamed).
- `microsoft_defender_for_endpoint_attach_enabled` → `microsoftDefenderForEndpointAttachEnabled` (Graph `microsoftDefenderForEndpointAttachEnabled`, property, renamed).
- `partner_minimum_supported_android_version` → `partnerMinimumSupportedAndroidVersion` (Graph `partnerMinimumSupportedAndroidVersion`, property, renamed).
- `partner_minimum_supported_ios_version` → `partnerMinimumSupportedIosVersion` (Graph `partnerMinimumSupportedIosVersion`, property, renamed).
- `partner_minimum_supported_mac_version` → `partnerMinimumSupportedMacVersion` (Graph `partnerMinimumSupportedMacVersion`, property, renamed).
- `partner_minimum_supported_windows_version` → `partnerMinimumSupportedWindowsVersion` (Graph `partnerMinimumSupportedWindowsVersion`, property, renamed).
- `partner_state` → `partnerState` (Graph `partnerState`, property, renamed).
- `partner_supports_android_mam` → `partnerSupportsAndroidMam` (Graph `partnerSupportsAndroidMam`, property, renamed).
- `partner_supports_ios_certificate_sync` → `partnerSupportsIosCertificateSync` (Graph `partnerSupportsIosCertificateSync`, property, renamed).
- `partner_supports_ios_mam` → `partnerSupportsIosMam` (Graph `partnerSupportsIosMam`, property, renamed).
- `partner_supports_windows_mam` → `partnerSupportsWindowsMam` (Graph `partnerSupportsWindowsMam`, property, renamed).
- `partner_unresponsiveness_threshold_in_days` → `partnerUnresponsivenessThresholdInDays` (Graph `partnerUnresponsivenessThresholdInDays`, property, renamed).
- `partner_unsupported_os_version_blocked` → `partnerUnsupportedOsVersionBlocked` (Graph `partnerUnsupportedOsVersionBlocked`, property, renamed).
- `windows_device_blocked_on_missing_partner_data` → `windowsDeviceBlockedOnMissingPartnerData` (Graph `windowsDeviceBlockedOnMissingPartnerData`, property, renamed).
- `windows_enabled` → `windowsEnabled` (Graph `windowsEnabled`, property, renamed).
- `windows_mobile_application_management_enabled` → `windowsMobileApplicationManagementEnabled` (Graph `windowsMobileApplicationManagementEnabled`, property, renamed).

### `beta/device-management/ndes-connectors` → `beta/deviceManagement/ndesConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `connector_version` → `connectorVersion` (Graph `connectorVersion`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrolled_date_time` → `enrolledDateTime` (Graph `enrolledDateTime`, property, renamed).
- `last_connection_date_time` → `lastConnectionDateTime` (Graph `lastConnectionDateTime`, property, renamed).
- `machine_name` → `machineName` (Graph `machineName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/notification-message-templates` → `beta/deviceManagement/notificationMessageTemplates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `branding_options` → `brandingOptions` (Graph `brandingOptions`, property, renamed).
- `default_locale` → `defaultLocale` (Graph `defaultLocale`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `localized_notification_messages` → `localizedNotificationMessages` (Graph `localizedNotificationMessages`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/notification-message-templates/localized-notification-messages` → `beta/deviceManagement/notificationMessageTemplates/localizedNotificationMessages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `is_default` → `isDefault` (Graph `isDefault`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `message_template` → `messageTemplate` (Graph `messageTemplate`, property, renamed).
- `notification_message_template_id` → `notificationMessageTemplate-id` (Graph `notificationMessageTemplate-id`, url_parameter, renamed).

### `beta/device-management/operation-approval-policies` → `beta/deviceManagement/operationApprovalPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `approver_group_ids` → `approverGroupIds` (Graph `approverGroupIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `policy_platform` → `policyPlatform` (Graph `policyPlatform`, property, renamed).
- `policy_set` → `policySet` (Graph `policySet`, property, renamed).
- `policy_type` → `policyType` (Graph `policyType`, property, renamed).

### `beta/device-management/operation-approval-requests` → `beta/deviceManagement/operationApprovalRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/device-management/privilege-management-elevations` → `beta/deviceManagement/privilegeManagementElevations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_payload` → `certificatePayload` (Graph `certificatePayload`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `elevation_type` → `elevationType` (Graph `elevationType`, property, renamed).
- `event_date_time` → `eventDateTime` (Graph `eventDateTime`, property, renamed).
- `file_description` → `fileDescription` (Graph `fileDescription`, property, renamed).
- `file_path` → `filePath` (Graph `filePath`, property, renamed).
- `file_version` → `fileVersion` (Graph `fileVersion`, property, renamed).
- `internal_name` → `internalName` (Graph `internalName`, property, renamed).
- `parent_process_name` → `parentProcessName` (Graph `parentProcessName`, property, renamed).
- `policy_id` → `policyId` (Graph `policyId`, property, renamed).
- `policy_name` → `policyName` (Graph `policyName`, property, renamed).
- `process_type` → `processType` (Graph `processType`, property, renamed).
- `product_name` → `productName` (Graph `productName`, property, renamed).
- `rule_id` → `ruleId` (Graph `ruleId`, property, renamed).
- `system_initiated_elevation` → `systemInitiatedElevation` (Graph `systemInitiatedElevation`, property, renamed).
- `user_type` → `userType` (Graph `userType`, property, renamed).

### `beta/device-management/remote-action-audits` → `beta/deviceManagement/remoteActionAudits`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_state` → `actionState` (Graph `actionState`, property, renamed).
- `bulk_device_action_id` → `bulkDeviceActionId` (Graph `bulkDeviceActionId`, property, renamed).
- `device_action_category` → `deviceActionCategory` (Graph `deviceActionCategory`, property, renamed).
- `device_display_name` → `deviceDisplayName` (Graph `deviceDisplayName`, property, renamed).
- `device_imei` → `deviceIMEI` (Graph `deviceIMEI`, property, renamed).
- `device_owner_user_principal_name` → `deviceOwnerUserPrincipalName` (Graph `deviceOwnerUserPrincipalName`, property, renamed).
- `initiated_by_user_principal_name` → `initiatedByUserPrincipalName` (Graph `initiatedByUserPrincipalName`, property, renamed).
- `managed_device_id` → `managedDeviceId` (Graph `managedDeviceId`, property, renamed).
- `request_date_time` → `requestDateTime` (Graph `requestDateTime`, property, renamed).
- `user_name` → `userName` (Graph `userName`, property, renamed).

### `beta/device-management/remote-assistance-partners` → `beta/deviceManagement/remoteAssistancePartners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_connection_date_time` → `lastConnectionDateTime` (Graph `lastConnectionDateTime`, property, renamed).
- `onboarding_request_expiry_date_time` → `onboardingRequestExpiryDateTime` (Graph `onboardingRequestExpiryDateTime`, property, renamed).
- `onboarding_status` → `onboardingStatus` (Graph `onboardingStatus`, property, renamed).
- `onboarding_url` → `onboardingUrl` (Graph `onboardingUrl`, property, renamed).

### `beta/device-management/reports/cached-report-configurations` → `beta/deviceManagement/reports/cachedReportConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `last_refresh_date_time` → `lastRefreshDateTime` (Graph `lastRefreshDateTime`, property, renamed).
- `order_by` → `orderBy` (Graph `orderBy`, property, renamed).
- `report_name` → `reportName` (Graph `reportName`, property, renamed).

### `beta/device-management/reports/export-jobs` → `beta/deviceManagement/reports/exportJobs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `localization_type` → `localizationType` (Graph `localizationType`, property, renamed).
- `report_name` → `reportName` (Graph `reportName`, property, renamed).
- `request_date_time` → `requestDateTime` (Graph `requestDateTime`, property, renamed).
- `snapshot_id` → `snapshotId` (Graph `snapshotId`, property, renamed).

### `beta/device-management/resource-access-profiles` → `beta/deviceManagement/resourceAccessProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `creation_date_time` → `creationDateTime` (Graph `creationDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/resource-access-profiles/assignments` → `beta/deviceManagement/resourceAccessProfiles/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `source_id` → `sourceId` (Graph `sourceId`, property, renamed).
- `device_management_resource_access_profile_base_id` → `deviceManagementResourceAccessProfileBase-id` (Graph `deviceManagementResourceAccessProfileBase-id`, url_parameter, renamed).

### `beta/device-management/resource-operations` → `beta/deviceManagement/resourceOperations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_name` → `actionName` (Graph `actionName`, property, renamed).
- `resource_name` → `resourceName` (Graph `resourceName`, property, renamed).

### `beta/device-management/reusable-policy-settings` → `beta/deviceManagement/reusablePolicySettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `setting_definition_id` → `settingDefinitionId` (Graph `settingDefinitionId`, property, renamed).
- `setting_instance` → `settingInstance` (Graph `settingInstance`, property, renamed).

### `beta/device-management/reusable-policy-settings/referencing-configuration-policies` → `beta/deviceManagement/reusablePolicySettings/referencingConfigurationPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `creation_source` → `creationSource` (Graph `creationSource`, property, renamed).
- `disable_entra_group_policy_assignment` → `disableEntraGroupPolicyAssignment` (Graph `disableEntraGroupPolicyAssignment`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `priority_meta_data` → `priorityMetaData` (Graph `priorityMetaData`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `setting_count` → `settingCount` (Graph `settingCount`, property, renamed).
- `template_reference` → `templateReference` (Graph `templateReference`, property, renamed).
- `device_management_reusable_policy_setting_id` → `deviceManagementReusablePolicySetting-id` (Graph `deviceManagementReusablePolicySetting-id`, url_parameter, renamed).

### `beta/device-management/reusable-settings` → `beta/deviceManagement/reusableSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_types` → `accessTypes` (Graph `accessTypes`, property, renamed).
- `base_uri` → `baseUri` (Graph `baseUri`, property, renamed).
- `category_id` → `categoryId` (Graph `categoryId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `help_text` → `helpText` (Graph `helpText`, property, renamed).
- `info_urls` → `infoUrls` (Graph `infoUrls`, property, renamed).
- `offset_uri` → `offsetUri` (Graph `offsetUri`, property, renamed).
- `referred_setting_information_list` → `referredSettingInformationList` (Graph `referredSettingInformationList`, property, renamed).
- `risk_level` → `riskLevel` (Graph `riskLevel`, property, renamed).
- `root_definition_id` → `rootDefinitionId` (Graph `rootDefinitionId`, property, renamed).
- `setting_usage` → `settingUsage` (Graph `settingUsage`, property, renamed).
- `ux_behavior` → `uxBehavior` (Graph `uxBehavior`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/role-assignments` → `beta/deviceManagement/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `resource_scopes` → `resourceScopes` (Graph `resourceScopes`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `role_scope_tags` → `roleScopeTags` (Graph `roleScopeTags`, property, renamed).
- `scope_members` → `scopeMembers` (Graph `scopeMembers`, property, renamed).
- `scope_type` → `scopeType` (Graph `scopeType`, property, renamed).

### `beta/device-management/role-definitions` → `beta/deviceManagement/roleDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_built_in` → `isBuiltIn` (Graph `isBuiltIn`, property, renamed).
- `is_built_in_role_definition` → `isBuiltInRoleDefinition` (Graph `isBuiltInRoleDefinition`, property, renamed).
- `role_assignments` → `roleAssignments` (Graph `roleAssignments`, property, renamed).
- `role_permissions` → `rolePermissions` (Graph `rolePermissions`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/role-definitions/role-assignments` → `beta/deviceManagement/roleDefinitions/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `resource_scopes` → `resourceScopes` (Graph `resourceScopes`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).
- `scope_members` → `scopeMembers` (Graph `scopeMembers`, property, renamed).
- `scope_type` → `scopeType` (Graph `scopeType`, property, renamed).
- `role_definition_id` → `roleDefinition-id` (Graph `roleDefinition-id`, url_parameter, renamed).

### `beta/device-management/role-scope-tags` → `beta/deviceManagement/roleScopeTags`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/device-management/setting-definitions` → `beta/deviceManagement/settingDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `documentation_url` → `documentationUrl` (Graph `documentationUrl`, property, renamed).
- `header_subtitle` → `headerSubtitle` (Graph `headerSubtitle`, property, renamed).
- `header_title` → `headerTitle` (Graph `headerTitle`, property, renamed).
- `is_top_level` → `isTopLevel` (Graph `isTopLevel`, property, renamed).
- `placeholder_text` → `placeholderText` (Graph `placeholderText`, property, renamed).
- `value_type` → `valueType` (Graph `valueType`, property, renamed).

### `beta/device-management/template-insights` → `beta/deviceManagement/templateInsights`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `setting_insights` → `settingInsights` (Graph `settingInsights`, property, renamed).

### `beta/device-management/template-settings` → `beta/deviceManagement/templateSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `setting_definitions` → `settingDefinitions` (Graph `settingDefinitions`, property, renamed).
- `setting_instance_template` → `settingInstanceTemplate` (Graph `settingInstanceTemplate`, property, renamed).

### `beta/device-management/templates` → `beta/deviceManagement/templates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `intent_count` → `intentCount` (Graph `intentCount`, property, renamed).
- `is_deprecated` → `isDeprecated` (Graph `isDeprecated`, property, renamed).
- `migratable_to` → `migratableTo` (Graph `migratableTo`, property, renamed).
- `platform_type` → `platformType` (Graph `platformType`, property, renamed).
- `published_date_time` → `publishedDateTime` (Graph `publishedDateTime`, property, renamed).
- `template_subtype` → `templateSubtype` (Graph `templateSubtype`, property, renamed).
- `template_type` → `templateType` (Graph `templateType`, property, renamed).
- `version_info` → `versionInfo` (Graph `versionInfo`, property, renamed).

### `beta/device-management/templates/categories` → `beta/deviceManagement/templates/categories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `has_required_setting` → `hasRequiredSetting` (Graph `hasRequiredSetting`, property, renamed).
- `recommended_settings` → `recommendedSettings` (Graph `recommendedSettings`, property, renamed).
- `setting_definitions` → `settingDefinitions` (Graph `settingDefinitions`, property, renamed).
- `device_management_template_id` → `deviceManagementTemplate-id` (Graph `deviceManagementTemplate-id`, url_parameter, renamed).

### `beta/device-management/templates/categories/recommended-settings` → `beta/deviceManagement/templates/categories/recommendedSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `definition_id` → `definitionId` (Graph `definitionId`, property, renamed).
- `value_json` → `valueJson` (Graph `valueJson`, property, renamed).
- `device_management_template_id` → `deviceManagementTemplate-id` (Graph `deviceManagementTemplate-id`, url_parameter, renamed).
- `device_management_template_setting_category_id` → `deviceManagementTemplateSettingCategory-id` (Graph `deviceManagementTemplateSettingCategory-id`, url_parameter, renamed).

### `beta/device-management/templates/categories/setting-definitions` → `beta/deviceManagement/templates/categories/settingDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `documentation_url` → `documentationUrl` (Graph `documentationUrl`, property, renamed).
- `header_subtitle` → `headerSubtitle` (Graph `headerSubtitle`, property, renamed).
- `header_title` → `headerTitle` (Graph `headerTitle`, property, renamed).
- `is_top_level` → `isTopLevel` (Graph `isTopLevel`, property, renamed).
- `placeholder_text` → `placeholderText` (Graph `placeholderText`, property, renamed).
- `value_type` → `valueType` (Graph `valueType`, property, renamed).
- `device_management_template_id` → `deviceManagementTemplate-id` (Graph `deviceManagementTemplate-id`, url_parameter, renamed).
- `device_management_template_setting_category_id` → `deviceManagementTemplateSettingCategory-id` (Graph `deviceManagementTemplateSettingCategory-id`, url_parameter, renamed).

### `beta/device-management/templates/migratable-to` → `beta/deviceManagement/templates/migratableTo`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `intent_count` → `intentCount` (Graph `intentCount`, property, renamed).
- `is_deprecated` → `isDeprecated` (Graph `isDeprecated`, property, renamed).
- `migratable_to` → `migratableTo` (Graph `migratableTo`, property, renamed).
- `platform_type` → `platformType` (Graph `platformType`, property, renamed).
- `published_date_time` → `publishedDateTime` (Graph `publishedDateTime`, property, renamed).
- `template_subtype` → `templateSubtype` (Graph `templateSubtype`, property, renamed).
- `template_type` → `templateType` (Graph `templateType`, property, renamed).
- `version_info` → `versionInfo` (Graph `versionInfo`, property, renamed).
- `device_management_template_id` → `deviceManagementTemplate-id` (Graph `deviceManagementTemplate-id`, url_parameter, renamed).

### `beta/device-management/templates/settings` → `beta/deviceManagement/templates/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `definition_id` → `definitionId` (Graph `definitionId`, property, renamed).
- `value_json` → `valueJson` (Graph `valueJson`, property, renamed).
- `device_management_template_id` → `deviceManagementTemplate-id` (Graph `deviceManagementTemplate-id`, url_parameter, renamed).

### `beta/device-management/terms-and-conditions` → `beta/deviceManagement/termsAndConditions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `acceptance_statement` → `acceptanceStatement` (Graph `acceptanceStatement`, property, renamed).
- `acceptance_statuses` → `acceptanceStatuses` (Graph `acceptanceStatuses`, property, renamed).
- `body_text` → `bodyText` (Graph `bodyText`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_assignments` → `groupAssignments` (Graph `groupAssignments`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/device-management/terms-and-conditions/acceptance-statuses` → `beta/deviceManagement/termsAndConditions/acceptanceStatuses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `accepted_date_time` → `acceptedDateTime` (Graph `acceptedDateTime`, property, renamed).
- `accepted_version` → `acceptedVersion` (Graph `acceptedVersion`, property, renamed).
- `terms_and_conditions` → `termsAndConditions` (Graph `termsAndConditions`, property, renamed).
- `user_display_name` → `userDisplayName` (Graph `userDisplayName`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `terms_and_conditions_id` → `termsAndConditions-id` (Graph `termsAndConditions-id`, url_parameter, renamed).

### `beta/device-management/terms-and-conditions/assignments` → `beta/deviceManagement/termsAndConditions/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `terms_and_conditions_id` → `termsAndConditions-id` (Graph `termsAndConditions-id`, url_parameter, renamed).

### `beta/device-management/terms-and-conditions/group-assignments` → `beta/deviceManagement/termsAndConditions/groupAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `target_group_id` → `targetGroupId` (Graph `targetGroupId`, property, renamed).
- `terms_and_conditions` → `termsAndConditions` (Graph `termsAndConditions`, property, renamed).
- `terms_and_conditions_id` → `termsAndConditions-id` (Graph `termsAndConditions-id`, url_parameter, renamed).

### `beta/device-management/troubleshooting-events` → `beta/deviceManagement/troubleshootingEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `correlation_id` → `correlationId` (Graph `correlationId`, property, renamed).
- `event_date_time` → `eventDateTime` (Graph `eventDateTime`, property, renamed).
- `event_name` → `eventName` (Graph `eventName`, property, renamed).
- `troubleshooting_error_details` → `troubleshootingErrorDetails` (Graph `troubleshootingErrorDetails`, property, renamed).

### `beta/device-management/user-pfx-certificates` → `beta/deviceManagement/userPfxCertificates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `encrypted_pfx_blob` → `encryptedPfxBlob` (Graph `encryptedPfxBlob`, property, renamed).
- `encrypted_pfx_password` → `encryptedPfxPassword` (Graph `encryptedPfxPassword`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `intended_purpose` → `intendedPurpose` (Graph `intendedPurpose`, property, renamed).
- `key_name` → `keyName` (Graph `keyName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `padding_scheme` → `paddingScheme` (Graph `paddingScheme`, property, renamed).
- `provider_name` → `providerName` (Graph `providerName`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `beta/device-management/virtual-endpoint/cloud-apps` → `beta/deviceManagement/virtualEndpoint/cloudApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_detail` → `appDetail` (Graph `appDetail`, property, renamed).
- `app_status` → `appStatus` (Graph `appStatus`, property, renamed).
- `available_to_user` → `availableToUser` (Graph `availableToUser`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `provisioning_policy_id` → `provisioningPolicyId` (Graph `provisioningPolicyId`, property, renamed).

### `beta/device-management/virtual-endpoint/cloud-pc-pools` → `beta/deviceManagement/virtualEndpoint/cloudPcPools`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cloud_pc_configuration` → `cloudPcConfiguration` (Graph `cloudPcConfiguration`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `network_configuration` → `networkConfiguration` (Graph `networkConfiguration`, property, renamed).

### `beta/device-management/virtual-endpoint/cloud-pc-pools/assignments` → `beta/deviceManagement/virtualEndpoint/cloudPcPools/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cloud_pc_pool_id` → `cloudPcPool-id` (Graph `cloudPcPool-id`, url_parameter, renamed).

### `beta/device-management/virtual-endpoint/device-images` → `beta/deviceManagement/virtualEndpoint/deviceImages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/device-management/virtual-endpoint/on-premises-connections` → `beta/deviceManagement/virtualEndpoint/onPremisesConnections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `ad_domain_name` → `adDomainName` (Graph `adDomainName`, property, renamed).
- `ad_domain_password` → `adDomainPassword` (Graph `adDomainPassword`, property, renamed).
- `ad_domain_username` → `adDomainUsername` (Graph `adDomainUsername`, property, renamed).
- `alternate_resource_url` → `alternateResourceUrl` (Graph `alternateResourceUrl`, property, renamed).
- `connection_type` → `connectionType` (Graph `connectionType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `health_check_status` → `healthCheckStatus` (Graph `healthCheckStatus`, property, renamed).
- `managed_by` → `managedBy` (Graph `managedBy`, property, renamed).
- `organizational_unit` → `organizationalUnit` (Graph `organizationalUnit`, property, renamed).
- `resource_group_id` → `resourceGroupId` (Graph `resourceGroupId`, property, renamed).
- `scope_ids` → `scopeIds` (Graph `scopeIds`, property, renamed).
- `subnet_id` → `subnetId` (Graph `subnetId`, property, renamed).
- `subscription_id` → `subscriptionId` (Graph `subscriptionId`, property, renamed).
- `virtual_network_id` → `virtualNetworkId` (Graph `virtualNetworkId`, property, renamed).

### `beta/device-management/virtual-endpoint/provisioning-policies` → `beta/deviceManagement/virtualEndpoint/provisioningPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `autopilot_configuration` → `autopilotConfiguration` (Graph `autopilotConfiguration`, property, renamed).
- `cloud_pc_naming_template` → `cloudPcNamingTemplate` (Graph `cloudPcNamingTemplate`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `domain_join_configurations` → `domainJoinConfigurations` (Graph `domainJoinConfigurations`, property, renamed).
- `enable_single_sign_on` → `enableSingleSignOn` (Graph `enableSingleSignOn`, property, renamed).
- `image_display_name` → `imageDisplayName` (Graph `imageDisplayName`, property, renamed).
- `image_id` → `imageId` (Graph `imageId`, property, renamed).
- `image_type` → `imageType` (Graph `imageType`, property, renamed).
- `local_admin_enabled` → `localAdminEnabled` (Graph `localAdminEnabled`, property, renamed).
- `managed_by` → `managedBy` (Graph `managedBy`, property, renamed).
- `microsoft_managed_desktop` → `microsoftManagedDesktop` (Graph `microsoftManagedDesktop`, property, renamed).
- `provisioning_type` → `provisioningType` (Graph `provisioningType`, property, renamed).
- `snapshot_reset_mode` → `snapshotResetMode` (Graph `snapshotResetMode`, property, renamed).
- `user_experience_type` → `userExperienceType` (Graph `userExperienceType`, property, renamed).
- `user_settings_persistence_configuration` → `userSettingsPersistenceConfiguration` (Graph `userSettingsPersistenceConfiguration`, property, renamed).
- `windows_setting` → `windowsSetting` (Graph `windowsSetting`, property, renamed).
- `windows_settings` → `windowsSettings` (Graph `windowsSettings`, property, renamed).

### `beta/device-management/virtual-endpoint/user-settings` → `beta/deviceManagement/virtualEndpoint/userSettings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `cross_region_disaster_recovery_setting` → `crossRegionDisasterRecoverySetting` (Graph `crossRegionDisasterRecoverySetting`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `local_admin_enabled` → `localAdminEnabled` (Graph `localAdminEnabled`, property, renamed).
- `notification_setting` → `notificationSetting` (Graph `notificationSetting`, property, renamed).
- `provisioning_source_type` → `provisioningSourceType` (Graph `provisioningSourceType`, property, renamed).
- `reset_enabled` → `resetEnabled` (Graph `resetEnabled`, property, renamed).
- `restore_point_setting` → `restorePointSetting` (Graph `restorePointSetting`, property, renamed).
- `self_service_enabled` → `selfServiceEnabled` (Graph `selfServiceEnabled`, property, renamed).

### `beta/device-management/windows-autopilot-deployment-profiles` → `beta/deviceManagement/windowsAutopilotDeploymentProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_devices` → `assignedDevices` (Graph `assignedDevices`, property, renamed).
- `device_name_template` → `deviceNameTemplate` (Graph `deviceNameTemplate`, property, renamed).
- `device_type` → `deviceType` (Graph `deviceType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrollment_status_screen_settings` → `enrollmentStatusScreenSettings` (Graph `enrollmentStatusScreenSettings`, property, renamed).
- `hardware_hash_extraction_enabled` → `hardwareHashExtractionEnabled` (Graph `hardwareHashExtractionEnabled`, property, renamed).
- `management_service_app_id` → `managementServiceAppId` (Graph `managementServiceAppId`, property, renamed).
- `out_of_box_experience_setting` → `outOfBoxExperienceSetting` (Graph `outOfBoxExperienceSetting`, property, renamed).
- `preprovisioning_allowed` → `preprovisioningAllowed` (Graph `preprovisioningAllowed`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/windows-autopilot-device-identities` → `beta/deviceManagement/windowsAutopilotDeviceIdentities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `addressable_user_name` → `addressableUserName` (Graph `addressableUserName`, property, renamed).
- `azure_active_directory_device_id` → `azureActiveDirectoryDeviceId` (Graph `azureActiveDirectoryDeviceId`, property, renamed).
- `azure_ad_device_id` → `azureAdDeviceId` (Graph `azureAdDeviceId`, property, renamed).
- `deployment_profile` → `deploymentProfile` (Graph `deploymentProfile`, property, renamed).
- `deployment_profile_assigned_date_time` → `deploymentProfileAssignedDateTime` (Graph `deploymentProfileAssignedDateTime`, property, renamed).
- `deployment_profile_assignment_detailed_status` → `deploymentProfileAssignmentDetailedStatus` (Graph `deploymentProfileAssignmentDetailedStatus`, property, renamed).
- `deployment_profile_assignment_status` → `deploymentProfileAssignmentStatus` (Graph `deploymentProfileAssignmentStatus`, property, renamed).
- `device_account_password` → `deviceAccountPassword` (Graph `deviceAccountPassword`, property, renamed).
- `device_account_upn` → `deviceAccountUpn` (Graph `deviceAccountUpn`, property, renamed).
- `device_friendly_name` → `deviceFriendlyName` (Graph `deviceFriendlyName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enrollment_state` → `enrollmentState` (Graph `enrollmentState`, property, renamed).
- `group_tag` → `groupTag` (Graph `groupTag`, property, renamed).
- `intended_deployment_profile` → `intendedDeploymentProfile` (Graph `intendedDeploymentProfile`, property, renamed).
- `last_contacted_date_time` → `lastContactedDateTime` (Graph `lastContactedDateTime`, property, renamed).
- `managed_device_id` → `managedDeviceId` (Graph `managedDeviceId`, property, renamed).
- `product_key` → `productKey` (Graph `productKey`, property, renamed).
- `purchase_order_identifier` → `purchaseOrderIdentifier` (Graph `purchaseOrderIdentifier`, property, renamed).
- `remediation_state` → `remediationState` (Graph `remediationState`, property, renamed).
- `remediation_state_last_modified_date_time` → `remediationStateLastModifiedDateTime` (Graph `remediationStateLastModifiedDateTime`, property, renamed).
- `resource_name` → `resourceName` (Graph `resourceName`, property, renamed).
- `serial_number` → `serialNumber` (Graph `serialNumber`, property, renamed).
- `sku_number` → `skuNumber` (Graph `skuNumber`, property, renamed).
- `system_family` → `systemFamily` (Graph `systemFamily`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `userless_enrollment_status` → `userlessEnrollmentStatus` (Graph `userlessEnrollmentStatus`, property, renamed).

### `beta/device-management/windows-driver-update-profiles` → `beta/deviceManagement/windowsDriverUpdateProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `approval_type` → `approvalType` (Graph `approvalType`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deployment_deferral_in_days` → `deploymentDeferralInDays` (Graph `deploymentDeferralInDays`, property, renamed).
- `device_reporting` → `deviceReporting` (Graph `deviceReporting`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `driver_inventories` → `driverInventories` (Graph `driverInventories`, property, renamed).
- `inventory_sync_status` → `inventorySyncStatus` (Graph `inventorySyncStatus`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `new_updates` → `newUpdates` (Graph `newUpdates`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/windows-driver-update-profiles/assignments` → `beta/deviceManagement/windowsDriverUpdateProfiles/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `windows_driver_update_profile_id` → `windowsDriverUpdateProfile-id` (Graph `windowsDriverUpdateProfile-id`, url_parameter, renamed).

### `beta/device-management/windows-driver-update-profiles/driver-inventories` → `beta/deviceManagement/windowsDriverUpdateProfiles/driverInventories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applicable_device_count` → `applicableDeviceCount` (Graph `applicableDeviceCount`, property, renamed).
- `approval_status` → `approvalStatus` (Graph `approvalStatus`, property, renamed).
- `deploy_date_time` → `deployDateTime` (Graph `deployDateTime`, property, renamed).
- `driver_class` → `driverClass` (Graph `driverClass`, property, renamed).
- `release_date_time` → `releaseDateTime` (Graph `releaseDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).
- `windows_driver_update_profile_id` → `windowsDriverUpdateProfile-id` (Graph `windowsDriverUpdateProfile-id`, url_parameter, renamed).

### `beta/device-management/windows-feature-update-profiles` → `beta/deviceManagement/windowsFeatureUpdateProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deployable_content_display_name` → `deployableContentDisplayName` (Graph `deployableContentDisplayName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `end_of_support_date` → `endOfSupportDate` (Graph `endOfSupportDate`, property, renamed).
- `feature_update_version` → `featureUpdateVersion` (Graph `featureUpdateVersion`, property, renamed).
- `install_feature_updates_optional` → `installFeatureUpdatesOptional` (Graph `installFeatureUpdatesOptional`, property, renamed).
- `install_latest_windows10_on_windows11_ineligible_device` → `installLatestWindows10OnWindows11IneligibleDevice` (Graph `installLatestWindows10OnWindows11IneligibleDevice`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).
- `rollout_settings` → `rolloutSettings` (Graph `rolloutSettings`, property, renamed).

### `beta/device-management/windows-feature-update-profiles/assignments` → `beta/deviceManagement/windowsFeatureUpdateProfiles/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `windows_feature_update_profile_id` → `windowsFeatureUpdateProfile-id` (Graph `windowsFeatureUpdateProfile-id`, url_parameter, renamed).

### `beta/device-management/windows-information-protection-app-learning-summaries` → `beta/deviceManagement/windowsInformationProtectionAppLearningSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `application_name` → `applicationName` (Graph `applicationName`, property, renamed).
- `application_type` → `applicationType` (Graph `applicationType`, property, renamed).
- `device_count` → `deviceCount` (Graph `deviceCount`, property, renamed).

### `beta/device-management/windows-information-protection-network-learning-summaries` → `beta/deviceManagement/windowsInformationProtectionNetworkLearningSummaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_count` → `deviceCount` (Graph `deviceCount`, property, renamed).

### `beta/device-management/windows-malware-information` → `beta/deviceManagement/windowsMalwareInformation`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information_url` → `additionalInformationUrl` (Graph `additionalInformationUrl`, property, renamed).
- `device_malware_states` → `deviceMalwareStates` (Graph `deviceMalwareStates`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_detection_date_time` → `lastDetectionDateTime` (Graph `lastDetectionDateTime`, property, renamed).

### `beta/device-management/windows-malware-information/device-malware-states` → `beta/deviceManagement/windowsMalwareInformation/deviceMalwareStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `detection_count` → `detectionCount` (Graph `detectionCount`, property, renamed).
- `device_name` → `deviceName` (Graph `deviceName`, property, renamed).
- `execution_state` → `executionState` (Graph `executionState`, property, renamed).
- `initial_detection_date_time` → `initialDetectionDateTime` (Graph `initialDetectionDateTime`, property, renamed).
- `last_state_change_date_time` → `lastStateChangeDateTime` (Graph `lastStateChangeDateTime`, property, renamed).
- `threat_state` → `threatState` (Graph `threatState`, property, renamed).
- `windows_malware_information_id` → `windowsMalwareInformation-id` (Graph `windowsMalwareInformation-id`, url_parameter, renamed).

### `beta/device-management/windows-quality-update-policies` → `beta/deviceManagement/windowsQualityUpdatePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `approval_settings` → `approvalSettings` (Graph `approvalSettings`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hotpatch_enabled` → `hotpatchEnabled` (Graph `hotpatchEnabled`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/windows-quality-update-policies/assignments` → `beta/deviceManagement/windowsQualityUpdatePolicies/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `windows_quality_update_policy_id` → `windowsQualityUpdatePolicy-id` (Graph `windowsQualityUpdatePolicy-id`, url_parameter, renamed).

### `beta/device-management/windows-quality-update-profiles` → `beta/deviceManagement/windowsQualityUpdateProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deployable_content_display_name` → `deployableContentDisplayName` (Graph `deployableContentDisplayName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `expedited_update_settings` → `expeditedUpdateSettings` (Graph `expeditedUpdateSettings`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `release_date_display_name` → `releaseDateDisplayName` (Graph `releaseDateDisplayName`, property, renamed).
- `role_scope_tag_ids` → `roleScopeTagIds` (Graph `roleScopeTagIds`, property, renamed).

### `beta/device-management/windows-quality-update-profiles/assignments` → `beta/deviceManagement/windowsQualityUpdateProfiles/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `windows_quality_update_profile_id` → `windowsQualityUpdateProfile-id` (Graph `windowsQualityUpdateProfile-id`, url_parameter, renamed).

### `beta/device-management/windows-update-catalog-items` → `beta/deviceManagement/windowsUpdateCatalogItems`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `end_of_support_date` → `endOfSupportDate` (Graph `endOfSupportDate`, property, renamed).
- `release_date_time` → `releaseDateTime` (Graph `releaseDateTime`, property, renamed).

### `beta/device-management/zebra-fota-artifacts` → `beta/deviceManagement/zebraFotaArtifacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `board_support_package_version` → `boardSupportPackageVersion` (Graph `boardSupportPackageVersion`, property, renamed).
- `device_model` → `deviceModel` (Graph `deviceModel`, property, renamed).
- `os_version` → `osVersion` (Graph `osVersion`, property, renamed).
- `patch_version` → `patchVersion` (Graph `patchVersion`, property, renamed).
- `release_notes_url` → `releaseNotesUrl` (Graph `releaseNotesUrl`, property, renamed).

### `beta/devices` → `beta/devices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `alternative_names` → `alternativeNames` (Graph `alternativeNames`, property, renamed).
- `alternative_security_ids` → `alternativeSecurityIds` (Graph `alternativeSecurityIds`, property, renamed).
- `cloud_licensing` → `cloudLicensing` (Graph `cloudLicensing`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `device_category` → `deviceCategory` (Graph `deviceCategory`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `device_metadata` → `deviceMetadata` (Graph `deviceMetadata`, property, renamed).
- `device_ownership` → `deviceOwnership` (Graph `deviceOwnership`, property, renamed).
- `device_version` → `deviceVersion` (Graph `deviceVersion`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `domain_name` → `domainName` (Graph `domainName`, property, renamed).
- `enrollment_profile_name` → `enrollmentProfileName` (Graph `enrollmentProfileName`, property, renamed).
- `enrollment_type` → `enrollmentType` (Graph `enrollmentType`, property, renamed).
- `extension_attributes` → `extensionAttributes` (Graph `extensionAttributes`, property, renamed).
- `is_managed` → `isManaged` (Graph `isManaged`, property, renamed).
- `is_rooted` → `isRooted` (Graph `isRooted`, property, renamed).
- `management_type` → `managementType` (Graph `managementType`, property, renamed).
- `operating_system` → `operatingSystem` (Graph `operatingSystem`, property, renamed).
- `operating_system_version` → `operatingSystemVersion` (Graph `operatingSystemVersion`, property, renamed).
- `physical_ids` → `physicalIds` (Graph `physicalIds`, property, renamed).
- `profile_type` → `profileType` (Graph `profileType`, property, renamed).
- `system_labels` → `systemLabels` (Graph `systemLabels`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).
- `usage_rights` → `usageRights` (Graph `usageRights`, property, renamed).

### `beta/devices/extensions` → `beta/devices/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `device-id` (Graph `device-id`, url_parameter, renamed).

### `beta/directory/authentication-method-devices/hardware-oath-devices` → `beta/directory/authenticationMethodDevices/hardwareOathDevices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assign_to` → `assignTo` (Graph `assignTo`, property, renamed).
- `assigned_to` → `assignedTo` (Graph `assignedTo`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hardware_oath_devices` → `hardwareOathDevices` (Graph `hardwareOathDevices`, property, renamed).
- `hash_function` → `hashFunction` (Graph `hashFunction`, property, renamed).
- `secret_key` → `secretKey` (Graph `secretKey`, property, renamed).
- `serial_number` → `serialNumber` (Graph `serialNumber`, property, renamed).
- `time_interval_in_seconds` → `timeIntervalInSeconds` (Graph `timeIntervalInSeconds`, property, renamed).

### `beta/directory/certificate-authorities/certificate-based-application-configurations` → `beta/directory/certificateAuthorities/certificateBasedApplicationConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `trusted_certificate_authorities` → `trustedCertificateAuthorities` (Graph `trustedCertificateAuthorities`, property, renamed).

### `beta/directory/certificate-authorities/certificate-based-application-configurations/trusted-certificate-authorities` → `beta/directory/certificateAuthorities/certificateBasedApplicationConfigurations/trustedCertificateAuthorities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `is_root_authority` → `isRootAuthority` (Graph `isRootAuthority`, property, renamed).
- `issuer_subject_key_identifier` → `issuerSubjectKeyIdentifier` (Graph `issuerSubjectKeyIdentifier`, property, renamed).
- `certificate_based_application_configuration_id` → `certificateBasedApplicationConfiguration-id` (Graph `certificateBasedApplicationConfiguration-id`, url_parameter, renamed).

### `beta/directory/certificate-authorities/mutual-tls-oauth-configurations` → `beta/directory/certificateAuthorities/mutualTlsOauthConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_authorities` → `certificateAuthorities` (Graph `certificateAuthorities`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `tls_client_auth_parameter` → `tlsClientAuthParameter` (Graph `tlsClientAuthParameter`, property, renamed).

### `beta/directory/pending-external-user-profiles` → `beta/directory/pendingExternalUserProfiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_discoverable` → `isDiscoverable` (Graph `isDiscoverable`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `phone_number` → `phoneNumber` (Graph `phoneNumber`, property, renamed).
- `supervisor_id` → `supervisorId` (Graph `supervisorId`, property, renamed).

### `beta/directory/public-key-infrastructure/certificate-based-auth-configurations` → `beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_authorities` → `certificateAuthorities` (Graph `certificateAuthorities`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `status_details` → `statusDetails` (Graph `statusDetails`, property, renamed).

### `beta/directory/public-key-infrastructure/certificate-based-auth-configurations/certificate-authorities` → `beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/certificateAuthorities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certificate_authority_type` → `certificateAuthorityType` (Graph `certificateAuthorityType`, property, renamed).
- `certificate_revocation_list_url` → `certificateRevocationListUrl` (Graph `certificateRevocationListUrl`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `delta_certificate_revocation_list_url` → `deltaCertificateRevocationListUrl` (Graph `deltaCertificateRevocationListUrl`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `is_issuer_hint_enabled` → `isIssuerHintEnabled` (Graph `isIssuerHintEnabled`, property, renamed).
- `issuer_subject_key_identifier` → `issuerSubjectKeyIdentifier` (Graph `issuerSubjectKeyIdentifier`, property, renamed).
- `certificate_based_auth_pki_id` → `certificateBasedAuthPki-id` (Graph `certificateBasedAuthPki-id`, url_parameter, renamed).

### `beta/directory/templates/device-templates` → `beta/directory/templates/deviceTemplates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `device_authority` → `deviceAuthority` (Graph `deviceAuthority`, property, renamed).
- `device_instances` → `deviceInstances` (Graph `deviceInstances`, property, renamed).
- `mutual_tls_oauth_configuration_id` → `mutualTlsOauthConfigurationId` (Graph `mutualTlsOauthConfigurationId`, property, renamed).
- `mutual_tls_oauth_configuration_tenant_id` → `mutualTlsOauthConfigurationTenantId` (Graph `mutualTlsOauthConfigurationTenantId`, property, renamed).
- `operating_system` → `operatingSystem` (Graph `operatingSystem`, property, renamed).

### `beta/directory/tenant-governance/governance-invitations` → `beta/directory/tenantGovernance/governanceInvitations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `governed_tenant_id` → `governedTenantId` (Graph `governedTenantId`, property, renamed).
- `governed_tenant_name` → `governedTenantName` (Graph `governedTenantName`, property, renamed).
- `governing_tenant_id` → `governingTenantId` (Graph `governingTenantId`, property, renamed).
- `governing_tenant_name` → `governingTenantName` (Graph `governingTenantName`, property, renamed).

### `beta/directory/tenant-governance/governance-policy-templates` → `beta/directory/tenantGovernance/governancePolicyTemplates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `delegated_administration_role_assignments` → `delegatedAdministrationRoleAssignments` (Graph `delegatedAdministrationRoleAssignments`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `governed_tenant_can_terminate` → `governedTenantCanTerminate` (Graph `governedTenantCanTerminate`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `multi_tenant_applications_to_provision` → `multiTenantApplicationsToProvision` (Graph `multiTenantApplicationsToProvision`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/domains` → `beta/domains`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_type` → `authenticationType` (Graph `authenticationType`, property, renamed).
- `availability_status` → `availabilityStatus` (Graph `availabilityStatus`, property, renamed).
- `federation_configuration` → `federationConfiguration` (Graph `federationConfiguration`, property, renamed).
- `is_admin_managed` → `isAdminManaged` (Graph `isAdminManaged`, property, renamed).
- `is_default` → `isDefault` (Graph `isDefault`, property, renamed).
- `is_initial` → `isInitial` (Graph `isInitial`, property, renamed).
- `is_root` → `isRoot` (Graph `isRoot`, property, renamed).
- `is_verified` → `isVerified` (Graph `isVerified`, property, renamed).
- `password_notification_window_in_days` → `passwordNotificationWindowInDays` (Graph `passwordNotificationWindowInDays`, property, renamed).
- `password_validity_period_in_days` → `passwordValidityPeriodInDays` (Graph `passwordValidityPeriodInDays`, property, renamed).
- `shared_email_domain_invitations` → `sharedEmailDomainInvitations` (Graph `sharedEmailDomainInvitations`, property, renamed).
- `supported_services` → `supportedServices` (Graph `supportedServices`, property, renamed).

### `beta/domains/federation-configuration` → `beta/domains/federationConfiguration`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `active_sign_in_uri` → `activeSignInUri` (Graph `activeSignInUri`, property, renamed).
- `default_interactive_authentication_method` → `defaultInteractiveAuthenticationMethod` (Graph `defaultInteractiveAuthenticationMethod`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `federated_idp_mfa_behavior` → `federatedIdpMfaBehavior` (Graph `federatedIdpMfaBehavior`, property, renamed).
- `is_signed_authentication_request_required` → `isSignedAuthenticationRequestRequired` (Graph `isSignedAuthenticationRequestRequired`, property, renamed).
- `issuer_uri` → `issuerUri` (Graph `issuerUri`, property, renamed).
- `metadata_exchange_uri` → `metadataExchangeUri` (Graph `metadataExchangeUri`, property, renamed).
- `next_signing_certificate` → `nextSigningCertificate` (Graph `nextSigningCertificate`, property, renamed).
- `open_id_connect_discovery_endpoint` → `openIdConnectDiscoveryEndpoint` (Graph `openIdConnectDiscoveryEndpoint`, property, renamed).
- `passive_sign_in_uri` → `passiveSignInUri` (Graph `passiveSignInUri`, property, renamed).
- `password_change_uri` → `passwordChangeUri` (Graph `passwordChangeUri`, property, renamed).
- `password_reset_uri` → `passwordResetUri` (Graph `passwordResetUri`, property, renamed).
- `preferred_authentication_protocol` → `preferredAuthenticationProtocol` (Graph `preferredAuthenticationProtocol`, property, renamed).
- `prompt_login_behavior` → `promptLoginBehavior` (Graph `promptLoginBehavior`, property, renamed).
- `sign_out_uri` → `signOutUri` (Graph `signOutUri`, property, renamed).
- `signing_certificate` → `signingCertificate` (Graph `signingCertificate`, property, renamed).
- `signing_certificate_update_status` → `signingCertificateUpdateStatus` (Graph `signingCertificateUpdateStatus`, property, renamed).
- `domain_id` → `domain-id` (Graph `domain-id`, url_parameter, renamed).

### `beta/drives/items/permissions` → `beta/drives/items/permissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `drive_id` → `drive-id` (Graph `drive-id`, url_parameter, renamed).
- `drive_item_id` → `driveItem-id` (Graph `driveItem-id`, url_parameter, renamed).

### `beta/education/classes` → `beta/education/classes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_categories` → `assignmentCategories` (Graph `assignmentCategories`, property, renamed).
- `assignment_defaults` → `assignmentDefaults` (Graph `assignmentDefaults`, property, renamed).
- `assignment_settings` → `assignmentSettings` (Graph `assignmentSettings`, property, renamed).
- `class_code` → `classCode` (Graph `classCode`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `external_name` → `externalName` (Graph `externalName`, property, renamed).
- `external_source` → `externalSource` (Graph `externalSource`, property, renamed).
- `external_source_detail` → `externalSourceDetail` (Graph `externalSourceDetail`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).

### `beta/education/classes/assignment-categories` → `beta/education/classes/assignmentCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `beta/education/classes/assignment-settings/grading-schemes` → `beta/education/classes/assignmentSettings/gradingSchemes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hide_points_during_grading` → `hidePointsDuringGrading` (Graph `hidePointsDuringGrading`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `beta/education/classes/assignments` → `beta/education/classes/assignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `add_to_calendar_action` → `addToCalendarAction` (Graph `addToCalendarAction`, property, renamed).
- `added_student_action` → `addedStudentAction` (Graph `addedStudentAction`, property, renamed).
- `allow_late_submissions` → `allowLateSubmissions` (Graph `allowLateSubmissions`, property, renamed).
- `allow_students_to_add_resources_to_submission` → `allowStudentsToAddResourcesToSubmission` (Graph `allowStudentsToAddResourcesToSubmission`, property, renamed).
- `assign_to` → `assignTo` (Graph `assignTo`, property, renamed).
- `class_id` → `classId` (Graph `classId`, property, renamed).
- `close_date_time` → `closeDateTime` (Graph `closeDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `grading_category` → `gradingCategory` (Graph `gradingCategory`, property, renamed).
- `grading_scheme` → `gradingScheme` (Graph `gradingScheme`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `module_url` → `moduleUrl` (Graph `moduleUrl`, property, renamed).
- `notification_channel_url` → `notificationChannelUrl` (Graph `notificationChannelUrl`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `beta/education/classes/assignments/resources` → `beta/education/classes/assignments/resources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `dependent_resources` → `dependentResources` (Graph `dependentResources`, property, renamed).
- `distribute_for_student_work` → `distributeForStudentWork` (Graph `distributeForStudentWork`, property, renamed).
- `education_assignment_id` → `educationAssignment-id` (Graph `educationAssignment-id`, url_parameter, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `beta/education/classes/assignments/submissions/outcomes` → `beta/education/classes/assignments/submissions/outcomes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `education_assignment_id` → `educationAssignment-id` (Graph `educationAssignment-id`, url_parameter, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).
- `education_submission_id` → `educationSubmission-id` (Graph `educationSubmission-id`, url_parameter, renamed).

### `beta/education/classes/assignments/submissions/resources` → `beta/education/classes/assignments/submissions/resources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assignment_resource_url` → `assignmentResourceUrl` (Graph `assignmentResourceUrl`, property, renamed).
- `dependent_resources` → `dependentResources` (Graph `dependentResources`, property, renamed).
- `education_assignment_id` → `educationAssignment-id` (Graph `educationAssignment-id`, url_parameter, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).
- `education_submission_id` → `educationSubmission-id` (Graph `educationSubmission-id`, url_parameter, renamed).

### `beta/education/classes/modules` → `beta/education/classes/modules`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_pinned` → `isPinned` (Graph `isPinned`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).

### `beta/education/classes/modules/resources` → `beta/education/classes/modules/resources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `education_class_id` → `educationClass-id` (Graph `educationClass-id`, url_parameter, renamed).
- `education_module_id` → `educationModule-id` (Graph `educationModule-id`, url_parameter, renamed).

### `beta/education/me/rubrics` → `beta/education/me/rubrics`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/education/schools` → `beta/education/schools`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `administrative_unit` → `administrativeUnit` (Graph `administrativeUnit`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `external_principal_id` → `externalPrincipalId` (Graph `externalPrincipalId`, property, renamed).
- `external_source` → `externalSource` (Graph `externalSource`, property, renamed).
- `external_source_detail` → `externalSourceDetail` (Graph `externalSourceDetail`, property, renamed).
- `highest_grade` → `highestGrade` (Graph `highestGrade`, property, renamed).
- `lowest_grade` → `lowestGrade` (Graph `lowestGrade`, property, renamed).
- `principal_email` → `principalEmail` (Graph `principalEmail`, property, renamed).
- `principal_name` → `principalName` (Graph `principalName`, property, renamed).
- `school_number` → `schoolNumber` (Graph `schoolNumber`, property, renamed).

### `beta/education/users` → `beta/education/users`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `assigned_licenses` → `assignedLicenses` (Graph `assignedLicenses`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_source` → `externalSource` (Graph `externalSource`, property, renamed).
- `external_source_detail` → `externalSourceDetail` (Graph `externalSourceDetail`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).
- `mailing_address` → `mailingAddress` (Graph `mailingAddress`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `on_premises_info` → `onPremisesInfo` (Graph `onPremisesInfo`, property, renamed).
- `password_policies` → `passwordPolicies` (Graph `passwordPolicies`, property, renamed).
- `password_profile` → `passwordProfile` (Graph `passwordProfile`, property, renamed).
- `preferred_language` → `preferredLanguage` (Graph `preferredLanguage`, property, renamed).
- `primary_role` → `primaryRole` (Graph `primaryRole`, property, renamed).
- `refresh_tokens_valid_from_date_time` → `refreshTokensValidFromDateTime` (Graph `refreshTokensValidFromDateTime`, property, renamed).
- `related_contacts` → `relatedContacts` (Graph `relatedContacts`, property, renamed).
- `residence_address` → `residenceAddress` (Graph `residenceAddress`, property, renamed).
- `show_in_address_list` → `showInAddressList` (Graph `showInAddressList`, property, renamed).
- `taught_classes` → `taughtClasses` (Graph `taughtClasses`, property, renamed).
- `usage_location` → `usageLocation` (Graph `usageLocation`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `user_type` → `userType` (Graph `userType`, property, renamed).

### `beta/employee-experience/communities` → `beta/employeeExperience/communities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/employee-experience/learning-providers/learning-course-activities` → `beta/employeeExperience/learningProviders/learningCourseActivities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `completion_percentage` → `completionPercentage` (Graph `completionPercentage`, property, renamed).
- `externalcourse_activity_id` → `externalcourseActivityId` (Graph `externalcourseActivityId`, property, renamed).
- `learner_user_id` → `learnerUserId` (Graph `learnerUserId`, property, renamed).
- `learning_content_id` → `learningContentId` (Graph `learningContentId`, property, renamed).
- `learning_provider_id_2` → `learningProviderId` (Graph `learningProviderId`, property, renamed).
- `learning_provider_id` → `learningProvider-id` (Graph `learningProvider-id`, url_parameter, renamed).

### `beta/external/connections` → `beta/external/connections`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `activity_settings` → `activitySettings` (Graph `activitySettings`, property, renamed).
- `compliance_settings` → `complianceSettings` (Graph `complianceSettings`, property, renamed).
- `connector_id` → `connectorId` (Graph `connectorId`, property, renamed).
- `content_category` → `contentCategory` (Graph `contentCategory`, property, renamed).
- `enabled_content_experiences` → `enabledContentExperiences` (Graph `enabledContentExperiences`, property, renamed).
- `ingested_items_count` → `ingestedItemsCount` (Graph `ingestedItemsCount`, property, renamed).
- `search_settings` → `searchSettings` (Graph `searchSettings`, property, renamed).

### `beta/external/connections/groups` → `beta/external/connections/groups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_connection_id` → `externalConnection-id` (Graph `externalConnection-id`, url_parameter, renamed).

### `beta/external/connections/groups/members` → `beta/external/connections/groups/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `external_connection_id` → `externalConnection-id` (Graph `externalConnection-id`, url_parameter, renamed).
- `external_group_id` → `externalGroup-id` (Graph `externalGroup-id`, url_parameter, renamed).

### `beta/external/industry-data/data-connectors` → `beta/external/industryData/dataConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `source_system` → `sourceSystem` (Graph `sourceSystem`, property, renamed).

### `beta/external/industry-data/inbound-flows` → `beta/external/industryData/inboundFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `data_connector` → `dataConnector` (Graph `dataConnector`, property, renamed).
- `data_domain` → `dataDomain` (Graph `dataDomain`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `effective_date_time` → `effectiveDateTime` (Graph `effectiveDateTime`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).

### `beta/external/industry-data/outbound-provisioning-flow-sets` → `beta/external/industryData/outboundProvisioningFlowSets`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `provisioning_flows` → `provisioningFlows` (Graph `provisioningFlows`, property, renamed).

### `beta/external/industry-data/outbound-provisioning-flow-sets/provisioning-flows` → `beta/external/industryData/outboundProvisioningFlowSets/provisioningFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `outbound_provisioning_flow_set_id` → `outboundProvisioningFlowSet-id` (Graph `outboundProvisioningFlowSet-id`, url_parameter, renamed).

### `beta/external/industry-data/reference-definitions` → `beta/external/industryData/referenceDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_disabled` → `isDisabled` (Graph `isDisabled`, property, renamed).
- `reference_type` → `referenceType` (Graph `referenceType`, property, renamed).
- `sort_index` → `sortIndex` (Graph `sortIndex`, property, renamed).

### `beta/external/industry-data/source-systems` → `beta/external/industryData/sourceSystems`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `user_matching_settings` → `userMatchingSettings` (Graph `userMatchingSettings`, property, renamed).

### `beta/external/industry-data/years` → `beta/external/industryData/years`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `end_date` → `endDate` (Graph `endDate`, property, renamed).
- `start_date` → `startDate` (Graph `startDate`, property, renamed).

### `beta/group-lifecycle-policies` → `beta/groupLifecyclePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `alternate_notification_emails` → `alternateNotificationEmails` (Graph `alternateNotificationEmails`, property, renamed).
- `group_lifetime_in_days` → `groupLifetimeInDays` (Graph `groupLifetimeInDays`, property, renamed).
- `managed_group_types` → `managedGroupTypes` (Graph `managedGroupTypes`, property, renamed).

### `beta/groups` → `beta/groups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `accepted_senders` → `acceptedSenders` (Graph `acceptedSenders`, property, renamed).
- `app_role_assignments` → `appRoleAssignments` (Graph `appRoleAssignments`, property, renamed).
- `assigned_labels` → `assignedLabels` (Graph `assignedLabels`, property, renamed).
- `cloud_licensing` → `cloudLicensing` (Graph `cloudLicensing`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `disable_nesting` → `disableNesting` (Graph `disableNesting`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_types` → `groupTypes` (Graph `groupTypes`, property, renamed).
- `has_members_with_license_errors` → `hasMembersWithLicenseErrors` (Graph `hasMembersWithLicenseErrors`, property, renamed).
- `info_catalogs` → `infoCatalogs` (Graph `infoCatalogs`, property, renamed).
- `is_assignable_to_role` → `isAssignableToRole` (Graph `isAssignableToRole`, property, renamed).
- `mail_enabled` → `mailEnabled` (Graph `mailEnabled`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).
- `membership_rule` → `membershipRule` (Graph `membershipRule`, property, renamed).
- `membership_rule_processing_state` → `membershipRuleProcessingState` (Graph `membershipRuleProcessingState`, property, renamed).
- `on_premises_extension_attributes` → `onPremisesExtensionAttributes` (Graph `onPremisesExtensionAttributes`, property, renamed).
- `on_premises_provisioning_errors` → `onPremisesProvisioningErrors` (Graph `onPremisesProvisioningErrors`, property, renamed).
- `on_premises_sync_behavior` → `onPremisesSyncBehavior` (Graph `onPremisesSyncBehavior`, property, renamed).
- `organization_id` → `organizationId` (Graph `organizationId`, property, renamed).
- `permission_grants` → `permissionGrants` (Graph `permissionGrants`, property, renamed).
- `preferred_data_location` → `preferredDataLocation` (Graph `preferredDataLocation`, property, renamed).
- `preferred_language` → `preferredLanguage` (Graph `preferredLanguage`, property, renamed).
- `rejected_senders` → `rejectedSenders` (Graph `rejectedSenders`, property, renamed).
- `resource_behavior_options` → `resourceBehaviorOptions` (Graph `resourceBehaviorOptions`, property, renamed).
- `resource_provisioning_options` → `resourceProvisioningOptions` (Graph `resourceProvisioningOptions`, property, renamed).
- `security_enabled` → `securityEnabled` (Graph `securityEnabled`, property, renamed).
- `service_provisioning_errors` → `serviceProvisioningErrors` (Graph `serviceProvisioningErrors`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).
- `transitive_members` → `transitiveMembers` (Graph `transitiveMembers`, property, renamed).
- `welcome_message_enabled` → `welcomeMessageEnabled` (Graph `welcomeMessageEnabled`, property, renamed).
- `writeback_configuration` → `writebackConfiguration` (Graph `writebackConfiguration`, property, renamed).

### `beta/groups/app-role-assignments` → `beta/groups/appRoleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/calendar/calendar-permissions` → `beta/groups/calendar/calendarPermissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_roles` → `allowedRoles` (Graph `allowedRoles`, property, renamed).
- `is_inside_organization` → `isInsideOrganization` (Graph `isInsideOrganization`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/calendar/events` → `beta/groups/calendar/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/conversations/threads` → `beta/groups/conversations/threads`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_locked` → `isLocked` (Graph `isLocked`, property, renamed).
- `last_delivered_date_time` → `lastDeliveredDateTime` (Graph `lastDeliveredDateTime`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_senders` → `uniqueSenders` (Graph `uniqueSenders`, property, renamed).
- `conversation_id` → `conversation-id` (Graph `conversation-id`, url_parameter, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/events` → `beta/groups/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/events/extensions` → `beta/groups/events/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `event_id` → `event-id` (Graph `event-id`, url_parameter, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/extensions` → `beta/groups/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/onenote/pages` → `beta/groups/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/settings` → `beta/groups/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/threads` → `beta/groups/threads`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_locked` → `isLocked` (Graph `isLocked`, property, renamed).
- `last_delivered_date_time` → `lastDeliveredDateTime` (Graph `lastDeliveredDateTime`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_senders` → `uniqueSenders` (Graph `uniqueSenders`, property, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).

### `beta/groups/threads/posts/extensions` → `beta/groups/threads/posts/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `conversation_thread_id` → `conversationThread-id` (Graph `conversationThread-id`, url_parameter, renamed).
- `group_id` → `group-id` (Graph `group-id`, url_parameter, renamed).
- `post_id` → `post-id` (Graph `post-id`, url_parameter, renamed).

### `beta/identity-governance/access-reviews/definitions` → `beta/identityGovernance/accessReviews/definitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_notification_recipients` → `additionalNotificationRecipients` (Graph `additionalNotificationRecipients`, property, renamed).
- `backup_reviewers` → `backupReviewers` (Graph `backupReviewers`, property, renamed).
- `description_for_admins` → `descriptionForAdmins` (Graph `descriptionForAdmins`, property, renamed).
- `description_for_reviewers` → `descriptionForReviewers` (Graph `descriptionForReviewers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `fallback_reviewers` → `fallbackReviewers` (Graph `fallbackReviewers`, property, renamed).
- `instance_enumeration_scope` → `instanceEnumerationScope` (Graph `instanceEnumerationScope`, property, renamed).
- `stage_settings` → `stageSettings` (Graph `stageSettings`, property, renamed).

### `beta/identity-governance/catalogs/access-package-resources/upload-sessions` → `beta/identityGovernance/catalogs/accessPackageResources/uploadSessions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `is_upload_done` → `isUploadDone` (Graph `isUploadDone`, property, renamed).
- `reference_id` → `referenceId` (Graph `referenceId`, property, renamed).
- `access_package_catalog_id` → `accessPackageCatalog-id` (Graph `accessPackageCatalog-id`, url_parameter, renamed).
- `access_package_resource_id` → `accessPackageResource-id` (Graph `accessPackageResource-id`, url_parameter, renamed).

### `beta/identity-governance/entitlement-management/access-package-assignment-policies` → `beta/identityGovernance/entitlementManagement/accessPackageAssignmentPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_package_catalog` → `accessPackageCatalog` (Graph `accessPackageCatalog`, property, renamed).
- `access_package_id` → `accessPackageId` (Graph `accessPackageId`, property, renamed).
- `access_package_notification_settings` → `accessPackageNotificationSettings` (Graph `accessPackageNotificationSettings`, property, renamed).
- `access_review_settings` → `accessReviewSettings` (Graph `accessReviewSettings`, property, renamed).
- `can_extend` → `canExtend` (Graph `canExtend`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_extension_handlers` → `customExtensionHandlers` (Graph `customExtensionHandlers`, property, renamed).
- `custom_extension_stage_settings` → `customExtensionStageSettings` (Graph `customExtensionStageSettings`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `duration_in_days` → `durationInDays` (Graph `durationInDays`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `modified_by` → `modifiedBy` (Graph `modifiedBy`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).
- `request_approval_settings` → `requestApprovalSettings` (Graph `requestApprovalSettings`, property, renamed).
- `requestor_settings` → `requestorSettings` (Graph `requestorSettings`, property, renamed).
- `verifiable_credential_settings` → `verifiableCredentialSettings` (Graph `verifiableCredentialSettings`, property, renamed).

### `beta/identity-governance/entitlement-management/access-package-assignment-requests` → `beta/identityGovernance/entitlementManagement/accessPackageAssignmentRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_package_assignment` → `accessPackageAssignment` (Graph `accessPackageAssignment`, property, renamed).
- `custom_extension_callout_instances` → `customExtensionCalloutInstances` (Graph `customExtensionCalloutInstances`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `is_validation_only` → `isValidationOnly` (Graph `isValidationOnly`, property, renamed).

### `beta/identity-governance/entitlement-management/access-package-catalogs` → `beta/identityGovernance/entitlementManagement/accessPackageCatalogs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_package_custom_workflow_extensions` → `accessPackageCustomWorkflowExtensions` (Graph `accessPackageCustomWorkflowExtensions`, property, renamed).
- `access_package_resource_scopes` → `accessPackageResourceScopes` (Graph `accessPackageResourceScopes`, property, renamed).
- `access_package_resources` → `accessPackageResources` (Graph `accessPackageResources`, property, renamed).
- `catalog_status` → `catalogStatus` (Graph `catalogStatus`, property, renamed).
- `catalog_type` → `catalogType` (Graph `catalogType`, property, renamed).
- `custom_access_package_workflow_extensions` → `customAccessPackageWorkflowExtensions` (Graph `customAccessPackageWorkflowExtensions`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_externally_visible` → `isExternallyVisible` (Graph `isExternallyVisible`, property, renamed).
- `privilege_level` → `privilegeLevel` (Graph `privilegeLevel`, property, renamed).
- `unique_name` → `uniqueName` (Graph `uniqueName`, property, renamed).

### `beta/identity-governance/entitlement-management/access-packages` → `beta/identityGovernance/entitlementManagement/accessPackages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_package_catalog` → `accessPackageCatalog` (Graph `accessPackageCatalog`, property, renamed).
- `access_package_resource_role_scopes` → `accessPackageResourceRoleScopes` (Graph `accessPackageResourceRoleScopes`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `incompatible_access_packages` → `incompatibleAccessPackages` (Graph `incompatibleAccessPackages`, property, renamed).
- `incompatible_groups` → `incompatibleGroups` (Graph `incompatibleGroups`, property, renamed).
- `is_hidden` → `isHidden` (Graph `isHidden`, property, renamed).
- `is_role_scopes_visible` → `isRoleScopesVisible` (Graph `isRoleScopesVisible`, property, renamed).
- `unique_name` → `uniqueName` (Graph `uniqueName`, property, renamed).

### `beta/identity-governance/entitlement-management/access-packages/access-package-resource-role-scopes` → `beta/identityGovernance/entitlementManagement/accessPackages/accessPackageResourceRoleScopes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_package_resource_scope` → `accessPackageResourceScope` (Graph `accessPackageResourceScope`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `modified_by` → `modifiedBy` (Graph `modifiedBy`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).
- `access_package_id` → `accessPackage-id` (Graph `accessPackage-id`, url_parameter, renamed).

### `beta/identity-governance/entitlement-management/assignment-requests` → `beta/identityGovernance/entitlementManagement/assignmentRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `access_package_assignment` → `accessPackageAssignment` (Graph `accessPackageAssignment`, property, renamed).
- `custom_extension_callout_instances` → `customExtensionCalloutInstances` (Graph `customExtensionCalloutInstances`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `is_validation_only` → `isValidationOnly` (Graph `isValidationOnly`, property, renamed).

### `beta/identity-governance/entitlement-management/connected-organizations` → `beta/identityGovernance/entitlementManagement/connectedOrganizations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_sponsors` → `externalSponsors` (Graph `externalSponsors`, property, renamed).
- `internal_sponsors` → `internalSponsors` (Graph `internalSponsors`, property, renamed).

### `beta/identity-governance/entitlement-management/external-origin-resource-connectors` → `beta/identityGovernance/entitlementManagement/externalOriginResourceConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `connection_info` → `connectionInfo` (Graph `connectionInfo`, property, renamed).
- `connector_type` → `connectorType` (Graph `connectorType`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `modified_by` → `modifiedBy` (Graph `modifiedBy`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).

### `beta/identity-governance/lifecycle-workflows/custom-task-extensions` → `beta/identityGovernance/lifecycleWorkflows/customTaskExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_configuration` → `authenticationConfiguration` (Graph `authenticationConfiguration`, property, renamed).
- `callback_configuration` → `callbackConfiguration` (Graph `callbackConfiguration`, property, renamed).
- `client_configuration` → `clientConfiguration` (Graph `clientConfiguration`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `endpoint_configuration` → `endpointConfiguration` (Graph `endpointConfiguration`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `reply_mode` → `replyMode` (Graph `replyMode`, property, renamed).

### `beta/identity-governance/lifecycle-workflows/workflows` → `beta/identityGovernance/lifecycleWorkflows/workflows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `administration_scope_targets` → `administrationScopeTargets` (Graph `administrationScopeTargets`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `execution_conditions` → `executionConditions` (Graph `executionConditions`, property, renamed).
- `execution_scope` → `executionScope` (Graph `executionScope`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `is_scheduling_enabled` → `isSchedulingEnabled` (Graph `isSchedulingEnabled`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `next_schedule_run_date_time` → `nextScheduleRunDateTime` (Graph `nextScheduleRunDateTime`, property, renamed).
- `quarantine_details` → `quarantineDetails` (Graph `quarantineDetails`, property, renamed).
- `subject_processing_results` → `subjectProcessingResults` (Graph `subjectProcessingResults`, property, renamed).
- `target_subject_type` → `targetSubjectType` (Graph `targetSubjectType`, property, renamed).
- `task_reports` → `taskReports` (Graph `taskReports`, property, renamed).
- `user_processing_results` → `userProcessingResults` (Graph `userProcessingResults`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/identity-governance/terms-of-use/agreements` → `beta/identityGovernance/termsOfUse/agreements`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_per_device_acceptance_required` → `isPerDeviceAcceptanceRequired` (Graph `isPerDeviceAcceptanceRequired`, property, renamed).
- `is_viewing_before_acceptance_required` → `isViewingBeforeAcceptanceRequired` (Graph `isViewingBeforeAcceptanceRequired`, property, renamed).
- `terms_expiration` → `termsExpiration` (Graph `termsExpiration`, property, renamed).
- `user_reaccept_required_frequency` → `userReacceptRequiredFrequency` (Graph `userReacceptRequiredFrequency`, property, renamed).

### `beta/identity-providers` → `beta/identityProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `client_id` → `clientId` (Graph `clientId`, property, renamed).
- `client_secret` → `clientSecret` (Graph `clientSecret`, property, renamed).

### `beta/identity/api-connectors` → `beta/identity/apiConnectors`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_configuration` → `authenticationConfiguration` (Graph `authenticationConfiguration`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `target_url` → `targetUrl` (Graph `targetUrl`, property, renamed).

### `beta/identity/authentication-event-listeners` → `beta/identity/authenticationEventListeners`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_events_flow_id` → `authenticationEventsFlowId` (Graph `authenticationEventsFlowId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/identity/authentication-events-flows` → `beta/identity/authenticationEventsFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/identity/b2c-user-flows` → `beta/identity/b2cUserFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `api_connector_configuration` → `apiConnectorConfiguration` (Graph `apiConnectorConfiguration`, property, renamed).
- `default_language_tag` → `defaultLanguageTag` (Graph `defaultLanguageTag`, property, renamed).
- `identity_providers` → `identityProviders` (Graph `identityProviders`, property, renamed).
- `is_language_customization_enabled` → `isLanguageCustomizationEnabled` (Graph `isLanguageCustomizationEnabled`, property, renamed).
- `user_attribute_assignments` → `userAttributeAssignments` (Graph `userAttributeAssignments`, property, renamed).
- `user_flow_identity_providers` → `userFlowIdentityProviders` (Graph `userFlowIdentityProviders`, property, renamed).
- `user_flow_type` → `userFlowType` (Graph `userFlowType`, property, renamed).
- `user_flow_type_version` → `userFlowTypeVersion` (Graph `userFlowTypeVersion`, property, renamed).

### `beta/identity/b2c-user-flows/user-attribute-assignments` → `beta/identity/b2cUserFlows/userAttributeAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_optional` → `isOptional` (Graph `isOptional`, property, renamed).
- `requires_verification` → `requiresVerification` (Graph `requiresVerification`, property, renamed).
- `user_attribute` → `userAttribute` (Graph `userAttribute`, property, renamed).
- `user_attribute_values` → `userAttributeValues` (Graph `userAttributeValues`, property, renamed).
- `user_input_type` → `userInputType` (Graph `userInputType`, property, renamed).
- `b2c_identity_user_flow_id` → `b2cIdentityUserFlow-id` (Graph `b2cIdentityUserFlow-id`, url_parameter, renamed).

### `beta/identity/b2x-user-flows` → `beta/identity/b2xUserFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `api_connector_configuration` → `apiConnectorConfiguration` (Graph `apiConnectorConfiguration`, property, renamed).
- `identity_providers` → `identityProviders` (Graph `identityProviders`, property, renamed).
- `user_attribute_assignments` → `userAttributeAssignments` (Graph `userAttributeAssignments`, property, renamed).
- `user_flow_identity_providers` → `userFlowIdentityProviders` (Graph `userFlowIdentityProviders`, property, renamed).
- `user_flow_type` → `userFlowType` (Graph `userFlowType`, property, renamed).
- `user_flow_type_version` → `userFlowTypeVersion` (Graph `userFlowTypeVersion`, property, renamed).

### `beta/identity/b2x-user-flows/user-attribute-assignments` → `beta/identity/b2xUserFlows/userAttributeAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_optional` → `isOptional` (Graph `isOptional`, property, renamed).
- `requires_verification` → `requiresVerification` (Graph `requiresVerification`, property, renamed).
- `user_attribute` → `userAttribute` (Graph `userAttribute`, property, renamed).
- `user_attribute_values` → `userAttributeValues` (Graph `userAttributeValues`, property, renamed).
- `user_input_type` → `userInputType` (Graph `userInputType`, property, renamed).
- `b2x_identity_user_flow_id` → `b2xIdentityUserFlow-id` (Graph `b2xIdentityUserFlow-id`, url_parameter, renamed).

### `beta/identity/conditional-access/authentication-context-class-references` → `beta/identity/conditionalAccess/authenticationContextClassReferences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_available` → `isAvailable` (Graph `isAvailable`, property, renamed).

### `beta/identity/conditional-access/authentication-strength/policies/combination-configurations` → `beta/identity/conditionalAccess/authenticationStrength/policies/combinationConfigurations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to_combinations` → `appliesToCombinations` (Graph `appliesToCombinations`, property, renamed).
- `authentication_strength_policy_id` → `authenticationStrengthPolicy-id` (Graph `authenticationStrengthPolicy-id`, url_parameter, renamed).

### `beta/identity/conditional-access/policies` → `beta/identity/conditionalAccess/policies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `grant_controls` → `grantControls` (Graph `grantControls`, property, renamed).
- `session_controls` → `sessionControls` (Graph `sessionControls`, property, renamed).

### `beta/identity/custom-authentication-extensions` → `beta/identity/customAuthenticationExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `authentication_configuration` → `authenticationConfiguration` (Graph `authenticationConfiguration`, property, renamed).
- `behavior_on_error` → `behaviorOnError` (Graph `behaviorOnError`, property, renamed).
- `client_configuration` → `clientConfiguration` (Graph `clientConfiguration`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `endpoint_configuration` → `endpointConfiguration` (Graph `endpointConfiguration`, property, renamed).

### `beta/identity/identity-providers` → `beta/identity/identityProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/identity/risk-prevention/fraud-protection-providers` → `beta/identity/riskPrevention/fraudProtectionProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/identity/risk-prevention/web-application-firewall-providers` → `beta/identity/riskPrevention/webApplicationFirewallProviders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/identity/user-flow-attributes` → `beta/identity/userFlowAttributes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `data_type` → `dataType` (Graph `dataType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `user_flow_attribute_type` → `userFlowAttributeType` (Graph `userFlowAttributeType`, property, renamed).

### `beta/identity/user-flows` → `beta/identity/userFlows`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_flow_type` → `userFlowType` (Graph `userFlowType`, property, renamed).
- `user_flow_type_version` → `userFlowTypeVersion` (Graph `userFlowTypeVersion`, property, renamed).

### `beta/identity/verified-id/profiles` → `beta/identity/verifiedId/profiles`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `face_check_configuration` → `faceCheckConfiguration` (Graph `faceCheckConfiguration`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `mobile_drivers_license_configuration` → `mobileDriversLicenseConfiguration` (Graph `mobileDriversLicenseConfiguration`, property, renamed).
- `self_service_issuance` → `selfServiceIssuance` (Graph `selfServiceIssuance`, property, renamed).
- `verified_id_profile_configuration` → `verifiedIdProfileConfiguration` (Graph `verifiedIdProfileConfiguration`, property, renamed).
- `verified_id_usage_configurations` → `verifiedIdUsageConfigurations` (Graph `verifiedIdUsageConfigurations`, property, renamed).
- `verifier_did` → `verifierDid` (Graph `verifierDid`, property, renamed).

### `beta/me/calendar-groups` → `beta/me/calendarGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/me/calendar-groups/calendars` → `beta/me/calendarGroups/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_group_id_2` → `calendarGroupId` (Graph `calendarGroupId`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `hex_color` → `hexColor` (Graph `hexColor`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).

### `beta/me/calendar-groups/calendars/events` → `beta/me/calendarGroups/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).

### `beta/me/calendar/events` → `beta/me/calendar/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).

### `beta/me/calendars` → `beta/me/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_group_id` → `calendarGroupId` (Graph `calendarGroupId`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `hex_color` → `hexColor` (Graph `hexColor`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).

### `beta/me/calendars/events` → `beta/me/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).

### `beta/me/contact-folders` → `beta/me/contactFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `well_known_name` → `wellKnownName` (Graph `wellKnownName`, property, renamed).

### `beta/me/contact-folders/contacts` → `beta/me/contactFolders/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `is_favorite` → `isFavorite` (Graph `isFavorite`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `postal_addresses` → `postalAddresses` (Graph `postalAddresses`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `wedding_anniversary` → `weddingAnniversary` (Graph `weddingAnniversary`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).
- `contact_folder_id` → `contactFolder-id` (Graph `contactFolder-id`, url_parameter, renamed).

### `beta/me/contacts` → `beta/me/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `is_favorite` → `isFavorite` (Graph `isFavorite`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `postal_addresses` → `postalAddresses` (Graph `postalAddresses`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `wedding_anniversary` → `weddingAnniversary` (Graph `weddingAnniversary`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).

### `beta/me/distribution-lists` → `beta/me/distributionLists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `person_id` → `personId` (Graph `personId`, property, renamed).

### `beta/me/events` → `beta/me/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).

### `beta/me/inference-classification/overrides` → `beta/me/inferenceClassification/overrides`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `classify_as` → `classifyAs` (Graph `classifyAs`, property, renamed).
- `sender_email_address` → `senderEmailAddress` (Graph `senderEmailAddress`, property, renamed).

### `beta/me/mail-folders` → `beta/me/mailFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `child_folder_count` → `childFolderCount` (Graph `childFolderCount`, property, renamed).
- `child_folders` → `childFolders` (Graph `childFolders`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_hidden` → `isHidden` (Graph `isHidden`, property, renamed).
- `message_rules` → `messageRules` (Graph `messageRules`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `total_item_count` → `totalItemCount` (Graph `totalItemCount`, property, renamed).
- `unread_item_count` → `unreadItemCount` (Graph `unreadItemCount`, property, renamed).
- `user_configurations` → `userConfigurations` (Graph `userConfigurations`, property, renamed).
- `well_known_name` → `wellKnownName` (Graph `wellKnownName`, property, renamed).

### `beta/me/mail-folders/messages` → `beta/me/mailFolders/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `mentions_preview` → `mentionsPreview` (Graph `mentionsPreview`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `unsubscribe_data` → `unsubscribeData` (Graph `unsubscribeData`, property, renamed).
- `unsubscribe_enabled` → `unsubscribeEnabled` (Graph `unsubscribeEnabled`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `mail_folder_id` → `mailFolder-id` (Graph `mailFolder-id`, url_parameter, renamed).

### `beta/me/messages` → `beta/me/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `mentions_preview` → `mentionsPreview` (Graph `mentionsPreview`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `unsubscribe_data` → `unsubscribeData` (Graph `unsubscribeData`, property, renamed).
- `unsubscribe_enabled` → `unsubscribeEnabled` (Graph `unsubscribeEnabled`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).

### `beta/me/onenote/pages` → `beta/me/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).

### `beta/me/online-meetings` → `beta/me/onlineMeetings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_attendee_to_enable_camera` → `allowAttendeeToEnableCamera` (Graph `allowAttendeeToEnableCamera`, property, renamed).
- `allow_attendee_to_enable_mic` → `allowAttendeeToEnableMic` (Graph `allowAttendeeToEnableMic`, property, renamed).
- `allow_breakout_rooms` → `allowBreakoutRooms` (Graph `allowBreakoutRooms`, property, renamed).
- `allow_copying_and_sharing_meeting_content` → `allowCopyingAndSharingMeetingContent` (Graph `allowCopyingAndSharingMeetingContent`, property, renamed).
- `allow_live_share` → `allowLiveShare` (Graph `allowLiveShare`, property, renamed).
- `allow_meeting_chat` → `allowMeetingChat` (Graph `allowMeetingChat`, property, renamed).
- `allow_participants_to_change_name` → `allowParticipantsToChangeName` (Graph `allowParticipantsToChangeName`, property, renamed).
- `allow_power_point_sharing` → `allowPowerPointSharing` (Graph `allowPowerPointSharing`, property, renamed).
- `allow_recording` → `allowRecording` (Graph `allowRecording`, property, renamed).
- `allow_teamwork_reactions` → `allowTeamworkReactions` (Graph `allowTeamworkReactions`, property, renamed).
- `allow_transcription` → `allowTranscription` (Graph `allowTranscription`, property, renamed).
- `allow_whiteboard` → `allowWhiteboard` (Graph `allowWhiteboard`, property, renamed).
- `allowed_lobby_admitters` → `allowedLobbyAdmitters` (Graph `allowedLobbyAdmitters`, property, renamed).
- `allowed_presenters` → `allowedPresenters` (Graph `allowedPresenters`, property, renamed).
- `anonymize_identity_for_roles` → `anonymizeIdentityForRoles` (Graph `anonymizeIdentityForRoles`, property, renamed).
- `broadcast_recording` → `broadcastRecording` (Graph `broadcastRecording`, property, renamed).
- `broadcast_settings` → `broadcastSettings` (Graph `broadcastSettings`, property, renamed).
- `chat_info` → `chatInfo` (Graph `chatInfo`, property, renamed).
- `chat_restrictions` → `chatRestrictions` (Graph `chatRestrictions`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `expiry_date_time` → `expiryDateTime` (Graph `expiryDateTime`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `is_broadcast` → `isBroadcast` (Graph `isBroadcast`, property, renamed).
- `is_end_to_end_encryption_enabled` → `isEndToEndEncryptionEnabled` (Graph `isEndToEndEncryptionEnabled`, property, renamed).
- `is_entry_exit_announced` → `isEntryExitAnnounced` (Graph `isEntryExitAnnounced`, property, renamed).
- `join_meeting_id_settings` → `joinMeetingIdSettings` (Graph `joinMeetingIdSettings`, property, renamed).
- `join_url` → `joinUrl` (Graph `joinUrl`, property, renamed).
- `lobby_bypass_settings` → `lobbyBypassSettings` (Graph `lobbyBypassSettings`, property, renamed).
- `meeting_options_web_url` → `meetingOptionsWebUrl` (Graph `meetingOptionsWebUrl`, property, renamed).
- `meeting_spoken_language_tag` → `meetingSpokenLanguageTag` (Graph `meetingSpokenLanguageTag`, property, renamed).
- `meeting_template_id` → `meetingTemplateId` (Graph `meetingTemplateId`, property, renamed).
- `record_automatically` → `recordAutomatically` (Graph `recordAutomatically`, property, renamed).
- `sensitivity_label_assignment` → `sensitivityLabelAssignment` (Graph `sensitivityLabelAssignment`, property, renamed).
- `share_meeting_chat_history_default` → `shareMeetingChatHistoryDefault` (Graph `shareMeetingChatHistoryDefault`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `watermark_protection` → `watermarkProtection` (Graph `watermarkProtection`, property, renamed).

### `beta/me/online-meetings/registration/registrants` → `beta/me/onlineMeetings/registration/registrants`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `online_meeting_id` → `onlineMeeting-id` (Graph `onlineMeeting-id`, url_parameter, renamed).

### `beta/me/outlook/master-categories` → `beta/me/outlook/masterCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/me/outlook/task-folders` → `beta/me/outlook/taskFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_key` → `changeKey` (Graph `changeKey`, property, renamed).
- `is_default_folder` → `isDefaultFolder` (Graph `isDefaultFolder`, property, renamed).
- `parent_group_key` → `parentGroupKey` (Graph `parentGroupKey`, property, renamed).

### `beta/me/outlook/task-groups` → `beta/me/outlook/taskGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_key` → `changeKey` (Graph `changeKey`, property, renamed).
- `group_key` → `groupKey` (Graph `groupKey`, property, renamed).
- `is_default_group` → `isDefaultGroup` (Graph `isDefaultGroup`, property, renamed).

### `beta/me/outlook/task-groups/task-folders` → `beta/me/outlook/taskGroups/taskFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_key` → `changeKey` (Graph `changeKey`, property, renamed).
- `is_default_folder` → `isDefaultFolder` (Graph `isDefaultFolder`, property, renamed).
- `parent_group_key` → `parentGroupKey` (Graph `parentGroupKey`, property, renamed).
- `outlook_task_group_id` → `outlookTaskGroup-id` (Graph `outlookTaskGroup-id`, url_parameter, renamed).

### `beta/me/outlook/tasks` → `beta/me/outlook/tasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `reminder_date_time` → `reminderDateTime` (Graph `reminderDateTime`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).

### `beta/me/profile/account` → `beta/me/profile/account`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `age_group` → `ageGroup` (Graph `ageGroup`, property, renamed).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `country_code` → `countryCode` (Graph `countryCode`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `origin_tenant_info` → `originTenantInfo` (Graph `originTenantInfo`, property, renamed).
- `preferred_language_tag` → `preferredLanguageTag` (Graph `preferredLanguageTag`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_persona` → `userPersona` (Graph `userPersona`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).

### `beta/me/profile/addresses` → `beta/me/profile/addresses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `geo_coordinates` → `geoCoordinates` (Graph `geoCoordinates`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).

### `beta/me/profile/anniversaries` → `beta/me/profile/anniversaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).

### `beta/me/profile/awards` → `beta/me/profile/awards`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `issued_date` → `issuedDate` (Graph `issuedDate`, property, renamed).
- `issuing_authority` → `issuingAuthority` (Graph `issuingAuthority`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/profile/certifications` → `beta/me/profile/certifications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `certification_id` → `certificationId` (Graph `certificationId`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `end_date` → `endDate` (Graph `endDate`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `issued_date` → `issuedDate` (Graph `issuedDate`, property, renamed).
- `issuing_authority` → `issuingAuthority` (Graph `issuingAuthority`, property, renamed).
- `issuing_company` → `issuingCompany` (Graph `issuingCompany`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `start_date` → `startDate` (Graph `startDate`, property, renamed).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/profile/educational-activities` → `beta/me/profile/educationalActivities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `completion_month_year` → `completionMonthYear` (Graph `completionMonthYear`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `end_month_year` → `endMonthYear` (Graph `endMonthYear`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `start_month_year` → `startMonthYear` (Graph `startMonthYear`, property, renamed).

### `beta/me/profile/emails` → `beta/me/profile/emails`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).

### `beta/me/profile/interests` → `beta/me/profile/interests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `collaboration_tags` → `collaborationTags` (Graph `collaborationTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/profile/languages` → `beta/me/profile/languages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).

### `beta/me/profile/names` → `beta/me/profile/names`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).

### `beta/me/profile/notes` → `beta/me/profile/notes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).

### `beta/me/profile/patents` → `beta/me/profile/patents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_pending` → `isPending` (Graph `isPending`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `issued_date` → `issuedDate` (Graph `issuedDate`, property, renamed).
- `issuing_authority` → `issuingAuthority` (Graph `issuingAuthority`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/profile/phones` → `beta/me/profile/phones`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).

### `beta/me/profile/positions` → `beta/me/profile/positions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `is_current` → `isCurrent` (Graph `isCurrent`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).

### `beta/me/profile/projects` → `beta/me/profile/projects`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `collaboration_tags` → `collaborationTags` (Graph `collaborationTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).

### `beta/me/profile/publications` → `beta/me/profile/publications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `published_date` → `publishedDate` (Graph `publishedDate`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/profile/skills` → `beta/me/profile/skills`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `collaboration_tags` → `collaborationTags` (Graph `collaborationTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/profile/web-accounts` → `beta/me/profile/webAccounts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `status_message` → `statusMessage` (Graph `statusMessage`, property, renamed).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/profile/websites` → `beta/me/profile/websites`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/me/settings/work-hours-and-locations/occurrences` → `beta/me/settings/workHoursAndLocations/occurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `recurrence_id` → `recurrenceId` (Graph `recurrenceId`, property, renamed).
- `time_off_details` → `timeOffDetails` (Graph `timeOffDetails`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).

### `beta/me/settings/work-hours-and-locations/recurrences` → `beta/me/settings/workHoursAndLocations/recurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).

### `beta/me/todo/lists` → `beta/me/todo/lists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_owner` → `isOwner` (Graph `isOwner`, property, renamed).
- `is_shared` → `isShared` (Graph `isShared`, property, renamed).
- `wellknown_list_name` → `wellknownListName` (Graph `wellknownListName`, property, renamed).

### `beta/me/todo/lists/tasks` → `beta/me/todo/lists/tasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `attachment_sessions` → `attachmentSessions` (Graph `attachmentSessions`, property, renamed).
- `body_last_modified_date_time` → `bodyLastModifiedDateTime` (Graph `bodyLastModifiedDateTime`, property, renamed).
- `checklist_items` → `checklistItems` (Graph `checklistItems`, property, renamed).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `linked_resources` → `linkedResources` (Graph `linkedResources`, property, renamed).
- `reminder_date_time` → `reminderDateTime` (Graph `reminderDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).

### `beta/me/todo/lists/tasks/checklist-items` → `beta/me/todo/lists/tasks/checklistItems`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `checked_date_time` → `checkedDateTime` (Graph `checkedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_checked` → `isChecked` (Graph `isChecked`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).

### `beta/me/todo/lists/tasks/linked-resources` → `beta/me/todo/lists/tasks/linkedResources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `application_name` → `applicationName` (Graph `applicationName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).

### `beta/network-access/cloud-firewall-policies` → `beta/networkAccess/cloudFirewallPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `policy_rules` → `policyRules` (Graph `policyRules`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/network-access/cloud-firewall-policies/policy-rules` → `beta/networkAccess/cloudFirewallPolicies/policyRules`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `cloud_firewall_policy_id` → `cloudFirewallPolicy-id` (Graph `cloudFirewallPolicy-id`, url_parameter, renamed).

### `beta/network-access/connectivity/branches` → `beta/networkAccess/connectivity/branches`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bandwidth_capacity` → `bandwidthCapacity` (Graph `bandwidthCapacity`, property, renamed).
- `connectivity_configuration` → `connectivityConfiguration` (Graph `connectivityConfiguration`, property, renamed).
- `connectivity_state` → `connectivityState` (Graph `connectivityState`, property, renamed).
- `device_links` → `deviceLinks` (Graph `deviceLinks`, property, renamed).
- `forwarding_profiles` → `forwardingProfiles` (Graph `forwardingProfiles`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/network-access/connectivity/branches/device-links` → `beta/networkAccess/connectivity/branches/deviceLinks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bandwidth_capacity_in_mbps` → `bandwidthCapacityInMbps` (Graph `bandwidthCapacityInMbps`, property, renamed).
- `bgp_configuration` → `bgpConfiguration` (Graph `bgpConfiguration`, property, renamed).
- `device_vendor` → `deviceVendor` (Graph `deviceVendor`, property, renamed).
- `ip_address` → `ipAddress` (Graph `ipAddress`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `redundancy_configuration` → `redundancyConfiguration` (Graph `redundancyConfiguration`, property, renamed).
- `tunnel_configuration` → `tunnelConfiguration` (Graph `tunnelConfiguration`, property, renamed).
- `branch_site_id` → `branchSite-id` (Graph `branchSite-id`, url_parameter, renamed).

### `beta/network-access/connectivity/remote-networks/device-links` → `beta/networkAccess/connectivity/remoteNetworks/deviceLinks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bandwidth_capacity_in_mbps` → `bandwidthCapacityInMbps` (Graph `bandwidthCapacityInMbps`, property, renamed).
- `bgp_configuration` → `bgpConfiguration` (Graph `bgpConfiguration`, property, renamed).
- `device_vendor` → `deviceVendor` (Graph `deviceVendor`, property, renamed).
- `ip_address` → `ipAddress` (Graph `ipAddress`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `redundancy_configuration` → `redundancyConfiguration` (Graph `redundancyConfiguration`, property, renamed).
- `tunnel_configuration` → `tunnelConfiguration` (Graph `tunnelConfiguration`, property, renamed).
- `remote_network_id` → `remoteNetwork-id` (Graph `remoteNetwork-id`, url_parameter, renamed).

### `beta/network-access/filtering-policies` → `beta/networkAccess/filteringPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `policy_rules` → `policyRules` (Graph `policyRules`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/network-access/filtering-policies/policy-rules` → `beta/networkAccess/filteringPolicies/policyRules`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `filtering_policy_id` → `filteringPolicy-id` (Graph `filteringPolicy-id`, url_parameter, renamed).

### `beta/network-access/threat-intelligence-policies` → `beta/networkAccess/threatIntelligencePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `policy_rules` → `policyRules` (Graph `policyRules`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/network-access/tls-inspection-policies` → `beta/networkAccess/tlsInspectionPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `policy_rules` → `policyRules` (Graph `policyRules`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/network-access/tls-inspection-policies/policy-rules` → `beta/networkAccess/tlsInspectionPolicies/policyRules`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `tls_inspection_policy_id` → `tlsInspectionPolicy-id` (Graph `tlsInspectionPolicy-id`, url_parameter, renamed).

### `beta/network-access/tls/external-certificate-authority-certificates` → `beta/networkAccess/tls/externalCertificateAuthorityCertificates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `common_name` → `commonName` (Graph `commonName`, property, renamed).
- `organization_name` → `organizationName` (Graph `organizationName`, property, renamed).

### `beta/oauth2-permission-grants` → `beta/oauth2PermissionGrants`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `client_id` → `clientId` (Graph `clientId`, property, renamed).
- `consent_type` → `consentType` (Graph `consentType`, property, renamed).
- `expiry_time` → `expiryTime` (Graph `expiryTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `start_time` → `startTime` (Graph `startTime`, property, renamed).

### `beta/organization/branding/localizations` → `beta/organization/branding/localizations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `background_color` → `backgroundColor` (Graph `backgroundColor`, property, renamed).
- `background_image` → `backgroundImage` (Graph `backgroundImage`, property, renamed).
- `banner_logo` → `bannerLogo` (Graph `bannerLogo`, property, renamed).
- `content_customization` → `contentCustomization` (Graph `contentCustomization`, property, renamed).
- `custom_account_reset_credentials_url` → `customAccountResetCredentialsUrl` (Graph `customAccountResetCredentialsUrl`, property, renamed).
- `custom_css` → `customCSS` (Graph `customCSS`, property, renamed).
- `custom_cannot_access_your_account_text` → `customCannotAccessYourAccountText` (Graph `customCannotAccessYourAccountText`, property, renamed).
- `custom_cannot_access_your_account_url` → `customCannotAccessYourAccountUrl` (Graph `customCannotAccessYourAccountUrl`, property, renamed).
- `custom_forgot_my_password_text` → `customForgotMyPasswordText` (Graph `customForgotMyPasswordText`, property, renamed).
- `custom_privacy_and_cookies_text` → `customPrivacyAndCookiesText` (Graph `customPrivacyAndCookiesText`, property, renamed).
- `custom_privacy_and_cookies_url` → `customPrivacyAndCookiesUrl` (Graph `customPrivacyAndCookiesUrl`, property, renamed).
- `custom_reset_it_now_text` → `customResetItNowText` (Graph `customResetItNowText`, property, renamed).
- `custom_terms_of_use_text` → `customTermsOfUseText` (Graph `customTermsOfUseText`, property, renamed).
- `custom_terms_of_use_url` → `customTermsOfUseUrl` (Graph `customTermsOfUseUrl`, property, renamed).
- `header_background_color` → `headerBackgroundColor` (Graph `headerBackgroundColor`, property, renamed).
- `header_logo` → `headerLogo` (Graph `headerLogo`, property, renamed).
- `login_page_layout_configuration` → `loginPageLayoutConfiguration` (Graph `loginPageLayoutConfiguration`, property, renamed).
- `login_page_text_visibility_settings` → `loginPageTextVisibilitySettings` (Graph `loginPageTextVisibilitySettings`, property, renamed).
- `sign_in_page_text` → `signInPageText` (Graph `signInPageText`, property, renamed).
- `square_logo` → `squareLogo` (Graph `squareLogo`, property, renamed).
- `square_logo_dark` → `squareLogoDark` (Graph `squareLogoDark`, property, renamed).
- `username_hint_text` → `usernameHintText` (Graph `usernameHintText`, property, renamed).
- `organization_id` → `organization-id` (Graph `organization-id`, url_parameter, renamed).

### `beta/organization/branding/themes` → `beta/organization/branding/themes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `is_default_theme` → `isDefaultTheme` (Graph `isDefaultTheme`, property, renamed).
- `organization_id` → `organization-id` (Graph `organization-id`, url_parameter, renamed).

### `beta/organization/extensions` → `beta/organization/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `organization_id` → `organization-id` (Graph `organization-id`, url_parameter, renamed).

### `beta/planner/rosters` → `beta/planner/rosters`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_sensitivity_label` → `assignedSensitivityLabel` (Graph `assignedSensitivityLabel`, property, renamed).

### `beta/planner/rosters/members` → `beta/planner/rosters/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `planner_roster_id` → `plannerRoster-id` (Graph `plannerRoster-id`, url_parameter, renamed).

### `beta/planner/tasks/messages` → `beta/planner/tasks/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `edited_date_time` → `editedDateTime` (Graph `editedDateTime`, property, renamed).
- `message_type` → `messageType` (Graph `messageType`, property, renamed).
- `parent_entity_id` → `parentEntityId` (Graph `parentEntityId`, property, renamed).
- `planner_task_id` → `plannerTask-id` (Graph `plannerTask-id`, url_parameter, renamed).

### `beta/policies/activity-based-timeout-policies` → `beta/policies/activityBasedTimeoutPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `beta/policies/app-management-policies` → `beta/policies/appManagementPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).

### `beta/policies/authentication-strength-policies` → `beta/policies/authenticationStrengthPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_combinations` → `allowedCombinations` (Graph `allowedCombinations`, property, renamed).
- `combination_configurations` → `combinationConfigurations` (Graph `combinationConfigurations`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `modified_date_time` → `modifiedDateTime` (Graph `modifiedDateTime`, property, renamed).
- `policy_type` → `policyType` (Graph `policyType`, property, renamed).
- `requirements_satisfied` → `requirementsSatisfied` (Graph `requirementsSatisfied`, property, renamed).

### `beta/policies/b2b-management-policies` → `beta/policies/b2bManagementPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `beta/policies/claims-mapping-policies` → `beta/policies/claimsMappingPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `beta/policies/cross-tenant-access-policy/partners/m365-capabilities` → `beta/policies/crossTenantAccessPolicy/partners/m365Capabilities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `inbound_access` → `inboundAccess` (Graph `inboundAccess`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `cross_tenant_access_policy_configuration_partner_tenant_id` → `crossTenantAccessPolicyConfigurationPartner-tenantId` (Graph `crossTenantAccessPolicyConfigurationPartner-tenantId`, url_parameter, renamed).

### `beta/policies/feature-rollout-policies` → `beta/policies/featureRolloutPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_applied_to_organization` → `isAppliedToOrganization` (Graph `isAppliedToOrganization`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).

### `beta/policies/home-realm-discovery-policies` → `beta/policies/homeRealmDiscoveryPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `beta/policies/on-prem-authentication-policies` → `beta/policies/onPremAuthenticationPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `beta/policies/permission-grant-policies` → `beta/policies/permissionGrantPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `include_all_pre_approved_applications` → `includeAllPreApprovedApplications` (Graph `includeAllPreApprovedApplications`, property, renamed).
- `resource_scope_type` → `resourceScopeType` (Graph `resourceScopeType`, property, renamed).

### `beta/policies/permission-grant-policies/excludes` → `beta/policies/permissionGrantPolicies/excludes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certified_client_applications_only` → `certifiedClientApplicationsOnly` (Graph `certifiedClientApplicationsOnly`, property, renamed).
- `client_application_ids` → `clientApplicationIds` (Graph `clientApplicationIds`, property, renamed).
- `client_application_publisher_ids` → `clientApplicationPublisherIds` (Graph `clientApplicationPublisherIds`, property, renamed).
- `client_application_tenant_ids` → `clientApplicationTenantIds` (Graph `clientApplicationTenantIds`, property, renamed).
- `client_applications_from_verified_publisher_only` → `clientApplicationsFromVerifiedPublisherOnly` (Graph `clientApplicationsFromVerifiedPublisherOnly`, property, renamed).
- `permission_classification` → `permissionClassification` (Graph `permissionClassification`, property, renamed).
- `permission_type` → `permissionType` (Graph `permissionType`, property, renamed).
- `resource_application` → `resourceApplication` (Graph `resourceApplication`, property, renamed).
- `scope_sensitivity_labels` → `scopeSensitivityLabels` (Graph `scopeSensitivityLabels`, property, renamed).
- `permission_grant_policy_id` → `permissionGrantPolicy-id` (Graph `permissionGrantPolicy-id`, url_parameter, renamed).

### `beta/policies/permission-grant-policies/includes` → `beta/policies/permissionGrantPolicies/includes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `certified_client_applications_only` → `certifiedClientApplicationsOnly` (Graph `certifiedClientApplicationsOnly`, property, renamed).
- `client_application_ids` → `clientApplicationIds` (Graph `clientApplicationIds`, property, renamed).
- `client_application_publisher_ids` → `clientApplicationPublisherIds` (Graph `clientApplicationPublisherIds`, property, renamed).
- `client_application_tenant_ids` → `clientApplicationTenantIds` (Graph `clientApplicationTenantIds`, property, renamed).
- `client_applications_from_verified_publisher_only` → `clientApplicationsFromVerifiedPublisherOnly` (Graph `clientApplicationsFromVerifiedPublisherOnly`, property, renamed).
- `permission_classification` → `permissionClassification` (Graph `permissionClassification`, property, renamed).
- `permission_type` → `permissionType` (Graph `permissionType`, property, renamed).
- `resource_application` → `resourceApplication` (Graph `resourceApplication`, property, renamed).
- `scope_sensitivity_labels` → `scopeSensitivityLabels` (Graph `scopeSensitivityLabels`, property, renamed).
- `permission_grant_policy_id` → `permissionGrantPolicy-id` (Graph `permissionGrantPolicy-id`, url_parameter, renamed).

### `beta/policies/permission-grant-pre-approval-policies` → `beta/policies/permissionGrantPreApprovalPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).

### `beta/policies/token-issuance-policies` → `beta/policies/tokenIssuancePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `beta/policies/token-lifetime-policies` → `beta/policies/tokenLifetimePolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `applies_to` → `appliesTo` (Graph `appliesTo`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_organization_default` → `isOrganizationDefault` (Graph `isOrganizationDefault`, property, renamed).

### `beta/print/printers/task-triggers` → `beta/print/printers/taskTriggers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `printer_id` → `printer-id` (Graph `printer-id`, url_parameter, renamed).

### `beta/print/shares` → `beta/print/shares`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_all_users` → `allowAllUsers` (Graph `allowAllUsers`, property, renamed).
- `allowed_groups` → `allowedGroups` (Graph `allowedGroups`, property, renamed).
- `allowed_users` → `allowedUsers` (Graph `allowedUsers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_accepting_jobs` → `isAcceptingJobs` (Graph `isAcceptingJobs`, property, renamed).
- `view_point` → `viewPoint` (Graph `viewPoint`, property, renamed).

### `beta/print/task-definitions` → `beta/print/taskDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/program-controls` → `beta/programControls`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `control_id` → `controlId` (Graph `controlId`, property, renamed).
- `control_type_id` → `controlTypeId` (Graph `controlTypeId`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `program_id` → `programId` (Graph `programId`, property, renamed).

### `beta/programs` → `beta/programs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/role-management/cloud-pc/role-assignments` → `beta/roleManagement/cloudPC/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_ids` → `appScopeIds` (Graph `appScopeIds`, property, renamed).
- `directory_scope_ids` → `directoryScopeIds` (Graph `directoryScopeIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `principal_ids` → `principalIds` (Graph `principalIds`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).
- `role_definition_id` → `roleDefinitionId` (Graph `roleDefinitionId`, property, renamed).

### `beta/role-management/cloud-pc/role-definitions` → `beta/roleManagement/cloudPC/roleDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/role-management/defender/role-assignments` → `beta/roleManagement/defender/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_ids` → `appScopeIds` (Graph `appScopeIds`, property, renamed).
- `directory_scope_ids` → `directoryScopeIds` (Graph `directoryScopeIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `principal_ids` → `principalIds` (Graph `principalIds`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).
- `role_definition_id` → `roleDefinitionId` (Graph `roleDefinitionId`, property, renamed).

### `beta/role-management/defender/role-definitions` → `beta/roleManagement/defender/roleDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/role-management/device-management/role-assignments` → `beta/roleManagement/deviceManagement/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_ids` → `appScopeIds` (Graph `appScopeIds`, property, renamed).
- `directory_scope_ids` → `directoryScopeIds` (Graph `directoryScopeIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `principal_ids` → `principalIds` (Graph `principalIds`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).
- `role_definition_id` → `roleDefinitionId` (Graph `roleDefinitionId`, property, renamed).

### `beta/role-management/device-management/role-definitions` → `beta/roleManagement/deviceManagement/roleDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/role-management/directory/role-assignments` → `beta/roleManagement/directory/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_id` → `appScopeId` (Graph `appScopeId`, property, renamed).
- `directory_scope_id` → `directoryScopeId` (Graph `directoryScopeId`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `principal_organization_id` → `principalOrganizationId` (Graph `principalOrganizationId`, property, renamed).
- `resource_scope` → `resourceScope` (Graph `resourceScope`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).

### `beta/role-management/directory/role-definitions` → `beta/roleManagement/directory/roleDefinitions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `role_permissions` → `rolePermissions` (Graph `rolePermissions`, property, renamed).
- `template_id` → `templateId` (Graph `templateId`, property, renamed).
- `graph_version` → `graph_version` (Graph `version`, property, exception).

### `beta/role-management/entitlement-management/role-assignments` → `beta/roleManagement/entitlementManagement/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_id` → `appScopeId` (Graph `appScopeId`, property, renamed).
- `directory_scope_id` → `directoryScopeId` (Graph `directoryScopeId`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `principal_organization_id` → `principalOrganizationId` (Graph `principalOrganizationId`, property, renamed).
- `resource_scope` → `resourceScope` (Graph `resourceScope`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).

### `beta/role-management/exchange/custom-app-scopes` → `beta/roleManagement/exchange/customAppScopes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `custom_attributes` → `customAttributes` (Graph `customAttributes`, property, renamed).

### `beta/role-management/exchange/role-assignments` → `beta/roleManagement/exchange/roleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_scope_id` → `appScopeId` (Graph `appScopeId`, property, renamed).
- `directory_scope_id` → `directoryScopeId` (Graph `directoryScopeId`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `principal_organization_id` → `principalOrganizationId` (Graph `principalOrganizationId`, property, renamed).
- `resource_scope` → `resourceScope` (Graph `resourceScope`, property, renamed).
- `role_definition` → `roleDefinition` (Graph `roleDefinition`, property, renamed).

### `beta/schema-extensions` → `beta/schemaExtensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `target_types` → `targetTypes` (Graph `targetTypes`, property, renamed).

### `beta/search/acronyms` → `beta/search/acronyms`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `stands_for` → `standsFor` (Graph `standsFor`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/search/bookmarks` → `beta/search/bookmarks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `availability_end_date_time` → `availabilityEndDateTime` (Graph `availabilityEndDateTime`, property, renamed).
- `availability_start_date_time` → `availabilityStartDateTime` (Graph `availabilityStartDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_ids` → `groupIds` (Graph `groupIds`, property, renamed).
- `language_tags` → `languageTags` (Graph `languageTags`, property, renamed).
- `power_app_ids` → `powerAppIds` (Graph `powerAppIds`, property, renamed).
- `targeted_variations` → `targetedVariations` (Graph `targetedVariations`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/search/qnas` → `beta/search/qnas`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `availability_end_date_time` → `availabilityEndDateTime` (Graph `availabilityEndDateTime`, property, renamed).
- `availability_start_date_time` → `availabilityStartDateTime` (Graph `availabilityStartDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `group_ids` → `groupIds` (Graph `groupIds`, property, renamed).
- `language_tags` → `languageTags` (Graph `languageTags`, property, renamed).
- `targeted_variations` → `targetedVariations` (Graph `targetedVariations`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).

### `beta/security/attack-simulation/simulations` → `beta/security/attackSimulation/simulations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `attack_technique` → `attackTechnique` (Graph `attackTechnique`, property, renamed).
- `attack_type` → `attackType` (Graph `attackType`, property, renamed).
- `automation_id` → `automationId` (Graph `automationId`, property, renamed).
- `completion_date_time` → `completionDateTime` (Graph `completionDateTime`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `duration_in_days` → `durationInDays` (Graph `durationInDays`, property, renamed).
- `end_user_notification_setting` → `endUserNotificationSetting` (Graph `endUserNotificationSetting`, property, renamed).
- `excluded_account_target` → `excludedAccountTarget` (Graph `excludedAccountTarget`, property, renamed).
- `included_account_target` → `includedAccountTarget` (Graph `includedAccountTarget`, property, renamed).
- `is_automated` → `isAutomated` (Graph `isAutomated`, property, renamed).
- `landing_page` → `landingPage` (Graph `landingPage`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `launch_date_time` → `launchDateTime` (Graph `launchDateTime`, property, renamed).
- `login_page` → `loginPage` (Graph `loginPage`, property, renamed).
- `o_auth_consent_app_detail` → `oAuthConsentAppDetail` (Graph `oAuthConsentAppDetail`, property, renamed).
- `payload_delivery_platform` → `payloadDeliveryPlatform` (Graph `payloadDeliveryPlatform`, property, renamed).
- `training_setting` → `trainingSetting` (Graph `trainingSetting`, property, renamed).

### `beta/security/case-management/cases` → `beta/security/caseManagement/cases`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_fields` → `customFields` (Graph `customFields`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).

### `beta/security/case-management/cases/activities` → `beta/security/caseManagement/cases/activities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).

### `beta/security/case-management/cases/relations` → `beta/security/caseManagement/cases/relations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `related_resource_id` → `relatedResourceId` (Graph `relatedResourceId`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).

### `beta/security/case-management/cases/tasks` → `beta/security/caseManagement/cases/tasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_to` → `assignedTo` (Graph `assignedTo`, property, renamed).
- `closing_notes` → `closingNotes` (Graph `closingNotes`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `case_id` → `case-id` (Graph `case-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases` → `beta/security/cases/ediscoveryCases`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `case_members` → `caseMembers` (Graph `caseMembers`, property, renamed).
- `closed_by` → `closedBy` (Graph `closedBy`, property, renamed).
- `closed_date_time` → `closedDateTime` (Graph `closedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `legal_holds` → `legalHolds` (Graph `legalHolds`, property, renamed).
- `noncustodial_data_sources` → `noncustodialDataSources` (Graph `noncustodialDataSources`, property, renamed).
- `review_sets` → `reviewSets` (Graph `reviewSets`, property, renamed).

### `beta/security/cases/ediscovery-cases/case-members` → `beta/security/cases/ediscoveryCases/caseMembers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `recipient_type` → `recipientType` (Graph `recipientType`, property, renamed).
- `smtp_address` → `smtpAddress` (Graph `smtpAddress`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/custodians/site-sources` → `beta/security/cases/ediscoveryCases/custodians/siteSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_custodian_id` → `ediscoveryCustodian-id` (Graph `ediscoveryCustodian-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/custodians/unified-group-sources` → `beta/security/cases/ediscoveryCases/custodians/unifiedGroupSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `included_sources` → `includedSources` (Graph `includedSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_custodian_id` → `ediscoveryCustodian-id` (Graph `ediscoveryCustodian-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/custodians/user-sources` → `beta/security/cases/ediscoveryCases/custodians/userSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `included_sources` → `includedSources` (Graph `includedSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_custodian_id` → `ediscoveryCustodian-id` (Graph `ediscoveryCustodian-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/legal-holds` → `beta/security/cases/ediscoveryCases/legalHolds`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `content_query` → `contentQuery` (Graph `contentQuery`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `site_sources` → `siteSources` (Graph `siteSources`, property, renamed).
- `user_sources` → `userSources` (Graph `userSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/legal-holds/site-sources` → `beta/security/cases/ediscoveryCases/legalHolds/siteSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_hold_policy_id` → `ediscoveryHoldPolicy-id` (Graph `ediscoveryHoldPolicy-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/legal-holds/user-sources` → `beta/security/cases/ediscoveryCases/legalHolds/userSources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `hold_status` → `holdStatus` (Graph `holdStatus`, property, renamed).
- `included_sources` → `includedSources` (Graph `includedSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_hold_policy_id` → `ediscoveryHoldPolicy-id` (Graph `ediscoveryHoldPolicy-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/review-sets/queries` → `beta/security/cases/ediscoveryCases/reviewSets/queries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `content_query` → `contentQuery` (Graph `contentQuery`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).
- `ediscovery_review_set_id` → `ediscoveryReviewSet-id` (Graph `ediscoveryReviewSet-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/searches` → `beta/security/cases/ediscoveryCases/searches`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `add_to_review_set_operation` → `addToReviewSetOperation` (Graph `addToReviewSetOperation`, property, renamed).
- `additional_sources` → `additionalSources` (Graph `additionalSources`, property, renamed).
- `content_query` → `contentQuery` (Graph `contentQuery`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custodian_sources` → `custodianSources` (Graph `custodianSources`, property, renamed).
- `data_source_scopes` → `dataSourceScopes` (Graph `dataSourceScopes`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_estimate_statistics_operation` → `lastEstimateStatisticsOperation` (Graph `lastEstimateStatisticsOperation`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `noncustodial_sources` → `noncustodialSources` (Graph `noncustodialSources`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).

### `beta/security/cases/ediscovery-cases/tags` → `beta/security/cases/ediscoveryCases/tags`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `child_selectability` → `childSelectability` (Graph `childSelectability`, property, renamed).
- `child_tags` → `childTags` (Graph `childTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `ediscovery_case_id` → `ediscoveryCase-id` (Graph `ediscoveryCase-id`, url_parameter, renamed).

### `beta/security/labels/authorities` → `beta/security/labels/authorities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/security/labels/categories` → `beta/security/labels/categories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/security/labels/citations` → `beta/security/labels/citations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `citation_jurisdiction` → `citationJurisdiction` (Graph `citationJurisdiction`, property, renamed).
- `citation_url` → `citationUrl` (Graph `citationUrl`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/security/labels/departments` → `beta/security/labels/departments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/security/labels/file-plan-references` → `beta/security/labels/filePlanReferences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/security/labels/retention-labels` → `beta/security/labels/retentionLabels`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `action_after_retention_period` → `actionAfterRetentionPeriod` (Graph `actionAfterRetentionPeriod`, property, renamed).
- `behavior_during_retention_period` → `behaviorDuringRetentionPeriod` (Graph `behaviorDuringRetentionPeriod`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `default_record_behavior` → `defaultRecordBehavior` (Graph `defaultRecordBehavior`, property, renamed).
- `description_for_admins` → `descriptionForAdmins` (Graph `descriptionForAdmins`, property, renamed).
- `description_for_users` → `descriptionForUsers` (Graph `descriptionForUsers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `disposition_review_stages` → `dispositionReviewStages` (Graph `dispositionReviewStages`, property, renamed).
- `is_in_use` → `isInUse` (Graph `isInUse`, property, renamed).
- `label_to_be_applied` → `labelToBeApplied` (Graph `labelToBeApplied`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `retention_duration` → `retentionDuration` (Graph `retentionDuration`, property, renamed).
- `retention_event_type` → `retentionEventType` (Graph `retentionEventType`, property, renamed).
- `retention_trigger` → `retentionTrigger` (Graph `retentionTrigger`, property, renamed).

### `beta/security/rules/detection-rules` → `beta/security/rules/detectionRules`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `detection_action` → `detectionAction` (Graph `detectionAction`, property, renamed).
- `detector_id` → `detectorId` (Graph `detectorId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property, renamed).
- `last_run_details` → `lastRunDetails` (Graph `lastRunDetails`, property, renamed).
- `query_condition` → `queryCondition` (Graph `queryCondition`, property, renamed).

### `beta/security/threat-submission/email-threat-submission-policies` → `beta/security/threatSubmission/emailThreatSubmissionPolicies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `customized_notification_sender_email_address` → `customizedNotificationSenderEmailAddress` (Graph `customizedNotificationSenderEmailAddress`, property, renamed).
- `customized_report_recipient_email_address` → `customizedReportRecipientEmailAddress` (Graph `customizedReportRecipientEmailAddress`, property, renamed).
- `is_always_report_enabled_for_users` → `isAlwaysReportEnabledForUsers` (Graph `isAlwaysReportEnabledForUsers`, property, renamed).
- `is_ask_me_enabled_for_users` → `isAskMeEnabledForUsers` (Graph `isAskMeEnabledForUsers`, property, renamed).
- `is_customized_message_enabled` → `isCustomizedMessageEnabled` (Graph `isCustomizedMessageEnabled`, property, renamed).
- `is_customized_message_enabled_for_phishing` → `isCustomizedMessageEnabledForPhishing` (Graph `isCustomizedMessageEnabledForPhishing`, property, renamed).
- `is_customized_notification_sender_enabled` → `isCustomizedNotificationSenderEnabled` (Graph `isCustomizedNotificationSenderEnabled`, property, renamed).
- `is_never_report_enabled_for_users` → `isNeverReportEnabledForUsers` (Graph `isNeverReportEnabledForUsers`, property, renamed).
- `is_organization_branding_enabled` → `isOrganizationBrandingEnabled` (Graph `isOrganizationBrandingEnabled`, property, renamed).
- `is_report_from_quarantine_enabled` → `isReportFromQuarantineEnabled` (Graph `isReportFromQuarantineEnabled`, property, renamed).
- `is_report_to_customized_email_address_enabled` → `isReportToCustomizedEmailAddressEnabled` (Graph `isReportToCustomizedEmailAddressEnabled`, property, renamed).
- `is_report_to_microsoft_enabled` → `isReportToMicrosoftEnabled` (Graph `isReportToMicrosoftEnabled`, property, renamed).
- `is_review_email_notification_enabled` → `isReviewEmailNotificationEnabled` (Graph `isReviewEmailNotificationEnabled`, property, renamed).

### `beta/security/ti-indicators` → `beta/security/tiIndicators`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `activity_group_names` → `activityGroupNames` (Graph `activityGroupNames`, property, renamed).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `azure_tenant_id` → `azureTenantId` (Graph `azureTenantId`, property, renamed).
- `diamond_model` → `diamondModel` (Graph `diamondModel`, property, renamed).
- `domain_name` → `domainName` (Graph `domainName`, property, renamed).
- `email_encoding` → `emailEncoding` (Graph `emailEncoding`, property, renamed).
- `email_language` → `emailLanguage` (Graph `emailLanguage`, property, renamed).
- `email_recipient` → `emailRecipient` (Graph `emailRecipient`, property, renamed).
- `email_sender_address` → `emailSenderAddress` (Graph `emailSenderAddress`, property, renamed).
- `email_sender_name` → `emailSenderName` (Graph `emailSenderName`, property, renamed).
- `email_source_domain` → `emailSourceDomain` (Graph `emailSourceDomain`, property, renamed).
- `email_source_ip_address` → `emailSourceIpAddress` (Graph `emailSourceIpAddress`, property, renamed).
- `email_subject` → `emailSubject` (Graph `emailSubject`, property, renamed).
- `email_x_mailer` → `emailXMailer` (Graph `emailXMailer`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `file_compile_date_time` → `fileCompileDateTime` (Graph `fileCompileDateTime`, property, renamed).
- `file_created_date_time` → `fileCreatedDateTime` (Graph `fileCreatedDateTime`, property, renamed).
- `file_hash_type` → `fileHashType` (Graph `fileHashType`, property, renamed).
- `file_hash_value` → `fileHashValue` (Graph `fileHashValue`, property, renamed).
- `file_mutex_name` → `fileMutexName` (Graph `fileMutexName`, property, renamed).
- `file_name` → `fileName` (Graph `fileName`, property, renamed).
- `file_packer` → `filePacker` (Graph `filePacker`, property, renamed).
- `file_path` → `filePath` (Graph `filePath`, property, renamed).
- `file_size` → `fileSize` (Graph `fileSize`, property, renamed).
- `file_type` → `fileType` (Graph `fileType`, property, renamed).
- `ingested_date_time` → `ingestedDateTime` (Graph `ingestedDateTime`, property, renamed).
- `is_active` → `isActive` (Graph `isActive`, property, renamed).
- `kill_chain` → `killChain` (Graph `killChain`, property, renamed).
- `known_false_positives` → `knownFalsePositives` (Graph `knownFalsePositives`, property, renamed).
- `last_reported_date_time` → `lastReportedDateTime` (Graph `lastReportedDateTime`, property, renamed).
- `malware_family_names` → `malwareFamilyNames` (Graph `malwareFamilyNames`, property, renamed).
- `network_cidr_block` → `networkCidrBlock` (Graph `networkCidrBlock`, property, renamed).
- `network_destination_asn` → `networkDestinationAsn` (Graph `networkDestinationAsn`, property, renamed).
- `network_destination_cidr_block` → `networkDestinationCidrBlock` (Graph `networkDestinationCidrBlock`, property, renamed).
- `network_destination_i_pv4` → `networkDestinationIPv4` (Graph `networkDestinationIPv4`, property, renamed).
- `network_destination_i_pv6` → `networkDestinationIPv6` (Graph `networkDestinationIPv6`, property, renamed).
- `network_destination_port` → `networkDestinationPort` (Graph `networkDestinationPort`, property, renamed).
- `network_i_pv4` → `networkIPv4` (Graph `networkIPv4`, property, renamed).
- `network_i_pv6` → `networkIPv6` (Graph `networkIPv6`, property, renamed).
- `network_port` → `networkPort` (Graph `networkPort`, property, renamed).
- `network_protocol` → `networkProtocol` (Graph `networkProtocol`, property, renamed).
- `network_source_asn` → `networkSourceAsn` (Graph `networkSourceAsn`, property, renamed).
- `network_source_cidr_block` → `networkSourceCidrBlock` (Graph `networkSourceCidrBlock`, property, renamed).
- `network_source_i_pv4` → `networkSourceIPv4` (Graph `networkSourceIPv4`, property, renamed).
- `network_source_i_pv6` → `networkSourceIPv6` (Graph `networkSourceIPv6`, property, renamed).
- `network_source_port` → `networkSourcePort` (Graph `networkSourcePort`, property, renamed).
- `passive_only` → `passiveOnly` (Graph `passiveOnly`, property, renamed).
- `target_product` → `targetProduct` (Graph `targetProduct`, property, renamed).
- `threat_type` → `threatType` (Graph `threatType`, property, renamed).
- `tlp_level` → `tlpLevel` (Graph `tlpLevel`, property, renamed).
- `user_agent` → `userAgent` (Graph `userAgent`, property, renamed).

### `beta/security/triggers/retention-events` → `beta/security/triggers/retentionEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `event_propagation_results` → `eventPropagationResults` (Graph `eventPropagationResults`, property, renamed).
- `event_queries` → `eventQueries` (Graph `eventQueries`, property, renamed).
- `event_status` → `eventStatus` (Graph `eventStatus`, property, renamed).
- `event_trigger_date_time` → `eventTriggerDateTime` (Graph `eventTriggerDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `last_status_update_date_time` → `lastStatusUpdateDateTime` (Graph `lastStatusUpdateDateTime`, property, renamed).
- `retention_event_type` → `retentionEventType` (Graph `retentionEventType`, property, renamed).

### `beta/security/workbooks` → `beta/security/workbooks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/security/zones` → `beta/security/zones`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).

### `beta/service-principals` → `beta/servicePrincipals`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `add_ins` → `addIns` (Graph `addIns`, property, renamed).
- `alternative_names` → `alternativeNames` (Graph `alternativeNames`, property, renamed).
- `app_description` → `appDescription` (Graph `appDescription`, property, renamed).
- `app_display_name` → `appDisplayName` (Graph `appDisplayName`, property, renamed).
- `app_id` → `appId` (Graph `appId`, property, renamed).
- `app_management_policies` → `appManagementPolicies` (Graph `appManagementPolicies`, property, renamed).
- `app_owner_organization_id` → `appOwnerOrganizationId` (Graph `appOwnerOrganizationId`, property, renamed).
- `app_role_assigned_to` → `appRoleAssignedTo` (Graph `appRoleAssignedTo`, property, renamed).
- `app_role_assignment_required` → `appRoleAssignmentRequired` (Graph `appRoleAssignmentRequired`, property, renamed).
- `app_role_assignments` → `appRoleAssignments` (Graph `appRoleAssignments`, property, renamed).
- `app_roles` → `appRoles` (Graph `appRoles`, property, renamed).
- `claims_mapping_policies` → `claimsMappingPolicies` (Graph `claimsMappingPolicies`, property, renamed).
- `claims_policy` → `claimsPolicy` (Graph `claimsPolicy`, property, renamed).
- `custom_security_attributes` → `customSecurityAttributes` (Graph `customSecurityAttributes`, property, renamed).
- `delegated_permission_classifications` → `delegatedPermissionClassifications` (Graph `delegatedPermissionClassifications`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `disabled_by_microsoft_status` → `disabledByMicrosoftStatus` (Graph `disabledByMicrosoftStatus`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `error_url` → `errorUrl` (Graph `errorUrl`, property, renamed).
- `federated_identity_credentials` → `federatedIdentityCredentials` (Graph `federatedIdentityCredentials`, property, renamed).
- `home_realm_discovery_policies` → `homeRealmDiscoveryPolicies` (Graph `homeRealmDiscoveryPolicies`, property, renamed).
- `is_disabled` → `isDisabled` (Graph `isDisabled`, property, renamed).
- `key_credentials` → `keyCredentials` (Graph `keyCredentials`, property, renamed).
- `license_details` → `licenseDetails` (Graph `licenseDetails`, property, renamed).
- `graph_lifecycle` → `graph_lifecycle` (Graph `lifecycle`, property, exception).
- `login_url` → `loginUrl` (Graph `loginUrl`, property, renamed).
- `logout_url` → `logoutUrl` (Graph `logoutUrl`, property, renamed).
- `notification_email_addresses` → `notificationEmailAddresses` (Graph `notificationEmailAddresses`, property, renamed).
- `password_credentials` → `passwordCredentials` (Graph `passwordCredentials`, property, renamed).
- `permission_grant_pre_approval_policies` → `permissionGrantPreApprovalPolicies` (Graph `permissionGrantPreApprovalPolicies`, property, renamed).
- `preferred_single_sign_on_mode` → `preferredSingleSignOnMode` (Graph `preferredSingleSignOnMode`, property, renamed).
- `preferred_token_signing_key_end_date_time` → `preferredTokenSigningKeyEndDateTime` (Graph `preferredTokenSigningKeyEndDateTime`, property, renamed).
- `preferred_token_signing_key_thumbprint` → `preferredTokenSigningKeyThumbprint` (Graph `preferredTokenSigningKeyThumbprint`, property, renamed).
- `published_permission_scopes` → `publishedPermissionScopes` (Graph `publishedPermissionScopes`, property, renamed).
- `publisher_name` → `publisherName` (Graph `publisherName`, property, renamed).
- `remote_desktop_security_configuration` → `remoteDesktopSecurityConfiguration` (Graph `remoteDesktopSecurityConfiguration`, property, renamed).
- `reply_urls` → `replyUrls` (Graph `replyUrls`, property, renamed).
- `saml_metadata_url` → `samlMetadataUrl` (Graph `samlMetadataUrl`, property, renamed).
- `saml_single_sign_on_settings` → `samlSingleSignOnSettings` (Graph `samlSingleSignOnSettings`, property, renamed).
- `service_principal_names` → `servicePrincipalNames` (Graph `servicePrincipalNames`, property, renamed).
- `service_principal_type` → `servicePrincipalType` (Graph `servicePrincipalType`, property, renamed).
- `token_encryption_key_id` → `tokenEncryptionKeyId` (Graph `tokenEncryptionKeyId`, property, renamed).
- `token_issuance_policies` → `tokenIssuancePolicies` (Graph `tokenIssuancePolicies`, property, renamed).
- `token_lifetime_policies` → `tokenLifetimePolicies` (Graph `tokenLifetimePolicies`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).
- `verified_publisher` → `verifiedPublisher` (Graph `verifiedPublisher`, property, renamed).

### `beta/service-principals/app-role-assigned-to` → `beta/servicePrincipals/appRoleAssignedTo`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `beta/service-principals/app-role-assignments` → `beta/servicePrincipals/appRoleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `beta/service-principals/delegated-permission-classifications` → `beta/servicePrincipals/delegatedPermissionClassifications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `permission_id` → `permissionId` (Graph `permissionId`, property, renamed).
- `permission_name` → `permissionName` (Graph `permissionName`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `beta/service-principals/remote-desktop-security-configuration/approved-client-apps` → `beta/servicePrincipals/remoteDesktopSecurityConfiguration/approvedClientApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `beta/service-principals/synchronization/jobs` → `beta/servicePrincipals/synchronization/jobs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bulk_upload` → `bulkUpload` (Graph `bulkUpload`, property, renamed).
- `synchronization_job_settings` → `synchronizationJobSettings` (Graph `synchronizationJobSettings`, property, renamed).
- `template_id` → `templateId` (Graph `templateId`, property, renamed).
- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, url_parameter, renamed).

### `beta/settings` → `beta/settings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/sites/columns` → `beta/sites/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `source_content_type` → `sourceContentType` (Graph `sourceContentType`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/content-types` → `beta/sites/contentTypes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `associated_hubs_urls` → `associatedHubsUrls` (Graph `associatedHubsUrls`, property, renamed).
- `base_types` → `baseTypes` (Graph `baseTypes`, property, renamed).
- `column_links` → `columnLinks` (Graph `columnLinks`, property, renamed).
- `column_positions` → `columnPositions` (Graph `columnPositions`, property, renamed).
- `document_set` → `documentSet` (Graph `documentSet`, property, renamed).
- `document_template` → `documentTemplate` (Graph `documentTemplate`, property, renamed).
- `inherited_from` → `inheritedFrom` (Graph `inheritedFrom`, property, renamed).
- `is_built_in` → `isBuiltIn` (Graph `isBuiltIn`, property, renamed).
- `parent_id` → `parentId` (Graph `parentId`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/content-types/columns` → `beta/sites/contentTypes/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `source_content_type` → `sourceContentType` (Graph `sourceContentType`, property, renamed).
- `content_type_id` → `contentType-id` (Graph `contentType-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/extensions` → `beta/sites/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/lists/columns` → `beta/sites/lists/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `source_content_type` → `sourceContentType` (Graph `sourceContentType`, property, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/lists/content-types/columns` → `beta/sites/lists/contentTypes/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `source_content_type` → `sourceContentType` (Graph `sourceContentType`, property, renamed).
- `content_type_id` → `contentType-id` (Graph `contentType-id`, url_parameter, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/lists/items` → `beta/sites/lists/items`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `content_type` → `contentType` (Graph `contentType`, property, renamed).
- `created_by_user` → `createdByUser` (Graph `createdByUser`, property, renamed).
- `document_set_versions` → `documentSetVersions` (Graph `documentSetVersions`, property, renamed).
- `drive_item` → `driveItem` (Graph `driveItem`, property, renamed).
- `last_modified_by_user` → `lastModifiedByUser` (Graph `lastModifiedByUser`, property, renamed).
- `parent_reference` → `parentReference` (Graph `parentReference`, property, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/lists/items/document-set-versions` → `beta/sites/lists/items/documentSetVersions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `should_capture_minor_version` → `shouldCaptureMinorVersion` (Graph `shouldCaptureMinorVersion`, property, renamed).
- `list_id` → `list-id` (Graph `list-id`, url_parameter, renamed).
- `list_item_id` → `listItem-id` (Graph `listItem-id`, url_parameter, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/onenote/pages` → `beta/sites/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/pages` → `beta/sites/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by_user` → `createdByUser` (Graph `createdByUser`, property, renamed).
- `last_modified_by_user` → `lastModifiedByUser` (Graph `lastModifiedByUser`, property, renamed).
- `page_layout` → `pageLayout` (Graph `pageLayout`, property, renamed).
- `parent_reference` → `parentReference` (Graph `parentReference`, property, renamed).
- `publishing_state` → `publishingState` (Graph `publishingState`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/sites/permissions` → `beta/sites/permissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `site_id` → `site-id` (Graph `site-id`, url_parameter, renamed).

### `beta/solutions/backup-restore/exchange-restore-sessions/mailbox-restore-artifacts-bulk-addition-requests` → `beta/solutions/backupRestore/exchangeRestoreSessions/mailboxRestoreArtifactsBulkAdditionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `destination_type` → `destinationType` (Graph `destinationType`, property, renamed).
- `directory_object_ids` → `directoryObjectIds` (Graph `directoryObjectIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `protection_time_period` → `protectionTimePeriod` (Graph `protectionTimePeriod`, property, renamed).
- `protection_unit_ids` → `protectionUnitIds` (Graph `protectionUnitIds`, property, renamed).
- `restore_point_preference` → `restorePointPreference` (Graph `restorePointPreference`, property, renamed).
- `exchange_restore_session_id` → `exchangeRestoreSession-id` (Graph `exchangeRestoreSession-id`, url_parameter, renamed).

### `beta/solutions/backup-restore/one-drive-for-business-restore-sessions/drive-restore-artifacts-bulk-addition-requests` → `beta/solutions/backupRestore/oneDriveForBusinessRestoreSessions/driveRestoreArtifactsBulkAdditionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `destination_type` → `destinationType` (Graph `destinationType`, property, renamed).
- `directory_object_ids` → `directoryObjectIds` (Graph `directoryObjectIds`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `protection_time_period` → `protectionTimePeriod` (Graph `protectionTimePeriod`, property, renamed).
- `protection_unit_ids` → `protectionUnitIds` (Graph `protectionUnitIds`, property, renamed).
- `restore_point_preference` → `restorePointPreference` (Graph `restorePointPreference`, property, renamed).
- `one_drive_for_business_restore_session_id` → `oneDriveForBusinessRestoreSession-id` (Graph `oneDriveForBusinessRestoreSession-id`, url_parameter, renamed).

### `beta/solutions/backup-restore/service-apps` → `beta/solutions/backupRestore/serviceApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `effective_date_time` → `effectiveDateTime` (Graph `effectiveDateTime`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `registration_date_time` → `registrationDateTime` (Graph `registrationDateTime`, property, renamed).

### `beta/solutions/backup-restore/share-point-restore-sessions/site-restore-artifacts-bulk-addition-requests` → `beta/solutions/backupRestore/sharePointRestoreSessions/siteRestoreArtifactsBulkAdditionRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `destination_type` → `destinationType` (Graph `destinationType`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `protection_time_period` → `protectionTimePeriod` (Graph `protectionTimePeriod`, property, renamed).
- `protection_unit_ids` → `protectionUnitIds` (Graph `protectionUnitIds`, property, renamed).
- `restore_point_preference` → `restorePointPreference` (Graph `restorePointPreference`, property, renamed).
- `site_ids` → `siteIds` (Graph `siteIds`, property, renamed).
- `site_web_urls` → `siteWebUrls` (Graph `siteWebUrls`, property, renamed).
- `share_point_restore_session_id` → `sharePointRestoreSession-id` (Graph `sharePointRestoreSession-id`, url_parameter, renamed).

### `beta/solutions/booking-businesses` → `beta/solutions/bookingBusinesses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `booking_page_settings` → `bookingPageSettings` (Graph `bookingPageSettings`, property, renamed).
- `business_hours` → `businessHours` (Graph `businessHours`, property, renamed).
- `business_type` → `businessType` (Graph `businessType`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_questions` → `customQuestions` (Graph `customQuestions`, property, renamed).
- `default_currency_iso` → `defaultCurrencyIso` (Graph `defaultCurrencyIso`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `scheduling_policy` → `schedulingPolicy` (Graph `schedulingPolicy`, property, renamed).
- `web_site_url` → `webSiteUrl` (Graph `webSiteUrl`, property, renamed).

### `beta/solutions/booking-businesses/appointments` → `beta/solutions/bookingBusinesses/appointments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `anonymous_join_web_url` → `anonymousJoinWebUrl` (Graph `anonymousJoinWebUrl`, property, renamed).
- `appointment_label` → `appointmentLabel` (Graph `appointmentLabel`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `customer_email_address` → `customerEmailAddress` (Graph `customerEmailAddress`, property, renamed).
- `customer_id` → `customerId` (Graph `customerId`, property, renamed).
- `customer_location` → `customerLocation` (Graph `customerLocation`, property, renamed).
- `customer_name` → `customerName` (Graph `customerName`, property, renamed).
- `customer_notes` → `customerNotes` (Graph `customerNotes`, property, renamed).
- `customer_phone` → `customerPhone` (Graph `customerPhone`, property, renamed).
- `customer_time_zone` → `customerTimeZone` (Graph `customerTimeZone`, property, renamed).
- `invoice_amount` → `invoiceAmount` (Graph `invoiceAmount`, property, renamed).
- `invoice_date` → `invoiceDate` (Graph `invoiceDate`, property, renamed).
- `invoice_id` → `invoiceId` (Graph `invoiceId`, property, renamed).
- `invoice_status` → `invoiceStatus` (Graph `invoiceStatus`, property, renamed).
- `invoice_url` → `invoiceUrl` (Graph `invoiceUrl`, property, renamed).
- `is_customer_allowed_to_manage_booking` → `isCustomerAllowedToManageBooking` (Graph `isCustomerAllowedToManageBooking`, property, renamed).
- `is_location_online` → `isLocationOnline` (Graph `isLocationOnline`, property, renamed).
- `join_web_url` → `joinWebUrl` (Graph `joinWebUrl`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `maximum_attendees_count` → `maximumAttendeesCount` (Graph `maximumAttendeesCount`, property, renamed).
- `online_meeting_url` → `onlineMeetingUrl` (Graph `onlineMeetingUrl`, property, renamed).
- `opt_out_of_customer_email` → `optOutOfCustomerEmail` (Graph `optOutOfCustomerEmail`, property, renamed).
- `post_buffer` → `postBuffer` (Graph `postBuffer`, property, renamed).
- `pre_buffer` → `preBuffer` (Graph `preBuffer`, property, renamed).
- `price_type` → `priceType` (Graph `priceType`, property, renamed).
- `self_service_appointment_id` → `selfServiceAppointmentId` (Graph `selfServiceAppointmentId`, property, renamed).
- `service_id` → `serviceId` (Graph `serviceId`, property, renamed).
- `service_location` → `serviceLocation` (Graph `serviceLocation`, property, renamed).
- `service_name` → `serviceName` (Graph `serviceName`, property, renamed).
- `service_notes` → `serviceNotes` (Graph `serviceNotes`, property, renamed).
- `sms_notifications_enabled` → `smsNotificationsEnabled` (Graph `smsNotificationsEnabled`, property, renamed).
- `staff_member_ids` → `staffMemberIds` (Graph `staffMemberIds`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `beta/solutions/booking-businesses/custom-questions` → `beta/solutions/bookingBusinesses/customQuestions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `answer_input_type` → `answerInputType` (Graph `answerInputType`, property, renamed).
- `answer_options` → `answerOptions` (Graph `answerOptions`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `beta/solutions/booking-businesses/customers` → `beta/solutions/bookingBusinesses/customers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_address` → `emailAddress` (Graph `emailAddress`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `beta/solutions/booking-businesses/services` → `beta/solutions/bookingBusinesses/services`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `custom_questions` → `customQuestions` (Graph `customQuestions`, property, renamed).
- `default_duration` → `defaultDuration` (Graph `defaultDuration`, property, renamed).
- `default_location` → `defaultLocation` (Graph `defaultLocation`, property, renamed).
- `default_price` → `defaultPrice` (Graph `defaultPrice`, property, renamed).
- `default_price_type` → `defaultPriceType` (Graph `defaultPriceType`, property, renamed).
- `default_reminders` → `defaultReminders` (Graph `defaultReminders`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_anonymous_join_enabled` → `isAnonymousJoinEnabled` (Graph `isAnonymousJoinEnabled`, property, renamed).
- `is_customer_allowed_to_manage_booking` → `isCustomerAllowedToManageBooking` (Graph `isCustomerAllowedToManageBooking`, property, renamed).
- `is_hidden_from_customers` → `isHiddenFromCustomers` (Graph `isHiddenFromCustomers`, property, renamed).
- `is_location_online` → `isLocationOnline` (Graph `isLocationOnline`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `maximum_attendees_count` → `maximumAttendeesCount` (Graph `maximumAttendeesCount`, property, renamed).
- `post_buffer` → `postBuffer` (Graph `postBuffer`, property, renamed).
- `pre_buffer` → `preBuffer` (Graph `preBuffer`, property, renamed).
- `scheduling_policy` → `schedulingPolicy` (Graph `schedulingPolicy`, property, renamed).
- `sms_notifications_enabled` → `smsNotificationsEnabled` (Graph `smsNotificationsEnabled`, property, renamed).
- `staff_member_ids` → `staffMemberIds` (Graph `staffMemberIds`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `beta/solutions/booking-businesses/staff-members` → `beta/solutions/bookingBusinesses/staffMembers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `availability_is_affected_by_personal_calendar` → `availabilityIsAffectedByPersonalCalendar` (Graph `availabilityIsAffectedByPersonalCalendar`, property, renamed).
- `color_index` → `colorIndex` (Graph `colorIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_address` → `emailAddress` (Graph `emailAddress`, property, renamed).
- `is_email_notification_enabled` → `isEmailNotificationEnabled` (Graph `isEmailNotificationEnabled`, property, renamed).
- `last_updated_date_time` → `lastUpdatedDateTime` (Graph `lastUpdatedDateTime`, property, renamed).
- `membership_status` → `membershipStatus` (Graph `membershipStatus`, property, renamed).
- `time_zone` → `timeZone` (Graph `timeZone`, property, renamed).
- `use_business_hours` → `useBusinessHours` (Graph `useBusinessHours`, property, renamed).
- `working_hours` → `workingHours` (Graph `workingHours`, property, renamed).
- `booking_business_id` → `bookingBusiness-id` (Graph `bookingBusiness-id`, url_parameter, renamed).

### `beta/solutions/business-scenarios` → `beta/solutions/businessScenarios`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `owner_app_ids` → `ownerAppIds` (Graph `ownerAppIds`, property, renamed).
- `unique_name` → `uniqueName` (Graph `uniqueName`, property, renamed).

### `beta/solutions/migrations/cross-tenant-migration-jobs` → `beta/solutions/migrations/crossTenantMigrationJobs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `complete_after_date_time` → `completeAfterDateTime` (Graph `completeAfterDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `exchange_settings` → `exchangeSettings` (Graph `exchangeSettings`, property, renamed).
- `job_type` → `jobType` (Graph `jobType`, property, renamed).
- `resource_type` → `resourceType` (Graph `resourceType`, property, renamed).
- `source_tenant_id` → `sourceTenantId` (Graph `sourceTenantId`, property, renamed).

### `beta/solutions/virtual-events/townhalls/presenters` → `beta/solutions/virtualEvents/townhalls/presenters`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `presenter_details` → `presenterDetails` (Graph `presenterDetails`, property, renamed).
- `virtual_event_townhall_id` → `virtualEventTownhall-id` (Graph `virtualEventTownhall-id`, url_parameter, renamed).

### `beta/solutions/virtual-events/townhalls/registration-configuration/questions` → `beta/solutions/virtualEvents/townhalls/registrationConfiguration/questions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_required` → `isRequired` (Graph `isRequired`, property, renamed).
- `virtual_event_townhall_id` → `virtualEventTownhall-id` (Graph `virtualEventTownhall-id`, url_parameter, renamed).

### `beta/solutions/virtual-events/webinars/presenters` → `beta/solutions/virtualEvents/webinars/presenters`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `presenter_details` → `presenterDetails` (Graph `presenterDetails`, property, renamed).
- `virtual_event_webinar_id` → `virtualEventWebinar-id` (Graph `virtualEventWebinar-id`, url_parameter, renamed).

### `beta/solutions/virtual-events/webinars/registration-configuration/questions` → `beta/solutions/virtualEvents/webinars/registrationConfiguration/questions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_required` → `isRequired` (Graph `isRequired`, property, renamed).
- `virtual_event_webinar_id` → `virtualEventWebinar-id` (Graph `virtualEventWebinar-id`, url_parameter, renamed).

### `beta/storage/file-storage/container-types` → `beta/storage/fileStorage/containerTypes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `billing_classification` → `billingClassification` (Graph `billingClassification`, property, renamed).
- `billing_status` → `billingStatus` (Graph `billingStatus`, property, renamed).
- `owning_app_id` → `owningAppId` (Graph `owningAppId`, property, renamed).

### `beta/storage/file-storage/container-types/permissions` → `beta/storage/fileStorage/containerTypes/permissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `file_storage_container_type_id` → `fileStorageContainerType-id` (Graph `fileStorageContainerType-id`, url_parameter, renamed).

### `beta/storage/file-storage/containers` → `beta/storage/fileStorage/containers`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `archival_details` → `archivalDetails` (Graph `archivalDetails`, property, renamed).
- `assigned_sensitivity_label` → `assignedSensitivityLabel` (Graph `assignedSensitivityLabel`, property, renamed).
- `custom_properties` → `customProperties` (Graph `customProperties`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_group_id` → `externalGroupId` (Graph `externalGroupId`, property, renamed).
- `information_barrier` → `informationBarrier` (Graph `informationBarrier`, property, renamed).
- `migration_jobs` → `migrationJobs` (Graph `migrationJobs`, property, renamed).
- `share_point_groups` → `sharePointGroups` (Graph `sharePointGroups`, property, renamed).

### `beta/storage/file-storage/containers/columns` → `beta/storage/fileStorage/containers/columns`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `column_group` → `columnGroup` (Graph `columnGroup`, property, renamed).
- `content_approval_status` → `contentApprovalStatus` (Graph `contentApprovalStatus`, property, renamed).
- `date_time` → `dateTime` (Graph `dateTime`, property, renamed).
- `default_value` → `defaultValue` (Graph `defaultValue`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enforce_unique_values` → `enforceUniqueValues` (Graph `enforceUniqueValues`, property, renamed).
- `hyperlink_or_picture` → `hyperlinkOrPicture` (Graph `hyperlinkOrPicture`, property, renamed).
- `is_deletable` → `isDeletable` (Graph `isDeletable`, property, renamed).
- `is_sealed` → `isSealed` (Graph `isSealed`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `person_or_group` → `personOrGroup` (Graph `personOrGroup`, property, renamed).
- `propagate_changes` → `propagateChanges` (Graph `propagateChanges`, property, renamed).
- `read_only` → `readOnly` (Graph `readOnly`, property, renamed).
- `source_column` → `sourceColumn` (Graph `sourceColumn`, property, renamed).
- `source_content_type` → `sourceContentType` (Graph `sourceContentType`, property, renamed).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `beta/storage/file-storage/containers/migration-jobs` → `beta/storage/fileStorage/containers/migrationJobs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `container_info` → `containerInfo` (Graph `containerInfo`, property, renamed).
- `progress_events` → `progressEvents` (Graph `progressEvents`, property, renamed).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `beta/storage/file-storage/containers/permissions` → `beta/storage/fileStorage/containers/permissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `beta/storage/file-storage/containers/share-point-groups` → `beta/storage/fileStorage/containers/sharePointGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).

### `beta/storage/file-storage/containers/share-point-groups/members` → `beta/storage/fileStorage/containers/sharePointGroups/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `file_storage_container_id` → `fileStorageContainer-id` (Graph `fileStorageContainer-id`, url_parameter, renamed).
- `share_point_group_id` → `sharePointGroup-id` (Graph `sharePointGroup-id`, url_parameter, renamed).

### `beta/subscriptions` → `beta/subscriptions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_type` → `changeType` (Graph `changeType`, property, renamed).
- `client_state` → `clientState` (Graph `clientState`, property, renamed).
- `encryption_certificate` → `encryptionCertificate` (Graph `encryptionCertificate`, property, renamed).
- `encryption_certificate_id` → `encryptionCertificateId` (Graph `encryptionCertificateId`, property, renamed).
- `expiration_date_time` → `expirationDateTime` (Graph `expirationDateTime`, property, renamed).
- `include_resource_data` → `includeResourceData` (Graph `includeResourceData`, property, renamed).
- `latest_supported_tls_version` → `latestSupportedTlsVersion` (Graph `latestSupportedTlsVersion`, property, renamed).
- `lifecycle_notification_url` → `lifecycleNotificationUrl` (Graph `lifecycleNotificationUrl`, property, renamed).
- `notification_content_type` → `notificationContentType` (Graph `notificationContentType`, property, renamed).
- `notification_query_options` → `notificationQueryOptions` (Graph `notificationQueryOptions`, property, renamed).
- `notification_url` → `notificationUrl` (Graph `notificationUrl`, property, renamed).
- `notification_url_app_id` → `notificationUrlAppId` (Graph `notificationUrlAppId`, property, renamed).
- `vapid_public_key` → `vapidPublicKey` (Graph `vapidPublicKey`, property, renamed).
- `web_push_encryption_p256dh_public_key` → `webPushEncryptionP256dhPublicKey` (Graph `webPushEncryptionP256dhPublicKey`, property, renamed).
- `web_push_encryption_secret` → `webPushEncryptionSecret` (Graph `webPushEncryptionSecret`, property, renamed).

### `beta/teams/channels` → `beta/teams/channels`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `all_members` → `allMembers` (Graph `allMembers`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `enabled_apps` → `enabledApps` (Graph `enabledApps`, property, renamed).
- `files_folder` → `filesFolder` (Graph `filesFolder`, property, renamed).
- `is_favorite_by_default` → `isFavoriteByDefault` (Graph `isFavoriteByDefault`, property, renamed).
- `joined_users` → `joinedUsers` (Graph `joinedUsers`, property, renamed).
- `layout_type` → `layoutType` (Graph `layoutType`, property, renamed).
- `membership_type` → `membershipType` (Graph `membershipType`, property, renamed).
- `migration_mode` → `migrationMode` (Graph `migrationMode`, property, renamed).
- `moderation_settings` → `moderationSettings` (Graph `moderationSettings`, property, renamed).
- `original_created_date_time` → `originalCreatedDateTime` (Graph `originalCreatedDateTime`, property, renamed).
- `shared_with_teams` → `sharedWithTeams` (Graph `sharedWithTeams`, property, renamed).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `beta/teams/channels/members` → `beta/teams/channels/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `visible_history_start_date_time` → `visibleHistoryStartDateTime` (Graph `visibleHistoryStartDateTime`, property, renamed).
- `channel_id` → `channel-id` (Graph `channel-id`, url_parameter, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `beta/teams/channels/tabs` → `beta/teams/channels/tabs`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `message_id` → `messageId` (Graph `messageId`, property, renamed).
- `sort_order_index` → `sortOrderIndex` (Graph `sortOrderIndex`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_id` → `teamsAppId` (Graph `teamsAppId`, property, renamed).
- `channel_id` → `channel-id` (Graph `channel-id`, url_parameter, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `beta/teams/installed-apps` → `beta/teams/installedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `consented_permission_set` → `consentedPermissionSet` (Graph `consentedPermissionSet`, property, renamed).
- `scope_info` → `scopeInfo` (Graph `scopeInfo`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_definition` → `teamsAppDefinition` (Graph `teamsAppDefinition`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `beta/teams/members` → `beta/teams/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `visible_history_start_date_time` → `visibleHistoryStartDateTime` (Graph `visibleHistoryStartDateTime`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `beta/teams/schedule/time-off-requests` → `beta/teams/schedule/timeOffRequests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assigned_to` → `assignedTo` (Graph `assignedTo`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `manager_action_message` → `managerActionMessage` (Graph `managerActionMessage`, property, renamed).
- `sender_message` → `senderMessage` (Graph `senderMessage`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `time_off_reason_id` → `timeOffReasonId` (Graph `timeOffReasonId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `beta/teams/tags` → `beta/teams/tags`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `member_count` → `memberCount` (Graph `memberCount`, property, renamed).
- `tag_type` → `tagType` (Graph `tagType`, property, renamed).
- `team_id_2` → `teamId` (Graph `teamId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).

### `beta/teams/tags/members` → `beta/teams/tags/members`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).
- `user_id` → `userId` (Graph `userId`, property, renamed).
- `team_id` → `team-id` (Graph `team-id`, url_parameter, renamed).
- `teamwork_tag_id` → `teamworkTag-id` (Graph `teamworkTag-id`, url_parameter, renamed).

### `beta/teamwork/workforce-integrations` → `beta/teamwork/workforceIntegrations`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `api_version` → `apiVersion` (Graph `apiVersion`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `eligibility_filtering_enabled_entities` → `eligibilityFilteringEnabledEntities` (Graph `eligibilityFilteringEnabledEntities`, property, renamed).
- `is_active` → `isActive` (Graph `isActive`, property, renamed).
- `supported_entities` → `supportedEntities` (Graph `supportedEntities`, property, renamed).

### `beta/tenant-relationships/managed-tenants/tenant-tags` → `beta/tenantRelationships/managedTenants/tenantTags`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/tenant-relationships/multi-tenant-organization/tenants` → `beta/tenantRelationships/multiTenantOrganization/tenants`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `tenant_id` → `tenantId` (Graph `tenantId`, property, renamed).

### `beta/term-store/groups` → `beta/termStore/groups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `parent_site_id` → `parentSiteId` (Graph `parentSiteId`, property, renamed).

### `beta/term-store/sets` → `beta/termStore/sets`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `localized_names` → `localizedNames` (Graph `localizedNames`, property, renamed).
- `parent_group` → `parentGroup` (Graph `parentGroup`, property, renamed).

### `beta/trust-framework/policies` → `beta/trustFramework/policies`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).

### `beta/users` → `beta/users`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `about_me` → `aboutMe` (Graph `aboutMe`, property, renamed).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property, renamed).
- `age_group` → `ageGroup` (Graph `ageGroup`, property, renamed).
- `app_consent_requests_for_approval` → `appConsentRequestsForApproval` (Graph `appConsentRequestsForApproval`, property, renamed).
- `app_role_assigned_resources` → `appRoleAssignedResources` (Graph `appRoleAssignedResources`, property, renamed).
- `app_role_assignments` → `appRoleAssignments` (Graph `appRoleAssignments`, property, renamed).
- `assigned_licenses` → `assignedLicenses` (Graph `assignedLicenses`, property, renamed).
- `authorization_info` → `authorizationInfo` (Graph `authorizationInfo`, property, renamed).
- `business_phones` → `businessPhones` (Graph `businessPhones`, property, renamed).
- `cloud_clipboard` → `cloudClipboard` (Graph `cloudClipboard`, property, renamed).
- `cloud_licensing` → `cloudLicensing` (Graph `cloudLicensing`, property, renamed).
- `cloud_realtime_communication_info` → `cloudRealtimeCommunicationInfo` (Graph `cloudRealtimeCommunicationInfo`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `consent_provided_for_minor` → `consentProvidedForMinor` (Graph `consentProvidedForMinor`, property, renamed).
- `custom_security_attributes` → `customSecurityAttributes` (Graph `customSecurityAttributes`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `device_enrollment_configurations` → `deviceEnrollmentConfigurations` (Graph `deviceEnrollmentConfigurations`, property, renamed).
- `device_enrollment_limit` → `deviceEnrollmentLimit` (Graph `deviceEnrollmentLimit`, property, renamed).
- `device_keys` → `deviceKeys` (Graph `deviceKeys`, property, renamed).
- `device_management_troubleshooting_events` → `deviceManagementTroubleshootingEvents` (Graph `deviceManagementTroubleshootingEvents`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `employee_hire_date` → `employeeHireDate` (Graph `employeeHireDate`, property, renamed).
- `employee_id` → `employeeId` (Graph `employeeId`, property, renamed).
- `employee_leave_date_time` → `employeeLeaveDateTime` (Graph `employeeLeaveDateTime`, property, renamed).
- `employee_org_data` → `employeeOrgData` (Graph `employeeOrgData`, property, renamed).
- `employee_type` → `employeeType` (Graph `employeeType`, property, renamed).
- `external_user_state` → `externalUserState` (Graph `externalUserState`, property, renamed).
- `external_user_state_change_date_time` → `externalUserStateChangeDateTime` (Graph `externalUserStateChangeDateTime`, property, renamed).
- `fax_number` → `faxNumber` (Graph `faxNumber`, property, renamed).
- `followed_sites` → `followedSites` (Graph `followedSites`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `hire_date` → `hireDate` (Graph `hireDate`, property, renamed).
- `identity_governance` → `identityGovernance` (Graph `identityGovernance`, property, renamed).
- `identity_parent_id` → `identityParentId` (Graph `identityParentId`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `info_catalogs` → `infoCatalogs` (Graph `infoCatalogs`, property, renamed).
- `information_protection` → `informationProtection` (Graph `informationProtection`, property, renamed).
- `invited_by` → `invitedBy` (Graph `invitedBy`, property, renamed).
- `is_resource_account` → `isResourceAccount` (Graph `isResourceAccount`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `joined_groups` → `joinedGroups` (Graph `joinedGroups`, property, renamed).
- `license_details` → `licenseDetails` (Graph `licenseDetails`, property, renamed).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property, renamed).
- `mailbox_settings` → `mailboxSettings` (Graph `mailboxSettings`, property, renamed).
- `managed_app_log_collection_requests` → `managedAppLogCollectionRequests` (Graph `managedAppLogCollectionRequests`, property, renamed).
- `managed_app_registrations` → `managedAppRegistrations` (Graph `managedAppRegistrations`, property, renamed).
- `managed_devices` → `managedDevices` (Graph `managedDevices`, property, renamed).
- `mobile_app_intent_and_states` → `mobileAppIntentAndStates` (Graph `mobileAppIntentAndStates`, property, renamed).
- `mobile_app_troubleshooting_events` → `mobileAppTroubleshootingEvents` (Graph `mobileAppTroubleshootingEvents`, property, renamed).
- `mobile_phone` → `mobilePhone` (Graph `mobilePhone`, property, renamed).
- `my_site` → `mySite` (Graph `mySite`, property, renamed).
- `oauth2_permission_grants` → `oauth2PermissionGrants` (Graph `oauth2PermissionGrants`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `on_premises_distinguished_name` → `onPremisesDistinguishedName` (Graph `onPremisesDistinguishedName`, property, renamed).
- `on_premises_domain_name` → `onPremisesDomainName` (Graph `onPremisesDomainName`, property, renamed).
- `on_premises_extension_attributes` → `onPremisesExtensionAttributes` (Graph `onPremisesExtensionAttributes`, property, renamed).
- `on_premises_immutable_id` → `onPremisesImmutableId` (Graph `onPremisesImmutableId`, property, renamed).
- `on_premises_provisioning_errors` → `onPremisesProvisioningErrors` (Graph `onPremisesProvisioningErrors`, property, renamed).
- `on_premises_sam_account_name` → `onPremisesSamAccountName` (Graph `onPremisesSamAccountName`, property, renamed).
- `on_premises_security_identifier` → `onPremisesSecurityIdentifier` (Graph `onPremisesSecurityIdentifier`, property, renamed).
- `on_premises_sync_behavior` → `onPremisesSyncBehavior` (Graph `onPremisesSyncBehavior`, property, renamed).
- `on_premises_user_principal_name` → `onPremisesUserPrincipalName` (Graph `onPremisesUserPrincipalName`, property, renamed).
- `online_meetings` → `onlineMeetings` (Graph `onlineMeetings`, property, renamed).
- `other_mails` → `otherMails` (Graph `otherMails`, property, renamed).
- `password_policies` → `passwordPolicies` (Graph `passwordPolicies`, property, renamed).
- `password_profile` → `passwordProfile` (Graph `passwordProfile`, property, renamed).
- `past_projects` → `pastProjects` (Graph `pastProjects`, property, renamed).
- `pending_access_review_instances` → `pendingAccessReviewInstances` (Graph `pendingAccessReviewInstances`, property, renamed).
- `permission_grants` → `permissionGrants` (Graph `permissionGrants`, property, renamed).
- `postal_code` → `postalCode` (Graph `postalCode`, property, renamed).
- `preferred_data_location` → `preferredDataLocation` (Graph `preferredDataLocation`, property, renamed).
- `preferred_language` → `preferredLanguage` (Graph `preferredLanguage`, property, renamed).
- `preferred_name` → `preferredName` (Graph `preferredName`, property, renamed).
- `service_provisioning_errors` → `serviceProvisioningErrors` (Graph `serviceProvisioningErrors`, property, renamed).
- `show_in_address_list` → `showInAddressList` (Graph `showInAddressList`, property, renamed).
- `street_address` → `streetAddress` (Graph `streetAddress`, property, renamed).
- `transitive_member_of` → `transitiveMemberOf` (Graph `transitiveMemberOf`, property, renamed).
- `usage_location` → `usageLocation` (Graph `usageLocation`, property, renamed).
- `usage_rights` → `usageRights` (Graph `usageRights`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `user_type` → `userType` (Graph `userType`, property, renamed).
- `virtual_events` → `virtualEvents` (Graph `virtualEvents`, property, renamed).
- `windows_information_protection_device_registrations` → `windowsInformationProtectionDeviceRegistrations` (Graph `windowsInformationProtectionDeviceRegistrations`, property, renamed).

### `beta/users/app-role-assignments` → `beta/users/appRoleAssignments`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `app_role_id` → `appRoleId` (Graph `appRoleId`, property, renamed).
- `deleted_date_time` → `deletedDateTime` (Graph `deletedDateTime`, property, renamed).
- `principal_id` → `principalId` (Graph `principalId`, property, renamed).
- `resource_display_name` → `resourceDisplayName` (Graph `resourceDisplayName`, property, renamed).
- `resource_id` → `resourceId` (Graph `resourceId`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/authentication/email-methods` → `beta/users/authentication/emailMethods`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `email_address` → `emailAddress` (Graph `emailAddress`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/authentication/phone-methods` → `beta/users/authentication/phoneMethods`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `phone_number` → `phoneNumber` (Graph `phoneNumber`, property, renamed).
- `phone_type` → `phoneType` (Graph `phoneType`, property, renamed).
- `sms_sign_in_state` → `smsSignInState` (Graph `smsSignInState`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/calendar-groups` → `beta/users/calendarGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/calendar-groups/calendars` → `beta/users/calendarGroups/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_group_id_2` → `calendarGroupId` (Graph `calendarGroupId`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `hex_color` → `hexColor` (Graph `hexColor`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/calendar-groups/calendars/events` → `beta/users/calendarGroups/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).
- `calendar_group_id` → `calendarGroup-id` (Graph `calendarGroup-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/calendar/calendar-permissions` → `beta/users/calendar/calendarPermissions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_roles` → `allowedRoles` (Graph `allowedRoles`, property, renamed).
- `is_inside_organization` → `isInsideOrganization` (Graph `isInsideOrganization`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/calendar/events` → `beta/users/calendar/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/calendars` → `beta/users/calendars`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_online_meeting_providers` → `allowedOnlineMeetingProviders` (Graph `allowedOnlineMeetingProviders`, property, renamed).
- `calendar_group_id` → `calendarGroupId` (Graph `calendarGroupId`, property, renamed).
- `calendar_permissions` → `calendarPermissions` (Graph `calendarPermissions`, property, renamed).
- `default_online_meeting_provider` → `defaultOnlineMeetingProvider` (Graph `defaultOnlineMeetingProvider`, property, renamed).
- `hex_color` → `hexColor` (Graph `hexColor`, property, renamed).
- `is_default_calendar` → `isDefaultCalendar` (Graph `isDefaultCalendar`, property, renamed).
- `is_removable` → `isRemovable` (Graph `isRemovable`, property, renamed).
- `is_tallying_responses` → `isTallyingResponses` (Graph `isTallyingResponses`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/calendars/events` → `beta/users/calendars/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `calendar_id` → `calendar-id` (Graph `calendar-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/contact-folders` → `beta/users/contactFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `well_known_name` → `wellKnownName` (Graph `wellKnownName`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/contact-folders/contacts` → `beta/users/contactFolders/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `is_favorite` → `isFavorite` (Graph `isFavorite`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `postal_addresses` → `postalAddresses` (Graph `postalAddresses`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `wedding_anniversary` → `weddingAnniversary` (Graph `weddingAnniversary`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).
- `contact_folder_id` → `contactFolder-id` (Graph `contactFolder-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/contacts` → `beta/users/contacts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `assistant_name` → `assistantName` (Graph `assistantName`, property, renamed).
- `company_name` → `companyName` (Graph `companyName`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `email_addresses` → `emailAddresses` (Graph `emailAddresses`, property, renamed).
- `file_as` → `fileAs` (Graph `fileAs`, property, renamed).
- `given_name` → `givenName` (Graph `givenName`, property, renamed).
- `im_addresses` → `imAddresses` (Graph `imAddresses`, property, renamed).
- `is_favorite` → `isFavorite` (Graph `isFavorite`, property, renamed).
- `job_title` → `jobTitle` (Graph `jobTitle`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `middle_name` → `middleName` (Graph `middleName`, property, renamed).
- `nick_name` → `nickName` (Graph `nickName`, property, renamed).
- `office_location` → `officeLocation` (Graph `officeLocation`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `personal_notes` → `personalNotes` (Graph `personalNotes`, property, renamed).
- `postal_addresses` → `postalAddresses` (Graph `postalAddresses`, property, renamed).
- `primary_email_address` → `primaryEmailAddress` (Graph `primaryEmailAddress`, property, renamed).
- `secondary_email_address` → `secondaryEmailAddress` (Graph `secondaryEmailAddress`, property, renamed).
- `spouse_name` → `spouseName` (Graph `spouseName`, property, renamed).
- `tertiary_email_address` → `tertiaryEmailAddress` (Graph `tertiaryEmailAddress`, property, renamed).
- `wedding_anniversary` → `weddingAnniversary` (Graph `weddingAnniversary`, property, renamed).
- `yomi_company_name` → `yomiCompanyName` (Graph `yomiCompanyName`, property, renamed).
- `yomi_given_name` → `yomiGivenName` (Graph `yomiGivenName`, property, renamed).
- `yomi_surname` → `yomiSurname` (Graph `yomiSurname`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/contacts/extensions` → `beta/users/contacts/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `contact_id` → `contact-id` (Graph `contact-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/distribution-lists` → `beta/users/distributionLists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `person_id` → `personId` (Graph `personId`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/events` → `beta/users/events`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_new_time_proposals` → `allowNewTimeProposals` (Graph `allowNewTimeProposals`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cancelled_occurrences` → `cancelledOccurrences` (Graph `cancelledOccurrences`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `exception_occurrences` → `exceptionOccurrences` (Graph `exceptionOccurrences`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `hide_attendees` → `hideAttendees` (Graph `hideAttendees`, property, renamed).
- `is_all_day` → `isAllDay` (Graph `isAllDay`, property, renamed).
- `is_cancelled` → `isCancelled` (Graph `isCancelled`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_online_meeting` → `isOnlineMeeting` (Graph `isOnlineMeeting`, property, renamed).
- `is_organizer` → `isOrganizer` (Graph `isOrganizer`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `occurrence_id` → `occurrenceId` (Graph `occurrenceId`, property, renamed).
- `online_meeting_provider` → `onlineMeetingProvider` (Graph `onlineMeetingProvider`, property, renamed).
- `original_end_time_zone` → `originalEndTimeZone` (Graph `originalEndTimeZone`, property, renamed).
- `original_start` → `originalStart` (Graph `originalStart`, property, renamed).
- `original_start_time_zone` → `originalStartTimeZone` (Graph `originalStartTimeZone`, property, renamed).
- `reminder_minutes_before_start` → `reminderMinutesBeforeStart` (Graph `reminderMinutesBeforeStart`, property, renamed).
- `response_requested` → `responseRequested` (Graph `responseRequested`, property, renamed).
- `response_status` → `responseStatus` (Graph `responseStatus`, property, renamed).
- `series_master_id` → `seriesMasterId` (Graph `seriesMasterId`, property, renamed).
- `show_as` → `showAs` (Graph `showAs`, property, renamed).
- `transaction_id` → `transactionId` (Graph `transactionId`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/events/extensions` → `beta/users/events/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `event_id` → `event-id` (Graph `event-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/extensions` → `beta/users/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/inference-classification/overrides` → `beta/users/inferenceClassification/overrides`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `classify_as` → `classifyAs` (Graph `classifyAs`, property, renamed).
- `sender_email_address` → `senderEmailAddress` (Graph `senderEmailAddress`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/mail-folders` → `beta/users/mailFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `child_folder_count` → `childFolderCount` (Graph `childFolderCount`, property, renamed).
- `child_folders` → `childFolders` (Graph `childFolders`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_hidden` → `isHidden` (Graph `isHidden`, property, renamed).
- `message_rules` → `messageRules` (Graph `messageRules`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `total_item_count` → `totalItemCount` (Graph `totalItemCount`, property, renamed).
- `unread_item_count` → `unreadItemCount` (Graph `unreadItemCount`, property, renamed).
- `user_configurations` → `userConfigurations` (Graph `userConfigurations`, property, renamed).
- `well_known_name` → `wellKnownName` (Graph `wellKnownName`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/mail-folders/messages` → `beta/users/mailFolders/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `mentions_preview` → `mentionsPreview` (Graph `mentionsPreview`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `unsubscribe_data` → `unsubscribeData` (Graph `unsubscribeData`, property, renamed).
- `unsubscribe_enabled` → `unsubscribeEnabled` (Graph `unsubscribeEnabled`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `mail_folder_id` → `mailFolder-id` (Graph `mailFolder-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/messages` → `beta/users/messages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `bcc_recipients` → `bccRecipients` (Graph `bccRecipients`, property, renamed).
- `body_preview` → `bodyPreview` (Graph `bodyPreview`, property, renamed).
- `cc_recipients` → `ccRecipients` (Graph `ccRecipients`, property, renamed).
- `conversation_id` → `conversationId` (Graph `conversationId`, property, renamed).
- `conversation_index` → `conversationIndex` (Graph `conversationIndex`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `inference_classification` → `inferenceClassification` (Graph `inferenceClassification`, property, renamed).
- `internet_message_id` → `internetMessageId` (Graph `internetMessageId`, property, renamed).
- `is_delivery_receipt_requested` → `isDeliveryReceiptRequested` (Graph `isDeliveryReceiptRequested`, property, renamed).
- `is_draft` → `isDraft` (Graph `isDraft`, property, renamed).
- `is_read` → `isRead` (Graph `isRead`, property, renamed).
- `is_read_receipt_requested` → `isReadReceiptRequested` (Graph `isReadReceiptRequested`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `mentions_preview` → `mentionsPreview` (Graph `mentionsPreview`, property, renamed).
- `multi_value_extended_properties` → `multiValueExtendedProperties` (Graph `multiValueExtendedProperties`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `received_date_time` → `receivedDateTime` (Graph `receivedDateTime`, property, renamed).
- `reply_to` → `replyTo` (Graph `replyTo`, property, renamed).
- `sent_date_time` → `sentDateTime` (Graph `sentDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `to_recipients` → `toRecipients` (Graph `toRecipients`, property, renamed).
- `unique_body` → `uniqueBody` (Graph `uniqueBody`, property, renamed).
- `unsubscribe_data` → `unsubscribeData` (Graph `unsubscribeData`, property, renamed).
- `unsubscribe_enabled` → `unsubscribeEnabled` (Graph `unsubscribeEnabled`, property, renamed).
- `web_link` → `webLink` (Graph `webLink`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/messages/extensions` → `beta/users/messages/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `message_id` → `message-id` (Graph `message-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/mobile-app-intent-and-states` → `beta/users/mobileAppIntentAndStates`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `managed_device_identifier` → `managedDeviceIdentifier` (Graph `managedDeviceIdentifier`, property, renamed).
- `mobile_app_list` → `mobileAppList` (Graph `mobileAppList`, property, renamed).
- `user_id_2` → `userId` (Graph `userId`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/mobile-app-troubleshooting-events` → `beta/users/mobileAppTroubleshootingEvents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `additional_information` → `additionalInformation` (Graph `additionalInformation`, property, renamed).
- `app_log_collection_requests` → `appLogCollectionRequests` (Graph `appLogCollectionRequests`, property, renamed).
- `application_id` → `applicationId` (Graph `applicationId`, property, renamed).
- `correlation_id` → `correlationId` (Graph `correlationId`, property, renamed).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `event_date_time` → `eventDateTime` (Graph `eventDateTime`, property, renamed).
- `event_name` → `eventName` (Graph `eventName`, property, renamed).
- `managed_device_identifier` → `managedDeviceIdentifier` (Graph `managedDeviceIdentifier`, property, renamed).
- `troubleshooting_error_details` → `troubleshootingErrorDetails` (Graph `troubleshootingErrorDetails`, property, renamed).
- `user_id_2` → `userId` (Graph `userId`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/onenote/pages` → `beta/users/onenote/pages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `user_tags` → `userTags` (Graph `userTags`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/online-meetings` → `beta/users/onlineMeetings`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allow_attendee_to_enable_camera` → `allowAttendeeToEnableCamera` (Graph `allowAttendeeToEnableCamera`, property, renamed).
- `allow_attendee_to_enable_mic` → `allowAttendeeToEnableMic` (Graph `allowAttendeeToEnableMic`, property, renamed).
- `allow_breakout_rooms` → `allowBreakoutRooms` (Graph `allowBreakoutRooms`, property, renamed).
- `allow_copying_and_sharing_meeting_content` → `allowCopyingAndSharingMeetingContent` (Graph `allowCopyingAndSharingMeetingContent`, property, renamed).
- `allow_live_share` → `allowLiveShare` (Graph `allowLiveShare`, property, renamed).
- `allow_meeting_chat` → `allowMeetingChat` (Graph `allowMeetingChat`, property, renamed).
- `allow_participants_to_change_name` → `allowParticipantsToChangeName` (Graph `allowParticipantsToChangeName`, property, renamed).
- `allow_power_point_sharing` → `allowPowerPointSharing` (Graph `allowPowerPointSharing`, property, renamed).
- `allow_recording` → `allowRecording` (Graph `allowRecording`, property, renamed).
- `allow_teamwork_reactions` → `allowTeamworkReactions` (Graph `allowTeamworkReactions`, property, renamed).
- `allow_transcription` → `allowTranscription` (Graph `allowTranscription`, property, renamed).
- `allow_whiteboard` → `allowWhiteboard` (Graph `allowWhiteboard`, property, renamed).
- `allowed_lobby_admitters` → `allowedLobbyAdmitters` (Graph `allowedLobbyAdmitters`, property, renamed).
- `allowed_presenters` → `allowedPresenters` (Graph `allowedPresenters`, property, renamed).
- `anonymize_identity_for_roles` → `anonymizeIdentityForRoles` (Graph `anonymizeIdentityForRoles`, property, renamed).
- `broadcast_recording` → `broadcastRecording` (Graph `broadcastRecording`, property, renamed).
- `broadcast_settings` → `broadcastSettings` (Graph `broadcastSettings`, property, renamed).
- `chat_info` → `chatInfo` (Graph `chatInfo`, property, renamed).
- `chat_restrictions` → `chatRestrictions` (Graph `chatRestrictions`, property, renamed).
- `end_date_time` → `endDateTime` (Graph `endDateTime`, property, renamed).
- `expiry_date_time` → `expiryDateTime` (Graph `expiryDateTime`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `is_broadcast` → `isBroadcast` (Graph `isBroadcast`, property, renamed).
- `is_end_to_end_encryption_enabled` → `isEndToEndEncryptionEnabled` (Graph `isEndToEndEncryptionEnabled`, property, renamed).
- `is_entry_exit_announced` → `isEntryExitAnnounced` (Graph `isEntryExitAnnounced`, property, renamed).
- `join_meeting_id_settings` → `joinMeetingIdSettings` (Graph `joinMeetingIdSettings`, property, renamed).
- `join_url` → `joinUrl` (Graph `joinUrl`, property, renamed).
- `lobby_bypass_settings` → `lobbyBypassSettings` (Graph `lobbyBypassSettings`, property, renamed).
- `meeting_options_web_url` → `meetingOptionsWebUrl` (Graph `meetingOptionsWebUrl`, property, renamed).
- `meeting_spoken_language_tag` → `meetingSpokenLanguageTag` (Graph `meetingSpokenLanguageTag`, property, renamed).
- `meeting_template_id` → `meetingTemplateId` (Graph `meetingTemplateId`, property, renamed).
- `record_automatically` → `recordAutomatically` (Graph `recordAutomatically`, property, renamed).
- `sensitivity_label_assignment` → `sensitivityLabelAssignment` (Graph `sensitivityLabelAssignment`, property, renamed).
- `share_meeting_chat_history_default` → `shareMeetingChatHistoryDefault` (Graph `shareMeetingChatHistoryDefault`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `watermark_protection` → `watermarkProtection` (Graph `watermarkProtection`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/online-meetings/registration/registrants` → `beta/users/onlineMeetings/registration/registrants`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `online_meeting_id` → `onlineMeeting-id` (Graph `onlineMeeting-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/outlook/master-categories` → `beta/users/outlook/masterCategories`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/outlook/task-folders` → `beta/users/outlook/taskFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_key` → `changeKey` (Graph `changeKey`, property, renamed).
- `is_default_folder` → `isDefaultFolder` (Graph `isDefaultFolder`, property, renamed).
- `parent_group_key` → `parentGroupKey` (Graph `parentGroupKey`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/outlook/task-groups` → `beta/users/outlook/taskGroups`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_key` → `changeKey` (Graph `changeKey`, property, renamed).
- `group_key` → `groupKey` (Graph `groupKey`, property, renamed).
- `is_default_group` → `isDefaultGroup` (Graph `isDefaultGroup`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/outlook/task-groups/task-folders` → `beta/users/outlook/taskGroups/taskFolders`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `change_key` → `changeKey` (Graph `changeKey`, property, renamed).
- `is_default_folder` → `isDefaultFolder` (Graph `isDefaultFolder`, property, renamed).
- `parent_group_key` → `parentGroupKey` (Graph `parentGroupKey`, property, renamed).
- `outlook_task_group_id` → `outlookTaskGroup-id` (Graph `outlookTaskGroup-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/outlook/tasks` → `beta/users/outlook/tasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `parent_folder_id` → `parentFolderId` (Graph `parentFolderId`, property, renamed).
- `reminder_date_time` → `reminderDateTime` (Graph `reminderDateTime`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/account` → `beta/users/profile/account`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `age_group` → `ageGroup` (Graph `ageGroup`, property, renamed).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `country_code` → `countryCode` (Graph `countryCode`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `origin_tenant_info` → `originTenantInfo` (Graph `originTenantInfo`, property, renamed).
- `preferred_language_tag` → `preferredLanguageTag` (Graph `preferredLanguageTag`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_persona` → `userPersona` (Graph `userPersona`, property, renamed).
- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/addresses` → `beta/users/profile/addresses`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `geo_coordinates` → `geoCoordinates` (Graph `geoCoordinates`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/anniversaries` → `beta/users/profile/anniversaries`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/awards` → `beta/users/profile/awards`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `issued_date` → `issuedDate` (Graph `issuedDate`, property, renamed).
- `issuing_authority` → `issuingAuthority` (Graph `issuingAuthority`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/certifications` → `beta/users/profile/certifications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `certification_id` → `certificationId` (Graph `certificationId`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `end_date` → `endDate` (Graph `endDate`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `issued_date` → `issuedDate` (Graph `issuedDate`, property, renamed).
- `issuing_authority` → `issuingAuthority` (Graph `issuingAuthority`, property, renamed).
- `issuing_company` → `issuingCompany` (Graph `issuingCompany`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `start_date` → `startDate` (Graph `startDate`, property, renamed).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/educational-activities` → `beta/users/profile/educationalActivities`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `completion_month_year` → `completionMonthYear` (Graph `completionMonthYear`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `end_month_year` → `endMonthYear` (Graph `endMonthYear`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `start_month_year` → `startMonthYear` (Graph `startMonthYear`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/emails` → `beta/users/profile/emails`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/interests` → `beta/users/profile/interests`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `collaboration_tags` → `collaborationTags` (Graph `collaborationTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/languages` → `beta/users/profile/languages`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/names` → `beta/users/profile/names`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `language_tag` → `languageTag` (Graph `languageTag`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/notes` → `beta/users/profile/notes`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/patents` → `beta/users/profile/patents`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_pending` → `isPending` (Graph `isPending`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `issued_date` → `issuedDate` (Graph `issuedDate`, property, renamed).
- `issuing_authority` → `issuingAuthority` (Graph `issuingAuthority`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/phones` → `beta/users/profile/phones`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/positions` → `beta/users/profile/positions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `is_current` → `isCurrent` (Graph `isCurrent`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/projects` → `beta/users/profile/projects`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `collaboration_tags` → `collaborationTags` (Graph `collaborationTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/publications` → `beta/users/profile/publications`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `published_date` → `publishedDate` (Graph `publishedDate`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/skills` → `beta/users/profile/skills`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `collaboration_tags` → `collaborationTags` (Graph `collaborationTags`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/web-accounts` → `beta/users/profile/webAccounts`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `status_message` → `statusMessage` (Graph `statusMessage`, property, renamed).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `user_id_2` → `userId` (Graph `userId`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/profile/websites` → `beta/users/profile/websites`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `allowed_audiences` → `allowedAudiences` (Graph `allowedAudiences`, property, renamed).
- `created_by` → `createdBy` (Graph `createdBy`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_searchable` → `isSearchable` (Graph `isSearchable`, property, renamed).
- `last_modified_by` → `lastModifiedBy` (Graph `lastModifiedBy`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `graph_source` → `graph_source` (Graph `source`, property, exception).
- `thumbnail_url` → `thumbnailUrl` (Graph `thumbnailUrl`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/settings/work-hours-and-locations/occurrences` → `beta/users/settings/workHoursAndLocations/occurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `recurrence_id` → `recurrenceId` (Graph `recurrenceId`, property, renamed).
- `time_off_details` → `timeOffDetails` (Graph `timeOffDetails`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/settings/work-hours-and-locations/recurrences` → `beta/users/settings/workHoursAndLocations/recurrences`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).
- `work_location_type` → `workLocationType` (Graph `workLocationType`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/teamwork/installed-apps` → `beta/users/teamwork/installedApps`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `consented_permission_set` → `consentedPermissionSet` (Graph `consentedPermissionSet`, property, renamed).
- `scope_info` → `scopeInfo` (Graph `scopeInfo`, property, renamed).
- `teams_app` → `teamsApp` (Graph `teamsApp`, property, renamed).
- `teams_app_definition` → `teamsAppDefinition` (Graph `teamsAppDefinition`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/todo/lists` → `beta/users/todo/lists`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_owner` → `isOwner` (Graph `isOwner`, property, renamed).
- `is_shared` → `isShared` (Graph `isShared`, property, renamed).
- `wellknown_list_name` → `wellknownListName` (Graph `wellknownListName`, property, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/todo/lists/extensions` → `beta/users/todo/lists/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/todo/lists/tasks` → `beta/users/todo/lists/tasks`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `attachment_sessions` → `attachmentSessions` (Graph `attachmentSessions`, property, renamed).
- `body_last_modified_date_time` → `bodyLastModifiedDateTime` (Graph `bodyLastModifiedDateTime`, property, renamed).
- `checklist_items` → `checklistItems` (Graph `checklistItems`, property, renamed).
- `completed_date_time` → `completedDateTime` (Graph `completedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `due_date_time` → `dueDateTime` (Graph `dueDateTime`, property, renamed).
- `has_attachments` → `hasAttachments` (Graph `hasAttachments`, property, renamed).
- `is_reminder_on` → `isReminderOn` (Graph `isReminderOn`, property, renamed).
- `last_modified_date_time` → `lastModifiedDateTime` (Graph `lastModifiedDateTime`, property, renamed).
- `linked_resources` → `linkedResources` (Graph `linkedResources`, property, renamed).
- `reminder_date_time` → `reminderDateTime` (Graph `reminderDateTime`, property, renamed).
- `single_value_extended_properties` → `singleValueExtendedProperties` (Graph `singleValueExtendedProperties`, property, renamed).
- `start_date_time` → `startDateTime` (Graph `startDateTime`, property, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/todo/lists/tasks/checklist-items` → `beta/users/todo/lists/tasks/checklistItems`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `checked_date_time` → `checkedDateTime` (Graph `checkedDateTime`, property, renamed).
- `created_date_time` → `createdDateTime` (Graph `createdDateTime`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `is_checked` → `isChecked` (Graph `isChecked`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/todo/lists/tasks/extensions` → `beta/users/todo/lists/tasks/extensions`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/users/todo/lists/tasks/linked-resources` → `beta/users/todo/lists/tasks/linkedResources`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `application_name` → `applicationName` (Graph `applicationName`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `external_id` → `externalId` (Graph `externalId`, property, renamed).
- `web_url` → `webUrl` (Graph `webUrl`, property, renamed).
- `todo_task_id` → `todoTask-id` (Graph `todoTask-id`, url_parameter, renamed).
- `todo_task_list_id` → `todoTaskList-id` (Graph `todoTaskList-id`, url_parameter, renamed).
- `user_id` → `user-id` (Graph `user-id`, url_parameter, renamed).

### `beta/workplace/sensor-devices` → `beta/workplace/sensorDevices`

- `odata_type` → `odata_type` (Graph `@odata.type`, property, exception).
- `device_id` → `deviceId` (Graph `deviceId`, property, renamed).
- `display_name` → `displayName` (Graph `displayName`, property, renamed).
- `ip_v4_address` → `ipV4Address` (Graph `ipV4Address`, property, renamed).
- `ip_v6_address` → `ipV6Address` (Graph `ipV6Address`, property, renamed).
- `mac_address` → `macAddress` (Graph `macAddress`, property, renamed).
- `place_id` → `placeId` (Graph `placeId`, property, renamed).

# Verified module casing migration

Baseline: published terraform-msgraph-modules `v5.0.0`. Verified tree only.

Update the module source path (`.../verified/<old path>` becomes `.../verified/<new path>`) and
update the module version to the new release, rename the arguments listed below, then run
`terraform init -upgrade` and inspect a saved plan before applying. Keep the caller's module
block label and every input value unchanged. A module's resource addresses do not depend on its
folder or on its input names, so a source or argument rename needs no state movement and no
`moved` block, and the plan proposes no change that the rename itself causes. No compatibility
aliases exist: the old folder and the old argument names are gone.

If you also rename your module block label, use a root-module moved block:

```hcl
moved {
  from = module.old_label
  to   = module.new_label
}
```

Graph URLs, request body keys, outputs and module controls
(`timeouts`, `api_version`, `name_pattern`, `enable_destroy_cleanup`, ...) keep their names.
An input that is not named by a Graph property or URL parameter at the top level of the
managed object keeps its name too; the reason is listed with it below. The attributes nested
inside the object inputs take Graph's property names, and the list of
each such input names every old and new attribute path (a list, set or map adds no path
segment: `tasks` holds a list of objects, and its `display_name` is written `display_name`).
A nested attribute that fills no single Graph property name keeps its name, with the reason.
An object input that still carries an old optional attribute name fails at plan time with a
message that names the new attribute, instead of dropping the old name and falling back to the
attribute's default (a dropped approval or session-control flag would otherwise default off).

## Every affected folder level

| Old path | New path |
| --- | --- |
| `directory/administrative-units` | `directory/administrativeUnits` |
| `identity-governance` | `identityGovernance` |
| `identity-governance/entitlement-management` | `identityGovernance/entitlementManagement` |
| `identity-governance/entitlement-management/access-packages` | `identityGovernance/entitlementManagement/accessPackages` |
| `identity-governance/entitlement-management/access-packages/resource-role-scopes` | `identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes` |
| `identity-governance/entitlement-management/assignment-policies` | `identityGovernance/entitlementManagement/assignmentPolicies` |
| `identity-governance/entitlement-management/catalogs` | `identityGovernance/entitlementManagement/catalogs` |
| `identity-governance/entitlement-management/catalogs/custom-extensions` | `identityGovernance/entitlementManagement/catalogs/customWorkflowExtensions` |
| `identity-governance/entitlement-management/catalogs/resources` | `identityGovernance/entitlementManagement/catalogs/resources` |
| `identity-governance/entitlement-management/connected-organizations` | `identityGovernance/entitlementManagement/connectedOrganizations` |
| `identity/conditional-access` | `identity/conditionalAccess` |
| `identity/conditional-access/named-locations` | `identity/conditionalAccess/namedLocations` |
| `identity/conditional-access/named-locations/countries` | `identity/conditionalAccess/namedLocations/countryNamedLocation` |
| `identity/conditional-access/named-locations/ip-ranges` | `identity/conditionalAccess/namedLocations/ipNamedLocation` |
| `identity/conditional-access/policies` | `identity/conditionalAccess/policies` |
| `role-management` | `roleManagement` |
| `role-management/directory` | `roleManagement/directory` |
| `role-management/directory/role-schedules` | `roleManagement/directory/roleSchedules` |
| `role-management/entitlement-management` | `roleManagement/entitlementManagement` |
| `role-management/entitlement-management/role-assignments` | `roleManagement/entitlementManagement/roleAssignments` |
| `service-principals` | `servicePrincipals` |

## Module sources and arguments

Paths are relative to the `verified` folder. Each arrow is old → new.

### `applications` → `applications`

The folder is unchanged.

- `display_name` → `displayName` (Graph `displayName`, property).
- `sign_in_audience` → `signInAudience` (Graph `signInAudience`, property).

Inputs that keep their name:

- `web_redirect_uris`: fills a nested Graph property, not a top-level one.
- `spa_redirect_uris`: fills a nested Graph property, not a top-level one.
- `public_client_redirect_uris`: fills a nested Graph property, not a top-level one.
- `app_roles`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).

Nested attributes (old → new, relative to the input):

- `app_roles`: `display_name` → `displayName`.
- `app_roles`: `allowed_member_types` → `allowedMemberTypes`.
- `app_roles`: `is_enabled` → `isEnabled`.

### `applications/federatedIdentityCredentials` → `applications/federatedIdentityCredentials`

The folder is unchanged.

- `application_id` → `application-id` (Graph `application-id`, URL parameter).

### `applications/passwordCredentials` → `applications/passwordCredentials`

The folder is unchanged.

- `application_id` → `application-id` (Graph `application-id`, URL parameter).

Inputs that keep their name:

- `rotation_trigger`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `acknowledge_secret_in_plan_output`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `directory/administrative-units` → `directory/administrativeUnits`

- `display_name` → `displayName` (Graph `displayName`, property).
- `is_member_management_restricted` → `isMemberManagementRestricted` (Graph `isMemberManagementRestricted`, property).
- `membership_type` → `membershipType` (Graph `membershipType`, property).
- `membership_rule` → `membershipRule` (Graph `membershipRule`, property).
- `membership_rule_processing_state` → `membershipRuleProcessingState` (Graph `membershipRuleProcessingState`, property).

Inputs that keep their name:

- `member_ids`: list of object IDs that the module adds through a relationship request, not a Graph property.
- `scoped_role_members`: list of object IDs that the module adds through a relationship request, not a Graph property.

Nested attributes (old → new, relative to the input):

- `scoped_role_members`: `role_id` → `roleId`.
- `scoped_role_members`: `member_id` keeps its name: fills roleMemberInfo.id, a nested path of another name; no Graph property is called memberId.

### `groups` → `groups`

The folder is unchanged.

- `display_name` → `displayName` (Graph `displayName`, property).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property).
- `security_enabled` → `securityEnabled` (Graph `securityEnabled`, property).
- `mail_enabled` → `mailEnabled` (Graph `mailEnabled`, property).
- `group_types` → `groupTypes` (Graph `groupTypes`, property).
- `membership_rule` → `membershipRule` (Graph `membershipRule`, property).
- `is_assignable_to_role` → `isAssignableToRole` (Graph `isAssignableToRole`, property).

Inputs that keep their name:

- `owner_ids`: Graph name is not a Terraform identifier (owners@odata.bind, members@odata.bind, @odata.type).
- `member_ids`: Graph name is not a Terraform identifier (owners@odata.bind, members@odata.bind, @odata.type).

### `groups/members` → `groups/members`

The folder is unchanged.

- `group_id` → `group-id` (Graph `group-id`, URL parameter).

Inputs that keep their name:

- `member_ids`: list of object IDs that the module adds through a relationship request, not a Graph property.

### `identity-governance/entitlement-management/access-packages` → `identityGovernance/entitlementManagement/accessPackages`

- `display_name` → `displayName` (Graph `displayName`, property).
- `is_hidden` → `isHidden` (Graph `isHidden`, property).

Inputs that keep their name:

- `catalog_id`: fills a nested Graph property, not a top-level one.

### `identity-governance/entitlement-management/access-packages/resource-role-scopes` → `identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes`

- `access_package_id` → `accessPackage-id` (Graph `accessPackage-id`, URL parameter).

Inputs that keep their name:

- `enable_destroy_cleanup`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `catalog_id`: selects or guards an object; no property of the managed object carries this value.
- `catalog_resource_id`: selects or guards an object; no property of the managed object carries this value.
- `resource_origin_system`: fills a nested Graph property, not a top-level one.
- `role_display_name`: fills a nested Graph property, not a top-level one.
- `role_origin_id`: fills a nested Graph property, not a top-level one.
- `role_definition_id`: fills a nested Graph property, not a top-level one.
- `role_type`: fills a nested Graph property, not a top-level one.
- `scope_origin_id`: fills a nested Graph property, not a top-level one.
- `scope_display_name`: fills a nested Graph property, not a top-level one.

### `identity-governance/entitlement-management/assignment-policies` → `identityGovernance/entitlementManagement/assignmentPolicies`

- `display_name` → `displayName` (Graph `displayName`, property).
- `allowed_target_scope` → `allowedTargetScope` (Graph `allowedTargetScope`, property).

Inputs that keep their name:

- `access_package_id`: fills a nested Graph property, not a top-level one.
- `specific_allowed_targets`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `requestor_settings`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `request_approval_settings`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `review_settings`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `custom_extension_stage_settings`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).

Nested attributes (old → new, relative to the input):

- `specific_allowed_targets`: `membership_rule` → `membershipRule`.
- `expiration`: `end_date_time` → `endDateTime`.
- `expiration`: `duration_days` keeps its name: Terraform-only number of days; the module builds the ISO 8601 duration property from it (P<n>D).
- `requestor_settings`: `allow_custom_assignment_schedule` → `allowCustomAssignmentSchedule`.
- `requestor_settings`: `enable_targets_to_self_add_access` → `enableTargetsToSelfAddAccess`.
- `requestor_settings`: `enable_targets_to_self_update_access` → `enableTargetsToSelfUpdateAccess`.
- `requestor_settings`: `enable_targets_to_self_remove_access` → `enableTargetsToSelfRemoveAccess`.
- `requestor_settings`: `enable_on_behalf_requestors_to_add_access` → `enableOnBehalfRequestorsToAddAccess`.
- `requestor_settings`: `enable_on_behalf_requestors_to_update_access` → `enableOnBehalfRequestorsToUpdateAccess`.
- `requestor_settings`: `enable_on_behalf_requestors_to_remove_access` → `enableOnBehalfRequestorsToRemoveAccess`.
- `requestor_settings`: `on_behalf_requestors` → `onBehalfRequestors`.
- `request_approval_settings`: `is_approval_required_for_add` → `isApprovalRequiredForAdd`.
- `request_approval_settings`: `is_approval_required_for_update` → `isApprovalRequiredForUpdate`.
- `request_approval_settings`: `is_requestor_justification_required` → `isRequestorJustificationRequired`.
- `request_approval_settings`: `stages.approver_information_visibility` → `stages.approverInformationVisibility`.
- `request_approval_settings`: `stages.is_approver_justification_required` → `stages.isApproverJustificationRequired`.
- `request_approval_settings`: `stages.is_escalation_enabled` → `stages.isEscalationEnabled`.
- `request_approval_settings`: `stages.primary_approvers` → `stages.primaryApprovers`.
- `request_approval_settings`: `stages.escalation_approvers` → `stages.escalationApprovers`.
- `request_approval_settings`: `stages.fallback_primary_approvers` → `stages.fallbackPrimaryApprovers`.
- `request_approval_settings`: `stages.fallback_escalation_approvers` → `stages.fallbackEscalationApprovers`.
- `request_approval_settings`: `stages.approval_timeout_in_days` keeps its name: Terraform-only number of days; the module builds the ISO 8601 duration properties durationBeforeAutomaticDenial / durationBeforeEscalation from it, and no Graph property carries this name.
- `request_approval_settings`: `stages.escalation_timeout_in_days` keeps its name: Terraform-only number of days; the module builds the ISO 8601 duration properties durationBeforeAutomaticDenial / durationBeforeEscalation from it, and no Graph property carries this name.
- `questions`: `is_required` → `isRequired`.
- `questions`: `is_answer_editable` → `isAnswerEditable`.
- `questions`: `is_single_line_question` → `isSingleLineQuestion`.
- `questions`: `regex_pattern` → `regexPattern`.
- `questions`: `is_multiple_selection_allowed` → `isMultipleSelectionAllowed`.
- `questions`: `localizations.language_code` → `localizations.languageCode`.
- `questions`: `choices.actual_value` → `choices.actualValue`.
- `questions`: `choices.localizations.language_code` → `choices.localizations.languageCode`.
- `review_settings`: `is_enabled` → `isEnabled`.
- `review_settings`: `expiration_behavior` → `expirationBehavior`.
- `review_settings`: `is_recommendation_enabled` → `isRecommendationEnabled`.
- `review_settings`: `is_reviewer_justification_required` → `isReviewerJustificationRequired`.
- `review_settings`: `is_self_review` → `isSelfReview`.
- `review_settings`: `primary_reviewers` → `primaryReviewers`.
- `review_settings`: `fallback_reviewers` → `fallbackReviewers`.
- `review_settings`: `schedule.start_date_time` → `schedule.startDateTime`.
- `review_settings`: `schedule.recurrence.day_of_month` → `schedule.recurrence.dayOfMonth`.
- `review_settings`: `schedule.recurrence.number_of_occurrences` → `schedule.recurrence.numberOfOccurrences`.
- `review_settings`: `schedule.duration_in_days` keeps its name: Terraform-only number of days; the module builds schedule.expiration { type, duration = P<n>D } from it.
- `review_settings`: `schedule.recurrence.range_type` keeps its name: Terraform-only flattening of schedule.recurrence.range.type; no Graph property named rangeType.
- `custom_extension_stage_settings`: `extension_id` keeps its name: Terraform-only; fills customExtension.id of the binding (a nested property of another name), and no Graph property is called extensionId.
- `custom_extension_stage_settings`: `extension_type` keeps its name: Terraform-only selector (request_workflow or assignment_workflow) from which the module derives customExtension.@odata.type.

### `identity-governance/entitlement-management/catalogs` → `identityGovernance/entitlementManagement/catalogs`

- `display_name` → `displayName` (Graph `displayName`, property).
- `is_externally_visible` → `isExternallyVisible` (Graph `isExternallyVisible`, property).

Inputs that keep their name:

- `catalog_type`: deprecated input that the module ignores; nothing is sent to Graph.

### `identity-governance/entitlement-management/catalogs/custom-extensions` → `identityGovernance/entitlementManagement/catalogs/customWorkflowExtensions`

Hand mapping (Graph collection identityGovernance/entitlementManagement/catalogs/{accessPackageCatalog-id}/customWorkflowExtensions (v1.0 and beta OpenAPI)).

- `catalog_id` → `accessPackageCatalog-id` (Graph `accessPackageCatalog-id`, URL parameter).
- `display_name` → `displayName` (Graph `displayName`, property).

Inputs that keep their name:

- `extension_type`: Graph name is not a Terraform identifier (owners@odata.bind, members@odata.bind, @odata.type).
- `logic_app`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `callback`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).

Nested attributes (old → new, relative to the input):

- `logic_app`: `subscription_id` → `subscriptionId`.
- `logic_app`: `resource_group_name` → `resourceGroupName`.
- `logic_app`: `workflow_name` → `logicAppWorkflowName`.
- `logic_app`: `trigger_url` → `url`.
- `callback`: `timeout` → `timeoutDuration`.

### `identity-governance/entitlement-management/catalogs/resources` → `identityGovernance/entitlementManagement/catalogs/resources`

- `catalog_id` → `accessPackageCatalog-id` (Graph `accessPackageCatalog-id`, URL parameter).

Inputs that keep their name:

- `enable_destroy_cleanup`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `resource_origin_system`: fills a nested Graph property, not a top-level one.
- `acknowledge_directory_role_preview`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `resource_origin_id`: fills a nested Graph property, not a top-level one.
- `resource_display_name`: fills a nested Graph property, not a top-level one.
- `verification_delay_seconds`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `fail_on_verification_mismatch`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `identity-governance/entitlement-management/connected-organizations` → `identityGovernance/entitlementManagement/connectedOrganizations`

- `display_name` → `displayName` (Graph `displayName`, property).

Inputs that keep their name:

- `identity_sources`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `internal_sponsor_ids`: list of object IDs that the module adds through a relationship request, not a Graph property.
- `external_sponsor_ids`: list of object IDs that the module adds through a relationship request, not a Graph property.

Nested attributes (old → new, relative to the input):

- `identity_sources`: `tenant_id` → `tenantId`.
- `identity_sources`: `domain_name` → `domainName`.
- `identity_sources`: `display_name` → `displayName`.

### `identity/conditional-access/named-locations/countries` → `identity/conditionalAccess/namedLocations/countryNamedLocation`

Hand mapping (Graph namedLocation subtype microsoft.graph.countryNamedLocation, the @odata.type the module sends).

- `display_name` → `displayName` (Graph `displayName`, property).
- `include_unknown_countries_and_regions` → `includeUnknownCountriesAndRegions` (Graph `includeUnknownCountriesAndRegions`, property).
- `country_lookup_method` → `countryLookupMethod` (Graph `countryLookupMethod`, property).
- `countries_and_regions` → `countriesAndRegions` (Graph `countriesAndRegions`, property).

### `identity/conditional-access/named-locations/ip-ranges` → `identity/conditionalAccess/namedLocations/ipNamedLocation`

Hand mapping (Graph namedLocation subtype microsoft.graph.ipNamedLocation, the @odata.type the module sends).

- `display_name` → `displayName` (Graph `displayName`, property).
- `is_trusted` → `isTrusted` (Graph `isTrusted`, property).

Inputs that keep their name:

- `ip_ranges`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).

### `identity/conditional-access/policies` → `identity/conditionalAccess/policies`

- `display_name` → `displayName` (Graph `displayName`, property).

Inputs that keep their name:

- `break_glass_user_ids`: fills a nested Graph property, not a top-level one.
- `break_glass_group_ids`: fills a nested Graph property, not a top-level one.
- `users`: fills a nested Graph property, not a top-level one.
- `applications`: fills a nested Graph property, not a top-level one.
- `client_app_types`: fills a nested Graph property, not a top-level one.
- `sign_in_risk_levels`: fills a nested Graph property, not a top-level one.
- `user_risk_levels`: fills a nested Graph property, not a top-level one.
- `locations`: fills a nested Graph property, not a top-level one.
- `platforms`: fills a nested Graph property, not a top-level one.
- `device_filter`: fills a nested Graph property, not a top-level one.
- `grant_controls`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `session_controls`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `licence_check`: Terraform-only control of the module; no Graph property or URL parameter names it.

Nested attributes (old → new, relative to the input):

- `users`: `include_users` → `includeUsers`.
- `users`: `exclude_users` → `excludeUsers`.
- `users`: `include_groups` → `includeGroups`.
- `users`: `exclude_groups` → `excludeGroups`.
- `users`: `include_roles` → `includeRoles`.
- `users`: `exclude_roles` → `excludeRoles`.
- `applications`: `include_applications` → `includeApplications`.
- `applications`: `exclude_applications` → `excludeApplications`.
- `applications`: `include_user_actions` → `includeUserActions`.
- `applications`: `include_authentication_context_class_references` → `includeAuthenticationContextClassReferences`.
- `locations`: `include_locations` → `includeLocations`.
- `locations`: `exclude_locations` → `excludeLocations`.
- `platforms`: `include_platforms` → `includePlatforms`.
- `platforms`: `exclude_platforms` → `excludePlatforms`.
- `grant_controls`: `built_in_controls` → `builtInControls`.
- `grant_controls`: `terms_of_use` → `termsOfUse`.
- `grant_controls`: `authentication_strength_id` keeps its name: fills authenticationStrength.id, a nested property of authenticationStrength; no Graph property of this name.
- `session_controls`: `sign_in_frequency` → `signInFrequency`.
- `session_controls`: `sign_in_frequency.frequency_interval` → `signInFrequency.frequencyInterval`.
- `session_controls`: `sign_in_frequency.authentication_type` → `signInFrequency.authenticationType`.
- `session_controls`: `application_enforced_restrictions` → `applicationEnforcedRestrictions`.
- `session_controls`: `cloud_app_security_type` → `cloudAppSecurityType`.
- `session_controls`: `persistent_browser_mode` keeps its name: fills persistentBrowser.mode (isEnabled is set by the module); no Graph property of this name.

### `identityGovernance/accessReviews/definitions` → `identityGovernance/accessReviews/definitions`

The folder is unchanged.

- `display_name` → `displayName` (Graph `displayName`, property).
- `description_for_admins` → `descriptionForAdmins` (Graph `descriptionForAdmins`, property).
- `description_for_reviewers` → `descriptionForReviewers` (Graph `descriptionForReviewers`, property).

Inputs that keep their name:

- `group_id`: fills a nested Graph property, not a top-level one.
- `membership_scope`: fills a nested Graph property, not a top-level one.
- `reviewer_user_ids`: fills a nested Graph property, not a top-level one.
- `fallback_reviewer_user_ids`: fills a nested Graph property, not a top-level one.
- `start_date`: fills a nested Graph property, not a top-level one.
- `recurrence`: fills a nested Graph property, not a top-level one.
- `instance_duration_in_days`: fills a nested Graph property, not a top-level one.
- `recommendations_enabled`: fills a nested Graph property, not a top-level one.
- `justification_required_on_approval`: fills a nested Graph property, not a top-level one.

Nested attributes (old → new, relative to the input):

- `recurrence`: `day_of_month` → `dayOfMonth`.
- `recurrence`: `number_of_occurrences` → `numberOfOccurrences`.

### `identityGovernance/entitlementManagement/assignments` → `identityGovernance/entitlementManagement/assignments`

The folder is unchanged.

- No argument is renamed.

Inputs that keep their name:

- `enable_destroy_cleanup`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `target_id`: fills a nested Graph property, not a top-level one.
- `access_package_id`: fills a nested Graph property, not a top-level one.
- `assignment_policy_id`: fills a nested Graph property, not a top-level one.
- `schedule`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `schedule_update`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `adopt_assignment_id`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `revoke_adopted_assignment_on_destroy`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `replacement_token`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `verification_delay_seconds`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `require_delivery`: Terraform-only control of the module; no Graph property or URL parameter names it.

Nested attributes (old → new, relative to the input):

- `schedule`: `start_date_time` → `startDateTime`.
- `schedule`: `expiration.end_date_time` → `expiration.endDateTime`.
- `schedule_update`: `start_date_time` → `startDateTime`.
- `schedule_update`: `expiration.end_date_time` → `expiration.endDateTime`.

### `identityGovernance/entitlementManagement/settings` → `identityGovernance/entitlementManagement/settings`

The folder is unchanged.

- `external_user_lifecycle_action` → `externalUserLifecycleAction` (Graph `externalUserLifecycleAction`, property).
- `duration_until_external_user_deleted_after_blocked` → `durationUntilExternalUserDeletedAfterBlocked` (Graph `durationUntilExternalUserDeletedAfterBlocked`, property).

Inputs that keep their name:

- `allow_external_user_deletion`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `restore_previous_state`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `restore_over_changes`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `identityGovernance/lifecycleWorkflows/customTaskExtensions` → `identityGovernance/lifecycleWorkflows/customTaskExtensions`

The folder is unchanged.

- `display_name` → `displayName` (Graph `displayName`, property).

Inputs that keep their name:

- `logic_app`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `authentication_resource_id`: fills a nested Graph property, not a top-level one.
- `timeout_in_milliseconds`: fills a nested Graph property, not a top-level one.
- `maximum_retries`: fills a nested Graph property, not a top-level one.
- `callback_timeout_duration`: fills a nested Graph property, not a top-level one.

Nested attributes (old → new, relative to the input):

- `logic_app`: `subscription_id` → `subscriptionId`.
- `logic_app`: `resource_group_name` → `resourceGroupName`.
- `logic_app`: `logic_app_workflow_name` → `logicAppWorkflowName`.

### `identityGovernance/lifecycleWorkflows/workflows` → `identityGovernance/lifecycleWorkflows/workflows`

The folder is unchanged.

- `display_name` → `displayName` (Graph `displayName`, property).
- `is_enabled` → `isEnabled` (Graph `isEnabled`, property).
- `is_scheduling_enabled` → `isSchedulingEnabled` (Graph `isSchedulingEnabled`, property).

Inputs that keep their name:

- `execution_conditions`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `tasks`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `activation_opt_in`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `acknowledge_dangerous_tasks`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `acknowledged_custom_task_extension_ids`: Terraform-only control of the module; no Graph property or URL parameter names it.

Nested attributes (old → new, relative to the input):

- `execution_conditions`: `trigger.time_based_attribute` → `trigger.timeBasedAttribute`.
- `execution_conditions`: `trigger.offset_in_days` → `trigger.offsetInDays`.
- `execution_conditions`: `scope_rule` keeps its name: Terraform-only flattening of scope.rule (ruleBasedSubjectSet); no Graph property of that name.
- `tasks`: `display_name` → `displayName`.
- `tasks`: `continue_on_error` → `continueOnError`.
- `tasks`: `is_enabled` → `isEnabled`.

### `identityGovernance/privilegedAccess/group/assignmentScheduleRequests` → `identityGovernance/privilegedAccess/group/assignmentScheduleRequests`

The folder is unchanged.

- `principal_id` → `principalId` (Graph `principalId`, property).
- `group_id` → `groupId` (Graph `groupId`, property).
- `access_id` → `accessId` (Graph `accessId`, property).

Inputs that keep their name:

- `start_date_time`: fills a nested Graph property, not a top-level one.
- `end_date_time`: fills a nested Graph property, not a top-level one.
- `verification_delay_seconds`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `fail_on_verification_mismatch`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `identityGovernance/privilegedAccess/group/eligibilityScheduleRequests` → `identityGovernance/privilegedAccess/group/eligibilityScheduleRequests`

The folder is unchanged.

- `principal_id` → `principalId` (Graph `principalId`, property).
- `group_id` → `groupId` (Graph `groupId`, property).
- `access_id` → `accessId` (Graph `accessId`, property).

Inputs that keep their name:

- `start_date_time`: fills a nested Graph property, not a top-level one.
- `end_date_time`: fills a nested Graph property, not a top-level one.
- `verification_delay_seconds`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `fail_on_verification_mismatch`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `identityGovernance/termsOfUse/agreements` → `identityGovernance/termsOfUse/agreements`

The folder is unchanged.

- `display_name` → `displayName` (Graph `displayName`, property).
- `is_viewing_before_acceptance_required` → `isViewingBeforeAcceptanceRequired` (Graph `isViewingBeforeAcceptanceRequired`, property).

Inputs that keep their name:

- `default_file`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `additional_files`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).
- `licence_check`: Terraform-only control of the module; no Graph property or URL parameter names it.

Nested attributes (old → new, relative to the input):

- `default_file`: `file_name` → `fileName`.
- `default_file`: `display_name` → `displayName`.
- `default_file`: `content_base64` keeps its name: Terraform-only: the base64 text is sent as fileData.data (a nested path, not a single Graph property name).
- `additional_files`: `file_name` → `fileName`.
- `additional_files`: `display_name` → `displayName`.
- `additional_files`: `is_major_version` → `isMajorVersion`.
- `additional_files`: `content_base64` keeps its name: Terraform-only: the base64 text is sent as fileData.data (a nested path, not a single Graph property name).

### `role-management/directory/role-schedules` → `roleManagement/directory/roleSchedules`

Hand mapping (the module manages both roleAssignmentSchedules and roleEligibilitySchedules (through their ScheduleRequests); Graph has no single segment for both, so the folder is named roleSchedules).

- `principal_id` → `principalId` (Graph `principalId`, property).
- `role_definition_id` → `roleDefinitionId` (Graph `roleDefinitionId`, property).
- `directory_scope_id` → `directoryScopeId` (Graph `directoryScopeId`, property).

Inputs that keep their name:

- `enable_destroy_cleanup`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `assignment_type`: selects or guards an object; no property of the managed object carries this value.
- `role_display_name`: selects or guards an object; no property of the managed object carries this value.
- `start_date_time`: fills a nested Graph property, not a top-level one.
- `expiration_type`: fills a nested Graph property, not a top-level one.
- `end_date_time`: fills a nested Graph property, not a top-level one.
- `duration`: fills a nested Graph property, not a top-level one.
- `verification_delay_seconds`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `fail_on_verification_mismatch`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `role-management/entitlement-management/role-assignments` → `roleManagement/entitlementManagement/roleAssignments`

- `principal_id` → `principalId` (Graph `principalId`, property).
- `role_definition_id` → `roleDefinitionId` (Graph `roleDefinitionId`, property).

Inputs that keep their name:

- `role`: selects or guards an object; no property of the managed object carries this value.
- `catalog_id`: the module reshapes the value before it reaches Graph (an object, strings turned into objects, or a list joined into a string).

### `roleManagement/directory/roleAssignments` → `roleManagement/directory/roleAssignments`

The folder is unchanged.

- `principal_id` → `principalId` (Graph `principalId`, property).
- `role_definition_id` → `roleDefinitionId` (Graph `roleDefinitionId`, property).
- `directory_scope_id` → `directoryScopeId` (Graph `directoryScopeId`, property).

Inputs that keep their name:

- `tenant_id`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `template_id`: selects or guards an object; no property of the managed object carries this value.
- `role_display_name`: selects or guards an object; no property of the managed object carries this value.
- `role_type`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `scope_type`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `service-principals` → `servicePrincipals`

- `app_id` → `appId` (Graph `appId`, property).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property).
- `app_role_assignment_required` → `appRoleAssignmentRequired` (Graph `appRoleAssignmentRequired`, property).
- `login_url` → `loginUrl` (Graph `loginUrl`, property).
- `preferred_single_sign_on_mode` → `preferredSingleSignOnMode` (Graph `preferredSingleSignOnMode`, property).

### `servicePrincipals/passwordCredentials` → `servicePrincipals/passwordCredentials`

The folder is unchanged.

- `service_principal_id` → `servicePrincipal-id` (Graph `servicePrincipal-id`, URL parameter).

Inputs that keep their name:

- `rotation_trigger`: Terraform-only control of the module; no Graph property or URL parameter names it.
- `acknowledge_secret_in_plan_output`: Terraform-only control of the module; no Graph property or URL parameter names it.

### `users` → `users`

The folder is unchanged.

- `user_principal_name` → `userPrincipalName` (Graph `userPrincipalName`, property).
- `display_name` → `displayName` (Graph `displayName`, property).
- `mail_nickname` → `mailNickname` (Graph `mailNickname`, property).
- `account_enabled` → `accountEnabled` (Graph `accountEnabled`, property).
- `given_name` → `givenName` (Graph `givenName`, property).
- `job_title` → `jobTitle` (Graph `jobTitle`, property).
- `usage_location` → `usageLocation` (Graph `usageLocation`, property).

Inputs that keep their name:

- `password`: fills a nested Graph property, not a top-level one.
- `force_change_password_next_sign_in`: fills a nested Graph property, not a top-level one.

## Modules without a rename

- `compositions/connected-organization-access`
- `naming`
- `oauth2PermissionGrants`
- `policies/authenticationStrengthPolicies`
- `roleManagement/directory/roleDefinitions`
- `security-baseline/admin-consent-workflow`
- `security-baseline/authentication-methods`
- `security-baseline/authorization-policy`
- `security-baseline/conditional-access-p1`
- `security-baseline/emergency-access-guard`
- `security-baseline/emergency-access-guard/verify`
- `security-baseline/licence-guard`
- `servicePrincipals/appRoleAssignedTo`
