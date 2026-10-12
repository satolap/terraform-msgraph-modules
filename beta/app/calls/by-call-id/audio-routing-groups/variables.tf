variable "call_id" {
  description = "The unique identifier of call"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.call_id)) > 0
    error_message = "call_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.audioRoutingGroup"
  nullable    = false
}

variable "receivers" {
  description = "List of receiving participant ids."
  type        = list(string)
  default     = null
}

variable "routing_mode" {
  description = "Microsoft Graph routingMode property."
  type        = string
  default     = null

  validation {
    condition     = var.routing_mode == null ? true : contains(["oneToOne", "multicast"], var.routing_mode)
    error_message = "routing_mode must be one of the documented enum values."
  }
}

variable "sources" {
  description = "List of source participant ids."
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
