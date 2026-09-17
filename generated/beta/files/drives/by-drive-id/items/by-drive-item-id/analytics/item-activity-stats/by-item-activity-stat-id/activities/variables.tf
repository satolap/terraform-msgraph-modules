variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "drive_item_id" {
  description = "The unique identifier of driveItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_item_id)) > 0
    error_message = "drive_item_id must not be empty."
  }
}

variable "item_activity_stat_id" {
  description = "The unique identifier of itemActivityStat"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.item_activity_stat_id)) > 0
    error_message = "item_activity_stat_id must not be empty."
  }
}

variable "access" {
  description = "An item was accessed."
  type        = any
  default     = null
}

variable "activity_date_time" {
  description = "Microsoft Graph activityDateTime property."
  type        = string
  default     = null
}

variable "drive_item" {
  description = "Exposes the driveItem that was the target of this activity."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.itemActivity"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["actor", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
