variable "alert_definition" {
  description = "The definition of the alert that contains its description, impact, and measures to mitigate or prevent it. Supports $expand."
  type        = any
  default     = null
}

variable "alert_definition_id" {
  description = "The identifier of an alert definition. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "true if the alert is enabled. Setting it to false disables PIM scanning the tenant to identify instances that trigger the alert."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleManagementAlertConfiguration"
  nullable    = false
}

variable "scope_id" {
  description = "The identifier of the scope to which the alert is related. Only / is supported to represent the tenant scope. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "scope_type" {
  description = "The type of scope where the alert is created. DirectoryRole is the only currently supported scope type for Microsoft Entra roles."
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
