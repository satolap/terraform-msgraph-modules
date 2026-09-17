variable "app_display_name" {
  description = "The display name of the app for which consent is requested. Required. Supports $filter (eq only) and $orderby."
  type        = string
  default     = null
}

variable "app_id" {
  description = "The identifier of the application. Required. Supports $filter (eq only) and $orderby."
  type        = string
  default     = null
}

variable "consent_type" {
  description = "The consent type of the request. The possible values are: Static and Dynamic. These represent static and dynamic permissions, respectively, requested in the consent workflow. Supports $filter (eq only) and $orderby. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.appConsentRequest"
  nullable    = false
}

variable "pending_scopes" {
  description = "A list of pending scopes waiting for approval. This is empty if the consentType is Static. Required."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.appConsentRequestScope")
    displayName = optional(string)
  }))
  default = null
}

variable "user_consent_requests" {
  description = "A list of pending user consent requests. Supports $filter (eq)."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.userConsentRequest")
    approval          = optional(any)
    approvalId        = optional(string)
    completedDateTime = optional(string)
    createdBy         = optional(any)
    createdDateTime   = optional(string)
    customData        = optional(string)
    reason            = optional(string)
    status            = optional(string)
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
