variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "container" {
  description = "Identifies the container of the plan. Specify only the url, the containerId and type, or all properties. After it's set, this property can’t be updated. Required."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerPlan"
  nullable    = false
}

variable "owner" {
  description = "Use the container property instead. ID of the group that owns the plan. After it's set, this property can’t be updated. This property won't return a valid group ID if the container of the plan isn't a group."
  type        = string
  default     = null
}

variable "title" {
  description = "Required. Title of the plan."
  type        = string
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["buckets", "createdBy", "createdDateTime", "details", "id", "tasks"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
