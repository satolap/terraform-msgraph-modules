variable "allowedInboundDataTransferSourceApps" {
  description = "Windows MAM data transfer locations"
  type        = string
  default     = null

  validation {
    condition     = var.allowedInboundDataTransferSourceApps == null ? true : try(alltrue([for value in split(",", var.allowedInboundDataTransferSourceApps) : contains(["none", "onedriveforbusiness"], lower(trimspace(value)))]), false)
    error_message = "allowedInboundDataTransferSourceApps must be one or more of the documented enum values, separated by commas."
  }
}

variable "allowedInboundDataTransferSources" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowedInboundDataTransferSources == null ? true : contains(["allApps", "none", "selectedApps"], var.allowedInboundDataTransferSources)
    error_message = "allowedInboundDataTransferSources must be one of the documented enum values."
  }
}

variable "allowedOutboundClipboardSharingLevel" {
  description = "Represents the level to which the device's clipboard may be shared between apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowedOutboundClipboardSharingLevel == null ? true : contains(["anyDestinationAnySource", "none"], var.allowedOutboundClipboardSharingLevel)
    error_message = "allowedOutboundClipboardSharingLevel must be one of the documented enum values."
  }
}

variable "allowedOutboundDataTransferDestinationApps" {
  description = "Windows MAM data transfer locations"
  type        = string
  default     = null

  validation {
    condition     = var.allowedOutboundDataTransferDestinationApps == null ? true : try(alltrue([for value in split(",", var.allowedOutboundDataTransferDestinationApps) : contains(["none", "onedriveforbusiness"], lower(trimspace(value)))]), false)
    error_message = "allowedOutboundDataTransferDestinationApps must be one or more of the documented enum values, separated by commas."
  }
}

variable "allowedOutboundDataTransferDestinations" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowedOutboundDataTransferDestinations == null ? true : contains(["allApps", "none", "selectedApps"], var.allowedOutboundDataTransferDestinations)
    error_message = "allowedOutboundDataTransferDestinations must be one of the documented enum values."
  }
}

variable "appActionIfUnableToAuthenticateUser" {
  description = "If set, it will specify what action to take in the case where the user is unable to checkin because their authentication token is invalid. This happens when the user is deleted or disabled in AAD. Some possible values are block or wipe. If this property is not set, no action will be taken. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = string
  default     = null

  validation {
    condition     = var.appActionIfUnableToAuthenticateUser == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.appActionIfUnableToAuthenticateUser)
    error_message = "appActionIfUnableToAuthenticateUser must be one of the documented enum values."
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

variable "createdDateTime" {
  description = "The date and time the policy was created."
  type        = string
  default     = null
}

variable "deployedAppCount" {
  description = "Indicates the total number of applications for which the current policy is deployed."
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

variable "displayName" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "isAssigned" {
  description = "When TRUE, indicates that the policy is deployed to some inclusion groups. When FALSE, indicates that the policy is not deployed to any inclusion groups. Default value is FALSE."
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Last time the policy was modified."
  type        = string
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

variable "maximumRequiredOsVersion" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "maximumWarningOsVersion" {
  description = "Versions bigger than the specified version will result in warning message on the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "maximumWipeOsVersion" {
  description = "Versions bigger than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumRequiredAppVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumRequiredOsVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumRequiredSdkVersion" {
  description = "Versions less than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumWarningAppVersion" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumWarningOsVersion" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumWipeAppVersion" {
  description = "Versions less than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumWipeOsVersion" {
  description = "Versions less than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimumWipeSdkVersion" {
  description = "Versions less than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsManagedAppProtection"
  nullable    = false
}

variable "periodOfflineBeforeAccessCheck" {
  description = "The period after which access is checked when the device is not connected to the internet. For example, PT5M indicates that the interval is 5 minutes in duration. A timespan value of PT0S indicates that access will be blocked immediately when the device is not connected to the internet."
  type        = string
  default     = null
}

variable "periodOfflineBeforeWipeIsEnforced" {
  description = "The amount of time an app is allowed to remain disconnected from the internet before all managed data it is wiped. For example, P5D indicates that the interval is 5 days in duration. A timespan value of PT0S indicates that managed data will never be wiped when the device is not connected to the internet."
  type        = string
  default     = null
}

variable "printBlocked" {
  description = "When TRUE, indicates that printing is blocked from managed apps. When FALSE, indicates that printing is allowed from managed apps. Default value is FALSE."
  type        = bool
  default     = null
}

variable "roleScopeTagIds" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
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
