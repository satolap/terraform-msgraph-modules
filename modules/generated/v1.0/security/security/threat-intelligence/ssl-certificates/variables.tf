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
  type        = any
  default     = null
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
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.host")
    childHostPairs = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostPair")
      childHost         = optional(any)
      firstSeenDateTime = optional(string)
      lastSeenDateTime  = optional(string)
      linkKind          = optional(string)
      parentHost        = optional(any)
    })))
    components = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostComponent")
      category          = optional(string)
      firstSeenDateTime = optional(string)
      host              = optional(any)
      lastSeenDateTime  = optional(string)
      name              = optional(string)
      version           = optional(string)
    })))
    cookies = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostCookie")
      domain            = optional(string)
      firstSeenDateTime = optional(string)
      host              = optional(any)
      lastSeenDateTime  = optional(string)
      name              = optional(string)
    })))
    firstSeenDateTime = optional(string)
    hostPairs = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostPair")
      childHost         = optional(any)
      firstSeenDateTime = optional(string)
      lastSeenDateTime  = optional(string)
      linkKind          = optional(string)
      parentHost        = optional(any)
    })))
    lastSeenDateTime = optional(string)
    parentHostPairs = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostPair")
      childHost         = optional(any)
      firstSeenDateTime = optional(string)
      lastSeenDateTime  = optional(string)
      linkKind          = optional(string)
      parentHost        = optional(any)
    })))
    passiveDns = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")
      artifact = optional(object({
        odata_type = optional(string, "#microsoft.graph.security.artifact")
      }))
      collectedDateTime = optional(string)
      firstSeenDateTime = optional(string)
      lastSeenDateTime  = optional(string)
      parentHost        = optional(any)
      recordType        = optional(string)
    })))
    passiveDnsReverse = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")
      artifact = optional(object({
        odata_type = optional(string, "#microsoft.graph.security.artifact")
      }))
      collectedDateTime = optional(string)
      firstSeenDateTime = optional(string)
      lastSeenDateTime  = optional(string)
      parentHost        = optional(any)
      recordType        = optional(string)
    })))
    ports = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.security.hostPort")
      banners                  = optional(any)
      firstSeenDateTime        = optional(string)
      host                     = optional(any)
      lastScanDateTime         = optional(string)
      lastSeenDateTime         = optional(string)
      mostRecentSslCertificate = optional(any)
      port                     = optional(number)
      protocol                 = optional(any)
      services                 = optional(any)
      status                   = optional(any)
      timesObserved            = optional(number)
    })))
    reputation = optional(any)
    sslCertificates = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostSslCertificate")
      firstSeenDateTime = optional(string)
      host              = optional(any)
      lastSeenDateTime  = optional(string)
      ports             = optional(any)
      sslCertificate    = optional(any)
    })))
    subdomains = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.subdomain")
      firstSeenDateTime = optional(string)
      host              = optional(any)
    })))
    trackers = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostTracker")
      firstSeenDateTime = optional(string)
      host              = optional(any)
      kind              = optional(string)
      lastSeenDateTime  = optional(string)
      value             = optional(string)
    })))
    whois = optional(any)
  }))
  default = null
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
