variable "assignments" {
  description = "The list of assignments for the device configuration profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceConfigurationAssignment")
    intent     = optional(any)
    source     = optional(string)
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

variable "device_management_applicability_rule_device_mode" {
  description = "The device mode applicability rule for this Policy."
  type        = any
  default     = null
}

variable "device_management_applicability_rule_os_edition" {
  description = "The OS edition applicability for this Policy."
  type        = any
  default     = null
}

variable "device_management_applicability_rule_os_version" {
  description = "The OS version applicability rule for this Policy."
  type        = any
  default     = null
}

variable "device_setting_state_summaries" {
  description = "Device Configuration Setting State Device Summary"
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
  description = "Device Configuration devices status overview"
  type        = any
  default     = null
}

variable "device_statuses" {
  description = "Device configuration installation status by device."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.deviceConfigurationDeviceStatus")
    complianceGracePeriodExpirationDateTime = optional(string)
    deviceDisplayName                       = optional(string)
    deviceModel                             = optional(string)
    lastReportedDateTime                    = optional(string)
    platform                                = optional(number)
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

variable "group_assignments" {
  description = "The list of group assignments for the device configuration profile."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.deviceConfigurationGroupAssignment")
    deviceConfiguration = optional(any)
    excludeGroup        = optional(bool)
    targetGroupId       = optional(string)
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceConfiguration"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "user_status_overview" {
  description = "Device Configuration users status overview"
  type        = any
  default     = null
}

variable "user_statuses" {
  description = "Device configuration installation status by user."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceConfigurationUserStatus")
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "supportsScopeTags"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
