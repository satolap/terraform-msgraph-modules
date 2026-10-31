variable "allowedDataStorageLocations" {
  description = "Data storage locations where a user may store managed data."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.allowedDataStorageLocations == null ? true : alltrue([alltrue([for input0 in var.allowedDataStorageLocations : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["oneDriveForBusiness", "sharePoint", "box", "localStorage"], input0))]))])]))
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

variable "appDataEncryptionType" {
  description = "Represents the level to which app data is encrypted for managed apps"
  type        = string
  default     = null

  validation {
    condition     = var.appDataEncryptionType == null ? true : contains(["useDeviceSettings", "afterDeviceRestart", "whenDeviceLockedExceptOpenFiles", "whenDeviceLocked"], var.appDataEncryptionType)
    error_message = "appDataEncryptionType must be one of the documented enum values."
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
    target     = optional(any)
  }))
  default = null
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

variable "faceIdBlocked" {
  description = "Indicates whether use of the FaceID is allowed in place of a pin if PinRequired is set to True."
  type        = bool
  default     = null
}

variable "fingerprintBlocked" {
  description = "Indicates whether use of the fingerprint reader is allowed in place of a pin if PinRequired is set to True."
  type        = bool
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

variable "maximumPinRetries" {
  description = "Maximum number of incorrect pin retry attempts before the managed app is either blocked or wiped. Valid values 1 to 65535"
  type        = number
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

variable "printBlocked" {
  description = "Indicates whether printing is allowed from managed apps."
  type        = bool
  default     = null
}

variable "saveAsBlocked" {
  description = "Indicates whether users may use the 'Save As' menu item to save a copy of protected files."
  type        = bool
  default     = null
}

variable "simplePinBlocked" {
  description = "Indicates whether simplePin is blocked."
  type        = bool
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
