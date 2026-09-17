variable "api_connector_configuration" {
  description = "Configuration for enabling an API connector for use as part of the user flow. You can only obtain the value of this object using Get userFlowApiConnectorConfiguration."
  type        = any
  default     = null
}

variable "default_language_tag" {
  description = "Indicates the default language of the b2cIdentityUserFlow that is used when no ui_locale tag is specified in the request. This field is RFC 5646 compliant."
  type        = string
  default     = null
}

variable "identity_providers" {
  description = "The identity providers included in the user flow."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.identityProvider")
    clientId     = optional(string)
    clientSecret = optional(string)
    name         = optional(string)
    type         = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "is_language_customization_enabled" {
  description = "The property that determines whether language customization is enabled within the B2C user flow. Language customization is not enabled by default for B2C user flows."
  type        = bool
  default     = null
}

variable "languages" {
  description = "The languages supported for customization within the user flow. Language customization is not enabled by default in B2C user flows."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.userFlowLanguageConfiguration")
    defaultPages = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")
    })))
    isEnabled = optional(bool)
    overridesPages = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.b2cIdentityUserFlow"
  nullable    = false
}

variable "user_attribute_assignments" {
  description = "The user attribute assignments included in the user flow."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.identityUserFlowAttributeAssignment")
    displayName          = optional(string)
    isOptional           = optional(bool)
    requiresVerification = optional(bool)
    userAttribute        = optional(any)
    userAttributeValues = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.userAttributeValuesItem")
      isDefault  = optional(bool)
      name       = optional(string)
      value      = optional(string)
    })))
    userInputType = optional(string)
  }))
  default = null
}

variable "user_flow_identity_providers" {
  description = "The identity providers included in the user flow."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.identityProviderBase")
    displayName = optional(string)
  }))
  default = null
}

variable "user_flow_type" {
  description = "Microsoft Graph userFlowType property."
  type        = string
  default     = null

  validation {
    condition     = var.user_flow_type == null ? true : contains(["signUp", "signIn", "signUpOrSignIn", "passwordReset", "profileUpdate", "resourceOwner", "unknownFutureValue"], var.user_flow_type)
    error_message = "user_flow_type must be one of the documented enum values."
  }
}

variable "user_flow_type_version" {
  description = "Microsoft Graph userFlowTypeVersion property."
  type        = any
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
