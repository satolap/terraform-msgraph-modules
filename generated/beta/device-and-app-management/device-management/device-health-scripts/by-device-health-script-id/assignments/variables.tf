variable "device_health_script_id" {
  description = "The unique identifier of deviceHealthScript"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_health_script_id)) > 0
    error_message = "device_health_script_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceHealthScriptAssignment"
  nullable    = false
}

variable "run_remediation_script" {
  description = "Determine whether we want to run detection script only or run both detection script and remediation script"
  type        = bool
  default     = null
}

variable "run_schedule" {
  description = "Script run schedule for the target group"
  type        = any
  default     = null
}

variable "target" {
  description = "The Azure Active Directory group we are targeting the script to"
  type        = any
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
