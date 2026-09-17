variable "app_id" {
  description = "The globally unique appId (also called client ID on the Microsoft Entra admin center) of the credentialed application."
  type        = string
  default     = null
}

variable "app_object_id" {
  description = "The ID of the credential application instance."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the credential was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "credential_origin" {
  description = "Microsoft Graph credentialOrigin property."
  type        = string
  default     = null
  sensitive   = true

  validation {
    condition     = var.credential_origin == null ? true : contains(["application", "servicePrincipal", "unknownFutureValue"], var.credential_origin)
    error_message = "credential_origin must be one of the documented enum values."
  }
}

variable "expiration_date_time" {
  description = "The date and time when the credential is set to expire. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "key_id" {
  description = "The key ID of the credential."
  type        = string
  default     = null
}

variable "key_type" {
  description = "Specifies the key type. The possible values are: clientSecret, certificate, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.key_type == null ? true : contains(["clientSecret", "certificate", "unknownFutureValue"], var.key_type)
    error_message = "key_type must be one of the documented enum values."
  }
}

variable "key_usage" {
  description = "Specifies what the key was used for. The possible values are: sign, verify, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.key_usage == null ? true : contains(["sign", "verify", "unknownFutureValue"], var.key_usage)
    error_message = "key_usage must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.appCredentialSignInActivity"
  nullable    = false
}

variable "resource_id" {
  description = "The ID of the accessed resource."
  type        = string
  default     = null
}

variable "service_principal_object_id" {
  description = "The ID of the service principal."
  type        = string
  default     = null
}

variable "sign_in_activity" {
  description = "Microsoft Graph signInActivity property."
  type = object({
    odata_type                        = optional(string, "#microsoft.graph.signInActivity")
    lastNonInteractiveSignInDateTime  = optional(string)
    lastNonInteractiveSignInRequestId = optional(string)
    lastSignInDateTime                = optional(string)
    lastSignInRequestId               = optional(string)
    lastSuccessfulSignInDateTime      = optional(string)
    lastSuccessfulSignInRequestId     = optional(string)
  })
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
