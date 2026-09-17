variable "content" {
  description = "Microsoft Graph content property."
  type        = string
  default     = null
}

variable "file_type" {
  description = "Microsoft Graph fileType property."
  type        = string
  default     = null

  validation {
    condition     = var.file_type == null ? true : contains(["dlpPolicy", "dlpSensitiveInformationType", "dataCollectionPolicy", "unknownFutureValue"], var.file_type)
    error_message = "file_type must be one of the documented enum values."
  }
}

variable "graph_version" {
  description = "Microsoft Graph version property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.policyFile"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["modified", "notModified", "noContent", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
