variable "tier" {
  description = "Licence tier the calling module needs: \"free\" (no premium plan), \"p1\" (Microsoft Entra ID P1) or \"p2\" (Microsoft Entra ID P2). There is no default and no automatic detection."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["free", "p1", "p2"], var.tier)
    error_message = "tier must be one of \"free\", \"p1\" or \"p2\"."
  }
}

variable "allowed_tiers" {
  description = "Tiers the calling module supports. The guard fails when tier is not one of them; a Conditional Access module passes [\"p1\", \"p2\"]."
  type        = set(string)
  default     = ["free", "p1", "p2"]
  nullable    = false

  validation {
    condition     = length(var.allowed_tiers) > 0 && alltrue([for tier in var.allowed_tiers : contains(["free", "p1", "p2"], tier)])
    error_message = "allowed_tiers must list one or more of \"free\", \"p1\" and \"p2\", and nothing else."
  }
}
