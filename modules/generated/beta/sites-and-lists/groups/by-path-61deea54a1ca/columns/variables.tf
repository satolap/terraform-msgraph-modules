variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "page_template_id" {
  description = "The unique identifier of pageTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.page_template_id)) > 0
    error_message = "page_template_id must not be empty."
  }
}

variable "horizontal_section_id" {
  description = "The unique identifier of horizontalSection"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.horizontal_section_id)) > 0
    error_message = "horizontal_section_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.horizontalSectionColumn"
  nullable    = false
}

variable "webparts" {
  description = "The collection of WebParts in this column."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.webPart")
  }))
  default = null
}

variable "width" {
  description = "Width of the column. A horizontal section is divided into 12 grids. A column should have a value of 1-12 to represent its range spans. For example, there can be two columns both have a width of 6 in a section."
  type        = number
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
