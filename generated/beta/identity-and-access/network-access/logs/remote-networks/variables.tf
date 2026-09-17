variable "bgp_routes_advertised_count" {
  description = "The number of BGP routes advertised through tunnel."
  type        = number
  default     = null
}

variable "created_date_time" {
  description = "The time of the original event generation in UTC. Supports $filter (ge, le) and $orderby."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the event."
  type        = string
  default     = null
}

variable "destination_ip" {
  description = "The IP address of the destination."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.remoteNetworkHealthEvent"
  nullable    = false
}

variable "received_bytes" {
  description = "The number of bytes sent from the destination to the source."
  type        = number
  default     = null
}

variable "remote_network_id" {
  description = "A unique identifier for each remoteNetwork site. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "sent_bytes" {
  description = "The number of bytes sent from the source to the destination for the connection or session."
  type        = number
  default     = null
}

variable "source_ip" {
  description = "The public IP address."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["tunnelDisconnected", "tunnelConnected", "bgpDisconnected", "bgpConnected", "remoteNetworkAlive", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
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
