variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "teamwork_tag_id" {
  description = "The unique identifier of teamworkTag"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.teamwork_tag_id)) > 0
    error_message = "teamwork_tag_id must not be empty."
  }
}

variable "display_name" {
  description = "The member's display name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamworkTagMember"
  nullable    = false
}

variable "tenant_id" {
  description = "The ID of the tenant that the tag member is a part of."
  type        = string
  default     = null
}

variable "user_id" {
  description = "The user ID of the member."
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
