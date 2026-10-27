variable "compliance_grace_period_expiration_date_time" {
  description = "The DateTime when device compliance grace period expires"
  type        = string
  default     = null
}

variable "device_id" {
  description = "The Device Id that is being reported"
  type        = string
  default     = null
}

variable "device_model" {
  description = "The device model that is being reported"
  type        = string
  default     = null
}

variable "device_name" {
  description = "The Device Name that is being reported"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.advancedThreatProtectionOnboardingDeviceSettingState"
  nullable    = false
}

variable "platform_type" {
  description = "Device type."
  type        = string
  default     = null

  validation {
    condition     = var.platform_type == null ? true : contains(["desktop", "windowsRT", "winMO6", "nokia", "windowsPhone", "mac", "winCE", "winEmbedded", "iPhone", "iPad", "iPod", "android", "iSocConsumer", "unix", "macMDM", "holoLens", "surfaceHub", "androidForWork", "androidEnterprise", "windows10x", "androidnGMS", "chromeOS", "linux", "visionOS", "tvOS", "blackberry", "palm", "unknown", "cloudPC"], var.platform_type)
    error_message = "platform_type must be one of the documented enum values."
  }
}

variable "setting" {
  description = "The setting class name and property name."
  type        = string
  default     = null
}

variable "setting_name" {
  description = "The Setting Name that is being reported"
  type        = string
  default     = null
}

variable "state" {
  description = "The compliance state of the setting"
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "user_email" {
  description = "The User email address that is being reported"
  type        = string
  default     = null
}

variable "user_id" {
  description = "The user Id that is being reported"
  type        = string
  default     = null
}

variable "user_name" {
  description = "The User Name that is being reported"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "The User PrincipalName that is being reported"
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
