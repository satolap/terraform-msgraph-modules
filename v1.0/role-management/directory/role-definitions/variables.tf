variable "display_name" {
  description = "The display name for the unifiedRoleDefinition. Read-only when isBuiltIn is true. Required.  Supports $filter (eq, in)."
  type        = string
  nullable    = false
}

variable "is_enabled" {
  description = "Flag indicating whether the role is enabled for assignment. If false the role is not available for assignment. Read-only when isBuiltIn is true."
  type        = bool
  nullable    = false
}

variable "role_permissions" {
  description = "List of permissions included in the role. Read-only when isBuiltIn is true. Required."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.unifiedRolePermission")
    allowedResourceActions  = list(string)
    condition               = optional(string)
    excludedResourceActions = optional(list(string))
  }))
  nullable = false

  validation {
    condition     = (var.role_permissions == null ? true : alltrue([alltrue([for input0 in var.role_permissions : (input0 == null ? false : (input0 == null ? true : alltrue([(input0["allowedResourceActions"] == null ? false : alltrue([]))])))])]))
    error_message = "role_permissions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "The description for the unifiedRoleDefinition. Read-only when isBuiltIn is true."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Indicates version of the role definition. Read-only when isBuiltIn is true."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleDefinition"
  nullable    = false
}

variable "template_id" {
  description = "Custom template identifier that can be set when isBuiltIn is false but is read-only when isBuiltIn is true. This identifier is typically used if one needs an identifier to be the same across different directories."
  type        = string
  default     = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "inheritsPermissionsFrom", "isBuiltIn", "resourceScopes"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
