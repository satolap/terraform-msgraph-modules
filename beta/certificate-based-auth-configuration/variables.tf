variable "certificate_authorities" {
  description = "Collection of certificate authorities that creates a trusted certificate chain."
  type = list(object({
    odata_type                        = optional(string, "#microsoft.graph.certificateAuthority")
    certificate                       = optional(string)
    certificateRevocationListUrl      = optional(string)
    deltaCertificateRevocationListUrl = optional(string)
    isRootAuthority                   = optional(bool)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.certificateBasedAuthConfiguration"
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
