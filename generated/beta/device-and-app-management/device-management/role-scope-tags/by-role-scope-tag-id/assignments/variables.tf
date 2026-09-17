variable "role_scope_tag_id" {
  description = "The unique identifier of roleScopeTag"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.role_scope_tag_id)) > 0
    error_message = "role_scope_tag_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.roleScopeTagAutoAssignment"
  nullable    = false
}

variable "target" {
  description = "The auto-assignment target for the specific Role Scope Tag."
  type        = any
  default     = null
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
