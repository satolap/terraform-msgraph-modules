variable "compliance_grace_period_expiration_date_time" {
  description = "The DateTime when device compliance grace period expires"
  type        = string
  default     = null
}

variable "device_display_name" {
  description = "Device name of the DevicePolicyStatus."
  type        = string
  default     = null
}

variable "device_id" {
  description = "The device id that is being reported."
  type        = string
  default     = null
}

variable "device_model" {
  description = "The device model that is being reported"
  type        = string
  default     = null
}

variable "install_status" {
  description = "Microsoft Graph installStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.install_status == null ? true : contains(["updateScanFailed", "deviceOsHigherThanDesiredOsVersion", "updateError", "sharedDeviceUserLoggedInError", "notSupportedOperation", "installFailed", "installPhoneCallInProgress", "installInsufficientPower", "installInsufficientSpace", "installing", "downloadInsufficientNetwork", "downloadInsufficientPower", "downloadInsufficientSpace", "downloadRequiresComputer", "downloadFailed", "downloading", "timeout", "mdmClientCrashed", "success", "available", "idle", "unknown"], var.install_status)
    error_message = "install_status must be one of the documented enum values."
  }
}

variable "last_reported_date_time" {
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

variable "os_version" {
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
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "user_id" {
  description = "The User id that is being reported."
  type        = string
  default     = null
}

variable "user_name" {
  description = "The User Name that is being reported"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "UserPrincipalName."
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
