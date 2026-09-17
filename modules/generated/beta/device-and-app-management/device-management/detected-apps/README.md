# /deviceManagement/detectedApps

Create new navigation property to detectedApps for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-detectedapp?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/detectedApps`, `GET/PATCH/DELETE /deviceManagement/detectedApps/{detectedApp-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/detected-apps"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `device_count` | `deviceCount` | `number` | no | no |
| `managed_devices` | `managedDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignmentFilterEvaluationStatusDetails")       payloadId = optional(string)     })))       chassisType = optional(string)       chromeOSDeviceInfo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chromeOSDeviceProperty")       name = optional(string)       updatable = optional(bool)       value = optional(string)       valueType = optional(string)     })))       cloudPcRemoteActionResults = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudPcRemoteActionResult")       actionName = optional(string)       lastUpdatedDateTime = optional(string)       startDateTime = optional(string)       statusDetail = optional(any)       statusDetails = optional(any)     })))       complianceState = optional(string)       configurationManagerClientHealthState = optional(any)       configurationManagerClientInformation = optional(any)       detectedApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.detectedApp")       deviceCount = optional(number)       managedDevices = optional(any)       platform = optional(string)       publisher = optional(string)     })))       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       deviceConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       deviceEnrollmentType = optional(string)       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       deviceRegistrationState = optional(string)       deviceType = optional(string)       exchangeAccessState = optional(string)       exchangeAccessStateReason = optional(string)       joinType = optional(string)       logCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceLogCollectionResponse")       enrolledByUser = optional(string)       errorCode = optional(number)       expirationDateTimeUTC = optional(string)       initiatedByUserPrincipalName = optional(string)       managedDeviceId = optional(string)       receivedDateTimeUTC = optional(string)       requestedDateTimeUTC = optional(string)       size = optional(any)       sizeInKB = optional(any)       status = optional(string)     })))       lostModeState = optional(string)       managedDeviceMobileAppConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementAgent = optional(string)       managementFeatures = optional(string)       managementState = optional(string)       notes = optional(string)       ownerType = optional(string)       partnerReportedThreatState = optional(string)       processorArchitecture = optional(string)       roleScopeTagIds = optional(list(string))       securityBaselineStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.securityBaselineState")       displayName = optional(string)       securityBaselineTemplateId = optional(string)       settingStates = optional(any)       state = optional(string)       userPrincipalName = optional(string)     })))       skuFamily = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(any)       appRoleAssignedResources = optional(any)       appRoleAssignments = optional(any)       approvals = optional(any)       assignedLicenses = optional(any)       authentication = optional(any)       authorizationInfo = optional(any)       birthday = optional(string)       chats = optional(any)       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(any)       cloudRealtimeCommunicationInfo = optional(any)       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(any)       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(any)       deviceManagementTroubleshootingEvents = optional(any)       devices = optional(any)       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(any)       employeeType = optional(string)       extensions = optional(any)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(any)       givenName = optional(string)       hireDate = optional(string)       identities = optional(any)       identityGovernance = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(any)       licenseDetails = optional(any)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(any)       managedAppLogCollectionRequests = optional(any)       managedAppRegistrations = optional(any)       managedDevices = optional(any)       mobileAppIntentAndStates = optional(any)       mobileAppTroubleshootingEvents = optional(any)       mySite = optional(string)       notifications = optional(any)       oauth2PermissionGrants = optional(any)       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(any)       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(any)       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(any)       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(any)       permissionGrants = optional(any)       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(any)       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       usageRights = optional(any)       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(any)     })))     }))` | no | yes |
| `odata_type` | `@odata.type` | `string` | no | no |
| `platform` | `platform` | `string` | no | no |
| `publisher` | `publisher` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
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

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
