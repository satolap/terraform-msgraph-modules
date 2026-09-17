variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the trusted certificate authorities."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the trusted certificate authorities."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.certificateBasedApplicationConfiguration"
  nullable    = false
}

variable "trusted_certificate_authorities" {
  description = "Collection of trusted certificate authorities."
  type = list(object({
    odata_type                 = optional(string, "#microsoft.graph.certificateAuthorityAsEntity")
    certificate                = optional(string)
    isRootAuthority            = optional(bool)
    issuer                     = optional(string)
    issuerSubjectKeyIdentifier = optional(string)
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
