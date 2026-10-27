variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "managed_device_identifier" {
  description = "Device identifier created or collected by Intune."
  type        = string
  default     = null
}

variable "mobile_app_list" {
  description = "The list of payload intents and states for the tenant."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.mobileAppIntentAndStateDetail")
    applicationId   = optional(string)
    displayName     = optional(string)
    displayVersion  = optional(string)
    installState    = optional(string)
    mobileAppIntent = optional(string)
    supportedDeviceTypes = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.mobileAppSupportedDeviceType")
      maximumOperatingSystemVersion = optional(string)
      minimumOperatingSystemVersion = optional(string)
      type                          = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.mobile_app_list == null ? true : alltrue([alltrue([for input0 in var.mobile_app_list : (input0 == null ? true : alltrue([(input0["installState"] == null ? true : alltrue([(input0["installState"] == null ? true : contains(["notApplicable", "installed", "failed", "notInstalled", "uninstallFailed", "pendingInstall", "unknown"], input0["installState"]))])), (input0["mobileAppIntent"] == null ? true : alltrue([(input0["mobileAppIntent"] == null ? true : contains(["available", "notAvailable", "requiredInstall", "requiredUninstall", "requiredAndAvailableInstall", "availableInstallWithoutEnrollment", "exclude"], input0["mobileAppIntent"]))])), (input0["supportedDeviceTypes"] == null ? true : alltrue([alltrue([for input2 in input0["supportedDeviceTypes"] : (input2 == null ? true : alltrue([(input2["type"] == null ? true : alltrue([(input2["type"] == null ? true : contains(["desktop", "windowsRT", "winMO6", "nokia", "windowsPhone", "mac", "winCE", "winEmbedded", "iPhone", "iPad", "iPod", "android", "iSocConsumer", "unix", "macMDM", "holoLens", "surfaceHub", "androidForWork", "androidEnterprise", "windows10x", "androidnGMS", "chromeOS", "linux", "visionOS", "tvOS", "blackberry", "palm", "unknown", "cloudPC"], input2["type"]))]))]))])]))]))])]))
    error_message = "mobile_app_list: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileAppIntentAndState"
  nullable    = false
}

variable "user_id_2" {
  description = "Identifier for the user that tried to enroll the device."
  type        = string
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
