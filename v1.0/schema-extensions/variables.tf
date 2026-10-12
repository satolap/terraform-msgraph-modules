variable "description" {
  description = "Description for the schema extension."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.schemaExtension"
  nullable    = false
}

variable "properties" {
  description = "The collection of property names and types that make up the schema extension definition."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extensionSchemaProperty")
    name       = optional(string)
    type       = optional(string)
  }))
  default = null
}

variable "status" {
  description = "The lifecycle state of the schema extension. Possible states are InDevelopment, Available, and Deprecated. Automatically set to InDevelopment on creation. For more information about the possible state transitions and behaviors, see Schema extensions lifecycle. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "target_types" {
  description = "Set of Microsoft Graph types (that can support extensions) that the schema extension can be applied to. Select from administrativeUnit, contact, device, event, group, message, organization, post, todoTask, todoTaskList, or user."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "owner"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
