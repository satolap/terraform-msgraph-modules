variable "external_connection_id" {
  description = "The unique identifier of externalConnection"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.external_connection_id)) > 0
    error_message = "external_connection_id must not be empty."
  }
}

variable "acl" {
  description = "An array of access control entries. Each entry specifies the access granted to a user or group. Required."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.externalConnectors.acl")
    accessType = optional(string)
    type       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "activities" {
  description = "Returns a list of activities performed on the item. Write-only."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.externalConnectors.externalActivity")
    performedBy   = optional(any)
    startDateTime = optional(string)
    type          = optional(string)
  }))
  default = null
}

variable "content" {
  description = "A plain-text  representation of the contents of the item. The text in this property is full-text indexed. Optional."
  type        = any
  default     = null
}

variable "information_protection_label" {
  description = "Microsoft Graph informationProtectionLabel property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalConnectors.externalItem"
  nullable    = false
}

variable "properties" {
  description = "A property bag with the properties of the item. The properties MUST conform to the schema defined for the externalConnection. Required."
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
