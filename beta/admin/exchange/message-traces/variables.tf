variable "destination_ip_address" {
  description = "Microsoft Graph destinationIPAddress property."
  type        = string
  default     = null
}

variable "message_id" {
  description = "Microsoft Graph messageId property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.messageTrace"
  nullable    = false
}

variable "received_date_time" {
  description = "Microsoft Graph receivedDateTime property."
  type        = string
  default     = null
}

variable "recipients" {
  description = "Microsoft Graph recipients property."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.messageRecipient")
    deliveryStatus = optional(string)
    events = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.messageEvent")
      dateTime    = optional(string)
      description = optional(string)
      eventType   = optional(string)
    })))
    recipientEmail = optional(string)
  }))
  default = null
}

variable "sender_email" {
  description = "Microsoft Graph senderEmail property."
  type        = string
  default     = null
}

variable "size" {
  description = "Microsoft Graph size property."
  type        = number
  default     = null
}

variable "source_ip_address" {
  description = "Microsoft Graph sourceIPAddress property."
  type        = string
  default     = null
}

variable "subject" {
  description = "Microsoft Graph subject property."
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
