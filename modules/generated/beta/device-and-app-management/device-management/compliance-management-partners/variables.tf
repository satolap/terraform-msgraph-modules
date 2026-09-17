variable "android_enrollment_assignments" {
  description = "User groups which enroll Android devices through partner."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.complianceManagementPartnerAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "android_onboarded" {
  description = "Partner onboarded for Android devices."
  type        = bool
  default     = null
}

variable "display_name" {
  description = "Partner display name"
  type        = string
  default     = null
}

variable "ios_enrollment_assignments" {
  description = "User groups which enroll ios devices through partner."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.complianceManagementPartnerAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "ios_onboarded" {
  description = "Partner onboarded for ios devices."
  type        = bool
  default     = null
}

variable "last_heartbeat_date_time" {
  description = "Timestamp of last heartbeat after admin onboarded to the compliance management partner"
  type        = string
  default     = null
}

variable "linux_enrollment_assignments" {
  description = "User groups which enroll Linux devices through partner."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.complianceManagementPartnerAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "linux_onboarded" {
  description = "Partner onboarded for Linux devices."
  type        = bool
  default     = null
}

variable "mac_os_enrollment_assignments" {
  description = "User groups which enroll Mac devices through partner."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.complianceManagementPartnerAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "mac_os_onboarded" {
  description = "Partner onboarded for Mac devices."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.complianceManagementPartner"
  nullable    = false
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
