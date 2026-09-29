variable "expiration_date_time" {
  description = "The date and time when a certificate expires. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "fingerprint" {
  description = "A hash of the certificate calculated on the data and signature."
  type        = string
  default     = null
}

variable "first_seen_date_time" {
  description = "The first date and time when this sslCertificate was observed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "issue_date_time" {
  description = "The date and time when a certificate was issued. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "issuer" {
  description = "The entity that grants this certificate."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.sslCertificateEntity")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    alternateNames       = optional(list(string))
    commonName           = optional(string)
    email                = optional(string)
    givenName            = optional(string)
    organizationName     = optional(string)
    organizationUnitName = optional(string)
    serialNumber         = optional(string)
    surname              = optional(string)
  })
  default = null
}

variable "last_seen_date_time" {
  description = "The most recent date and time when this sslCertificate was observed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.sslCertificate"
  nullable    = false
}

variable "related_hosts" {
  description = "The host resources related with this sslCertificate."
  type        = any
  default     = null
}

variable "serial_number" {
  description = "The serial number associated with an SSL certificate."
  type        = string
  default     = null
}

variable "sha1" {
  description = "A SHA-1 hash of the certificate. Note: This is not the signature."
  type        = string
  default     = null
}

variable "subject" {
  description = "The person, site, machine, and so on, this certificate is for."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.sslCertificateEntity")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    alternateNames       = optional(list(string))
    commonName           = optional(string)
    email                = optional(string)
    givenName            = optional(string)
    organizationName     = optional(string)
    organizationUnitName = optional(string)
    serialNumber         = optional(string)
    surname              = optional(string)
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
