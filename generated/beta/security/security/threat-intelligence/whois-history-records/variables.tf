variable "abuse" {
  description = "The contact information for the abuse contact."
  type        = any
  default     = null
}

variable "admin" {
  description = "The contact information for the admin contact."
  type        = any
  default     = null
}

variable "billing" {
  description = "The contact information for the billing contact."
  type        = any
  default     = null
}

variable "domain_status" {
  description = "The domain status for this WHOIS object."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The date and time when this WHOIS record expires with the registrar. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "first_seen_date_time" {
  description = "The first seen date and time of this WHOIS record. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "host" {
  description = "Microsoft Graph host property."
  type = object({
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
      odata_type = optional(string, "#microsoft.graph.security.hostPort")
      banners = optional(list(object({
        odata_type        = optional(string, "#microsoft.graph.security.hostPortBanner")
        banner            = optional(string)
        firstSeenDateTime = optional(string)
        lastSeenDateTime  = optional(string)
        scanProtocol      = optional(string)
        timesObserved     = optional(number)
      })))
      firstSeenDateTime        = optional(string)
      host                     = optional(any)
      lastScanDateTime         = optional(string)
      lastSeenDateTime         = optional(string)
      mostRecentSslCertificate = optional(any)
      port                     = optional(number)
      protocol                 = optional(any)
      services = optional(list(object({
        odata_type        = optional(string, "#microsoft.graph.security.hostPortComponent")
        component         = optional(any)
        firstSeenDateTime = optional(string)
        isRecent          = optional(bool)
        lastSeenDateTime  = optional(string)
      })))
      status        = optional(any)
      timesObserved = optional(number)
    })))
    reputation = optional(any)
    sslCertificates = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostSslCertificate")
      firstSeenDateTime = optional(string)
      host              = optional(any)
      lastSeenDateTime  = optional(string)
      ports = optional(list(object({
        odata_type        = optional(string, "#microsoft.graph.security.hostSslCertificatePort")
        firstSeenDateTime = optional(string)
        lastSeenDateTime  = optional(string)
        port              = optional(number)
      })))
      sslCertificate = optional(any)
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
  })
  default = null
}

variable "last_seen_date_time" {
  description = "The last seen date and time of this WHOIS record. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_update_date_time" {
  description = "The date and time when this WHOIS record was last modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "nameservers" {
  description = "The nameservers for this WHOIS object."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.whoisNameserver")
    firstSeenDateTime = optional(string)
    host = optional(object({
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
        odata_type        = optional(string, "#microsoft.graph.security.passiveDnsRecord")
        artifact          = optional(any)
        collectedDateTime = optional(string)
        firstSeenDateTime = optional(string)
        lastSeenDateTime  = optional(string)
        parentHost        = optional(any)
        recordType        = optional(string)
      })))
      passiveDnsReverse = optional(list(object({
        odata_type        = optional(string, "#microsoft.graph.security.passiveDnsRecord")
        artifact          = optional(any)
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
    lastSeenDateTime = optional(string)
  }))
  default = null
}

variable "noc" {
  description = "The contact information for the noc contact."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.whoisHistoryRecord"
  nullable    = false
}

variable "raw_whois_text" {
  description = "The raw WHOIS details for this WHOIS object."
  type        = string
  default     = null
}

variable "registrant" {
  description = "The contact information for the registrant contact."
  type        = any
  default     = null
}

variable "registrar" {
  description = "The contact information for the registrar contact."
  type        = any
  default     = null
}

variable "registration_date_time" {
  description = "The date and time when this WHOIS record was registered with a registrar. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "technical" {
  description = "The contact information for the technical contact."
  type        = any
  default     = null
}

variable "whois_server" {
  description = "The WHOIS server that provides the details."
  type        = string
  default     = null
}

variable "zone" {
  description = "The contact information for the zone contact."
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
