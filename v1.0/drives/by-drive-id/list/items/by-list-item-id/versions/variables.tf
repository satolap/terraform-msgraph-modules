variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "list_item_id" {
  description = "The unique identifier of listItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.list_item_id)) > 0
    error_message = "list_item_id must not be empty."
  }
}

variable "fields" {
  description = "A collection of the fields and values for this version of the list item."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.listItemVersion"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastModifiedBy", "lastModifiedDateTime", "publication"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
