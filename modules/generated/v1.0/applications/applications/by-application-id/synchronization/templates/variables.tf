variable "application_id" {
  description = "The unique identifier of application"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.application_id)) > 0
    error_message = "application_id must not be empty."
  }
}

variable "application_id_2" {
  description = "Identifier of the application this template belongs to."
  type        = string
  default     = null
}

variable "default" {
  description = "true if this template is recommended to be the default for the application."
  type        = bool
  default     = null
}

variable "description" {
  description = "Description of the template."
  type        = string
  default     = null
}

variable "discoverable" {
  description = "true if this template should appear in the collection of templates available for the application instance (service principal)."
  type        = bool
  default     = null
}

variable "factory_tag" {
  description = "One of the well-known factory tags supported by the synchronization engine. The factoryTag tells the synchronization engine which implementation to use when processing jobs based on this template."
  type        = string
  default     = null
}

variable "metadata" {
  description = "Additional extension properties. Unless mentioned explicitly, metadata values should not be changed."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.synchronizationMetadataEntry")
    key        = optional(any)
    value      = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.synchronizationTemplate"
  nullable    = false
}

variable "schema" {
  description = "Default synchronization schema for the jobs based on this template."
  type        = any
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
