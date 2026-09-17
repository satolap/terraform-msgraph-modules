variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.remoteTenantGroup"
  nullable    = false
}

variable "remote_group_display_name" {
  description = "Display name of the group in the remote tenant."
  type        = string
  default     = null
}

variable "remote_group_id" {
  description = "Unique identifier of the group in the remote tenant."
  type        = string
  default     = null
}

variable "remote_tenant_display_name" {
  description = "Display name of the remote tenant."
  type        = string
  default     = null
}

variable "remote_tenant_id" {
  description = "Unique identifier of the remote tenant."
  type        = string
  default     = null
}

variable "remote_tenant_primary_domain" {
  description = "Primary domain name of the remote tenant."
  type        = string
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
