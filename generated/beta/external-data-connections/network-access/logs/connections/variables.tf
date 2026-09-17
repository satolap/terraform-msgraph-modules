variable "agent_version" {
  description = "The version of the client that initiated the connection."
  type        = string
  default     = null
}

variable "application_snapshot" {
  description = "appId (or client ID) of the destination Microsoft Entra application."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time the connection was created."
  type        = string
  default     = null
}

variable "cross_tenant_access_type" {
  description = "Cross tenant access details, for B2B scenarios. The possible values are: none, b2bCollaboration, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.cross_tenant_access_type == null ? true : contains(["none", "b2bCollaboration", "unknownFutureValue"], var.cross_tenant_access_type)
    error_message = "cross_tenant_access_type must be one of the documented enum values."
  }
}

variable "destination_fqdn" {
  description = "The destination FQDN of the connection."
  type        = string
  default     = null
}

variable "destination_ip" {
  description = "The destination IP of the connection."
  type        = string
  default     = null
}

variable "destination_port" {
  description = "The destination port of the connection."
  type        = number
  default     = null
}

variable "device_category" {
  description = "The category of the device. The possible values are: client, branch, unknownFutureValue, remoteNetwork. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: remoteNetwork."
  type        = any
  default     = null

  validation {
    condition     = var.device_category == null ? true : contains(["client", "branch", "unknownFutureValue", "remoteNetwork"], var.device_category)
    error_message = "device_category must be one of the documented enum values."
  }
}

variable "device_id" {
  description = "The DeviceID."
  type        = string
  default     = null
}

variable "device_join_type" {
  description = "Device registration type, for BYOD scenarios. The possible values are: none, microsoftEntraJoined, microsoftEntraRegistered, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.device_join_type == null ? true : contains(["none", "microsoftEntraJoined", "microsoftEntraRegistered", "unknownFutureValue"], var.device_join_type)
    error_message = "device_join_type must be one of the documented enum values."
  }
}

variable "device_operating_system" {
  description = "The device operating system type."
  type        = string
  default     = null
}

variable "device_operating_system_version" {
  description = "The device operating system version."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "The time the connection was terminated."
  type        = string
  default     = null
}

variable "home_tenant_id" {
  description = "The identifier of the home tenant, for Entra B2B scenarios."
  type        = string
  default     = null
}

variable "initiating_process_name" {
  description = "The process initiating the traffic connection."
  type        = string
  default     = null
}

variable "last_update_date_time" {
  description = "When the connection was last updated."
  type        = string
  default     = null
}

variable "network_protocol" {
  description = "The network protocol of the connection. The possible values are: ip, icmp, igmp, ggp, ipv4, tcp, pup, udp, idp, ipv6, ipv6RoutingHeader, ipv6FragmentHeader, ipSecEncapsulatingSecurityPayload, ipSecAuthenticationHeader, icmpV6, ipv6NoNextHeader, ipv6DestinationOptions, nd, raw, ipx, spx, spxII, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.network_protocol == null ? true : contains(["ip", "icmp", "igmp", "ggp", "ipv4", "tcp", "pup", "udp", "idp", "ipv6", "ipv6RoutingHeader", "ipv6FragmentHeader", "ipSecEncapsulatingSecurityPayload", "ipSecAuthenticationHeader", "icmpV6", "ipv6NoNextHeader", "ipv6DestinationOptions", "nd", "ipx", "raw", "spx", "spxII", "unknownFutureValue"], var.network_protocol)
    error_message = "network_protocol must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.connection"
  nullable    = false
}

variable "pop_processing_region" {
  description = "The Point-of-Presence processing region of the traffic."
  type        = string
  default     = null
}

variable "private_access_details" {
  description = "Private access details."
  type        = any
  default     = null
}

variable "received_bytes" {
  description = "Accumulative bytes received."
  type        = number
  default     = null
}

variable "sent_bytes" {
  description = "Accumulative bytes sent."
  type        = number
  default     = null
}

variable "source_ip" {
  description = "The source IP of the connection."
  type        = string
  default     = null
}

variable "source_port" {
  description = "The source port of the connection."
  type        = number
  default     = null
}

variable "status" {
  description = "Status of the connection. The possible values are: open, active, closed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["open", "active", "closed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "tenant_id" {
  description = "The ID of the tenant where the connection was initiated."
  type        = string
  default     = null
}

variable "traffic_type" {
  description = "Microsoft Graph trafficType property."
  type        = string
  default     = null

  validation {
    condition     = var.traffic_type == null ? true : contains(["internet", "private", "microsoft365", "all", "unknownFutureValue"], var.traffic_type)
    error_message = "traffic_type must be one of the documented enum values."
  }
}

variable "transaction_block_count" {
  description = "The number of blocked transactions belonging to the connection."
  type        = number
  default     = null
}

variable "transaction_count" {
  description = "The number of transactions belonging to the connection."
  type        = number
  default     = null
}

variable "transport_protocol" {
  description = "The transport protocol of the connection. The possible values are: ip, icmp, igmp, ggp, ipv4, tcp, pup, udp, idp, ipv6, ipv6RoutingHeader, ipv6FragmentHeader, ipSecEncapsulatingSecurityPayload, ipSecAuthenticationHeader, icmpV6, ipv6NoNextHeader, ipv6DestinationOptions, nd, raw, ipx, spx, spxII, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.transport_protocol == null ? true : contains(["ip", "icmp", "igmp", "ggp", "ipv4", "tcp", "pup", "udp", "idp", "ipv6", "ipv6RoutingHeader", "ipv6FragmentHeader", "ipSecEncapsulatingSecurityPayload", "ipSecAuthenticationHeader", "icmpV6", "ipv6NoNextHeader", "ipv6DestinationOptions", "nd", "ipx", "raw", "spx", "spxII", "unknownFutureValue"], var.transport_protocol)
    error_message = "transport_protocol must be one of the documented enum values."
  }
}

variable "user_id" {
  description = "The user ID."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "The principal name of the user."
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
