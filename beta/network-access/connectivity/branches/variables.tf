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
    condition     = var.connectivity_state == null ? true : contains(["pending", "connected", "inactive", "error"], var.connectivity_state)
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

  validation {
    condition     = (var.device_links == null ? true : alltrue([alltrue([for input0 in var.device_links : (input0 == null ? true : alltrue([(input0["bandwidthCapacityInMbps"] == null ? true : alltrue([(input0["bandwidthCapacityInMbps"] == null ? true : contains(["mbps250", "mbps500", "mbps750", "mbps1000"], input0["bandwidthCapacityInMbps"]))])), (input0["deviceVendor"] == null ? true : alltrue([(input0["deviceVendor"] == null ? true : contains(["barracudaNetworks", "checkPoint", "ciscoMeraki", "citrix", "fortinet", "hpeAruba", "netFoundry", "nuage", "openSystems", "paloAltoNetworks", "riverbedTechnology", "silverPeak", "vmWareSdWan", "versa", "other", "ciscoCatalyst"], input0["deviceVendor"]))])), (input0["redundancyConfiguration"] == null ? true : alltrue([(input0["redundancyConfiguration"]["redundancyTier"] == null ? true : alltrue([(input0["redundancyConfiguration"]["redundancyTier"] == null ? true : contains(["noRedundancy", "zoneRedundancy"], input0["redundancyConfiguration"]["redundancyTier"]))]))]))]))])]))
    error_message = "device_links: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.forwarding_profiles == null ? true : alltrue([alltrue([for input0 in var.forwarding_profiles : (input0 == null ? true : alltrue([(input0["state"] == null ? true : alltrue([(input0["state"] == null ? true : contains(["enabled", "disabled"], input0["state"]))])), (input0["trafficForwardingType"] == null ? true : alltrue([(input0["trafficForwardingType"] == null ? true : contains(["m365", "internet", "private"], input0["trafficForwardingType"]))]))]))])]))
    error_message = "forwarding_profiles: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = var.region == null ? true : contains(["eastUS", "eastUS2", "westUS", "westUS2", "westUS3", "centralUS", "northCentralUS", "southCentralUS", "northEurope", "westEurope", "franceCentral", "germanyWestCentral", "switzerlandNorth", "ukSouth", "canadaEast", "canadaCentral", "southAfricaWest", "southAfricaNorth", "uaeNorth", "australiaEast", "westCentralUS", "centralIndia", "southEastAsia", "swedenCentral", "southIndia", "australiaSouthEast", "koreaCentral", "polandCentral", "brazilSouth", "japanEast", "japanWest", "koreaSouth", "italyNorth", "franceSouth", "israelCentral"], var.region)
    error_message = "region must be one of the documented enum values."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
