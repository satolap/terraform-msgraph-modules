variable "notebook_id" {
  description = "The unique identifier of notebook"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.notebook_id)) > 0
    error_message = "notebook_id must not be empty."
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

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Microsoft Graph lastModifiedBy property."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
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

variable "self" {
  description = "Microsoft Graph self property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isDefault", "pages", "pagesUrl", "parentNotebook", "parentSectionGroup"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
