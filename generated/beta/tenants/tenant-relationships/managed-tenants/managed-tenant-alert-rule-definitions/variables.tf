variable "alert_rules" {
  description = "Microsoft Graph alertRules property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.managedTenants.managedTenantAlertRule")
    alertDisplayName = optional(string)
    alertTTL         = optional(number)
    alerts = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.managedTenants.managedTenantAlert")
      alertData                 = optional(any)
      alertDataReferenceStrings = optional(any)
      alertLogs                 = optional(any)
      alertRule                 = optional(any)
      alertRuleDisplayName      = optional(string)
      apiNotifications          = optional(any)
      assignedToUserId          = optional(string)
      correlationCount          = optional(number)
      correlationId             = optional(string)
      createdByUserId           = optional(string)
      createdDateTime           = optional(string)
      emailNotifications        = optional(any)
      lastActionByUserId        = optional(string)
      lastActionDateTime        = optional(string)
      message                   = optional(string)
      severity                  = optional(any)
      status                    = optional(any)
      tenantId                  = optional(string)
      title                     = optional(string)
    })))
    createdByUserId               = optional(string)
    createdDateTime               = optional(string)
    description                   = optional(string)
    displayName                   = optional(string)
    lastActionByUserId            = optional(string)
    lastActionDateTime            = optional(string)
    lastRunDateTime               = optional(string)
    notificationFinalDestinations = optional(any)
    ruleDefinition                = optional(any)
    severity                      = optional(any)
    targets = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.managedTenants.notificationTarget")
      displayName = optional(string)
    })))
    tenantIds = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.managedTenants.tenantInfo")
      tenantId   = optional(string)
    })))
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

variable "definition_template" {
  description = "Microsoft Graph definitionTemplate property."
  type        = any
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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managedTenantAlertRuleDefinition"
  nullable    = false
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
