variable "deleted" {
  description = "Indicates that an identity mapping was deleted successfully."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharePointUserIdentityMapping"
  nullable    = false
}

variable "source_organization_id" {
  description = "The unique identifier of the source organization in the migration."
  type        = string
  default     = null
}

variable "source_user_identity" {
  description = "The identity information of the source user in the originating organization. Contains the source user's principal name."
  type        = any
  default     = null
}

variable "target_user_identity" {
  description = "The identity information of the target user in the destination organization. Contains the target user's principal name."
  type        = any
  default     = null
}

variable "target_user_migration_data" {
  description = "Additional migration-specific data for the target user. Contains the email address for the user in the destination organization."
  type        = any
  default     = null
}

variable "user_type" {
  description = "Microsoft Graph userType property."
  type        = string
  default     = null

  validation {
    condition     = var.user_type == null ? true : contains(["none", "regularUser", "adminUser", "guestUser", "unknownFutureValue"], var.user_type)
    error_message = "user_type must be one of the documented enum values."
  }
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
