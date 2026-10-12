variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.security.hostname", "#microsoft.graph.security.ipAddress"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "child_host_pairs" {
  description = "The hostPairs that are resources associated with a host, where that host is the parentHost and has an outgoing pairing to a childHost."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.hostPair")
    childHost         = optional(any)
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    linkKind          = optional(string)
    parentHost        = optional(any)
  }))
  default = null
}

variable "components" {
  description = "The hostComponents that are associated with this host."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.hostComponent")
    category          = optional(string)
    firstSeenDateTime = optional(string)
    host              = optional(any)
    lastSeenDateTime  = optional(string)
    name              = optional(string)
    version           = optional(string)
  }))
  default = null
}

variable "cookies" {
  description = "The hostCookies that are associated with this host."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.hostCookie")
    domain            = optional(string)
    firstSeenDateTime = optional(string)
    host              = optional(any)
    lastSeenDateTime  = optional(string)
    name              = optional(string)
  }))
  default = null
}

variable "first_seen_date_time" {
  description = "The first date and time when this host was observed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "host_pairs" {
  description = "The hostPairs that are associated with this host, where this host is either the parentHost or childHost."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.hostPair")
    childHost         = optional(any)
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    linkKind          = optional(string)
    parentHost        = optional(any)
  }))
  default = null
}

variable "last_seen_date_time" {
  description = "The most recent date and time when this host was observed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "parent_host_pairs" {
  description = "The hostPairs that are associated with a host, where that host is the childHost and has an incoming pairing with a parentHost."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.hostPair")
    childHost         = optional(any)
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    linkKind          = optional(string)
    parentHost        = optional(any)
  }))
  default = null
}

variable "passive_dns" {
  description = "Passive DNS retrieval about this host."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.passiveDnsRecord")
    artifact          = optional(any)
    collectedDateTime = optional(string)
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    parentHost        = optional(any)
    recordType        = optional(string)
  }))
  default = null
}

variable "passive_dns_reverse" {
  description = "Reverse passive DNS retrieval about this host."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.passiveDnsRecord")
    artifact          = optional(any)
    collectedDateTime = optional(string)
    firstSeenDateTime = optional(string)
    lastSeenDateTime  = optional(string)
    parentHost        = optional(any)
    recordType        = optional(string)
  }))
  default = null
}

variable "ports" {
  description = "The hostPorts associated with a host."
  type = list(object({
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
    protocol                 = optional(string)
    services = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.hostPortComponent")
      component         = optional(any)
      firstSeenDateTime = optional(string)
      isRecent          = optional(bool)
      lastSeenDateTime  = optional(string)
    })))
    status        = optional(string)
    timesObserved = optional(number)
  }))
  default = null
}

variable "reputation" {
  description = "Represents a calculated reputation of this host."
  type        = any
  default     = null
}

variable "ssl_certificates" {
  description = "The hostSslCertificates that are associated with this host."
  type = list(object({
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
  }))
  default = null
}

variable "subdomains" {
  description = "The subdomains that are associated with this host."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.subdomain")
    firstSeenDateTime = optional(string)
    host              = optional(any)
  }))
  default = null
}

variable "trackers" {
  description = "The hostTrackers that are associated with this host."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.hostTracker")
    firstSeenDateTime = optional(string)
    host              = optional(any)
    kind              = optional(string)
    lastSeenDateTime  = optional(string)
    value             = optional(string)
  }))
  default = null
}

variable "whois" {
  description = "The most recent whoisRecord for this host."
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
