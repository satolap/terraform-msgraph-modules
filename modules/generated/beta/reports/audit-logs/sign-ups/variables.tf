variable "app_display_name" {
  description = "App name displayed in the Microsoft Entra admin center.  Supports $filter (eq, startsWith)."
  type        = string
  default     = null
}

variable "app_id" {
  description = "Unique GUID that represents the app ID in the Microsoft Entra ID.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "applied_event_listeners" {
  description = "Detailed information about the listeners, such as Azure Logic Apps and Azure Functions, which the corresponding events in the sign-up event triggered."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.appliedAuthenticationEventListener")
    eventType          = optional(any)
    executedListenerId = optional(string)
    handlerResult      = optional(any)
  }))
  default = null
}

variable "correlation_id" {
  description = "The request ID sent from the client when the sign-up is initiated. Used to troubleshoot sign-up activity.  Supports $filter (eq)."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Date and time (UTC) the sign-up was initiated. Example: midnight on Jan 1, 2014 is reported as 2014-01-01T00:00:00Z.  Supports $orderby, $filter (eq, le, and ge)."
  type        = string
  default     = null
}

variable "fraud_protection_details" {
  description = "Microsoft Graph fraudProtectionDetails property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.selfServiceSignUp"
  nullable    = false
}

variable "sign_up_identity" {
  description = "Unique identifier for self-service sign-up user. Supports $filter (eq) on the signUpIdentifierType."
  type        = any
  default     = null
}

variable "sign_up_identity_provider" {
  description = "Describes the type of account for which the user registered. Values include Email OTP, Email Password, Google."
  type        = string
  default     = null
}

variable "sign_up_stage" {
  description = "Microsoft Graph signUpStage property."
  type        = string
  default     = null

  validation {
    condition     = var.sign_up_stage == null ? true : contains(["credentialCollection", "credentialValidation", "credentialFederation", "consent", "attributeCollectionAndValidation", "userCreation", "tenantConsent", "unknownFutureValue"], var.sign_up_stage)
    error_message = "sign_up_stage must be one of the documented enum values."
  }
}

variable "status" {
  description = "Sign-up status. Includes the error code and description of the error (if a sign-up failure or interrupt occurs).  Supports $filter (eq) on errorCode property."
  type        = any
  default     = null
}

variable "user_id" {
  description = "The identifier of the user object created during the sign-up."
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
