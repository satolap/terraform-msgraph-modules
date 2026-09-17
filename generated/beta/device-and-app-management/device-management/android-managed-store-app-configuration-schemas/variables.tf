variable "example_json" {
  description = "UTF8 encoded byte array containing example JSON string conforming to this schema that demonstrates how to set the configuration for this app"
  type        = string
  default     = null
}

variable "nested_schema_items" {
  description = "Collection of items each representing a named configuration option in the schema. It contains a flat list of all configuration."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.androidManagedStoreAppConfigurationSchemaItem")
    dataType                = optional(string)
    defaultBoolValue        = optional(bool)
    defaultIntValue         = optional(number)
    defaultStringArrayValue = optional(list(string))
    defaultStringValue      = optional(string)
    description             = optional(string)
    displayName             = optional(string)
    index                   = optional(number)
    parentIndex             = optional(number)
    schemaItemKey           = optional(string)
    selections = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValuePair")
      name       = optional(string)
      value      = optional(string)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.androidManagedStoreAppConfigurationSchema"
  nullable    = false
}

variable "schema_items" {
  description = "Collection of items each representing a named configuration option in the schema. It only contains the root-level configuration."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.androidManagedStoreAppConfigurationSchemaItem")
    dataType                = optional(string)
    defaultBoolValue        = optional(bool)
    defaultIntValue         = optional(number)
    defaultStringArrayValue = optional(list(string))
    defaultStringValue      = optional(string)
    description             = optional(string)
    displayName             = optional(string)
    index                   = optional(number)
    parentIndex             = optional(number)
    schemaItemKey           = optional(string)
    selections = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValuePair")
      name       = optional(string)
      value      = optional(string)
    })))
  }))
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
