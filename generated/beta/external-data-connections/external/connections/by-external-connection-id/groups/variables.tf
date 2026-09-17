variable "external_connection_id" {
  description = "The unique identifier of externalConnection"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.external_connection_id)) > 0
    error_message = "external_connection_id must not be empty."
  }
}

variable "description" {
  description = "The description of the external group. Optional."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The friendly name of the external group. Optional."
  type        = string
  default     = null
}

variable "members" {
  description = "A member added to an externalGroup. You can add Microsoft Entra users, Microsoft Entra groups, or other externalGroups as members."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.externalConnectors.identity")
    type       = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalConnectors.externalGroup"
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
