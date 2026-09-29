variable "bandwidth_capacity" {
  description = "Determines the maximum allowed Mbps (megabits per second) bandwidth from a branch site. The possible values are:250,500,750,1000."
  type        = number
  default     = null
}

variable "connectivity_configuration" {
  description = "Specifies the connectivity details of all device links associated with a branch."
  type        = any
  default     = null
}

variable "connectivity_state" {
  description = "Determines the branch site status. The possible values are: pending, connected, inactive, error."
  type        = string
  default     = null

  validation {
    condition     = var.connectivity_state == null ? true : contains(["pending", "connected", "inactive", "error", "unknownFutureValue"], var.connectivity_state)
    error_message = "connectivity_state must be one of the documented enum values."
  }
}

variable "country" {
  description = "The branch site is created in the specified country. DO NOT USE."
  type        = string
  default     = null
}

variable "device_links" {
  description = "Each unique CPE device associated with a branch is specified. Supports $expand."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.networkaccess.deviceLink")
    bandwidthCapacityInMbps = optional(string)
    bgpConfiguration = optional(object({
      odata_type     = optional(string, "#microsoft.graph.networkaccess.bgpConfiguration")
      asn            = optional(number)
      ipAddress      = optional(string)
      localIpAddress = optional(string)
      peerIpAddress  = optional(string)
    }))
    deviceVendor         = optional(string)
    ipAddress            = optional(string)
    lastModifiedDateTime = optional(string)
    name                 = optional(string)
    redundancyConfiguration = optional(object({
      odata_type         = optional(string, "#microsoft.graph.networkaccess.redundancyConfiguration")
      redundancyTier     = optional(string)
      zoneLocalIpAddress = optional(string)
    }))
    tunnelConfiguration = optional(any)
  }))
  default = null
}

variable "forwarding_profiles" {
  description = "Each forwarding profile associated with a branch site is specified. Supports $expand."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.networkaccess.forwardingProfile")
    associations          = optional(any)
    description           = optional(string)
    isCustomProfile       = optional(bool)
    lastModifiedDateTime  = optional(string)
    name                  = optional(string)
    policies              = optional(any)
    priority              = optional(number)
    servicePrincipal      = optional(any)
    state                 = optional(string)
    trafficForwardingType = optional(string)
    version               = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "graph_version" {
  description = "The branch version."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "last modified time."
  type        = string
  default     = null
}

variable "name" {
  description = "Name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.branchSite"
  nullable    = false
}

variable "region" {
  description = "Microsoft Graph region property."
  type        = string
  default     = null

  validation {
    condition     = var.region == null ? true : contains(["eastUS", "eastUS2", "westUS", "westUS2", "westUS3", "centralUS", "northCentralUS", "southCentralUS", "northEurope", "westEurope", "franceCentral", "germanyWestCentral", "switzerlandNorth", "ukSouth", "canadaEast", "canadaCentral", "southAfricaWest", "southAfricaNorth", "uaeNorth", "australiaEast", "westCentralUS", "centralIndia", "southEastAsia", "swedenCentral", "southIndia", "australiaSouthEast", "koreaCentral", "polandCentral", "brazilSouth", "japanEast", "japanWest", "koreaSouth", "italyNorth", "franceSouth", "israelCentral", "unknownFutureValue", "taiwanNorth", "mexicoCentral", "spainCentral", "jioIndiaCentral", "brazilSouthEast"], var.region)
    error_message = "region must be one of the documented enum values."
  }
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
