variable "remote_network_id" {
  description = "The unique identifier of remoteNetwork"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.remote_network_id)) > 0
    error_message = "remote_network_id must not be empty."
  }
}

variable "bandwidth_capacity_in_mbps" {
  description = "Determines the maximum allowed Mbps (megabits per second) bandwidth from a device link. The possible values are:250,500,750,1000."
  type        = any
  default     = null

  validation {
    condition     = var.bandwidth_capacity_in_mbps == null ? true : contains(["mbps250", "mbps500", "mbps750", "mbps1000", "unknownFutureValue"], var.bandwidth_capacity_in_mbps)
    error_message = "bandwidth_capacity_in_mbps must be one of the documented enum values."
  }
}

variable "bgp_configuration" {
  description = "Microsoft Graph bgpConfiguration property."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.networkaccess.bgpConfiguration")
    asn            = optional(number)
    ipAddress      = optional(string)
    localIpAddress = optional(string)
    peerIpAddress  = optional(string)
  })
  default = null
}

variable "device_vendor" {
  description = "Microsoft Graph deviceVendor property."
  type        = string
  default     = null

  validation {
    condition     = var.device_vendor == null ? true : contains(["barracudaNetworks", "checkPoint", "ciscoMeraki", "citrix", "fortinet", "hpeAruba", "netFoundry", "nuage", "openSystems", "paloAltoNetworks", "riverbedTechnology", "silverPeak", "vmWareSdWan", "versa", "other", "ciscoCatalyst", "unknownFutureValue", "aviatrix", "netskope", "teridion", "aristaNetworks", "aristaVeloCloud", "juniperNetworks"], var.device_vendor)
    error_message = "device_vendor must be one of the documented enum values."
  }
}

variable "ip_address" {
  description = "The public IP address of your CPE (customer premise equipment) device."
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
  default     = "#microsoft.graph.networkaccess.deviceLink"
  nullable    = false
}

variable "redundancy_configuration" {
  description = "Microsoft Graph redundancyConfiguration property."
  type        = any
  default     = null
}

variable "tunnel_configuration" {
  description = "Microsoft Graph tunnelConfiguration property."
  type = object({
    odata_type                 = optional(string, "#microsoft.graph.networkaccess.tunnelConfiguration")
    preSharedKey               = optional(string)
    zoneRedundancyPreSharedKey = optional(string)
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
