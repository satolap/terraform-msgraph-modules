variable "branch_site_id" {
  description = "The unique identifier of branchSite"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.branch_site_id)) > 0
    error_message = "branch_site_id must not be empty."
  }
}

variable "bandwidth_capacity_in_mbps" {
  description = "Determines the maximum allowed Mbps (megabits per second) bandwidth from a device link. The possible values are:250,500,750,1000."
  type        = string
  default     = null

  validation {
    condition     = var.bandwidth_capacity_in_mbps == null ? true : contains(["mbps250", "mbps500", "mbps750", "mbps1000"], var.bandwidth_capacity_in_mbps)
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
    condition     = var.device_vendor == null ? true : contains(["barracudaNetworks", "checkPoint", "ciscoMeraki", "citrix", "fortinet", "hpeAruba", "netFoundry", "nuage", "openSystems", "paloAltoNetworks", "riverbedTechnology", "silverPeak", "vmWareSdWan", "versa", "other", "ciscoCatalyst"], var.device_vendor)
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
  type = object({
    odata_type         = optional(string, "#microsoft.graph.networkaccess.redundancyConfiguration")
    redundancyTier     = optional(string)
    zoneLocalIpAddress = optional(string)
  })
  default = null

  validation {
    condition     = (var.redundancy_configuration == null ? true : alltrue([(var.redundancy_configuration["redundancyTier"] == null ? true : alltrue([(var.redundancy_configuration["redundancyTier"] == null ? true : contains(["noRedundancy", "zoneRedundancy"], var.redundancy_configuration["redundancyTier"]))]))]))
    error_message = "redundancy_configuration: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "tunnel_configuration" {
  description = "Microsoft Graph tunnelConfiguration property."
  type        = any
  default     = null
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
