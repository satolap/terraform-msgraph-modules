variable "default_mfa_method" {
  description = "The method the user or admin selected as default for performing multifactor authentication for the user. The possible values are: none, mobilePhone, alternateMobilePhone, officePhone, microsoftAuthenticatorPush, softwareOneTimePasscode, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.default_mfa_method == null ? true : contains(["none", "mobilePhone", "alternateMobilePhone", "officePhone", "microsoftAuthenticatorPush", "softwareOneTimePasscode", "unknownFutureValue"], var.default_mfa_method)
    error_message = "default_mfa_method must be one of the documented enum values."
  }
}

variable "is_admin" {
  description = "Indicates whether the user has an admin role in the tenant. This value can be used to check the authentication methods that privileged accounts are registered for and capable of."
  type        = bool
  default     = null
}

variable "is_mfa_capable" {
  description = "Indicates whether the user has registered a strong authentication method for multifactor authentication. The method must be allowed by the authentication methods policy. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "is_mfa_registered" {
  description = "Indicates whether the user has registered a strong authentication method for multifactor authentication. The method may not necessarily be allowed by the authentication methods policy. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "is_passwordless_capable" {
  description = "Indicates whether the user has registered a passwordless strong authentication method (including FIDO2, Windows Hello for Business, and Microsoft Authenticator (Passwordless)) that is allowed by the authentication methods policy. Supports $filter (eq)."
  type        = bool
  default     = null
  sensitive   = true
}

variable "is_sspr_capable" {
  description = "Indicates whether the user has registered the required number of authentication methods for self-service password reset and the user is allowed to perform self-service password reset by policy. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "is_sspr_enabled" {
  description = "Indicates whether the user is allowed to perform self-service password reset by policy. The user may not necessarily have registered the required number of authentication methods for self-service password reset. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "is_sspr_registered" {
  description = "Indicates whether the user has registered the required number of authentication methods for self-service password reset. The user may not necessarily be allowed to perform self-service password reset by policy. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "is_system_preferred_authentication_method_enabled" {
  description = "Indicates whether system preferred authentication method is enabled. If enabled, the system dynamically determines the most secure authentication method among the methods registered by the user. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "last_updated_date_time" {
  description = "The date and time (UTC) when the report was last updated. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "methods_registered" {
  description = "Collection of authentication methods registered, such as mobilePhone, email, passKeyDeviceBound. Supports $filter (any with eq)."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userRegistrationDetails"
  nullable    = false
}

variable "system_preferred_authentication_methods" {
  description = "Collection of authentication methods that the system determined to be the most secure authentication methods among the registered methods for second factor authentication. The possible values are: push, oath, voiceMobile, voiceAlternateMobile, voiceOffice, sms, none, unknownFutureValue. Supports $filter (any with eq)."
  type        = list(string)
  default     = null
}

variable "user_display_name" {
  description = "The user display name, such as Adele Vance. Supports $filter (eq, startsWith) and $orderby."
  type        = string
  default     = null
}

variable "user_preferred_method_for_secondary_authentication" {
  description = "The method the user selected as the default second-factor for performing multifactor authentication. The possible values are: push, oath, voiceMobile, voiceAlternateMobile, voiceOffice, sms, none, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.user_preferred_method_for_secondary_authentication == null ? true : contains(["push", "oath", "voiceMobile", "voiceAlternateMobile", "voiceOffice", "sms", "none", "unknownFutureValue"], var.user_preferred_method_for_secondary_authentication)
    error_message = "user_preferred_method_for_secondary_authentication must be one of the documented enum values."
  }
}

variable "user_principal_name" {
  description = "The user principal name, such as AdeleV@contoso.com. Supports $filter (eq, startsWith) and $orderby."
  type        = string
  default     = null
}

variable "user_type" {
  description = "Identifies whether the user is a member or guest in the tenant. The possible values are: member, guest, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.user_type == null ? true : contains(["member", "guest", "unknownFutureValue"], var.user_type)
    error_message = "user_type must be one of the documented enum values."
  }
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
