variable "certificate_authorities" {
  description = "The collection of certificate authorities contained in this public key infrastructure resource."
  type = list(object({
    odata_type                        = optional(string, "#microsoft.graph.certificateAuthorityDetail")
    certificate                       = optional(string)
    certificateAuthorityType          = optional(any)
    certificateRevocationListUrl      = optional(string)
    createdDateTime                   = optional(string)
    deletedDateTime                   = optional(string)
    deltaCertificateRevocationListUrl = optional(string)
    displayName                       = optional(string)
    expirationDateTime                = optional(string)
    isIssuerHintEnabled               = optional(bool)
    issuer                            = optional(string)
    issuerSubjectKeyIdentifier        = optional(string)
    thumbprint                        = optional(string)
  }))
  default = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the object. Maximum length is 256 characters."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the object was created or last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.certificateBasedAuthPki"
  nullable    = false
}

variable "status" {
  description = "The status of any asynchronous jobs runs on the object which can be upload or delete."
  type        = string
  default     = null
}

variable "status_details" {
  description = "The status details of the upload/deleted operation of PKI (Public Key Infrastructure)."
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
