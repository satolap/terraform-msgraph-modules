variable "activity_date_time" {
  description = "Microsoft Graph activityDateTime property."
  type        = string
  default     = null
}

variable "activity_display_name" {
  description = "Microsoft Graph activityDisplayName property."
  type        = string
  default     = null
}

variable "additional_details" {
  description = "Microsoft Graph additionalDetails property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValue")
    key        = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null
}

variable "correlation_id" {
  description = "Microsoft Graph correlationId property."
  type        = string
  default     = null
}

variable "initiated_by" {
  description = "Microsoft Graph initiatedBy property."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.auditActivityInitiator")
    app                 = optional(any)
    linkableIdentifiers = optional(any)
    user                = optional(any)
  })
  default = null
}

variable "logged_by_service" {
  description = "Microsoft Graph loggedByService property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.customSecurityAttributeAudit"
  nullable    = false
}

variable "operation_type" {
  description = "Microsoft Graph operationType property."
  type        = string
  default     = null
}

variable "result" {
  description = "Microsoft Graph result property."
  type        = any
  default     = null

  validation {
    condition     = var.result == null ? true : contains(["success", "failure", "timeout", "unknownFutureValue"], var.result)
    error_message = "result must be one of the documented enum values."
  }
}

variable "result_reason" {
  description = "Microsoft Graph resultReason property."
  type        = string
  default     = null
}

variable "target_resources" {
  description = "Microsoft Graph targetResources property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.targetResource")
    displayName = optional(string)
    groupType   = optional(any)
    id          = optional(string)
    modifiedProperties = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.modifiedProperty")
      displayName = optional(string)
      newValue    = optional(string)
      oldValue    = optional(string)
    })))
    type              = optional(string)
    userPrincipalName = optional(string)
  }))
  default = null
}

variable "user_agent" {
  description = "Microsoft Graph userAgent property."
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
