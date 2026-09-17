variable "connection_info" {
  description = "Microsoft Graph connectionInfo property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.connectionInfo")
    url        = optional(string)
  })
  default = null
}

variable "connector_type" {
  description = "Microsoft Graph connectorType property."
  type        = string
  default     = null

  validation {
    condition     = var.connector_type == null ? true : contains(["sapIag", "sapAc", "unknownFutureValue"], var.connector_type)
    error_message = "connector_type must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "The identifier of the user or application that created the connector."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the connector was created."
  type        = string
  default     = null
}

variable "description" {
  description = "A description of the connector."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the connector."
  type        = string
  default     = null
}

variable "modified_by" {
  description = "The identifier of the user or application that last modified the connector."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "The date and time when the connector was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalOriginResourceConnector"
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
