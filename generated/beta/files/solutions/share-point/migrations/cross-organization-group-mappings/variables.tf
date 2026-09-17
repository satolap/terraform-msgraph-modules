variable "deleted" {
  description = "Indicates that an identity mapping was deleted successfully."
  type        = any
  default     = null
}

variable "group_type" {
  description = "Microsoft Graph groupType property."
  type        = string
  default     = null

  validation {
    condition     = var.group_type == null ? true : contains(["none", "regularGroup", "m365Group", "unknownFutureValue"], var.group_type)
    error_message = "group_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharePointGroupIdentityMapping"
  nullable    = false
}

variable "source_group_identity" {
  description = "The identity information of the source group in the originating organization. Contains the ID of the source group."
  type        = any
  default     = null
}

variable "source_organization_id" {
  description = "The unique identifier of the source organization in the migration."
  type        = string
  default     = null
}

variable "target_group_identity" {
  description = "The identity information of the target group in the destination organization. Contains the ID of the target group."
  type        = any
  default     = null
}

variable "target_group_migration_data" {
  description = "Additional migration-specific data for the target group."
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
