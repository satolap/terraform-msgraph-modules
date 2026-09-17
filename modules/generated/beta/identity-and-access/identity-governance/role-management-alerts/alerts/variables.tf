variable "alert_configuration" {
  description = "The configuration of the alert in PIM for Microsoft Entra roles. Alert configurations are pre-defined and cannot be created or deleted, but some configurations can be modified. Supports $filter for the isEnabled property and $expand."
  type        = any
  default     = null
}

variable "alert_definition" {
  description = "Contains the description, impact, and measures to mitigate or prevent the security alert from being triggered in your tenant. Supports $expand."
  type        = any
  default     = null
}

variable "alert_definition_id" {
  description = "The identifier of an alert definition. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "alert_incidents" {
  description = "Represents the incidents of this type of alert that have been triggered in Privileged Identity Management (PIM) for Microsoft Entra roles in the tenant. Supports $expand."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.unifiedRoleManagementAlertIncident")
  }))
  default = null
}

variable "incident_count" {
  description = "The number of incidents triggered in the tenant and relating to the alert. Can only be a positive integer."
  type        = number
  default     = null
}

variable "is_active" {
  description = "false by default. true if the alert is active."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date time when the alert configuration was updated or new incidents generated."
  type        = string
  default     = null
}

variable "last_scanned_date_time" {
  description = "The date time when the tenant was last scanned for incidents that trigger this alert."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleManagementAlert"
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
