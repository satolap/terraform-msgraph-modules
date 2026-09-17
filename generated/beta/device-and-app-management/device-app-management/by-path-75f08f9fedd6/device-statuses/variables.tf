variable "windows_defender_application_control_supplemental_policy_id" {
  description = "The unique identifier of windowsDefenderApplicationControlSupplementalPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.windows_defender_application_control_supplemental_policy_id)) > 0
    error_message = "windows_defender_application_control_supplemental_policy_id must not be empty."
  }
}

variable "deployment_status" {
  description = "Enum values for the various WindowsDefenderApplicationControl supplemental policy deployment statuses."
  type        = string
  default     = null

  validation {
    condition     = var.deployment_status == null ? true : contains(["unknown", "success", "tokenError", "notAuthorizedByToken", "policyNotFound"], var.deployment_status)
    error_message = "deployment_status must be one of the documented enum values."
  }
}

variable "device_id" {
  description = "Device ID."
  type        = string
  default     = null
}

variable "device_name" {
  description = "Device name."
  type        = string
  default     = null
}

variable "last_sync_date_time" {
  description = "Last sync date time."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsDefenderApplicationControlSupplementalPolicyDeploymentStatus"
  nullable    = false
}

variable "os_description" {
  description = "Windows OS Version Description."
  type        = string
  default     = null
}

variable "os_version" {
  description = "Windows OS Version."
  type        = string
  default     = null
}

variable "policy" {
  description = "The navigation link to the WindowsDefenderApplicationControl supplemental policy."
  type        = any
  default     = null
}

variable "policy_version" {
  description = "Human readable version of the WindowsDefenderApplicationControl supplemental policy."
  type        = string
  default     = null
}

variable "user_name" {
  description = "The name of the user of this device."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User Principal Name."
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
