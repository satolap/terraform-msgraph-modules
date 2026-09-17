variable "assignments" {
  description = "The collection of assignments that grant user or service principal identities access to this pool."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.cloudPcPoolAssignment")
  }))
  default = null
}

variable "capabilities" {
  description = "Microsoft Graph capabilities property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.cloudPcPoolCapabilityConfiguration")
  })
  default = null
}

variable "cloud_pc_configuration" {
  description = "Microsoft Graph cloudPcConfiguration property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.cloudPcConfiguration")
    imageId    = optional(string)
    imageType  = optional(string)
    osLocale   = optional(string)
  })
  default = null
}

variable "description" {
  description = "The description of the pool. The maximum length is 512 characters."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the pool. The name is unique across Cloud PC pools in an organization. The maximum length is 60 characters."
  type        = string
  default     = null
}

variable "network_configuration" {
  description = "Microsoft Graph networkConfiguration property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.cloudPcNetworkConfiguration")
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcPool"
  nullable    = false
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
