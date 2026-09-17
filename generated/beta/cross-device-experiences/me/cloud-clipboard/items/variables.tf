variable "created_date_time" {
  description = "Set by the server. DateTime in UTC when the object was created on the server."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Set by the server. DateTime in UTC when the object expires and after that the object is no longer available. The default and also maximum TTL is 12 hours after the creation, but it might change for performance optimization."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Set by the server if not provided in the client's request. DateTime in UTC when the object was modified by the client."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudClipboardItem"
  nullable    = false
}

variable "payloads" {
  description = "A cloudClipboardItem can have multiple cloudClipboardItemPayload objects in the payloads. A window can place more than one clipboard object on the clipboard. Each one represents the same information in a different clipboard format."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.cloudClipboardItemPayload")
    content    = optional(string)
    formatName = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
