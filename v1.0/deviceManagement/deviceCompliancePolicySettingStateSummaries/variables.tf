variable "compliantDeviceCount" {
  description = "Number of compliant devices"
  type        = number
  default     = null
}

variable "conflictDeviceCount" {
  description = "Number of conflict devices"
  type        = number
  default     = null
}

variable "deviceComplianceSettingStates" {
  description = "Microsoft Graph deviceComplianceSettingStates property."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.deviceComplianceSettingState")
    complianceGracePeriodExpirationDateTime = optional(string)
    deviceId                                = optional(string)
    deviceModel                             = optional(string)
    deviceName                              = optional(string)
    setting                                 = optional(string)
    settingName                             = optional(string)
    state                                   = optional(string)
    userEmail                               = optional(string)
    userId                                  = optional(string)
    userName                                = optional(string)
    userPrincipalName                       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.deviceComplianceSettingStates == null ? true : alltrue([alltrue([for input0 in var.deviceComplianceSettingStates : (input0 == null ? true : alltrue([(input0["state"] == null ? true : alltrue([(input0["state"] == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], input0["state"]))]))]))])]))
    error_message = "deviceComplianceSettingStates: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "errorDeviceCount" {
  description = "Number of error devices"
  type        = number
  default     = null
}

variable "nonCompliantDeviceCount" {
  description = "Number of NonCompliant devices"
  type        = number
  default     = null
}

variable "notApplicableDeviceCount" {
  description = "Number of not applicable devices"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceCompliancePolicySettingStateSummary"
  nullable    = false
}

variable "platformType" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platformType == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "all"], var.platformType)
    error_message = "platformType must be one of the documented enum values."
  }
}

variable "remediatedDeviceCount" {
  description = "Number of remediated devices"
  type        = number
  default     = null
}

variable "setting" {
  description = "The setting class name and property name."
  type        = string
  default     = null
}

variable "settingName" {
  description = "Name of the setting."
  type        = string
  default     = null
}

variable "unknownDeviceCount" {
  description = "Number of unknown devices"
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
