variable "first_seen_date_time" {
  description = "The first date and time when this hostSslCertificate was observed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "host" {
  description = "The host for this hostSslCertificate."
  type        = any
  default     = null
}

variable "last_seen_date_time" {
  description = "The most recent date and time when this hostSslCertificate was observed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.hostSslCertificate"
  nullable    = false
}

variable "ports" {
  description = "The ports related with this hostSslCertificate."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.hostSslCertificatePort")
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    port              = optional(number)
  }))
  default = null
}

variable "ssl_certificate" {
  description = "The sslCertificate for this hostSslCertificate."
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
