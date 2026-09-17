variable "workspace_id" {
  description = "The unique identifier of workspace"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workspace_id)) > 0
    error_message = "workspace_id must not be empty."
  }
}

variable "created_date_time" {
  description = "Created time of the session (UTC)."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the session."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Last modified time of the session (UTC). Updated when displayName changes."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.securityCopilot.session"
  nullable    = false
}

variable "prompts" {
  description = "The collection of prompts in the session."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.security.securityCopilot.prompt")
    content         = optional(string)
    createdDateTime = optional(string)
    evaluations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.security.securityCopilot.evaluation")
      completedDateTime    = optional(string)
      createdDateTime      = optional(string)
      executionCount       = optional(number)
      isCancelled          = optional(bool)
      lastModifiedDateTime = optional(string)
      result               = optional(any)
      runStartDateTime     = optional(string)
      state                = optional(string)
    })))
    inputs               = optional(any)
    lastModifiedDateTime = optional(string)
    skillInputDescriptors = optional(list(object({
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
    })))
    skillName = optional(string)
    type      = optional(string)
  }))
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
