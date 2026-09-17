variable "remote_network_id" {
  description = "The unique identifier of remoteNetwork"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.remote_network_id)) > 0
    error_message = "remote_network_id must not be empty."
  }
}

variable "display_name" {
  description = "Specifies the name of the link."
  type        = string
  default     = null
}

variable "local_configurations" {
  description = "Specifies Microsoft's end of the tunnel configuration for a device link."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.localConnectivityConfiguration")
    asn        = optional(number)
    bgpAddress = optional(string)
    endpoint   = optional(string)
    region     = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.connectivityConfigurationLink"
  nullable    = false
}

variable "peer_configuration" {
  description = "Microsoft Graph peerConfiguration property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.peerConnectivityConfiguration")
    asn        = optional(number)
    bgpAddress = optional(string)
    endpoint   = optional(string)
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
