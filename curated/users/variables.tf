variable "user_principal_name" {
  description = "The user principal name (alias@domain), where domain is a verified domain in the tenant."
  type        = string

  validation {
    condition     = can(regex("^[^@]+@[^@]+$", var.user_principal_name))
    error_message = "user_principal_name must be in the form alias@domain."
  }
}

variable "display_name" {
  description = "The name to display in the address book for the user."
  type        = string

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 256
    error_message = "display_name must be between 1 and 256 characters."
  }
}

variable "mail_nickname" {
  description = "The mail alias for the user."
  type        = string
}

variable "password" {
  description = "The initial password for the user. Must satisfy the tenant's password policy."
  type        = string
  sensitive   = true
}

variable "force_change_password_next_sign_in" {
  description = "Whether the user must change their password on next sign-in."
  type        = bool
  default     = true
}

variable "account_enabled" {
  description = "Whether the account is enabled."
  type        = bool
  default     = true
}

variable "given_name" {
  description = "The given (first) name of the user."
  type        = string
  default     = null
}

variable "surname" {
  description = "The surname (last name) of the user."
  type        = string
  default     = null
}

variable "job_title" {
  description = "The user's job title."
  type        = string
  default     = null
}

variable "department" {
  description = "The department the user works in."
  type        = string
  default     = null
}

variable "usage_location" {
  description = "Two-letter ISO 3166 country code (e.g. \"US\"). Required before assigning some licenses."
  type        = string
  default     = null

  validation {
    condition     = var.usage_location == null ? true : can(regex("^[A-Z]{2}$", var.usage_location))
    error_message = "usage_location must be a two-letter uppercase ISO 3166 country code."
  }
}

variable "additional_properties" {
  description = "Other writable user properties (camelCase Graph keys), e.g. { companyName = \"Contoso\" }. Must be an object and cannot override the module's explicit properties. Mixed value types are supported."
  type        = any
  default     = {}

  validation {
    condition = try(length(setintersection(toset(keys(var.additional_properties)), toset([
      "accountEnabled", "displayName", "mailNickname", "userPrincipalName", "passwordProfile",
      "givenName", "surname", "jobTitle", "department", "usageLocation",
    ]))) == 0, false)
    error_message = "additional_properties must be an object without keys managed by the module's explicit variables."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the users endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
