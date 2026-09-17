variable "alert_data" {
  description = "Microsoft Graph alertData property."
  type        = any
  default     = null
}

variable "alert_data_reference_strings" {
  description = "Microsoft Graph alertDataReferenceStrings property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.managedTenants.alertDataReferenceString")
    displayName = optional(string)
  }))
  default = null
}

variable "alert_logs" {
  description = "Microsoft Graph alertLogs property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.managedTenants.managedTenantAlertLog")
    alert              = optional(any)
    content            = optional(any)
    createdByUserId    = optional(string)
    createdDateTime    = optional(string)
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
  }))
  default = null
}

variable "alert_rule" {
  description = "Microsoft Graph alertRule property."
  type        = any
  default     = null
}

variable "alert_rule_display_name" {
  description = "Microsoft Graph alertRuleDisplayName property."
  type        = string
  default     = null
}

variable "api_notifications" {
  description = "Microsoft Graph apiNotifications property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.managedTenants.managedTenantApiNotification")
    alert              = optional(any)
    createdByUserId    = optional(string)
    createdDateTime    = optional(string)
    isAcknowledged     = optional(bool)
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    message            = optional(string)
    title              = optional(string)
    userId             = optional(string)
  }))
  default = null
}

variable "assigned_to_user_id" {
  description = "Microsoft Graph assignedToUserId property."
  type        = string
  default     = null
}

variable "correlation_count" {
  description = "Microsoft Graph correlationCount property."
  type        = number
  default     = null
}

variable "correlation_id" {
  description = "Microsoft Graph correlationId property."
  type        = string
  default     = null
}

variable "created_by_user_id" {
  description = "Microsoft Graph createdByUserId property."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "email_notifications" {
  description = "Microsoft Graph emailNotifications property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.managedTenants.managedTenantEmailNotification")
    alert           = optional(any)
    createdByUserId = optional(string)
    createdDateTime = optional(string)
    emailAddresses = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.managedTenants.email")
      emailAddress = optional(string)
    })))
    emailBody          = optional(string)
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    subject            = optional(string)
  }))
  default = null
}

variable "last_action_by_user_id" {
  description = "Microsoft Graph lastActionByUserId property."
  type        = string
  default     = null
}

variable "last_action_date_time" {
  description = "Microsoft Graph lastActionDateTime property."
  type        = string
  default     = null
}

variable "message" {
  description = "Microsoft Graph message property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managedTenantAlert"
  nullable    = false
}

variable "severity" {
  description = "Microsoft Graph severity property."
  type        = any
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["unknown", "informational", "low", "medium", "high", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "newAlert", "inProgress", "resolved", "dismissed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "tenant_id" {
  description = "Microsoft Graph tenantId property."
  type        = string
  default     = null
}

variable "title" {
  description = "Microsoft Graph title property."
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
