variable "abuse" {
  description = "The contact information for the abuse contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
  })
  default = null
}

variable "admin" {
  description = "The contact information for the admin contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
  })
  default = null
}

variable "billing" {
  description = "The contact information for the billing contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
  })
  default = null
}

variable "domain_status" {
  description = "The domain status for this WHOIS object."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The date and time when this WHOIS record expires with the registrar. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "first_seen_date_time" {
  description = "The first seen date and time of this WHOIS record. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "history" {
  description = "The collection of historical records associated to this WHOIS object."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.whoisHistoryRecord")
    abuse = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
    admin = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
    billing = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
    domainStatus       = optional(string)
    expirationDateTime = optional(string)
    firstSeenDateTime  = optional(string)
    host               = optional(any)
    lastSeenDateTime   = optional(string)
    lastUpdateDateTime = optional(string)
    nameservers = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.security.whoisNameserver")
      firstSeenDateTime = optional(string)
      host              = optional(any)
      lastSeenDateTime  = optional(string)
    })))
    noc = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
    rawWhoisText = optional(string)
    registrant = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
    registrar = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
    registrationDateTime = optional(string)
    technical = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
    whoisServer = optional(string)
    zone = optional(object({
      odata_type = optional(string, "#microsoft.graph.security.whoisContact")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
      }))
      email        = optional(string)
      fax          = optional(string)
      name         = optional(string)
      organization = optional(string)
      telephone    = optional(string)
    }))
  }))
  default = null
}

variable "host" {
  description = "Microsoft Graph host property."
  type        = any
  default     = null
}

variable "last_seen_date_time" {
  description = "The last seen date and time of this WHOIS record. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_update_date_time" {
  description = "The date and time when this WHOIS record was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "nameservers" {
  description = "The nameservers for this WHOIS object."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.whoisNameserver")
    firstSeenDateTime = optional(string)
    host              = optional(any)
    lastSeenDateTime  = optional(string)
  }))
  default = null
}

variable "noc" {
  description = "The contact information for the noc contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.whoisRecord"
  nullable    = false
}

variable "raw_whois_text" {
  description = "The raw WHOIS details for this WHOIS object."
  type        = string
  default     = null
}

variable "registrant" {
  description = "The contact information for the registrant contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
  })
  default = null
}

variable "registrar" {
  description = "The contact information for the registrar contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
  })
  default = null
}

variable "registration_date_time" {
  description = "The date and time when this WHOIS record was registered with a registrar. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "technical" {
  description = "The contact information for the technical contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
  })
  default = null
}

variable "whois_server" {
  description = "The WHOIS server that provides the details."
  type        = string
  default     = null
}

variable "zone" {
  description = "The contact information for the zone contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.whoisContact")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    email        = optional(string)
    fax          = optional(string)
    name         = optional(string)
    organization = optional(string)
    telephone    = optional(string)
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
