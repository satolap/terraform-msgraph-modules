variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "administrative_unit_id" {
  description = "Unique identifier for the administrative unit that the directory role is scoped to"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.scopedRoleMembership"
  nullable    = false
}

variable "role_id" {
  description = "Unique identifier for the directory role that the member is in."
  type        = string
  default     = null
}

variable "role_member_info" {
  description = "Microsoft Graph roleMemberInfo property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.identity")
    displayName = optional(string)
    id          = optional(string)
  })
  default = null
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
