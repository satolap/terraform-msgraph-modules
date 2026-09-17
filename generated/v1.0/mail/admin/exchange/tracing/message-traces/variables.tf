variable "from_ip" {
  description = "The source IP address. For incoming messages, this value is the public IP address of the SMTP email server that sent the message. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "message_id" {
  description = "The Message-ID header field of the message. The format of the Message-ID depends on the messaging server that sent the message. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.exchangeMessageTrace"
  nullable    = false
}

variable "received_date_time" {
  description = "The date and time when the message was received by Exchange Online. The timestamp is in UTC format. Supports $filter (ge, le)."
  type        = string
  default     = null
}

variable "recipient_address" {
  description = "The SMTP email address of the user that the message was addressed to. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "sender_address" {
  description = "The SMTP email address of the user the message was purportedly from. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "size" {
  description = "The size of the message in bytes."
  type        = number
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["gettingStatus", "pending", "failed", "delivered", "expanded", "quarantined", "filteredAsSpam", "unknownFutureValue", "recalled"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "subject" {
  description = "The subject line of the message. Supports $filter (contains, startsWith, endsWith)."
  type        = string
  default     = null
}

variable "to_ip" {
  description = "The destination IP address. For outgoing messages, this value is the public IP address in the resolved MX record for the destination domain. For incoming messages to Exchange Online, this value is blank. Supports $filter (eq)."
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
