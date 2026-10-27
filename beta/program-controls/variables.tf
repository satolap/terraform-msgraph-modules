variable "control_id" {
  description = "The controlId of the control, in particular the identifier of an access review. Required on create."
  type        = string
  default     = null
}

variable "control_type_id" {
  description = "The programControlType identifies the type of program control - for example, a control linking to guest access reviews. Required on create."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The creation date and time of the program control."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the control."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.programControl"
  nullable    = false
}

variable "owner" {
  description = "The user who created the program control."
  type        = any
  default     = null
}

variable "program" {
  description = "The program this control is part of."
  type        = any
  default     = null
}

variable "program_id" {
  description = "The programId of the program this control is a part of. Required on create."
  type        = string
  default     = null
}

variable "resource" {
  description = "The resource, a group or an app, targeted by this program control's access review."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.programResource")
    displayName = optional(string)
    id          = optional(string)
    type        = optional(string)
  })
  default = null
}

variable "status" {
  description = "The life cycle status of the control."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
