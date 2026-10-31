variable "baseline" {
  description = "Microsoft Graph baseline property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.configurationBaseline")
    description = optional(string)
    displayName = optional(string)
    parameters = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.baselineParameter")
      description   = optional(string)
      displayName   = optional(string)
      parameterType = optional(string)
    })))
    resources = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.baselineResource")
      displayName  = optional(string)
      properties   = optional(any)
      resourceType = optional(string)
    })))
  })
  default = null

  validation {
    condition     = (var.baseline == null ? true : alltrue([(var.baseline["parameters"] == null ? true : alltrue([alltrue([for input1 in var.baseline["parameters"] : (input1 == null ? true : alltrue([(input1["parameterType"] == null ? true : alltrue([(input1["parameterType"] == null ? true : contains(["string", "integer", "boolean"], input1["parameterType"]))]))]))])]))]))
    error_message = "baseline: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "User-friendly description of the monitor given by the user. Supports $filter (eq, ne, startsWith) and $orderby."
  type        = string
  default     = null
}

variable "displayName" {
  description = "User-friendly name given by the user to the monitor. Supports $filter (eq, ne, startsWith) and $orderby."
  type        = string
  default     = null
}

variable "mode" {
  description = "Microsoft Graph mode property."
  type        = string
  default     = null

  validation {
    condition     = var.mode == null ? true : contains(["monitorOnly"], var.mode)
    error_message = "mode must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.configurationMonitor"
  nullable    = false
}

variable "parameters" {
  description = "Key-value pairs that contain parameter values which might be used in the baseline. Requires $select to retrieve."
  type        = any
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "inactivationReason", "lastModifiedBy", "lastModifiedDateTime", "monitorRunFrequencyInHours", "status", "tenantId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
