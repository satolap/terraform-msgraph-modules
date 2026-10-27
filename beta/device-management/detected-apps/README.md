# /deviceManagement/detectedApps

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `managed_devices`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create new navigation property to detectedApps for deviceManagement

[Catalog](../../README.md) Â· [Device and app management](../../README.md#device-and-app-management) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-detectedapp?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/detectedApps`, `GET/PATCH/DELETE /deviceManagement/detectedApps/{detectedApp-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/device-management/detected-apps"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `device_count` | `deviceCount` | `number` | no | no | in place |
| `managed_devices` | `managedDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       assignmentFilterEvaluationStatusDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignmentFilterEvaluationStatusDetails")       payloadId = optional(string)     })))       chromeOSDeviceInfo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chromeOSDeviceProperty")       name = optional(string)       updatable = optional(bool)       value = optional(string)       valueType = optional(string)     })))       cloudPcRemoteActionResults = optional(list(object({       odata_type = optional(string, "#microsoft.graph.cloudPcRemoteActionResult")       actionName = optional(string)       lastUpdatedDateTime = optional(string)       startDateTime = optional(string)       statusDetail = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudPcStatusDetail")       additionalInformation = optional(any)       code = optional(string)       message = optional(string)     }))       statusDetails = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudPcStatusDetails")       additionalInformation = optional(any)       code = optional(string)       message = optional(string)     }))     })))       configurationManagerClientHealthState = optional(object({       odata_type = optional(string, "#microsoft.graph.configurationManagerClientHealthState")       errorCode = optional(number)       lastSyncDateTime = optional(string)       state = optional(string)     }))       configurationManagerClientInformation = optional(object({       odata_type = optional(string, "#microsoft.graph.configurationManagerClientInformation")       clientIdentifier = optional(string)       clientVersion = optional(string)       isBlocked = optional(bool)     }))       detectedApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.detectedApp")       deviceCount = optional(number)       managedDevices = optional(any)       platform = optional(string)       publisher = optional(string)     })))       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       deviceConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       deviceFirmwareConfigurationInterfaceManaged = optional(bool)       joinType = optional(string)       logCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceLogCollectionResponse")       enrolledByUser = optional(string)       errorCode = optional(number)       expirationDateTimeUTC = optional(string)       initiatedByUserPrincipalName = optional(string)       managedDeviceId = optional(string)       receivedDateTimeUTC = optional(string)       requestedDateTimeUTC = optional(string)       size = optional(any)       sizeInKB = optional(any)       status = optional(string)     })))       managedDeviceMobileAppConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       userId = optional(string)       userPrincipalName = optional(string)       version = optional(number)     })))       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       managementFeatures = optional(string)       notes = optional(string)       ownerType = optional(string)       roleScopeTagIds = optional(list(string))       securityBaselineStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.securityBaselineState")       displayName = optional(string)       securityBaselineTemplateId = optional(string)       settingStates = optional(any)       state = optional(string)       userPrincipalName = optional(string)     })))       skuFamily = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       analytics = optional(any)       appConsentRequestsForApproval = optional(any)       appRoleAssignedResources = optional(any)       appRoleAssignments = optional(any)       approvals = optional(any)       assignedLicenses = optional(any)       authentication = optional(any)       authorizationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(any)     }))       birthday = optional(string)       chats = optional(any)       city = optional(string)       cloudClipboard = optional(any)       cloudLicensing = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudLicensing.userCloudLicensing")       assignmentErrors = optional(any)       assignments = optional(any)       usageRights = optional(any)       waitingMembers = optional(any)     }))       cloudRealtimeCommunicationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudRealtimeCommunicationInfo")     }))       communications = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentConfigurations = optional(any)       deviceEnrollmentLimit = optional(number)       deviceKeys = optional(any)       deviceManagementTroubleshootingEvents = optional(any)       devices = optional(any)       displayName = optional(string)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     }))       employeeType = optional(string)       extensions = optional(any)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(any)       givenName = optional(string)       hireDate = optional(string)       identities = optional(any)       identityGovernance = optional(object({       odata_type = optional(string, "#microsoft.graph.identityGovernanceUserSettings")       approverDelegate = optional(any)     }))       identityParentId = optional(string)       inferenceClassification = optional(any)       infoCatalogs = optional(list(string))       informationProtection = optional(any)       interests = optional(list(string))       invitedBy = optional(any)       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedGroups = optional(any)       licenseDetails = optional(any)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       automaticRepliesSetting = optional(any)       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(any)       timeFormat = optional(string)       timeZone = optional(string)       userPurposeV2 = optional(string)       workingHours = optional(any)     }))       managedAppLogCollectionRequests = optional(any)       managedAppRegistrations = optional(any)       managedDevices = optional(any)       mobileAppIntentAndStates = optional(any)       mobileAppTroubleshootingEvents = optional(any)       mySite = optional(string)       notifications = optional(any)       oauth2PermissionGrants = optional(any)       officeLocation = optional(string)       onPremisesDistinguishedName = optional(string)       onPremisesDomainName = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(any)       onPremisesSamAccountName = optional(string)       onPremisesSecurityIdentifier = optional(string)       onPremisesSyncBehavior = optional(any)       onPremisesUserPrincipalName = optional(string)       onenote = optional(any)       onlineMeetings = optional(any)       otherMails = optional(list(string))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       pastProjects = optional(list(string))       pendingAccessReviewInstances = optional(any)       permissionGrants = optional(any)       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(any)     }))       profile = optional(any)       responsibilities = optional(list(string))       schools = optional(list(string))       security = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       usageRights = optional(any)       userPrincipalName = optional(string)       userType = optional(string)       virtualEvents = optional(any)       windowsInformationProtectionDeviceRegistrations = optional(any)     })))     }))` | no | yes | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `platform` | `platform` | `string` | no | no | in place |
| `publisher` | `publisher` | `string` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `displayName`, `id`, `sizeInByte`, `version`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- managedDevices[].cloudPcRemoteActionResults[].statusDetail.additionalInformation: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].cloudPcRemoteActionResults[].statusDetails.additionalInformation: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].detectedApps[].managedDevices[]: recursive schema; accepts an untyped value
- managedDevices[].deviceCategory: navigation property; accepts an untyped value
- managedDevices[].deviceCompliancePolicyStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].deviceConfigurationStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].logCollectionRequests[].size: polymorphic schema; accepts an untyped value
- managedDevices[].logCollectionRequests[].sizeInKB: polymorphic schema; accepts an untyped value
- managedDevices[].managedDeviceMobileAppConfigurationStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].securityBaselineStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].analytics: navigation property; accepts an untyped value
- managedDevices[].users[].appConsentRequestsForApproval[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].appRoleAssignedResources[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].approvals[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].authentication: navigation property; accepts an untyped value
- managedDevices[].users[].authorizationInfo.certificateUserIds: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].chats[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudClipboard: navigation property; accepts an untyped value
- managedDevices[].users[].cloudLicensing.assignmentErrors: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudLicensing.assignments: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudLicensing.usageRights: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudLicensing.waitingMembers: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].communications: navigation property; accepts an untyped value
- managedDevices[].users[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- managedDevices[].users[].deviceEnrollmentConfigurations[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].deviceKeys[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].deviceManagementTroubleshootingEvents[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].devices[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].followedSites[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].identities[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].identityGovernance.approverDelegate: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].inferenceClassification: navigation property; accepts an untyped value
- managedDevices[].users[].informationProtection: navigation property; accepts an untyped value
- managedDevices[].users[].invitedBy: polymorphic schema; accepts an untyped value
- managedDevices[].users[].joinedGroups[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].licenseDetails[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.automaticRepliesSetting: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.language: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.workingHours: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedAppLogCollectionRequests[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedAppRegistrations[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedDevices[]: recursive schema; accepts an untyped value
- managedDevices[].users[].mobileAppIntentAndStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mobileAppTroubleshootingEvents[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].notifications[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].oauth2PermissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- managedDevices[].users[].onenote: navigation property; accepts an untyped value
- managedDevices[].users[].onlineMeetings[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].pendingAccessReviewInstances[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].presence: navigation property; accepts an untyped value
- managedDevices[].users[].print.recentPrinterShares: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].profile: navigation property; accepts an untyped value
- managedDevices[].users[].security: navigation property; accepts an untyped value
- managedDevices[].users[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].settings: navigation property; accepts an untyped value
- managedDevices[].users[].sponsors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].todo: navigation property; accepts an untyped value
- managedDevices[].users[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].usageRights[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].virtualEvents: navigation property; accepts an untyped value
- managedDevices[].users[].windowsInformationProtectionDeviceRegistrations[]: nested schema exceeds depth limit; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
