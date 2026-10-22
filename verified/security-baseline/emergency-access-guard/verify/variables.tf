variable "tier" {
  description = "Licence tier of the security baseline: \"free\", \"p1\" or \"p2\". The free tier keeps security defaults on, reads no policies and accepts no baseline_policy_ids."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["free", "p1", "p2"], var.tier)
    error_message = "tier must be one of \"free\", \"p1\" or \"p2\"."
  }
}

variable "exclusions" {
  description = "The emergency access guard's conditional_access_users_exclusions output: { excludeUsers, excludeGroups }."
  type = object({
    excludeUsers  = set(string)
    excludeGroups = set(string)
  })
  nullable = false

  validation {
    condition     = length(var.exclusions.excludeUsers) > 0
    error_message = "exclusions.excludeUsers must list at least one emergency access user. Pass the emergency access guard's conditional_access_users_exclusions output."
  }

  validation {
    condition     = alltrue([for id in setunion(var.exclusions.excludeUsers, var.exclusions.excludeGroups) : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "exclusions must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "baseline_policy_ids" {
  description = "IDs of the Conditional Access baseline policies, for example values(module.conditional_access_baseline.policy_ids). Each one must exclude every emergency access user and group, whatever its state. Non-free baseline scope requires a nonempty set. When this root updates policies, the verifier module must explicitly depend on those policy writers."
  type        = set(string)
  nullable    = false

  validation {
    condition     = alltrue([for id in var.baseline_policy_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "baseline_policy_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "scope" {
  description = "\"baseline\" checks the baseline policies. \"tenant\" also checks every policy in the tenant whose state is enabled, including Microsoft-managed policies."
  type        = string
  default     = "baseline"
  nullable    = false

  validation {
    condition     = contains(["baseline", "tenant"], var.scope)
    error_message = "scope must be \"baseline\" or \"tenant\"."
  }
}
