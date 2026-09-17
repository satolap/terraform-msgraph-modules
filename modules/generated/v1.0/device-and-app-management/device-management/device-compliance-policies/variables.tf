variable "assignments" {
  description = "The collection of assignments for this compliance policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "DateTime the object was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Admin provided description of the Device Configuration."
  type        = string
  default     = null
}

variable "device_setting_state_summaries" {
  description = "Compliance Setting State Device Summary"
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.settingStateDeviceSummary")
    compliantDeviceCount     = optional(number)
    conflictDeviceCount      = optional(number)
    errorDeviceCount         = optional(number)
    instancePath             = optional(string)
    nonCompliantDeviceCount  = optional(number)
    notApplicableDeviceCount = optional(number)
    remediatedDeviceCount    = optional(number)
    settingName              = optional(string)
    unknownDeviceCount       = optional(number)
  }))
  default = null
}

variable "device_status_overview" {
  description = "Device compliance devices status overview"
  type        = any
  default     = null
}

variable "device_statuses" {
  description = "List of DeviceComplianceDeviceStatus."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.deviceComplianceDeviceStatus")
    complianceGracePeriodExpirationDateTime = optional(string)
    deviceDisplayName                       = optional(string)
    deviceModel                             = optional(string)
    lastReportedDateTime                    = optional(string)
    status                                  = optional(string)
    userName                                = optional(string)
    userPrincipalName                       = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "Admin provided name of the device configuration."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the device configuration."
  type        = number
  default     = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceCompliancePolicy"
  nullable    = false
}

variable "scheduled_actions_for_rule" {
  description = "The list of scheduled action per rule for this compliance policy. This is a required property when creating any individual per-platform compliance policies."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceComplianceScheduledActionForRule")
    ruleName   = optional(string)
    scheduledActionConfigurations = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.deviceComplianceActionItem")
      actionType                = optional(string)
      gracePeriodHours          = optional(number)
      notificationMessageCCList = optional(list(string))
      notificationTemplateId    = optional(string)
    })))
  }))
  default = null
}

variable "user_status_overview" {
  description = "Device compliance users status overview"
  type        = any
  default     = null
}

variable "user_statuses" {
  description = "List of DeviceComplianceUserStatus."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceComplianceUserStatus")
    devicesCount         = optional(number)
    lastReportedDateTime = optional(string)
    status               = optional(string)
    userDisplayName      = optional(string)
    userPrincipalName    = optional(string)
  }))
  default = null
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
