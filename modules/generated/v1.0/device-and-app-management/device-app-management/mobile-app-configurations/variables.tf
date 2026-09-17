variable "assignments" {
  description = "The list of group assignemenets for app configration."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationAssignment")
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

variable "device_status_summary" {
  description = "App configuration device status summary."
  type        = any
  default     = null
}

variable "device_statuses" {
  description = "List of ManagedDeviceMobileAppConfigurationDeviceStatus."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationDeviceStatus")
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
  default     = "#microsoft.graph.managedDeviceMobileAppConfiguration"
  nullable    = false
}

variable "targeted_mobile_apps" {
  description = "the associated app."
  type        = list(string)
  default     = null
}

variable "user_status_summary" {
  description = "App configuration user status summary."
  type        = any
  default     = null
}

variable "user_statuses" {
  description = "List of ManagedDeviceMobileAppConfigurationUserStatus."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationUserStatus")
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
