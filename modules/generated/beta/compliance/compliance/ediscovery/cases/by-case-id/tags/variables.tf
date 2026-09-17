variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "child_selectability" {
  description = "Indicates whether a single or multiple child tags can be associated with a document. The possible values are: One, Many.  This value controls whether the UX presents the tags as checkboxes or a radio button group."
  type        = any
  default     = null

  validation {
    condition     = var.child_selectability == null ? true : contains(["One", "Many"], var.child_selectability)
    error_message = "child_selectability must be one of the documented enum values."
  }
}

variable "child_tags" {
  description = "Returns the tags that are a child of a tag."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.ediscovery.tag")
    childSelectability   = optional(any)
    childTags            = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    parent               = optional(any)
  }))
  default = null
}

variable "created_by" {
  description = "The user who created the tag."
  type        = any
  default     = null
}

variable "description" {
  description = "The description for the tag."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the tag."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the tag was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ediscovery.tag"
  nullable    = false
}

variable "parent" {
  description = "Returns the parent tag of the specified tag."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
