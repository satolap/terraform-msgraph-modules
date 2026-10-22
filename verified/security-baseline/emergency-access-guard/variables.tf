variable "tier" {
  description = "Licence tier of the security baseline: \"free\" (security defaults stay on), \"p1\" (Microsoft Entra ID P1) or \"p2\" (Microsoft Entra ID P2). For p1 and p2 the plan fails unless the tenant has a usable subscription for the tier."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["free", "p1", "p2"], var.tier)
    error_message = "tier must be one of \"free\", \"p1\" or \"p2\"."
  }
}

variable "break_glass_user_ids" {
  description = "Object IDs of the existing emergency access (break-glass) users. At least one, each a lowercase GUID. The module reads these users and never changes them."
  type        = set(string)
  nullable    = false

  validation {
    condition     = length(var.break_glass_user_ids) > 0
    error_message = "break_glass_user_ids must list at least one emergency access user. A group alone is not enough, because its membership can change outside Terraform."
  }

  validation {
    condition     = length(var.break_glass_user_ids) <= 15
    error_message = "break_glass_user_ids lists ${length(var.break_glass_user_ids)} IDs; Microsoft Graph accepts at most 15 values in one in filter."
  }

  validation {
    condition     = alltrue([for id in var.break_glass_user_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "break_glass_user_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "break_glass_group_ids" {
  description = "Object IDs of existing emergency access security groups used only to discover and validate user members. Optional and in addition to break_glass_user_ids; no group ID is returned for Conditional Access exclusion."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = length(var.break_glass_group_ids) <= 15
    error_message = "break_glass_group_ids lists ${length(var.break_glass_group_ids)} IDs; Microsoft Graph accepts at most 15 values in one in filter."
  }

  validation {
    condition     = alltrue([for id in var.break_glass_group_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "break_glass_group_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "minimum_accounts" {
  description = "Minimum number of resolved emergency access users: the direct users plus the user members of the groups, without duplicates. Microsoft recommends two or more."
  type        = number
  default     = 2
  nullable    = false

  validation {
    condition     = var.minimum_accounts >= 1 && floor(var.minimum_accounts) == var.minimum_accounts
    error_message = "minimum_accounts must be a whole number of at least 1."
  }
}

variable "require_onmicrosoft_upn" {
  description = "Require each emergency access user's userPrincipalName to end in .onmicrosoft.com, so that sign-in does not depend on a custom domain or federation."
  type        = bool
  default     = true
  nullable    = false
}

variable "expected_group_member_ids" {
  description = "When set, the direct members of the break-glass groups, taken together, must equal this set of object IDs. Use a reviewed set to reject discovery-membership changes before any later exclusion-snapshot update."
  type        = set(string)
  default     = null

  validation {
    condition     = var.expected_group_member_ids == null ? true : alltrue([for id in var.expected_group_member_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "expected_group_member_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "require_role_assignable_group" {
  description = "Fail the plan when a break-glass group is not role-assignable. When false, such a discovery group adds a warning. This toggle never permits group IDs in Conditional Access exclusion outputs."
  type        = bool
  default     = false
  nullable    = false
}
