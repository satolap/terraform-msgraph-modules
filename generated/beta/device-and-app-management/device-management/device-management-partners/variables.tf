variable "display_name" {
  description = "Partner display name"
  type        = string
  default     = null
}

variable "groups_requiring_partner_enrollment" {
  description = "User groups that specifies whether enrollment is through partner."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementPartnerAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "is_configured" {
  description = "Whether device management partner is configured or not"
  type        = bool
  default     = null
}

variable "last_heartbeat_date_time" {
  description = "Timestamp of last heartbeat after admin enabled option Connect to Device management Partner"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementPartner"
  nullable    = false
}

variable "partner_app_type" {
  description = "Partner App Type."
  type        = string
  default     = null

  validation {
    condition     = var.partner_app_type == null ? true : contains(["unknown", "singleTenantApp", "multiTenantApp"], var.partner_app_type)
    error_message = "partner_app_type must be one of the documented enum values."
  }
}

variable "partner_state" {
  description = "Partner state of this tenant."
  type        = string
  default     = null

  validation {
    condition     = var.partner_state == null ? true : contains(["unknown", "unavailable", "enabled", "terminated", "rejected", "unresponsive"], var.partner_state)
    error_message = "partner_state must be one of the documented enum values."
  }
}

variable "single_tenant_app_id" {
  description = "Partner Single tenant App id"
  type        = string
  default     = null
}

variable "when_partner_devices_will_be_marked_as_non_compliant_date_time" {
  description = "DateTime in UTC when PartnerDevices will be marked as NonCompliant"
  type        = string
  default     = null
}

variable "when_partner_devices_will_be_removed_date_time" {
  description = "DateTime in UTC when PartnerDevices will be removed"
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
