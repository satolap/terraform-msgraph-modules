variable "shared_drive_item_id" {
  description = "The unique identifier of sharedDriveItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.shared_drive_item_id)) > 0
    error_message = "shared_drive_item_id must not be empty."
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

variable "comment" {
  description = "Comment about the captured version."
  type        = string
  default     = null
}

variable "created_by" {
  description = "User who captured the version."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time when this version was created."
  type        = string
  default     = null
}

variable "fields" {
  description = "A collection of the fields and values for this version of the list item."
  type        = any
  default     = null
}

variable "items" {
  description = "Items within the document set that are captured as part of this version."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.documentSetVersionItem")
    itemId     = optional(string)
    title      = optional(string)
    versionId  = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.documentSetVersion"
  nullable    = false
}

variable "should_capture_minor_version" {
  description = "If true, minor versions of items are also captured; otherwise, only major versions are captured. The default value is false."
  type        = bool
  default     = null
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
