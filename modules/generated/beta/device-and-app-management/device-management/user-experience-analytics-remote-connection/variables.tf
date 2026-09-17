variable "cloud_pc_failure_percentage" {
  description = "The sign in failure percentage of Cloud PC Device. Valid values 0 to 100"
  type        = any
  default     = null
}

variable "cloud_pc_round_trip_time" {
  description = "The round tip time of Cloud PC Device. Valid values 0 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "cloud_pc_sign_in_time" {
  description = "The sign in time of Cloud PC Device. Valid values 0 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "core_boot_time" {
  description = "The core boot time of Cloud PC Device. Valid values 0 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "core_sign_in_time" {
  description = "The core sign in time of Cloud PC Device. Valid values 0 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "device_count" {
  description = "The count of remote connection. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "device_id" {
  description = "The id of the device."
  type        = string
  default     = null
}

variable "device_name" {
  description = "The name of the device."
  type        = string
  default     = null
}

variable "manufacturer" {
  description = "The user experience analytics manufacturer."
  type        = string
  default     = null
}

variable "model" {
  description = "The user experience analytics device model."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsRemoteConnection"
  nullable    = false
}

variable "remote_sign_in_time" {
  description = "The remote sign in time of Cloud PC Device. Valid values 0 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "user_principal_name" {
  description = "The user experience analytics userPrincipalName."
  type        = string
  default     = null
}

variable "virtual_network" {
  description = "The user experience analytics virtual network."
  type        = string
  default     = null
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
