variable "microsoft_tunnel_site_id" {
  description = "The unique identifier of microsoftTunnelSite"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.microsoft_tunnel_site_id)) > 0
    error_message = "microsoft_tunnel_site_id must not be empty."
  }
}

variable "display_name" {
  description = "The display name of the server. It is the same as the host name during registration and can be changed later. Supports: $filter, $select, $top, $skip, $orderby. $search is not supported. Max allowed length is 200 chars."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.microsoftTunnelServer"
  nullable    = false
}

variable "tunnel_server_health_status" {
  description = "Enum of possible MicrosoftTunnelServer health status types"
  type        = string
  default     = null

  validation {
    condition     = var.tunnel_server_health_status == null ? true : contains(["unknown", "healthy", "unhealthy", "warning", "offline", "upgradeInProgress", "upgradeFailed", "unknownFutureValue"], var.tunnel_server_health_status)
    error_message = "tunnel_server_health_status must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["agentImageDigest", "deploymentMode", "id", "lastCheckinDateTime", "serverImageDigest"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
