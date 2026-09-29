variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.onAttributeCollectionListener", "#microsoft.graph.onAttributeCollectionStartListener", "#microsoft.graph.onAttributeCollectionSubmitListener", "#microsoft.graph.onAuthenticationMethodLoadStartListener", "#microsoft.graph.onEmailOtpSendListener", "#microsoft.graph.onFraudProtectionLoadStartListener", "#microsoft.graph.onInteractiveAuthFlowStartListener", "#microsoft.graph.onPasswordSubmitListener", "#microsoft.graph.onPhoneMethodLoadStartListener", "#microsoft.graph.onTokenIssuanceStartListener", "#microsoft.graph.onUserCreateStartListener", "#microsoft.graph.onVerifiedIdClaimValidationListener"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "authentication_events_flow_id" {
  description = "The identifier of the authenticationEventsFlow object."
  type        = string
  default     = null
}

variable "conditions" {
  description = "The conditions on which this authenticationEventListener should trigger."
  type = object({
    odata_type = optional(string, "#microsoft.graph.authenticationConditions")
    applications = optional(object({
      odata_type             = optional(string, "#microsoft.graph.authenticationConditionsApplications")
      includeAllApplications = optional(bool)
      includeApplications = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.authenticationConditionApplication")
        appId      = optional(string)
      })))
    }))
  })
  default = null
}

variable "display_name" {
  description = "The display name of the listener."
  type        = string
  default     = null
}

variable "priority" {
  description = "The priority of this handler. Between 0 (lower priority) and 1000 (higher priority)."
  type        = number
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
