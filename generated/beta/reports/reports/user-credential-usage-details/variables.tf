variable "auth_method" {
  description = "Microsoft Graph authMethod property."
  type        = string
  default     = null

  validation {
    condition     = var.auth_method == null ? true : contains(["email", "mobileSMS", "mobileCall", "officePhone", "securityQuestion", "appNotification", "appCode", "alternateMobileCall", "fido", "appPassword", "unknownFutureValue", "externalAuthMethod", "hardwareOneTimePasscode", "windowsHelloForBusiness", "microsoftAuthenticatorPasswordless", "temporaryAccessPass", "macOsSecureEnclaveKey", "passKeyDeviceBound", "passKeyDeviceBoundAuthenticator", "passKeyDeviceBoundWindowsHello", "softwareOneTimePasscode", "microsoftAuthenticatorPush", "mobilePhone", "sms", "alternateMobilePhone", "fido2SecurityKey", "oneTimePasscode", "passKeySynced", "qrCode"], var.auth_method)
    error_message = "auth_method must be one of the documented enum values."
  }
}

variable "event_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "failure_reason" {
  description = "Provides the failure reason for the corresponding reset or registration workflow."
  type        = string
  default     = null
}

variable "feature" {
  description = "Microsoft Graph feature property."
  type        = string
  default     = null

  validation {
    condition     = var.feature == null ? true : contains(["registration", "reset", "unknownFutureValue"], var.feature)
    error_message = "feature must be one of the documented enum values."
  }
}

variable "is_success" {
  description = "Indicates success or failure of the workflow."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userCredentialUsageDetails"
  nullable    = false
}

variable "user_display_name" {
  description = "User name of the user performing the reset or registration workflow."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User principal name of the user performing the reset or registration workflow."
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
