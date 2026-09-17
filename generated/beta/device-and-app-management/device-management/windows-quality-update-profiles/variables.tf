variable "assignments" {
  description = "The list of group assignments of the profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsQualityUpdateProfileAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date time that the profile was created."
  type        = string
  default     = null
}

variable "deployable_content_display_name" {
  description = "Friendly display name of the quality update profile deployable content"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the profile which is specified by the user."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the profile."
  type        = string
  default     = null
}

variable "expedited_update_settings" {
  description = "Expedited update settings."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date time that the profile was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsQualityUpdateProfile"
  nullable    = false
}

variable "release_date_display_name" {
  description = "Friendly release date to display for a Quality Update release"
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Quality Update entity."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
