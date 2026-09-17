variable "team_template_id" {
  description = "The unique identifier of teamTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_id)) > 0
    error_message = "team_template_id must not be empty."
  }
}

variable "team_template_definition_id" {
  description = "The unique identifier of teamTemplateDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_definition_id)) > 0
    error_message = "team_template_definition_id must not be empty."
  }
}

variable "created_by" {
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "day_note_date" {
  description = "The date of the day note."
  type        = string
  default     = null
}

variable "draft_day_note" {
  description = "The draft version of this day note that is viewable by managers. Only contentType text is supported."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.dayNote"
  nullable    = false
}

variable "shared_day_note" {
  description = "The shared version of this day note that is viewable by both employees and managers. Only contentType text is supported."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
