variable "delivery_status" {
  description = "Microsoft Graph deliveryStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.delivery_status == null ? true : contains(["gettingStatus", "pending", "failed", "delivered", "expanded", "quarantined", "filteredAsSpam", "unknownFutureValue"], var.delivery_status)
    error_message = "delivery_status must be one of the documented enum values."
  }
}

variable "events" {
  description = "Microsoft Graph events property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.messageEvent")
    dateTime    = optional(string)
    description = optional(string)
    eventType   = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.messageRecipient"
  nullable    = false
}

variable "recipient_email" {
  description = "Microsoft Graph recipientEmail property."
  type        = string
  default     = null
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
