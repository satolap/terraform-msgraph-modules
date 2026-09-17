variable "program_control_id" {
  description = "The unique identifier of programControl"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.program_control_id)) > 0
    error_message = "program_control_id must not be empty."
  }
}

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
  type        = any
  default     = null
}

variable "status" {
  description = "The life cycle status of the control."
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
