variable "teams_app_id" {
  description = "The unique identifier of teamsApp"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.teams_app_id)) > 0
    error_message = "teams_app_id must not be empty."
  }
}

variable "teams_app_definition_id" {
  description = "The unique identifier of teamsAppDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.teams_app_definition_id)) > 0
    error_message = "teams_app_definition_id must not be empty."
  }
}

variable "content_source" {
  description = "The configuration for the source of the card content. Required."
  type        = any
  default     = null
}

variable "default_size" {
  description = "The size of the card. The possible values are: medium, large, unknownFutureValue. Required."
  type        = any
  default     = null

  validation {
    condition     = var.default_size == null ? true : contains(["medium", "large", "unknownFutureValue"], var.default_size)
    error_message = "default_size must be one of the documented enum values."
  }
}

variable "description" {
  description = "The description for the card. Required."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the card. Required."
  type        = string
  default     = null
}

variable "icon" {
  description = "Configuration for the display of the icon in the card picker. If neither this nor any of its properties (iconUrl and officeUIFabricIconName) are specified, the color icon of the app is used. Optional."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAppDashboardCardDefinition"
  nullable    = false
}

variable "picker_group_id" {
  description = "ID for the group in the card picker. Required."
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
