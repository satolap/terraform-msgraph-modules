variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "description" {
  description = "The description of the tag as it appears to the user in Microsoft Teams. A teamworkTag can't have more than 200 teamworkTagMembers."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the tag as it appears to the user in Microsoft Teams."
  type        = string
  default     = null
}

variable "member_count" {
  description = "The number of users assigned to the tag."
  type        = number
  default     = null
}

variable "members" {
  description = "Users assigned to the tag."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.teamworkTagMember")
    displayName = optional(string)
    tenantId    = optional(string)
    userId      = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamworkTag"
  nullable    = false
}

variable "tag_type" {
  description = "The type of the tag. Default is standard."
  type        = any
  default     = null

  validation {
    condition     = var.tag_type == null ? true : contains(["standard", "unknownFutureValue"], var.tag_type)
    error_message = "tag_type must be one of the documented enum values."
  }
}

variable "team_id" {
  description = "ID of the team in which the tag is defined."
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
