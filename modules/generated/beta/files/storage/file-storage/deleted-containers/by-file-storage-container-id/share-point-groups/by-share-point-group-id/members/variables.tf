variable "file_storage_container_id" {
  description = "The unique identifier of fileStorageContainer"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.file_storage_container_id)) > 0
    error_message = "file_storage_container_id must not be empty."
  }
}

variable "share_point_group_id" {
  description = "The unique identifier of sharePointGroup"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.share_point_group_id)) > 0
    error_message = "share_point_group_id must not be empty."
  }
}

variable "identity" {
  description = "The identity represented by the sharePointGroupMember object."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharePointGroupMember"
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
