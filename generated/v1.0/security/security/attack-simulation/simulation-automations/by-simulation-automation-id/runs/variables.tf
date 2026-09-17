variable "simulation_automation_id" {
  description = "The unique identifier of simulationAutomation"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.simulation_automation_id)) > 0
    error_message = "simulation_automation_id must not be empty."
  }
}

variable "end_date_time" {
  description = "Date and time when the run ends in an attack simulation automation."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.simulationAutomationRun"
  nullable    = false
}

variable "simulation_id" {
  description = "Unique identifier for the attack simulation campaign initiated in the attack simulation automation run."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "Date and time when the run starts in an attack simulation automation."
  type        = string
  default     = null
}

variable "status" {
  description = "Status of the attack simulation automation run. The possible values are: unknown, running, succeeded, failed, skipped, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "running", "succeeded", "failed", "skipped", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
