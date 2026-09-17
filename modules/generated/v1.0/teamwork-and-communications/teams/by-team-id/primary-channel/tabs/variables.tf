variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "configuration" {
  description = "Container for custom settings applied to a tab. The tab is considered configured only once this property is set."
  type        = any
  default     = null
}

variable "display_name" {
  description = "Name of the tab."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsTab"
  nullable    = false
}

variable "teams_app" {
  description = "The application that is linked to the tab. This can't be changed after tab creation."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
