variable "allowed_values" {
  description = "Values that are predefined for this custom security attribute. This navigation property is not returned by default and must be specified in an $expand query. For example, /directory/customSecurityAttributeDefinitions?$expand=allowedValues."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.allowedValue")
    isActive   = optional(bool)
  }))
  default = null
}

variable "attribute_set" {
  description = "Name of the attribute set. Case insensitive."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the custom security attribute. Can be up to 128 characters long and include Unicode characters. Can be changed later."
  type        = string
  default     = null
}

variable "is_collection" {
  description = "Indicates whether multiple values can be assigned to the custom security attribute. Cannot be changed later. If type is set to Boolean, isCollection cannot be set to true."
  type        = bool
  default     = null
}

variable "is_searchable" {
  description = "Indicates whether custom security attribute values are indexed for searching on objects that are assigned attribute values. Cannot be changed later."
  type        = bool
  default     = null
}

variable "name" {
  description = "Name of the custom security attribute. Must be unique within an attribute set. Can be up to 32 characters long and include Unicode characters. Cannot contain spaces or special characters. Cannot be changed later. Case insensitive."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.customSecurityAttributeDefinition"
  nullable    = false
}

variable "status" {
  description = "Specifies whether the custom security attribute is active or deactivated. Acceptable values are: Available and Deprecated. Can be changed later."
  type        = string
  default     = null
}

variable "type" {
  description = "Data type for the custom security attribute values. Supported types are: Boolean, Integer, and String. Cannot be changed later."
  type        = string
  default     = null
}

variable "use_pre_defined_values_only" {
  description = "Indicates whether only predefined values can be assigned to the custom security attribute. If set to false, free-form values are allowed. Can later be changed from true to false, but cannot be changed from false to true. If type is set to Boolean, usePreDefinedValuesOnly cannot be set to true."
  type        = bool
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
