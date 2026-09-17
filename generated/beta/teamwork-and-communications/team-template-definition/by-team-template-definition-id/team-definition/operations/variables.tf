variable "team_template_definition_id" {
  description = "The unique identifier of teamTemplateDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_definition_id)) > 0
    error_message = "team_template_definition_id must not be empty."
  }
}

variable "attempts_count" {
  description = "Number of times the operation was attempted before being marked successful or failed."
  type        = number
  default     = null
}

variable "created_date_time" {
  description = "Time when the operation was created."
  type        = string
  default     = null
}

variable "error" {
  description = "Any error that causes the async operation to fail."
  type        = any
  default     = null
}

variable "last_action_date_time" {
  description = "Time when the async operation was last updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAsyncOperation"
  nullable    = false
}

variable "operation_type" {
  description = "Microsoft Graph operationType property."
  type        = string
  default     = null

  validation {
    condition     = var.operation_type == null ? true : contains(["invalid", "cloneTeam", "archiveTeam", "unarchiveTeam", "createTeam", "unknownFutureValue", "teamifyGroup", "createChannel", "createChat", "archiveChannel", "unarchiveChannel"], var.operation_type)
    error_message = "operation_type must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["invalid", "notStarted", "inProgress", "succeeded", "failed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "target_resource_id" {
  description = "The ID of the object that's created or modified as result of this async operation, typically a team."
  type        = string
  default     = null
}

variable "target_resource_location" {
  description = "The location of the object that's created or modified as result of this async operation. This URL should be treated as an opaque value and not parsed into its component paths."
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
