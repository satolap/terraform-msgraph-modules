variable "complianceGracePeriodExpirationDateTime" {
  description = "The DateTime when device compliance grace period expires"
  type        = string
  default     = null
}

variable "deviceDisplayName" {
  description = "Device name of the DevicePolicyStatus."
  type        = string
  default     = null
}

variable "deviceId" {
  description = "The device id that is being reported."
  type        = string
  default     = null
}

variable "deviceModel" {
  description = "The device model that is being reported"
  type        = string
  default     = null
}

variable "installStatus" {
  description = "The installation status of the policy report."
  type        = string
  default     = null

  validation {
    condition     = var.installStatus == null ? true : contains(["updateScanFailed", "deviceOsHigherThanDesiredOsVersion", "updateError", "sharedDeviceUserLoggedInError", "notSupportedOperation", "installFailed", "installPhoneCallInProgress", "installInsufficientPower", "installInsufficientSpace", "installing", "downloadInsufficientNetwork", "downloadInsufficientPower", "downloadInsufficientSpace", "downloadRequiresComputer", "downloadFailed", "downloading", "timeout", "mdmClientCrashed", "success", "available", "idle", "unknown"], var.installStatus)
    error_message = "installStatus must be one of the documented enum values."
  }
}

variable "lastReportedDateTime" {
  description = "Last modified date time of the policy report."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.iosUpdateDeviceStatus"
  nullable    = false
}

variable "osVersion" {
  description = "The device version that is being reported."
  type        = string
  default     = null
}

variable "platform" {
  description = "Platform of the device that is being reported"
  type        = number
  default     = null
}

variable "status" {
  description = "Compliance status of the policy report."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "userId" {
  description = "The User id that is being reported."
  type        = string
  default     = null
}

variable "userName" {
  description = "The User Name that is being reported"
  type        = string
  default     = null
}

variable "userPrincipalName" {
  description = "UserPrincipalName."
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
