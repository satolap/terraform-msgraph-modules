variable "unified_role_management_alert_id" {
  description = "The unique identifier of unifiedRoleManagementAlert"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.unified_role_management_alert_id)) > 0
    error_message = "unified_role_management_alert_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.invalidLicenseAlertIncident", "#microsoft.graph.noMfaOnRoleActivationAlertIncident", "#microsoft.graph.redundantAssignmentAlertIncident", "#microsoft.graph.rolesAssignedOutsidePrivilegedIdentityManagementAlertIncident", "#microsoft.graph.sequentialActivationRenewalsAlertIncident", "#microsoft.graph.staleSignInAlertIncident", "#microsoft.graph.tooManyGlobalAdminsAssignedToTenantAlertIncident"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
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
