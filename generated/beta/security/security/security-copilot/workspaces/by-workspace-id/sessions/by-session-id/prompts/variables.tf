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

variable "content" {
  description = "Input content to the prompt."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Created time."
  type        = string
  default     = null
}

variable "evaluations" {
  description = "Collection of evaluations"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.securityCopilot.evaluation")
    completedDateTime    = optional(string)
    createdDateTime      = optional(string)
    executionCount       = optional(number)
    isCancelled          = optional(bool)
    lastModifiedDateTime = optional(string)
    result               = optional(any)
    runStartDateTime     = optional(string)
    state                = optional(string)
  }))
  default = null
}

variable "inputs" {
  description = "Not implemented."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Last modified time."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.securityCopilot.prompt"
  nullable    = false
}

variable "skill_input_descriptors" {
  description = "Skill Input descriptor."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.security.securityCopilot.skillInputDescriptor")
    defaultValue     = optional(string)
    description      = optional(string)
    isRequired       = optional(bool)
    name             = optional(string)
    placeholderValue = optional(string)
    type = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.securityCopilot.skillTypeDescriptor")
      name       = optional(string)
    }))
  }))
  default = null
}

variable "skill_name" {
  description = "Skill name."
  type        = string
  default     = null
}

variable "type" {
  description = "Microsoft Graph type property."
  type        = string
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["unknown", "context", "prompt", "skill", "feedback", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
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
