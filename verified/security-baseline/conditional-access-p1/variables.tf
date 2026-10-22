variable "tier" {
  description = "Licence tier of the tenant: \"p1\" (Microsoft Entra ID P1) or \"p2\" (Microsoft Entra ID P2). Required, with no default and no automatic detection. Conditional Access needs P1, so \"free\" is rejected: use the free-tier singleton modules, which keep security defaults on."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["p1", "p2"], var.tier)
    error_message = "tier must be \"p1\" or \"p2\": Conditional Access requires Microsoft Entra ID P1. For a free tenant use the free-tier singleton modules (authorization-policy, admin-consent-workflow, authentication-methods with tier = \"free\"), which keep security defaults on."
  }
}

variable "break_glass_user_ids" {
  description = "Object IDs of the existing emergency access (break-glass) users, excluded from all four policies. At least one, each a lowercase GUID, and each must exist in the tenant. Required in report-only mode too, because enforce changes only the policy state. The module never creates or changes these accounts. Checked by the emergency access guard."
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
  description = "Object IDs of optional emergency access security groups. The emergency access guard validates them and snapshots their direct user members into the exclusions. Group IDs are never sent as excludeGroups, so a later membership change cannot exempt anyone from the policies without a plan. Lowercase GUIDs."
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

variable "enforce" {
  description = "false (default) creates the policies in report-only mode (enabledForReportingButNotEnforced). true sets them to enabled, and turns security defaults off first when they were on. Enforcing fails at plan time unless all four baseline policies already exist, so the first apply is always report-only. Turn it on only after reviewing the sign-in logs; the policies apply tenant-wide."
  type        = bool
  default     = false
  nullable    = false
}

variable "decommission" {
  description = "true deletes the four policies, then sets security defaults back to the value recorded before the module first applied (only when that value was true). Run this apply, with enforce = false, before terraform destroy: destroying the security defaults update sends no request. Needs no valid licence and no existing break-glass accounts."
  type        = bool
  default     = false
  nullable    = false
}

variable "display_name_prefix" {
  description = "Prefix of the four policy display names, which are also how the enforce check finds the existing baseline."
  type        = string
  default     = "Security baseline - "
  nullable    = false

  validation {
    condition     = length(var.display_name_prefix) <= 100
    error_message = "display_name_prefix must be at most 100 characters."
  }
}

variable "additional_admin_role_template_ids" {
  description = "Role template IDs added to the administrator MFA policy besides the 16 default built-in roles, which cannot be removed. Conditional Access applies to built-in roles only. GUIDs."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.additional_admin_role_template_ids : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id))])
    error_message = "additional_admin_role_template_ids must contain role template GUIDs."
  }
}

variable "exclude_directory_sync_accounts" {
  description = "Exclude the Directory Synchronization Accounts role from the all-users MFA policy, as Microsoft advises for hybrid tenants. Security defaults exclude this role too."
  type        = bool
  default     = true
  nullable    = false
}
