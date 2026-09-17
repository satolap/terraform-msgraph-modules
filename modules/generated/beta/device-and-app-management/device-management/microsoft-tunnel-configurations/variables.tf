variable "advanced_settings" {
  description = "Additional settings that may be applied to the server"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "default_domain_suffix" {
  description = "The Default Domain appendix that will be used by the clients"
  type        = string
  default     = null
}

variable "description" {
  description = "The configuration's description (optional)"
  type        = string
  default     = null
}

variable "disable_udp_connections" {
  description = "When DisableUdpConnections is set, the clients and VPN server will not use DTLS connections to transfer data."
  type        = bool
  default     = null
}

variable "display_name" {
  description = "The display name for the server configuration. This property is required when a server is created."
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "The DNS servers that will be used by the clients"
  type        = list(string)
  default     = null
}

variable "ipv6_network" {
  description = "The IPv6 subnet that will be used to allocate virtual address for the clients"
  type        = string
  default     = null
}

variable "last_update_date_time" {
  description = "When the configuration was last updated"
  type        = string
  default     = null
}

variable "listen_port" {
  description = "The port that both TCP and UPD will listen over on the server"
  type        = number
  default     = null
}

variable "network" {
  description = "The IPv4 subnet that will be used to allocate virtual address for the clients"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.microsoftTunnelConfiguration"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance"
  type        = list(string)
  default     = null
}

variable "route_excludes" {
  description = "Subsets of the routes that will not be routed by the server"
  type        = list(string)
  default     = null
}

variable "route_includes" {
  description = "The routes that will be routed by the server"
  type        = list(string)
  default     = null
}

variable "routes_exclude" {
  description = "Subsets of the routes that will not be routed by the server. This property is going to be deprecated with the option of using the new property, 'RouteExcludes'."
  type        = list(string)
  default     = null
}

variable "routes_include" {
  description = "The routes that will be routed by the server. This property is going to be deprecated with the option of using the new property, 'RouteIncludes'."
  type        = list(string)
  default     = null
}

variable "split_dns" {
  description = "The domains that will be resolved using the provided dns servers"
  type        = list(string)
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
