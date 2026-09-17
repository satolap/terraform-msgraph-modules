variable "workspace_id" {
  description = "The unique identifier of workspace"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workspace_id)) > 0
    error_message = "workspace_id must not be empty."
  }
}

variable "session_id" {
  description = "The unique identifier of session"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.session_id)) > 0
    error_message = "session_id must not be empty."
  }
}

variable "prompt_id" {
  description = "The unique identifier of prompt"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.prompt_id)) > 0
    error_message = "prompt_id must not be empty."
  }
}

variable "completed_date_time" {
  description = "Evaluation completion time."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Evaluation created time."
  type        = string
  default     = null
}

variable "execution_count" {
  description = "Evaluation execution count."
  type        = number
  default     = null
}

variable "is_cancelled" {
  description = "Evaluation cancellation status."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Evaluation modified time."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.securityCopilot.evaluation"
  nullable    = false
}

variable "result" {
  description = "Evaluation results collection."
  type        = any
  default     = null
}

variable "run_start_date_time" {
  description = "Evaluation Run start time."
  type        = string
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "created", "running", "completed", "cancelled", "pending", "deferred", "waitingForInput", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
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
