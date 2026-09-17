variable "team_template_definition_id" {
  description = "The unique identifier of teamTemplateDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_definition_id)) > 0
    error_message = "team_template_definition_id must not be empty."
  }
}

variable "code" {
  description = "The code for the schedulingGroup to represent an external identifier. This field must be unique within the team in Microsoft Teams and uses an alphanumeric format, with a maximum of 100 characters."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The display name for the schedulingGroup. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.schedulingGroup"
  nullable    = false
}

variable "user_ids" {
  description = "The list of user IDs that are a member of the schedulingGroup. Required."
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "isActive", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
