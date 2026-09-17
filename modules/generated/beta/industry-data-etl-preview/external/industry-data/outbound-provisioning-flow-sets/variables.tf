variable "display_name" {
  description = "The display name of the flowSet provided by the caller."
  type        = string
  default     = null
}

variable "filter" {
  description = "The collection of provisioning filters applicable to all the flows under the given flowSet."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.industryData.outboundProvisioningFlowSet"
  nullable    = false
}

variable "provisioning_flows" {
  description = "A flow that provisions relevant records of a given entity type in the Microsoft 365 tenant."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.industryData.provisioningFlow")
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
