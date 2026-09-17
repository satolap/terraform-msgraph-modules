variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "planner_plan_id" {
  description = "The unique identifier of plannerPlan"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_plan_id)) > 0
    error_message = "planner_plan_id must not be empty."
  }
}

variable "creation_source" {
  description = "Contains information about the origin of the bucket."
  type        = any
  default     = null
}

variable "name" {
  description = "Name of the bucket."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerBucket"
  nullable    = false
}

variable "order_hint" {
  description = "Hint used to order items of this type in a list view. For details about the supported format, see Using order hints in Planner."
  type        = string
  default     = null
}

variable "plan_id" {
  description = "Plan ID to which the bucket belongs."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["archivalInfo", "id", "isArchived", "tasks"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
