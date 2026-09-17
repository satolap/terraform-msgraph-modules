variable "printer_share_id" {
  description = "The unique identifier of printerShare"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.printer_share_id)) > 0
    error_message = "printer_share_id must not be empty."
  }
}

variable "print_job_id" {
  description = "The unique identifier of printJob"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.print_job_id)) > 0
    error_message = "print_job_id must not be empty."
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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printTask"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.printTaskStatus")
    description = optional(string)
    state       = optional(string)
  })
  default = null
}

variable "trigger" {
  description = "Microsoft Graph trigger property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.printTaskTrigger")
    definition = optional(object({
      odata_type = optional(string, "#microsoft.graph.printTaskDefinition")
      createdBy = optional(object({
        odata_type           = optional(string, "#microsoft.graph.appIdentity")
        appId                = optional(string)
        displayName          = optional(string)
        servicePrincipalId   = optional(string)
        servicePrincipalName = optional(string)
      }))
      displayName = optional(string)
    }))
    event = optional(string)
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "parentUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
