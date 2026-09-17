variable "description" {
  description = "The site's description (optional)"
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the site. This property is required when a site is created."
  type        = string
  default     = null
}

variable "internal_network_probe_url" {
  description = "The site's Internal Network Access Probe URL"
  type        = string
  default     = null
}

variable "microsoft_tunnel_configuration" {
  description = "The MicrosoftTunnelConfiguration that has been applied to this MicrosoftTunnelSite"
  type        = any
  default     = null
}

variable "microsoft_tunnel_servers" {
  description = "A list of MicrosoftTunnelServers that are registered to this MicrosoftTunnelSite"
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.microsoftTunnelServer")
    displayName              = optional(string)
    tunnelServerHealthStatus = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.microsoftTunnelSite"
  nullable    = false
}

variable "public_address" {
  description = "The site's public domain name or IP address"
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance"
  type        = list(string)
  default     = null
}

variable "upgrade_automatically" {
  description = "The site's automatic upgrade setting. True for automatic upgrades, false for manual control"
  type        = bool
  default     = null
}

variable "upgrade_available" {
  description = "The site provides the state of when an upgrade is available"
  type        = bool
  default     = null
}

variable "upgrade_window_end_time" {
  description = "The site's upgrade window end time of day"
  type        = string
  default     = null
}

variable "upgrade_window_start_time" {
  description = "The site's upgrade window start time of day"
  type        = string
  default     = null
}

variable "upgrade_window_utc_offset_in_minutes" {
  description = "The site's timezone represented as a minute offset from UTC"
  type        = number
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
