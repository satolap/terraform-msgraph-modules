variable "remote_network_id" {
  description = "The unique identifier of remoteNetwork"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.remote_network_id)) > 0
    error_message = "remote_network_id must not be empty."
  }
}

variable "associations" {
  description = "Microsoft Graph associations property."
  type        = any
  default     = null
}

variable "description" {
  description = "Description."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Profile version."
  type        = string
  default     = null
}

variable "is_custom_profile" {
  description = "Microsoft Graph isCustomProfile property."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the profile was last modified."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the entity"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.forwardingProfile"
  nullable    = false
}

variable "policies" {
  description = "The traffic forwarding policies associated with this profile."
  type        = any
  default     = null
}

variable "priority" {
  description = "Microsoft Graph priority property."
  type        = number
  default     = null
}

variable "service_principal" {
  description = "Microsoft Graph servicePrincipal property."
  type        = any
  default     = null
  sensitive   = true
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "traffic_forwarding_type" {
  description = "Microsoft Graph trafficForwardingType property."
  type        = string
  default     = null

  validation {
    condition     = var.traffic_forwarding_type == null ? true : contains(["m365", "internet", "private", "unknownFutureValue"], var.traffic_forwarding_type)
    error_message = "traffic_forwarding_type must be one of the documented enum values."
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
