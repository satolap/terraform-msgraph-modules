variable "shared_drive_item_id" {
  description = "The unique identifier of sharedDriveItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.shared_drive_item_id)) > 0
    error_message = "shared_drive_item_id must not be empty."
  }
}

variable "content_type_id" {
  description = "The unique identifier of contentType"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.content_type_id)) > 0
    error_message = "content_type_id must not be empty."
  }
}

variable "name" {
  description = "The name of the column  in this content type."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.columnLink"
  nullable    = false
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
