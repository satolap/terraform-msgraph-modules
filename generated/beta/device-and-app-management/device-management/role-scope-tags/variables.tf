variable "assignments" {
  description = "The list of assignments for this Role Scope Tag."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.roleScopeTagAutoAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "description" {
  description = "Description of the Role Scope Tag."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display or friendly name of the Role Scope Tag."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.roleScopeTag"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isBuiltIn"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
