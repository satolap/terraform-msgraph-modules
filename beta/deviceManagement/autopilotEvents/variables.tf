variable "accountSetupDuration" {
  description = "Time spent in user ESP."
  type        = string
  default     = null
}

variable "accountSetupStatus" {
  description = "Deployment states for Autopilot devices"
  type        = string
  default     = null

  validation {
    condition     = var.accountSetupStatus == null ? true : contains(["unknown", "success", "inProgress", "failure", "successWithTimeout", "notAttempted", "disabled", "successOnRetry"], var.accountSetupStatus)
    error_message = "accountSetupStatus must be one of the documented enum values."
  }
}

variable "deploymentDuration" {
  description = "Autopilot deployment duration including enrollment."
  type        = string
  default     = null
}

variable "deploymentEndDateTime" {
  description = "Deployment end time."
  type        = string
  default     = null
}

variable "deploymentStartDateTime" {
  description = "Deployment start time."
  type        = string
  default     = null
}

variable "deploymentState" {
  description = "Deployment states for Autopilot devices"
  type        = string
  default     = null

  validation {
    condition     = var.deploymentState == null ? true : contains(["unknown", "success", "inProgress", "failure", "successWithTimeout", "notAttempted", "disabled", "successOnRetry"], var.deploymentState)
    error_message = "deploymentState must be one of the documented enum values."
  }
}

variable "deploymentTotalDuration" {
  description = "Total deployment duration from enrollment to Desktop screen."
  type        = string
  default     = null
}

variable "deviceId" {
  description = "Device id associated with the object"
  type        = string
  default     = null
}

variable "deviceRegisteredDateTime" {
  description = "Device registration date."
  type        = string
  default     = null
}

variable "deviceSerialNumber" {
  description = "Device serial number."
  type        = string
  default     = null
}

variable "deviceSetupDuration" {
  description = "Time spent in device ESP."
  type        = string
  default     = null
}

variable "deviceSetupStatus" {
  description = "Deployment states for Autopilot devices"
  type        = string
  default     = null

  validation {
    condition     = var.deviceSetupStatus == null ? true : contains(["unknown", "success", "inProgress", "failure", "successWithTimeout", "notAttempted", "disabled", "successOnRetry"], var.deviceSetupStatus)
    error_message = "deviceSetupStatus must be one of the documented enum values."
  }
}

variable "enrollmentFailureDetails" {
  description = "Enrollment failure details."
  type        = string
  default     = null
}

variable "enrollmentStartDateTime" {
  description = "Device enrollment start date."
  type        = string
  default     = null
}

variable "enrollmentState" {
  description = "Enrollment state like Enrolled, Failed."
  type        = string
  default     = null

  validation {
    condition     = var.enrollmentState == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollmentState)
    error_message = "enrollmentState must be one of the documented enum values."
  }
}

variable "enrollmentType" {
  description = "Enrollment type."
  type        = string
  default     = null

  validation {
    condition     = var.enrollmentType == null ? true : contains(["unknown", "azureADJoinedWithAutopilotProfile", "offlineDomainJoined", "azureADJoinedUsingDeviceAuthWithAutopilotProfile", "azureADJoinedUsingDeviceAuthWithoutAutopilotProfile", "azureADJoinedWithOfflineAutopilotProfile", "azureADJoinedWithWhiteGlove", "offlineDomainJoinedWithWhiteGlove", "offlineDomainJoinedWithOfflineAutopilotProfile"], var.enrollmentType)
    error_message = "enrollmentType must be one of the documented enum values."
  }
}

variable "eventDateTime" {
  description = "Time when the event occurred ."
  type        = string
  default     = null
}

variable "managedDeviceName" {
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

variable "osVersion" {
  description = "Device operating system version."
  type        = string
  default     = null
}

variable "userId" {
  description = "UserId id associated with the object"
  type        = string
  default     = null
}

variable "userPrincipalName" {
  description = "User principal name used to enroll the device."
  type        = string
  default     = null
}

variable "windows10EnrollmentCompletionPageConfigurationDisplayName" {
  description = "Enrollment Status Page profile name"
  type        = string
  default     = null
}

variable "windows10EnrollmentCompletionPageConfigurationId" {
  description = "Enrollment Status Page profile ID"
  type        = string
  default     = null
}

variable "windowsAutopilotDeploymentProfileDisplayName" {
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
