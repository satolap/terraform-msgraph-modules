variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "assigned_to" {
  description = "Indicates who the request is assigned to. The possible values are: sender, recipient, manager, system, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.assigned_to == null ? true : contains(["sender", "recipient", "manager", "system", "unknownFutureValue"], var.assigned_to)
    error_message = "assigned_to must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "Identity of the creator of the entity."
  type        = any
  default     = null
}

variable "manager_action_message" {
  description = "The message sent by the manager regarding the scheduleChangeRequest. Optional."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.offerShiftRequest"
  nullable    = false
}

variable "recipient_action_message" {
  description = "The message sent by the recipient regarding the request."
  type        = string
  default     = null
}

variable "recipient_user_id" {
  description = "The recipient's user ID."
  type        = string
  default     = null
}

variable "sender_message" {
  description = "The message sent by the sender of the scheduleChangeRequest. Optional."
  type        = string
  default     = null
}

variable "sender_shift_id" {
  description = "The sender's shift ID."
  type        = string
  default     = null
}

variable "state" {
  description = "The state of the scheduleChangeRequest. The possible values are: pending, approved, declined, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["pending", "approved", "declined", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime", "managerActionDateTime", "managerUserId", "recipientActionDateTime", "senderDateTime", "senderUserId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
