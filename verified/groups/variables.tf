variable "display_name" {
  description = "Display name of the group."
  type        = string

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 256
    error_message = "display_name must be between 1 and 256 characters."
  }
}

variable "mail_nickname" {
  description = "The mail alias for the group, at most 64 characters. Microsoft Graph accepts only ASCII characters and none of these: @ ( ) \\ [ ] \" ; : < > , or a space. A period is allowed."
  type        = string

  # Microsoft Learn's group resource and create group pages allow ASCII 0 to 127
  # except the characters below. A period is not among them, and Exchange
  # aliases such as help.desk use one; only the update group page also lists it.
  validation {
    condition     = can(regex("^[^@()\\\\\\[\\]\";:<>, \\x{80}-\\x{10FFFF}]+$", var.mail_nickname))
    error_message = "mail_nickname must hold only ASCII characters and none of these: @ ( ) \\ [ ] \" ; : < > , or a space. A period is allowed."
  }

  validation {
    condition     = length(var.mail_nickname) <= 64
    error_message = "mail_nickname must be at most 64 characters long."
  }
}

variable "description" {
  description = "Description of the group."
  type        = string
  default     = null
}

variable "security_enabled" {
  description = "Whether the group is a security group."
  type        = bool
  default     = true
}

variable "mail_enabled" {
  description = "Whether the group is mail-enabled. Mail-enabled security groups and Microsoft 365 groups have additional constraints; a plain security group should leave this false."
  type        = bool
  default     = false
}

variable "group_types" {
  description = "The group type. Use [\"Unified\"] for a Microsoft 365 group, or [] for a security group. Dynamic membership adds \"DynamicMembership\"."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for t in var.group_types : contains(["Unified", "DynamicMembership"], t)])
    error_message = "group_types entries must be one of \"Unified\" or \"DynamicMembership\"."
  }
}

variable "visibility" {
  description = "Visibility of a Microsoft 365 group: \"Public\", \"Private\", or \"HiddenMembership\". Ignored for security groups. Microsoft Graph sets HiddenMembership only at creation, so changing to or from it replaces the group."
  type        = string
  default     = null

  validation {
    condition     = var.visibility == null ? true : contains(["Public", "Private", "HiddenMembership"], var.visibility)
    error_message = "visibility must be one of \"Public\", \"Private\", or \"HiddenMembership\"."
  }
}

variable "is_assignable_to_role" {
  description = "Whether Microsoft Entra roles can be assigned to the group. Microsoft Graph sets it only at creation, so changing it between true and false or null replaces the group. Requires the group to be a security group."
  type        = bool
  default     = null
}

variable "membership_rule" {
  description = "Dynamic membership rule. Required when group_types includes \"DynamicMembership\"."
  type        = string
  default     = null
}

variable "owner_ids" {
  description = "Directory object IDs (users or service principals) to set as owners of the group at creation."
  type        = list(string)
  default     = []
}

variable "member_ids" {
  description = "Directory object IDs (users, groups, or service principals) to set as members of the group at creation."
  type        = list(string)
  default     = []
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the groups endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that display_name must match, such as the pattern of a naming convention. When it is set and display_name does not match, the plan fails. Null, the default, accepts any display_name."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "mail_nickname_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that mail_nickname must match, such as the pattern of a naming convention. When it is set and mail_nickname does not match, the plan fails. Null, the default, accepts any mail_nickname."
  type        = string
  default     = null

  validation {
    condition     = var.mail_nickname_pattern == null || can(regexall(var.mail_nickname_pattern, ""))
    error_message = "mail_nickname_pattern must be a valid regular expression (RE2 syntax)."
  }
}
