variable "description" {
  description = "A short explanation of the policies that are enforced by authenticationContextClassReference. This value should be used to provide secondary text to describe the authentication context class reference when building user facing admin experiences. For example, selection UX."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A friendly name that identifies the authenticationContextClassReference object when building user-facing admin experiences. For example, a selection UX."
  type        = string
  default     = null
}

variable "is_available" {
  description = "Indicates whether the authenticationContextClassReference has been published by the security admin and is ready for use by apps. When it's set to false, it shouldn't be shown in selection UX used to tag resources with authentication context class values. It will still be shown in the Conditional Access policy authoring experience.  Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authenticationContextClassReference"
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
