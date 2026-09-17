variable "applies_to" {
  description = "Nullable. Specifies a list of directoryObject resources that feature is enabled for."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "description" {
  description = "A description for this feature rollout policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for this  feature rollout policy."
  type        = string
  default     = null
}

variable "feature" {
  description = "Microsoft Graph feature property."
  type        = string
  default     = null

  validation {
    condition     = var.feature == null ? true : contains(["passthroughAuthentication", "seamlessSso", "passwordHashSync", "emailAsAlternateId", "unknownFutureValue", "certificateBasedAuthentication", "multiFactorAuthentication"], var.feature)
    error_message = "feature must be one of the documented enum values."
  }
}

variable "is_applied_to_organization" {
  description = "Indicates whether this feature rollout policy should be applied to the entire organization."
  type        = bool
  default     = null
}

variable "is_enabled" {
  description = "Indicates whether the feature rollout is enabled."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.featureRolloutPolicy"
  nullable    = false
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
