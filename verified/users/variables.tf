variable "userPrincipalName" {
  description = "The user principal name (alias@domain), where domain is a verified domain in the tenant."
  type        = string

  validation {
    condition     = can(regex("^[^@]+@[^@]+$", var.userPrincipalName))
    error_message = "userPrincipalName must be in the form alias@domain."
  }
}

variable "displayName" {
  description = "The name to display in the address book for the user."
  type        = string

  validation {
    condition     = length(var.displayName) > 0 && length(var.displayName) <= 256
    error_message = "displayName must be between 1 and 256 characters."
  }
}

variable "mailNickname" {
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

variable "accountEnabled" {
  description = "Whether the account is enabled."
  type        = bool
  default     = true
}

variable "givenName" {
  description = "The given (first) name of the user."
  type        = string
  default     = null
}

variable "surname" {
  description = "The surname (last name) of the user."
  type        = string
  default     = null
}

variable "jobTitle" {
  description = "The user's job title."
  type        = string
  default     = null
}

variable "department" {
  description = "The department the user works in."
  type        = string
  default     = null
}

variable "usageLocation" {
  description = "Two-letter ISO 3166 country code (e.g. \"US\"). Required before assigning some licenses."
  type        = string
  default     = null

  validation {
    condition     = var.usageLocation == null ? true : can(regex("^[A-Z]{2}$", var.usageLocation))
    error_message = "usageLocation must be a two-letter uppercase ISO 3166 country code."
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

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "mail_nickname_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that mailNickname must match, such as the pattern of a naming convention. When it is set and mailNickname does not match, the plan fails. Null, the default, accepts any mailNickname."
  type        = string
  default     = null

  validation {
    condition     = var.mail_nickname_pattern == null || can(regexall(var.mail_nickname_pattern, ""))
    error_message = "mail_nickname_pattern must be a valid regular expression (RE2 syntax)."
  }
}
