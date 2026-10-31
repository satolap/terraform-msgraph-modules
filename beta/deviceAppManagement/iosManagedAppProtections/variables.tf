variable "allowWidgetContentSync" {
  description = "Indicates  if content sync for widgets is allowed for iOS on App Protection Policies"
  type        = bool
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

variable "allowedIosDeviceModels" {
  description = "Semicolon seperated list of device models allowed, as a string, for the managed app to work."
  type        = string
  default     = null
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

variable "appActionIfDeviceComplianceRequired" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfDeviceComplianceRequired == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfDeviceComplianceRequired)
    error_message = "appActionIfDeviceComplianceRequired must be one of the documented enum values."
  }
}

variable "appActionIfIosDeviceModelNotAllowed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfIosDeviceModelNotAllowed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfIosDeviceModelNotAllowed)
    error_message = "appActionIfIosDeviceModelNotAllowed must be one of the documented enum values."
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

variable "appActionIfUnableToAuthenticateUser" {
  description = "If set, it will specify what action to take in the case where the user is unable to checkin because their authentication token is invalid. This happens when the user is deleted or disabled in AAD. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfUnableToAuthenticateUser == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfUnableToAuthenticateUser)
    error_message = "appActionIfUnableToAuthenticateUser must be one of the documented enum values."
  }
}

variable "appDataEncryptionType" {
  description = "Represents the level to which app data is encrypted for managed apps"
  type        = string
  default     = null

  validation {
    condition     = var.appDataEncryptionType == null ? true : contains(["useDeviceSettings", "afterDeviceRestart", "whenDeviceLockedExceptOpenFiles", "whenDeviceLocked"], var.appDataEncryptionType)
    error_message = "appDataEncryptionType must be one of the documented enum values."
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

variable "blockDataIngestionIntoOrganizationDocuments" {
  description = "Indicates whether a user can bring data into org documents."
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

variable "customBrowserProtocol" {
  description = "A custom browser protocol to open weblink on iOS. When this property is configured, ManagedBrowserToOpenLinksRequired should be true."
  type        = string
  default     = null
}

variable "customDialerAppProtocol" {
  description = "Protocol of a custom dialer app to click-to-open a phone number on iOS, for example, skype:."
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

variable "dialerRestrictionLevel" {
  description = "The classes of apps that are allowed to click-to-open a phone number, for making phone calls or sending text messages."
  type        = string
  default     = null

  validation {
    condition     = var.dialerRestrictionLevel == null ? true : contains(["allApps", "managedApps", "customApp", "blocked"], var.dialerRestrictionLevel)
    error_message = "dialerRestrictionLevel must be one of the documented enum values."
  }
}

variable "disableAppPinIfDevicePinIsSet" {
  description = "Indicates whether use of the app pin is required if the device pin is set."
  type        = bool
  default     = null
}

variable "disableProtectionOfManagedOutboundOpenInData" {
  description = "Disable protection of data transferred to other apps through IOS OpenIn option. This setting is only allowed to be True when AllowedOutboundDataTransferDestinations is set to ManagedApps."
  type        = bool
  default     = null
}

variable "displayName" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "exemptedAppProtocols" {
  description = "Apps in this list will be exempt from the policy and will be able to receive data from managed apps."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "exemptedUniversalLinks" {
  description = "A list of custom urls that are allowed to invocate an unmanaged app"
  type        = list(string)
  default     = null
}

variable "faceIdBlocked" {
  description = "Indicates whether use of the FaceID is allowed in place of a pin if PinRequired is set to True."
  type        = bool
  default     = null
}

variable "filterOpenInToOnlyManagedApps" {
  description = "Defines if open-in operation is supported from the managed app to the filesharing locations selected. This setting only applies when AllowedOutboundDataTransferDestinations is set to ManagedApps and DisableProtectionOfManagedOutboundOpenInData is set to False."
  type        = bool
  default     = null
}

variable "fingerprintBlocked" {
  description = "Indicates whether use of the fingerprint reader is allowed in place of a pin if PinRequired is set to True."
  type        = bool
  default     = null
}

variable "genmojiConfigurationState" {
  description = "Configuration state (blocked or not blocked) for Apple Intelligence Genmoji setting. Possible values are: notBlocked, blocked, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.genmojiConfigurationState == null ? true : contains(["notBlocked", "blocked"], var.genmojiConfigurationState)
    error_message = "genmojiConfigurationState must be one of the documented enum values."
  }
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

variable "managedUniversalLinks" {
  description = "A list of custom urls that are allowed to invocate a managed app"
  type        = list(string)
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

variable "messagingRedirectAppUrlScheme" {
  description = "When a specific app redirection is enforced by protectedMessagingRedirectAppType in an App Protection Policy, this value defines the app url redirect schemes which are allowed to be used."
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

variable "minimumRequiredOsVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimumRequiredSdkVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimumWarningAppVersion" {
  description = "Versions less than the specified version will result in warning message on the managed app."
  type        = string
  default     = null
}

variable "minimumWarningOsVersion" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimumWarningSdkVersion" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimumWipeAppVersion" {
  description = "Versions less than or equal to the specified version will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "minimumWipeOsVersion" {
  description = "Versions less than or equal to the specified version will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "minimumWipeSdkVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data."
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
  default     = "#microsoft.graph.iosManagedAppProtection"
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

variable "protectInboundDataFromUnknownSources" {
  description = "Protect incoming data from unknown source. This setting is only allowed to be True when AllowedInboundDataTransferSources is set to AllApps."
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

variable "screenCaptureConfigurationState" {
  description = "Configuration state (blocked or not blocked) for Apple Intelligence screen capture setting. Possible values are: notBlocked, blocked, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.screenCaptureConfigurationState == null ? true : contains(["notBlocked", "blocked"], var.screenCaptureConfigurationState)
    error_message = "screenCaptureConfigurationState must be one of the documented enum values."
  }
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

variable "thirdPartyKeyboardsBlocked" {
  description = "Defines if third party keyboards are allowed while accessing a managed app"
  type        = bool
  default     = null
}

variable "writingToolsConfigurationState" {
  description = "Configuration state (blocked or not blocked) for Apple Intelligence writing tools setting. Possible values are: notBlocked, blocked, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.writingToolsConfigurationState == null ? true : contains(["notBlocked", "blocked"], var.writingToolsConfigurationState)
    error_message = "writingToolsConfigurationState must be one of the documented enum values."
  }
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
