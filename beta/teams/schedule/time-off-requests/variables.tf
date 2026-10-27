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
  type        = string
  default     = null

  validation {
    condition     = var.assigned_to == null ? true : contains(["sender", "recipient", "manager", "system"], var.assigned_to)
    error_message = "assigned_to must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "end_date_time" {
  description = "The date and time the time off ends in ISO 8601 format and in UTC time."
  type        = string
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
  default     = "#microsoft.graph.timeOffRequest"
  nullable    = false
}

variable "sender_message" {
  description = "The message sent by the sender of the scheduleChangeRequest. Optional."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "The date and time the time off starts in ISO 8601 format and in UTC time."
  type        = string
  default     = null
}

variable "state" {
  description = "The state of the scheduleChangeRequest. The possible values are: pending, approved, declined, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["pending", "approved", "declined"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "time_off_reason_id" {
  description = "The reason for the time off."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime", "managerActionDateTime", "managerUserId", "senderDateTime", "senderUserId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
