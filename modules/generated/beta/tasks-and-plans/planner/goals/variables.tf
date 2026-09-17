variable "display_name" {
  description = "Required. The display name of the goal."
  type        = string
  default     = null
}

variable "finish_date" {
  description = "Nullable. The date on which the goal is scheduled to finish."
  type        = string
  default     = null
}

variable "notes" {
  description = "Nullable. The notes associated with the goal."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerGoal"
  nullable    = false
}

variable "plan_id" {
  description = "Required. The ID of the plan that contains the goal."
  type        = string
  default     = null
}

variable "priority" {
  description = "Optional. The relative priority of the goal. Valid values range from 0 to 10, inclusive. The default value is 5."
  type        = number
  default     = null
}

variable "start_date" {
  description = "Nullable. The date on which the goal is scheduled to start."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "onTrack", "behind", "atRisk", "closed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "tasks"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
