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
  description = "Enrollment state like Enrolled, Failed."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_state == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollment_state)
    error_message = "enrollment_state must be one of the documented enum values."
  }
}

variable "enrollment_type" {
  description = "Enrollment type."
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
