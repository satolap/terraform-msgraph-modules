variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.emailAuthenticationMethodConfiguration", "#microsoft.graph.externalAuthenticationMethodConfiguration", "#microsoft.graph.fido2AuthenticationMethodConfiguration", "#microsoft.graph.hardwareOathAuthenticationMethodConfiguration", "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", "#microsoft.graph.qrCodePinAuthenticationMethodConfiguration", "#microsoft.graph.smsAuthenticationMethodConfiguration", "#microsoft.graph.softwareOathAuthenticationMethodConfiguration", "#microsoft.graph.temporaryAccessPassAuthenticationMethodConfiguration", "#microsoft.graph.verifiableCredentialsAuthenticationMethodConfiguration", "#microsoft.graph.voiceAuthenticationMethodConfiguration", "#microsoft.graph.x509CertificateAuthenticationMethodConfiguration"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "exclude_targets" {
  description = "Groups of users that are excluded from a policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.excludeTarget")
    id         = optional(string)
    targetType = optional(string)
  }))
  default = null
}

variable "state" {
  description = "The state of the policy. The possible values are: enabled, disabled."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled"], var.state)
    error_message = "state must be one of the documented enum values."
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
