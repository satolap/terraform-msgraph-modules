variable "authentication_method" {
  description = "Microsoft Graph authenticationMethod property."
  type        = string
  default     = null

  validation {
    condition     = var.authentication_method == null ? true : contains(["password", "voice", "hardwareOath", "softwareOath", "sms", "fido2", "windowsHelloForBusiness", "microsoftAuthenticator", "temporaryAccessPass", "email", "x509Certificate", "federation", "unknownFutureValue", "qrCodePin"], var.authentication_method)
    error_message = "authentication_method must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "The display name of this mode"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authenticationMethodModeDetail"
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
