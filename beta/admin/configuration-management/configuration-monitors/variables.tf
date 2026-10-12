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
}

variable "description" {
  description = "User-friendly description of the monitor given by the user. Supports $filter (eq, ne, startsWith) and $orderby."
  type        = string
  default     = null
}

variable "display_name" {
  description = "User-friendly name given by the user to the monitor. Supports $filter (eq, ne, startsWith) and $orderby."
  type        = string
  default     = null
}

variable "mode" {
  description = "Microsoft Graph mode property."
  type        = string
  default     = null

  validation {
    condition     = var.mode == null ? true : contains(["monitorOnly", "unknownFutureValue"], var.mode)
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
