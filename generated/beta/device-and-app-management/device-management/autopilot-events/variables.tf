variable "account_setup_duration" {
  description = "Time spent in user ESP."
  type        = string
  default     = null
}

variable "account_setup_status" {
  description = "Deployment states for Autopilot devices"
  type        = string
  default     = null

  validation {
    condition     = var.account_setup_status == null ? true : contains(["unknown", "success", "inProgress", "failure", "successWithTimeout", "notAttempted", "disabled", "successOnRetry"], var.account_setup_status)
    error_message = "account_setup_status must be one of the documented enum values."
  }
}

variable "deployment_duration" {
  description = "Autopilot deployment duration including enrollment."
  type        = string
  default     = null
}

variable "deployment_end_date_time" {
  description = "Deployment end time."
  type        = string
  default     = null
}

variable "deployment_start_date_time" {
  description = "Deployment start time."
  type        = string
  default     = null
}

variable "deployment_state" {
  description = "Deployment states for Autopilot devices"
  type        = string
  default     = null

  validation {
    condition     = var.deployment_state == null ? true : contains(["unknown", "success", "inProgress", "failure", "successWithTimeout", "notAttempted", "disabled", "successOnRetry"], var.deployment_state)
    error_message = "deployment_state must be one of the documented enum values."
  }
}

variable "deployment_total_duration" {
  description = "Total deployment duration from enrollment to Desktop screen."
  type        = string
  default     = null
}

variable "device_id" {
  description = "Device id associated with the object"
  type        = string
  default     = null
}

variable "device_registered_date_time" {
  description = "Device registration date."
  type        = string
  default     = null
}

variable "device_serial_number" {
  description = "Device serial number."
  type        = string
  default     = null
}

variable "device_setup_duration" {
  description = "Time spent in device ESP."
  type        = string
  default     = null
}

variable "device_setup_status" {
  description = "Deployment states for Autopilot devices"
  type        = string
  default     = null

  validation {
    condition     = var.device_setup_status == null ? true : contains(["unknown", "success", "inProgress", "failure", "successWithTimeout", "notAttempted", "disabled", "successOnRetry"], var.device_setup_status)
    error_message = "device_setup_status must be one of the documented enum values."
  }
}

variable "enrollment_failure_details" {
  description = "Enrollment failure details."
  type        = string
  default     = null
}

variable "enrollment_start_date_time" {
  description = "Device enrollment start date."
  type        = string
  default     = null
}

variable "enrollment_state" {
  description = "Microsoft Graph enrollmentState property."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_state == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollment_state)
    error_message = "enrollment_state must be one of the documented enum values."
  }
}

variable "enrollment_type" {
  description = "Microsoft Graph enrollmentType property."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_type == null ? true : contains(["unknown", "azureADJoinedWithAutopilotProfile", "offlineDomainJoined", "azureADJoinedUsingDeviceAuthWithAutopilotProfile", "azureADJoinedUsingDeviceAuthWithoutAutopilotProfile", "azureADJoinedWithOfflineAutopilotProfile", "azureADJoinedWithWhiteGlove", "offlineDomainJoinedWithWhiteGlove", "offlineDomainJoinedWithOfflineAutopilotProfile"], var.enrollment_type)
    error_message = "enrollment_type must be one of the documented enum values."
  }
}

variable "event_date_time" {
  description = "Time when the event occurred ."
  type        = string
  default     = null
}

variable "managed_device_name" {
  description = "Managed device name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementAutopilotEvent"
  nullable    = false
}

variable "os_version" {
  description = "Device operating system version."
  type        = string
  default     = null
}

variable "user_id" {
  description = "UserId id associated with the object"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User principal name used to enroll the device."
  type        = string
  default     = null
}

variable "windows10_enrollment_completion_page_configuration_display_name" {
  description = "Enrollment Status Page profile name"
  type        = string
  default     = null
}

variable "windows10_enrollment_completion_page_configuration_id" {
  description = "Enrollment Status Page profile ID"
  type        = string
  default     = null
}

variable "windows_autopilot_deployment_profile_display_name" {
  description = "Autopilot profile name."
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
