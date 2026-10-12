variable "app_version" {
  description = "The connector's version."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the connector."
  type        = string
  default     = null
}

variable "fully_qualified_domain_name" {
  description = "The connector machine's hostname."
  type        = string
  default     = null
}

variable "location" {
  description = "The physical and/or organizational location of the connector."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.printerLocation")
    altitudeInMeters = optional(number)
    building         = optional(string)
    city             = optional(string)
    countryOrRegion  = optional(string)
    floor            = optional(string)
    floorDescription = optional(string)
    latitude         = optional(any)
    longitude        = optional(any)
    organization     = optional(list(string))
    postalCode       = optional(string)
    roomDescription  = optional(string)
    roomName         = optional(string)
    site             = optional(string)
    stateOrProvince  = optional(string)
    streetAddress    = optional(string)
    subdivision      = optional(list(string))
    subunit          = optional(list(string))
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printConnector"
  nullable    = false
}

variable "operating_system" {
  description = "The connector machine's operating system version."
  type        = string
  default     = null
}

variable "registered_date_time" {
  description = "The DateTimeOffset when the connector was registered."
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
