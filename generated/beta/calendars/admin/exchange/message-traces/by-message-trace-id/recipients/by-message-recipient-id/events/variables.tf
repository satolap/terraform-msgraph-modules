variable "message_trace_id" {
  description = "The unique identifier of messageTrace"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.message_trace_id)) > 0
    error_message = "message_trace_id must not be empty."
  }
}

variable "message_recipient_id" {
  description = "The unique identifier of messageRecipient"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.message_recipient_id)) > 0
    error_message = "message_recipient_id must not be empty."
  }
}

variable "date_time" {
  description = "Microsoft Graph dateTime property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "event_type" {
  description = "Microsoft Graph eventType property."
  type        = string
  default     = null

  validation {
    condition     = var.event_type == null ? true : contains(["received", "sent", "delivered", "failed", "processingFailed", "distributionGroupExpanded", "submitted", "delayed", "redirected", "resolved", "dropped", "recipientsAdded", "malwareDetected", "malwareDetectedInMessage", "malwareDetectedInAttachment", "ttZapped", "ttDelivered", "spamDetected", "transportRuleTriggered", "dlpRuleTriggered", "journaled", "unknownFutureValue"], var.event_type)
    error_message = "event_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.messageEvent"
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
