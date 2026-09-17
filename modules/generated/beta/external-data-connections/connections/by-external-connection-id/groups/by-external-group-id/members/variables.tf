variable "external_connection_id" {
  description = "The unique identifier of externalConnection"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.external_connection_id)) > 0
    error_message = "external_connection_id must not be empty."
  }
}

variable "external_group_id" {
  description = "The unique identifier of externalGroup"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.external_group_id)) > 0
    error_message = "external_group_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalConnectors.identity"
  nullable    = false
}

variable "type" {
  description = "The type of identity. The possible values are: user or group for Microsoft Entra identities and externalgroup for groups in an external system."
  type        = any
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["user", "group", "externalGroup", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
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
