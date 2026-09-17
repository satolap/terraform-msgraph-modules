variable "description" {
  description = "The description of the alert."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The friendly display name that renders in Privileged Identity Management (PIM) alerts in the Microsoft Entra admin center."
  type        = string
  default     = null
}

variable "how_to_prevent" {
  description = "Long-form text that indicates the ways to prevent the alert from being triggered in your tenant."
  type        = string
  default     = null
}

variable "is_configurable" {
  description = "true if the alert configuration can be customized in the tenant, and false otherwise. For example, the number and percentage thresholds of the 'There are too many global administrators' alert can be configured by users, while the 'This organization doesn't have Microsoft Entra ID P2' can't be configured, because the criteria are restricted."
  type        = bool
  default     = null
}

variable "is_remediatable" {
  description = "true if the alert can be remediated, and false otherwise."
  type        = bool
  default     = null
}

variable "mitigation_steps" {
  description = "The methods to mitigate the alert when it's triggered in the tenant. For example, to mitigate the 'There are too many global administrators', you could remove redundant privileged role assignments."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleManagementAlertDefinition"
  nullable    = false
}

variable "scope_id" {
  description = "The identifier of the scope where the alert is related. / is the only supported one for the tenant. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "scope_type" {
  description = "The type of scope where the alert is created. DirectoryRole is the only currently supported scope type for Microsoft Entra roles."
  type        = string
  default     = null
}

variable "security_impact" {
  description = "Security impact of the alert. For example, it could be information leaks or unauthorized access."
  type        = string
  default     = null
}

variable "severity_level" {
  description = "Severity level of the alert. The possible values are: unknown, informational, low, medium, high, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.severity_level == null ? true : contains(["unknown", "informational", "low", "medium", "high", "unknownFutureValue"], var.severity_level)
    error_message = "severity_level must be one of the documented enum values."
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
