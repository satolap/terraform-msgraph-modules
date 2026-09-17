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

variable "description" {
  description = "The description of the role."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the role."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.shiftsRoleDefinition"
  nullable    = false
}

variable "shifts_role_permissions" {
  description = "The collection of role permissions within the role."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.shiftsRolePermission")
    allowedResourceActions = optional(list(string))
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
