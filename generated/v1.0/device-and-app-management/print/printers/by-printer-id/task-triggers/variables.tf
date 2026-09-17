variable "printer_id" {
  description = "The unique identifier of printer"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.printer_id)) > 0
    error_message = "printer_id must not be empty."
  }
}

variable "definition" {
  description = "Microsoft Graph definition property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.printTaskDefinition")
    createdBy = optional(object({
      odata_type           = optional(string, "#microsoft.graph.appIdentity")
      appId                = optional(string)
      displayName          = optional(string)
      servicePrincipalId   = optional(string)
      servicePrincipalName = optional(string)
    }))
    displayName = optional(string)
  })
  default = null
}

variable "event" {
  description = "Microsoft Graph event property."
  type        = string
  default     = null

  validation {
    condition     = var.event == null ? true : contains(["jobStarted", "unknownFutureValue"], var.event)
    error_message = "event must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printTaskTrigger"
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
