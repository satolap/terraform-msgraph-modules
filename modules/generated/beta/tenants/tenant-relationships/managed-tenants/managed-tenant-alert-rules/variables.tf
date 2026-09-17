variable "alert_display_name" {
  description = "Microsoft Graph alertDisplayName property."
  type        = string
  default     = null
}

variable "alert_ttl" {
  description = "Microsoft Graph alertTTL property."
  type        = number
  default     = null
}

variable "alerts" {
  description = "Microsoft Graph alerts property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedTenants.managedTenantAlert")
    alertData  = optional(any)
    alertDataReferenceStrings = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.managedTenants.alertDataReferenceString")
      displayName = optional(string)
    })))
    alertLogs = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.managedTenants.managedTenantAlertLog")
      alert              = optional(any)
      content            = optional(any)
      createdByUserId    = optional(string)
      createdDateTime    = optional(string)
      lastActionByUserId = optional(string)
      lastActionDateTime = optional(string)
    })))
    alertRule            = optional(any)
    alertRuleDisplayName = optional(string)
    apiNotifications = optional(list(object({
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
    })))
    assignedToUserId = optional(string)
    correlationCount = optional(number)
    correlationId    = optional(string)
    createdByUserId  = optional(string)
    createdDateTime  = optional(string)
    emailNotifications = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.managedTenants.managedTenantEmailNotification")
      alert              = optional(any)
      createdByUserId    = optional(string)
      createdDateTime    = optional(string)
      emailAddresses     = optional(any)
      emailBody          = optional(string)
      lastActionByUserId = optional(string)
      lastActionDateTime = optional(string)
      subject            = optional(string)
    })))
    lastActionByUserId = optional(string)
    lastActionDateTime = optional(string)
    message            = optional(string)
    severity           = optional(any)
    status             = optional(any)
    tenantId           = optional(string)
    title              = optional(string)
  }))
  default = null
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

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
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

variable "last_run_date_time" {
  description = "Microsoft Graph lastRunDateTime property."
  type        = string
  default     = null
}

variable "notification_final_destinations" {
  description = "Microsoft Graph notificationFinalDestinations property."
  type        = any
  default     = null

  validation {
    condition     = var.notification_final_destinations == null ? true : contains(["none", "api", "email", "sms", "unknownFutureValue"], var.notification_final_destinations)
    error_message = "notification_final_destinations must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managedTenantAlertRule"
  nullable    = false
}

variable "rule_definition" {
  description = "Microsoft Graph ruleDefinition property."
  type        = any
  default     = null
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

variable "targets" {
  description = "Microsoft Graph targets property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.managedTenants.notificationTarget")
    displayName = optional(string)
  }))
  default = null
}

variable "tenant_ids" {
  description = "Microsoft Graph tenantIds property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedTenants.tenantInfo")
    tenantId   = optional(string)
  }))
  default = null
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
