# /deviceManagement/detectedApps

Create new navigation property to detectedApps for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-detectedapp?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

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
| `managed_devices` | `managedDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedDevice")       deviceCategory = optional(any)       deviceCompliancePolicyStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       version = optional(number)     })))       deviceConfigurationStates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceConfigurationState")       displayName = optional(string)       platformType = optional(string)       settingCount = optional(number)       settingStates = optional(any)       state = optional(string)       version = optional(number)     })))       logCollectionRequests = optional(list(object({       odata_type = optional(string, "#microsoft.graph.deviceLogCollectionResponse")       enrolledByUser = optional(string)       expirationDateTimeUTC = optional(string)       initiatedByUserPrincipalName = optional(string)       managedDeviceId = optional(string)       receivedDateTimeUTC = optional(string)       requestedDateTimeUTC = optional(string)       sizeInKB = optional(any)       status = optional(string)     })))       managedDeviceName = optional(string)       managedDeviceOwnerType = optional(string)       notes = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.user")       aboutMe = optional(string)       accountEnabled = optional(bool)       ageGroup = optional(string)       appRoleAssignments = optional(any)       assignedLicenses = optional(any)       authentication = optional(any)       authorizationInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.authorizationInfo")       certificateUserIds = optional(any)     }))       birthday = optional(string)       chats = optional(any)       city = optional(string)       cloudClipboard = optional(any)       companyName = optional(string)       consentProvidedForMinor = optional(string)       country = optional(string)       customSecurityAttributes = optional(any)       deletedDateTime = optional(string)       department = optional(string)       deviceEnrollmentLimit = optional(number)       deviceManagementTroubleshootingEvents = optional(any)       displayName = optional(string)       employeeExperience = optional(any)       employeeHireDate = optional(string)       employeeId = optional(string)       employeeLeaveDateTime = optional(string)       employeeOrgData = optional(object({       odata_type = optional(string, "#microsoft.graph.employeeOrgData")       costCenter = optional(string)       division = optional(string)     }))       employeeType = optional(string)       externalUserState = optional(string)       externalUserStateChangeDateTime = optional(string)       faxNumber = optional(string)       followedSites = optional(any)       givenName = optional(string)       hireDate = optional(string)       identities = optional(any)       identityParentId = optional(string)       inferenceClassification = optional(any)       interests = optional(list(string))       isResourceAccount = optional(bool)       jobTitle = optional(string)       joinedTeams = optional(any)       lastPasswordChangeDateTime = optional(string)       mail = optional(string)       mailNickname = optional(string)       mailboxSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.mailboxSettings")       archiveFolder = optional(string)       automaticRepliesSetting = optional(any)       dateFormat = optional(string)       delegateMeetingMessageDeliveryOptions = optional(string)       language = optional(any)       timeFormat = optional(string)       timeZone = optional(string)       workingHours = optional(any)     }))       managedAppRegistrations = optional(any)       managedDevices = optional(any)       mySite = optional(string)       oauth2PermissionGrants = optional(any)       officeLocation = optional(string)       onPremisesImmutableId = optional(string)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       onlineMeetings = optional(any)       otherMails = optional(list(string))       outlook = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       pastProjects = optional(list(string))       permissionGrants = optional(any)       postalCode = optional(string)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       preferredName = optional(string)       presence = optional(any)       print = optional(object({       odata_type = optional(string, "#microsoft.graph.userPrint")       recentPrinterShares = optional(any)     }))       responsibilities = optional(list(string))       schools = optional(list(string))       scopedRoleMemberOf = optional(any)       serviceProvisioningErrors = optional(any)       settings = optional(any)       showInAddressList = optional(bool)       skills = optional(list(string))       sponsors = optional(any)       state = optional(string)       streetAddress = optional(string)       surname = optional(string)       todo = optional(any)       transitiveMemberOf = optional(any)       usageLocation = optional(string)       userPrincipalName = optional(string)       userType = optional(string)     })))     }))` | no | yes |
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

- managedDevices[].deviceCategory: navigation property; accepts an untyped value
- managedDevices[].deviceCompliancePolicyStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].deviceConfigurationStates[].settingStates[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].logCollectionRequests[].sizeInKB: polymorphic schema; accepts an untyped value
- managedDevices[].users[].appRoleAssignments[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].authentication: navigation property; accepts an untyped value
- managedDevices[].users[].authorizationInfo.certificateUserIds: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].chats[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].cloudClipboard: navigation property; accepts an untyped value
- managedDevices[].users[].customSecurityAttributes: polymorphic schema; accepts an untyped value
- managedDevices[].users[].deviceManagementTroubleshootingEvents[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].employeeExperience: navigation property; accepts an untyped value
- managedDevices[].users[].followedSites[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].identities[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].inferenceClassification: navigation property; accepts an untyped value
- managedDevices[].users[].joinedTeams[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.automaticRepliesSetting: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.language: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].mailboxSettings.workingHours: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedAppRegistrations[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].managedDevices[]: recursive schema; accepts an untyped value
- managedDevices[].users[].oauth2PermissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].onPremisesSyncBehavior: navigation property; accepts an untyped value
- managedDevices[].users[].onenote: navigation property; accepts an untyped value
- managedDevices[].users[].onlineMeetings[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].outlook: navigation property; accepts an untyped value
- managedDevices[].users[].permissionGrants[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].presence: navigation property; accepts an untyped value
- managedDevices[].users[].print.recentPrinterShares: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].scopedRoleMemberOf[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].serviceProvisioningErrors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].settings: navigation property; accepts an untyped value
- managedDevices[].users[].sponsors[]: nested schema exceeds depth limit; accepts an untyped value
- managedDevices[].users[].todo: navigation property; accepts an untyped value
- managedDevices[].users[].transitiveMemberOf[]: nested schema exceeds depth limit; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
