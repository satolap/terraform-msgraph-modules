variable "team_template_definition_id" {
  description = "The unique identifier of teamTemplateDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_definition_id)) > 0
    error_message = "team_template_definition_id must not be empty."
  }
}

variable "channel_id" {
  description = "The unique identifier of channel"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.channel_id)) > 0
    error_message = "channel_id must not be empty."
  }
}

variable "allowed_members" {
  description = "A collection of team members who have access to the shared channel."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.conversationMember")
    displayName                 = optional(string)
    roles                       = optional(list(string))
    visibleHistoryStartDateTime = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "The name of the team."
  type        = string
  default     = null
}

variable "is_host_team" {
  description = "Indicates whether the team is the host of the channel."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharedWithChannelTeamInfo"
  nullable    = false
}

variable "team" {
  description = "Microsoft Graph team property."
  type        = any
  default     = null
}

variable "tenant_id" {
  description = "The ID of the Microsoft Entra tenant."
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
