variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "section_group_id" {
  description = "The unique identifier of sectionGroup"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.section_group_id)) > 0
    error_message = "section_group_id must not be empty."
  }
}

variable "display_name" {
  description = "The name of the notebook."
  type        = string
  default     = null
}

variable "links" {
  description = "Links for opening the section. The oneNoteClientURL link opens the section in the OneNote native client if it's installed. The oneNoteWebURL link opens the section in OneNote on the web."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onenoteSection"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "isDefault", "lastModifiedBy", "lastModifiedDateTime", "pages", "pagesUrl", "parentNotebook", "parentSectionGroup", "self"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
