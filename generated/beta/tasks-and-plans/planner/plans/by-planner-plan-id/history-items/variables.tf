variable "planner_plan_id" {
  description = "The unique identifier of plannerPlan"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_plan_id)) > 0
    error_message = "planner_plan_id must not be empty."
  }
}

variable "actor" {
  description = "The identity of the user or application that performed the change."
  type        = any
  default     = null
}

variable "entity_id" {
  description = "The ID of the entity that was changed."
  type        = string
  default     = null
}

variable "entity_type" {
  description = "Microsoft Graph entityType property."
  type        = string
  default     = null

  validation {
    condition     = var.entity_type == null ? true : contains(["task", "unknownFutureValue"], var.entity_type)
    error_message = "entity_type must be one of the documented enum values."
  }
}

variable "event_type" {
  description = "Microsoft Graph eventType property."
  type        = string
  default     = null

  validation {
    condition     = var.event_type == null ? true : contains(["created", "updated", "deleted", "undeleted", "moved", "unknownFutureValue"], var.event_type)
    error_message = "event_type must be one of the documented enum values."
  }
}

variable "occurred_date_time" {
  description = "The date and time when the change occurred. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2024, is 2024-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerHistoryItem"
  nullable    = false
}

variable "plan_id" {
  description = "The ID of the plan that contains the changed entity."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
