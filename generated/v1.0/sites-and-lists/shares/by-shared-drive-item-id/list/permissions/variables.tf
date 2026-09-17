variable "shared_drive_item_id" {
  description = "The unique identifier of sharedDriveItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.shared_drive_item_id)) > 0
    error_message = "shared_drive_item_id must not be empty."
  }
}

variable "expiration_date_time" {
  description = "A format of yyyy-MM-ddTHH:mm:ssZ of DateTimeOffset indicates the expiration time of the permission. DateTime.MinValue indicates there's no expiration set for this permission. Optional."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.permission"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["grantedTo", "grantedToIdentities", "grantedToIdentitiesV2", "grantedToV2", "hasPassword", "id", "inheritedFrom", "invitation", "link", "roles", "shareId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
