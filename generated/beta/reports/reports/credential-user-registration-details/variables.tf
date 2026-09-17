variable "auth_methods" {
  description = "Represents the authentication method that the user has registered. The possible values are: email, mobilePhone, officePhone,  securityQuestion (only used for self-service password reset), appNotification,  appCode, alternateMobilePhone (supported only in registration),  fido,  appPassword,  unknownFutureValue."
  type        = list(string)
  default     = null
}

variable "is_capable" {
  description = "Indicates whether the user is ready to perform self-service password reset or MFA."
  type        = bool
  default     = null
}

variable "is_enabled" {
  description = "Indicates whether the user enabled to perform self-service password reset."
  type        = bool
  default     = null
}

variable "is_mfa_registered" {
  description = "Indicates whether the user is registered for MFA."
  type        = bool
  default     = null
}

variable "is_registered" {
  description = "Indicates whether the user has registered any authentication methods for self-service password reset."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.credentialUserRegistrationDetails"
  nullable    = false
}

variable "user_display_name" {
  description = "Provides the user name of the corresponding user."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "Provides the user principal name of the corresponding user."
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
