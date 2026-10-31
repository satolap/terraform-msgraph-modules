variable "exampleJson" {
  description = "UTF8 encoded byte array containing example JSON string conforming to this schema that demonstrates how to set the configuration for this app"
  type        = string
  default     = null
}

variable "nestedSchemaItems" {
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

  validation {
    condition     = (var.nestedSchemaItems == null ? true : alltrue([alltrue([for input0 in var.nestedSchemaItems : (input0 == null ? true : alltrue([(input0["dataType"] == null ? true : alltrue([(input0["dataType"] == null ? true : contains(["bool", "integer", "string", "choice", "multiselect", "bundle", "bundleArray", "hidden"], input0["dataType"]))]))]))])]))
    error_message = "nestedSchemaItems: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.androidManagedStoreAppConfigurationSchema"
  nullable    = false
}

variable "schemaItems" {
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

  validation {
    condition     = (var.schemaItems == null ? true : alltrue([alltrue([for input0 in var.schemaItems : (input0 == null ? true : alltrue([(input0["dataType"] == null ? true : alltrue([(input0["dataType"] == null ? true : contains(["bool", "integer", "string", "choice", "multiselect", "bundle", "bundleArray", "hidden"], input0["dataType"]))]))]))])]))
    error_message = "schemaItems: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
