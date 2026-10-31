variable "allowedAndroidDeviceManufacturers" {
  description = "Semicolon seperated list of device manufacturers allowed, as a string, for the managed app to work."
  type        = string
  default     = null
}

variable "allowedAndroidDeviceModels" {
  description = "List of device models allowed, as a string, for the managed app to work."
  type        = list(string)
  default     = null
}

variable "allowedDataIngestionLocations" {
  description = "Data storage locations where a user may store managed data."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.allowedDataIngestionLocations == null ? true : alltrue([alltrue([for input0 in var.allowedDataIngestionLocations : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["oneDriveForBusiness", "sharePoint", "camera", "photoLibrary"], input0))]))])]))
    error_message = "allowedDataIngestionLocations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "allowedDataStorageLocations" {
  description = "Data storage locations where a user may store managed data."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.allowedDataStorageLocations == null ? true : alltrue([alltrue([for input0 in var.allowedDataStorageLocations : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["oneDriveForBusiness", "sharePoint", "box", "localStorage", "photoLibrary", "iManage", "egnyte"], input0))]))])]))
    error_message = "allowedDataStorageLocations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "allowedInboundDataTransferSources" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowedInboundDataTransferSources == null ? true : contains(["allApps", "managedApps", "none"], var.allowedInboundDataTransferSources)
    error_message = "allowedInboundDataTransferSources must be one of the documented enum values."
  }
}

variable "allowedOutboundClipboardSharingExceptionLength" {
  description = "Specify the number of characters that may be cut or copied from Org data and accounts to any application. This setting overrides the AllowedOutboundClipboardSharingLevel restriction. Default value of '0' means no exception is allowed. Valid values 0 to 65535"
  type        = number
  default     = null
}

variable "allowedOutboundClipboardSharingLevel" {
  description = "Represents the level to which the device's clipboard may be shared between apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowedOutboundClipboardSharingLevel == null ? true : contains(["allApps", "managedAppsWithPasteIn", "managedApps", "blocked"], var.allowedOutboundClipboardSharingLevel)
    error_message = "allowedOutboundClipboardSharingLevel must be one of the documented enum values."
  }
}

variable "allowedOutboundDataTransferDestinations" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowedOutboundDataTransferDestinations == null ? true : contains(["allApps", "managedApps", "none"], var.allowedOutboundDataTransferDestinations)
    error_message = "allowedOutboundDataTransferDestinations must be one of the documented enum values."
  }
}

variable "appActionIfAccountIsClockedOut" {
  description = "Defines a managed app behavior, either block or warn, if the user is clocked out (non-working time). Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfAccountIsClockedOut == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfAccountIsClockedOut)
    error_message = "appActionIfAccountIsClockedOut must be one of the documented enum values."
  }
}

variable "appActionIfAndroidDeviceManufacturerNotAllowed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfAndroidDeviceManufacturerNotAllowed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfAndroidDeviceManufacturerNotAllowed)
    error_message = "appActionIfAndroidDeviceManufacturerNotAllowed must be one of the documented enum values."
  }
}

variable "appActionIfAndroidDeviceModelNotAllowed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfAndroidDeviceModelNotAllowed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfAndroidDeviceModelNotAllowed)
    error_message = "appActionIfAndroidDeviceModelNotAllowed must be one of the documented enum values."
  }
}

variable "appActionIfAndroidSafetyNetAppsVerificationFailed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfAndroidSafetyNetAppsVerificationFailed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfAndroidSafetyNetAppsVerificationFailed)
    error_message = "appActionIfAndroidSafetyNetAppsVerificationFailed must be one of the documented enum values."
  }
}

variable "appActionIfAndroidSafetyNetDeviceAttestationFailed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfAndroidSafetyNetDeviceAttestationFailed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfAndroidSafetyNetDeviceAttestationFailed)
    error_message = "appActionIfAndroidSafetyNetDeviceAttestationFailed must be one of the documented enum values."
  }
}

variable "appActionIfDeveloperOptionsEnabled" {
  description = "Defines a managed app behavior, either warn, block, or wipe, if Developer Options are enabled on the Android device. If the admin does not set this action, the default is null, which indicates this setting is not configured."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfDeveloperOptionsEnabled == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfDeveloperOptionsEnabled)
    error_message = "appActionIfDeveloperOptionsEnabled must be one of the documented enum values."
  }
}

variable "appActionIfDeviceComplianceRequired" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfDeviceComplianceRequired == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfDeviceComplianceRequired)
    error_message = "appActionIfDeviceComplianceRequired must be one of the documented enum values."
  }
}

variable "appActionIfDeviceLockNotSet" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfDeviceLockNotSet == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfDeviceLockNotSet)
    error_message = "appActionIfDeviceLockNotSet must be one of the documented enum values."
  }
}

variable "appActionIfDevicePasscodeComplexityLessThanHigh" {
  description = "If the device does not have a passcode of high complexity or higher, trigger the stored action. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfDevicePasscodeComplexityLessThanHigh == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfDevicePasscodeComplexityLessThanHigh)
    error_message = "appActionIfDevicePasscodeComplexityLessThanHigh must be one of the documented enum values."
  }
}

variable "appActionIfDevicePasscodeComplexityLessThanLow" {
  description = "If the device does not have a passcode of low complexity or higher, trigger the stored action. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfDevicePasscodeComplexityLessThanLow == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfDevicePasscodeComplexityLessThanLow)
    error_message = "appActionIfDevicePasscodeComplexityLessThanLow must be one of the documented enum values."
  }
}

variable "appActionIfDevicePasscodeComplexityLessThanMedium" {
  description = "If the device does not have a passcode of medium complexity or higher, trigger the stored action. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfDevicePasscodeComplexityLessThanMedium == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfDevicePasscodeComplexityLessThanMedium)
    error_message = "appActionIfDevicePasscodeComplexityLessThanMedium must be one of the documented enum values."
  }
}

variable "appActionIfMaximumPinRetriesExceeded" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfMaximumPinRetriesExceeded == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfMaximumPinRetriesExceeded)
    error_message = "appActionIfMaximumPinRetriesExceeded must be one of the documented enum values."
  }
}

variable "appActionIfSamsungKnoxAttestationRequired" {
  description = "Defines the behavior of a managed app when Samsung Knox Attestation is required. Possible values are null, warn, block & wipe. If the admin does not set this action, the default is null, which indicates this setting is not configured. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfSamsungKnoxAttestationRequired == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfSamsungKnoxAttestationRequired)
    error_message = "appActionIfSamsungKnoxAttestationRequired must be one of the documented enum values."
  }
}

variable "appActionIfUnableToAuthenticateUser" {
  description = "If set, it will specify what action to take in the case where the user is unable to checkin because their authentication token is invalid. This happens when the user is deleted or disabled in AAD. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfUnableToAuthenticateUser == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfUnableToAuthenticateUser)
    error_message = "appActionIfUnableToAuthenticateUser must be one of the documented enum values."
  }
}

variable "appGroupType" {
  description = "Indicates a collection of apps to target which can be one of several pre-defined lists of apps or a manually selected list of apps"
  type        = string
  default     = null

  validation {
    condition     = var.appGroupType == null ? true : contains(["selectedPublicApps", "allCoreMicrosoftApps", "allMicrosoftApps", "allApps"], var.appGroupType)
    error_message = "appGroupType must be one of the documented enum values."
  }
}

variable "approvedKeyboards" {
  description = "If Keyboard Restriction is enabled, only keyboards in this approved list will be allowed. A key should be Android package id for a keyboard and value should be a friendly name"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "apps" {
  description = "List of apps to which the policy is deployed."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.managedMobileApp")
    mobileAppIdentifier = optional(any)
    version             = optional(string)
  }))
  default = null
}

variable "assignments" {
  description = "Navigation property to list of inclusion and exclusion groups to which the policy is deployed."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")
    source     = optional(string)
    sourceId   = optional(string)
    target     = optional(any)
  }))
  default = null

  validation {
    condition     = (var.assignments == null ? true : alltrue([alltrue([for input0 in var.assignments : (input0 == null ? true : alltrue([(input0["source"] == null ? true : alltrue([(input0["source"] == null ? true : contains(["direct", "policySets"], input0["source"]))]))]))])]))
    error_message = "assignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "biometricAuthenticationBlocked" {
  description = "Indicates whether use of the biometric authentication is allowed in place of a pin if PinRequired is set to True."
  type        = bool
  default     = null
}

variable "blockAfterCompanyPortalUpdateDeferralInDays" {
  description = "Maximum number of days Company Portal update can be deferred on the device or app access will be blocked."
  type        = number
  default     = null
}

variable "blockDataIngestionIntoOrganizationDocuments" {
  description = "Indicates whether a user can bring data into org documents."
  type        = bool
  default     = null
}

variable "connectToVpnOnLaunch" {
  description = "Whether the app should connect to the configured VPN on launch."
  type        = bool
  default     = null
}

variable "contactSyncBlocked" {
  description = "Indicates whether contacts can be synced to the user's device."
  type        = bool
  default     = null
}

variable "createdDateTime" {
  description = "The date and time the policy was created."
  type        = string
  default     = null
}

variable "customBrowserDisplayName" {
  description = "Friendly name of the preferred custom browser to open weblink on Android. When this property is configured, ManagedBrowserToOpenLinksRequired should be true."
  type        = string
  default     = null
}

variable "customBrowserPackageId" {
  description = "Unique identifier of the preferred custom browser to open weblink on Android. When this property is configured, ManagedBrowserToOpenLinksRequired should be true."
  type        = string
  default     = null
}

variable "customDialerAppDisplayName" {
  description = "Friendly name of a custom dialer app to click-to-open a phone number on Android."
  type        = string
  default     = null
}

variable "customDialerAppPackageId" {
  description = "PackageId of a custom dialer app to click-to-open a phone number on Android."
  type        = string
  default     = null
}

variable "dataBackupBlocked" {
  description = "Indicates whether the backup of a managed app's data is blocked."
  type        = bool
  default     = null
}

variable "deployedAppCount" {
  description = "Count of apps to which the current policy is deployed."
  type        = number
  default     = null
}

variable "deploymentSummary" {
  description = "Navigation property to deployment summary of the configuration."
  type        = any
  default     = null
}

variable "description" {
  description = "The policy's description."
  type        = string
  default     = null
}

variable "deviceComplianceRequired" {
  description = "Indicates whether device compliance is required."
  type        = bool
  default     = null
}

variable "deviceLockRequired" {
  description = "Defines if any kind of lock must be required on android device"
  type        = bool
  default     = null
}

variable "dialerRestrictionLevel" {
  description = "The classes of apps that are allowed to click-to-open a phone number, for making phone calls or sending text messages."
  type        = string
  default     = null

  validation {
    condition     = var.dialerRestrictionLevel == null ? true : contains(["allApps", "managedApps", "customApp", "blocked"], var.dialerRestrictionLevel)
    error_message = "dialerRestrictionLevel must be one of the documented enum values."
  }
}

variable "disableAppEncryptionIfDeviceEncryptionIsEnabled" {
  description = "When this setting is enabled, app level encryption is disabled if device level encryption is enabled"
  type        = bool
  default     = null
}

variable "disableAppPinIfDevicePinIsSet" {
  description = "Indicates whether use of the app pin is required if the device pin is set."
  type        = bool
  default     = null
}

variable "displayName" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "encryptAppData" {
  description = "Indicates whether application data for managed apps should be encrypted"
  type        = bool
  default     = null
}

variable "exemptedAppPackages" {
  description = "App packages in this list will be exempt from the policy and will be able to receive data from managed apps."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "fingerprintAndBiometricEnabled" {
  description = "If null, this setting will be ignored. If false both fingerprints and biometrics will not be enabled. If true, both fingerprints and biometrics will be enabled."
  type        = bool
  default     = null
}

variable "fingerprintBlocked" {
  description = "Indicates whether use of the fingerprint reader is allowed in place of a pin if PinRequired is set to True."
  type        = bool
  default     = null
}

variable "gracePeriodToBlockAppsDuringOffClockHours" {
  description = "A grace period before blocking app access during off clock hours."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "isAssigned" {
  description = "Indicates if the policy is deployed to any inclusion groups or not."
  type        = bool
  default     = null
}

variable "keyboardsRestricted" {
  description = "Indicates if keyboard restriction is enabled. If enabled list of approved keyboards must be provided as well."
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Last time the policy was modified."
  type        = string
  default     = null
}

variable "managedBrowser" {
  description = "Type of managed browser"
  type        = string
  default     = null

  validation {
    condition     = var.managedBrowser == null ? true : try(alltrue([for value in split(",", var.managedBrowser) : contains(["notconfigured", "microsoftedge"], lower(trimspace(value)))]), false)
    error_message = "managedBrowser must be one or more of the documented enum values, separated by commas."
  }
}

variable "managedBrowserToOpenLinksRequired" {
  description = "Indicates whether internet links should be opened in the managed browser app, or any custom browser specified by CustomBrowserProtocol (for iOS) or CustomBrowserPackageId/CustomBrowserDisplayName (for Android)"
  type        = bool
  default     = null
}

variable "maximumAllowedDeviceThreatLevel" {
  description = "The maxium threat level allowed for an app to be compliant."
  type        = string
  default     = null

  validation {
    condition     = var.maximumAllowedDeviceThreatLevel == null ? true : contains(["notConfigured", "secured", "low", "medium", "high"], var.maximumAllowedDeviceThreatLevel)
    error_message = "maximumAllowedDeviceThreatLevel must be one of the documented enum values."
  }
}

variable "maximumPinRetries" {
  description = "Maximum number of incorrect pin retry attempts before the managed app is either blocked or wiped. Valid values 1 to 65535"
  type        = number
  default     = null
}

variable "maximumRequiredOsVersion" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "maximumWarningOsVersion" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "maximumWipeOsVersion" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "messagingRedirectAppDisplayName" {
  description = "When a specific app redirection is enforced by protectedMessagingRedirectAppType in an App Protection Policy, this value defines the app name which is allowed to be used."
  type        = string
  default     = null
}

variable "messagingRedirectAppPackageId" {
  description = "When a specific app redirection is enforced by protectedMessagingRedirectAppType in an App Protection Policy, this value defines the app package id which is allowed to be used."
  type        = string
  default     = null
}

variable "minimumPinLength" {
  description = "Minimum pin length required for an app-level pin if PinRequired is set to True"
  type        = number
  default     = null
}

variable "minimumRequiredAppVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimumRequiredCompanyPortalVersion" {
  description = "Minimum version of the Company portal that must be installed on the device or app access will be blocked"
  type        = string
  default     = null
}

variable "minimumRequiredOsVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimumRequiredPatchVersion" {
  description = "Define the oldest required Android security patch level a user can have to gain secure access to the app."
  type        = string
  default     = null
}

variable "minimumWarningAppVersion" {
  description = "Versions less than the specified version will result in warning message on the managed app."
  type        = string
  default     = null
}

variable "minimumWarningCompanyPortalVersion" {
  description = "Minimum version of the Company portal that must be installed on the device or the user will receive a warning"
  type        = string
  default     = null
}

variable "minimumWarningOsVersion" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimumWarningPatchVersion" {
  description = "Define the oldest recommended Android security patch level a user can have for secure access to the app."
  type        = string
  default     = null
}

variable "minimumWipeAppVersion" {
  description = "Versions less than or equal to the specified version will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "minimumWipeCompanyPortalVersion" {
  description = "Minimum version of the Company portal that must be installed on the device or the company data on the app will be wiped"
  type        = string
  default     = null
}

variable "minimumWipeOsVersion" {
  description = "Versions less than or equal to the specified version will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "minimumWipePatchVersion" {
  description = "Android security patch level  less than or equal to the specified value will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "mobileThreatDefensePartnerPriority" {
  description = "Indicates how to prioritize which Mobile Threat Defense (MTD) partner is enabled for a given platform, when more than one is enabled. An app can only be actively using a single Mobile Threat Defense partner. When NULL, Microsoft Defender will be given preference. Otherwise setting the value to defenderOverThirdPartyPartner or thirdPartyPartnerOverDefender will make explicit which partner to prioritize. Possible values are: null, defenderOverThirdPartyPartner, thirdPartyPartnerOverDefender and unknownFutureValue. Default value is null. Possible values are: defenderOverThirdPartyPartner, thirdPartyPartnerOverDefender, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.mobileThreatDefensePartnerPriority == null ? true : contains(["defenderOverThirdPartyPartner", "thirdPartyPartnerOverDefender"], var.mobileThreatDefensePartnerPriority)
    error_message = "mobileThreatDefensePartnerPriority must be one of the documented enum values."
  }
}

variable "mobileThreatDefenseRemediationAction" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.mobileThreatDefenseRemediationAction == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.mobileThreatDefenseRemediationAction)
    error_message = "mobileThreatDefenseRemediationAction must be one of the documented enum values."
  }
}

variable "notificationRestriction" {
  description = "Restrict managed app notification"
  type        = string
  default     = null

  validation {
    condition     = var.notificationRestriction == null ? true : contains(["allow", "blockOrganizationalData", "block"], var.notificationRestriction)
    error_message = "notificationRestriction must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.androidManagedAppProtection"
  nullable    = false
}

variable "organizationalCredentialsRequired" {
  description = "Indicates whether organizational credentials are required for app use."
  type        = bool
  default     = null
  sensitive   = true
}

variable "periodBeforePinReset" {
  description = "TimePeriod before the all-level pin must be reset if PinRequired is set to True."
  type        = string
  default     = null
}

variable "periodOfflineBeforeAccessCheck" {
  description = "The period after which access is checked when the device is not connected to the internet."
  type        = string
  default     = null
}

variable "periodOfflineBeforeWipeIsEnforced" {
  description = "The amount of time an app is allowed to remain disconnected from the internet before all managed data it is wiped."
  type        = string
  default     = null
}

variable "periodOnlineBeforeAccessCheck" {
  description = "The period after which access is checked when the device is connected to the internet."
  type        = string
  default     = null
}

variable "pinCharacterSet" {
  description = "Character set which is to be used for a user's app PIN"
  type        = string
  default     = null

  validation {
    condition     = var.pinCharacterSet == null ? true : contains(["numeric", "alphanumericAndSymbol"], var.pinCharacterSet)
    error_message = "pinCharacterSet must be one of the documented enum values."
  }
}

variable "pinRequired" {
  description = "Indicates whether an app-level pin is required."
  type        = bool
  default     = null
}

variable "pinRequiredInsteadOfBiometricTimeout" {
  description = "Timeout in minutes for an app pin instead of non biometrics passcode"
  type        = string
  default     = null
}

variable "previousPinBlockCount" {
  description = "Requires a pin to be unique from the number specified in this property. Valid values 0 to 24"
  type        = number
  default     = null
}

variable "printBlocked" {
  description = "Indicates whether printing is allowed from managed apps."
  type        = bool
  default     = null
}

variable "protectedMessagingRedirectAppType" {
  description = "Defines how app messaging redirection is protected by an App Protection Policy. Default is anyApp."
  type        = string
  default     = null

  validation {
    condition     = var.protectedMessagingRedirectAppType == null ? true : contains(["anyApp", "anyManagedApp", "specificApps", "blocked"], var.protectedMessagingRedirectAppType)
    error_message = "protectedMessagingRedirectAppType must be one of the documented enum values."
  }
}

variable "purviewContentEvaluationRequired" {
  description = "Specifies whether Microsoft Purview Data Loss Prevention (DLP) content evaluation is required before data sharing."
  type        = string
  default     = null

  validation {
    condition     = var.purviewContentEvaluationRequired == null ? true : contains(["notRequired", "requiredWhenOnline", "required"], var.purviewContentEvaluationRequired)
    error_message = "purviewContentEvaluationRequired must be one of the documented enum values."
  }
}

variable "requireClass3Biometrics" {
  description = "Require user to apply Class 3 Biometrics on their Android device."
  type        = bool
  default     = null
}

variable "requirePinAfterBiometricChange" {
  description = "A PIN prompt will override biometric prompts if class 3 biometrics are updated on the device."
  type        = bool
  default     = null
}

variable "requiredAndroidSafetyNetAppsVerificationType" {
  description = "An admin enforced Android SafetyNet Device Attestation requirement on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.requiredAndroidSafetyNetAppsVerificationType == null ? true : contains(["none", "enabled"], var.requiredAndroidSafetyNetAppsVerificationType)
    error_message = "requiredAndroidSafetyNetAppsVerificationType must be one of the documented enum values."
  }
}

variable "requiredAndroidSafetyNetDeviceAttestationType" {
  description = "An admin enforced Android SafetyNet Device Attestation requirement on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.requiredAndroidSafetyNetDeviceAttestationType == null ? true : contains(["none", "basicIntegrity", "basicIntegrityAndDeviceCertification"], var.requiredAndroidSafetyNetDeviceAttestationType)
    error_message = "requiredAndroidSafetyNetDeviceAttestationType must be one of the documented enum values."
  }
}

variable "requiredAndroidSafetyNetEvaluationType" {
  description = "An admin enforced Android SafetyNet evaluation type requirement on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.requiredAndroidSafetyNetEvaluationType == null ? true : contains(["basic", "hardwareBacked"], var.requiredAndroidSafetyNetEvaluationType)
    error_message = "requiredAndroidSafetyNetEvaluationType must be one of the documented enum values."
  }
}

variable "roleScopeTagIds" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "saveAsBlocked" {
  description = "Indicates whether users may use the 'Save As' menu item to save a copy of protected files."
  type        = bool
  default     = null
}

variable "screenCaptureBlocked" {
  description = "Indicates whether a managed user can take screen captures of managed apps"
  type        = bool
  default     = null
}

variable "simplePinBlocked" {
  description = "Indicates whether simplePin is blocked."
  type        = bool
  default     = null
}

variable "targetedAppManagementLevels" {
  description = "Management levels for apps"
  type        = string
  default     = null

  validation {
    condition     = var.targetedAppManagementLevels == null ? true : try(alltrue([for value in split(",", var.targetedAppManagementLevels) : contains(["unspecified", "unmanaged", "mdm", "androidenterprise", "androidenterprisededicateddeviceswithazureadsharedmode", "androidopensourceprojectuserassociated", "androidopensourceprojectuserless"], lower(trimspace(value)))]), false)
    error_message = "targetedAppManagementLevels must be one or more of the documented enum values, separated by commas."
  }
}

variable "warnAfterCompanyPortalUpdateDeferralInDays" {
  description = "Maximum number of days Company Portal update can be deferred on the device or the user will receive the warning"
  type        = number
  default     = null
}

variable "wipeAfterCompanyPortalUpdateDeferralInDays" {
  description = "Maximum number of days Company Portal update can be deferred on the device or the company data on the app will be wiped"
  type        = number
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
