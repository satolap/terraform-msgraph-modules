variable "description" {
  description = "The site's description (optional)"
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name for the site. This property is required when a site is created."
  type        = string
  default     = null
}

variable "internalNetworkProbeUrl" {
  description = "The site's Internal Network Access Probe URL"
  type        = string
  default     = null
}

variable "microsoftTunnelConfiguration" {
  description = "The MicrosoftTunnelConfiguration that has been applied to this MicrosoftTunnelSite"
  type        = any
  default     = null
}

variable "microsoftTunnelServers" {
  description = "A list of MicrosoftTunnelServers that are registered to this MicrosoftTunnelSite"
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.microsoftTunnelServer")
    displayName              = optional(string)
    tunnelServerHealthStatus = optional(string)
  }))
  default = null

  validation {
    condition     = (var.microsoftTunnelServers == null ? true : alltrue([alltrue([for input0 in var.microsoftTunnelServers : (input0 == null ? true : alltrue([(input0["tunnelServerHealthStatus"] == null ? true : alltrue([(input0["tunnelServerHealthStatus"] == null ? true : contains(["unknown", "healthy", "unhealthy", "warning", "offline", "upgradeInProgress", "upgradeFailed"], input0["tunnelServerHealthStatus"]))]))]))])]))
    error_message = "microsoftTunnelServers: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.microsoftTunnelSite"
  nullable    = false
}

variable "publicAddress" {
  description = "The site's public domain name or IP address"
  type        = string
  default     = null
}

variable "roleScopeTagIds" {
  description = "List of Scope Tags for this Entity instance"
  type        = list(string)
  default     = null
}

variable "upgradeAutomatically" {
  description = "The site's automatic upgrade setting. True for automatic upgrades, false for manual control"
  type        = bool
  default     = null
}

variable "upgradeAvailable" {
  description = "The site provides the state of when an upgrade is available"
  type        = bool
  default     = null
}

variable "upgradeWindowEndTime" {
  description = "The site's upgrade window end time of day"
  type        = string
  default     = null
}

variable "upgradeWindowStartTime" {
  description = "The site's upgrade window start time of day"
  type        = string
  default     = null
}

variable "upgradeWindowUtcOffsetInMinutes" {
  description = "The site's timezone represented as a minute offset from UTC"
  type        = number
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
