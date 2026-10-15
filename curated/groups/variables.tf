variable "display_name" {
  description = "Display name of the group."
  type        = string

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 256
    error_message = "display_name must be between 1 and 256 characters."
  }
}

variable "mail_nickname" {
  description = "The mail alias for the group. May not contain spaces or these characters: @ () \\ [] \" ; : <> , SPACE."
  type        = string

  validation {
    condition     = can(regex("^[^@()\\\\\\[\\]\";:<>, ]+$", var.mail_nickname))
    error_message = "mail_nickname must not contain spaces or the characters @ () \\ [ ] \" ; : <> , ."
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
  description = "Visibility of a Microsoft 365 group: \"Public\", \"Private\", or \"HiddenMembership\". Ignored for security groups."
  type        = string
  default     = null

  validation {
    condition     = var.visibility == null ? true : contains(["Public", "Private", "HiddenMembership"], var.visibility)
    error_message = "visibility must be one of \"Public\", \"Private\", or \"HiddenMembership\"."
  }
}

variable "is_assignable_to_role" {
  description = "Whether Microsoft Entra roles can be assigned to the group. Can only be set at creation time and requires the group to be a security group."
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
