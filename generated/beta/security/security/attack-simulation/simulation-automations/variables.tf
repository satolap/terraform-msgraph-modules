variable "created_by" {
  description = "Identity of the user who created the attack simulation automation."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the attack simulation automation was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the attack simulation automation."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the attack simulation automation. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the user who most recently modified the attack simulation automation."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Date and time when the attack simulation automation was most recently modified."
  type        = string
  default     = null
}

variable "last_run_date_time" {
  description = "Date and time of the latest run of the attack simulation automation."
  type        = string
  default     = null
}

variable "next_run_date_time" {
  description = "Date and time of the upcoming run of the attack simulation automation."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.simulationAutomation"
  nullable    = false
}

variable "runs" {
  description = "A collection of simulation automation runs."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.simulationAutomationRun")
    endDateTime   = optional(string)
    simulationId  = optional(string)
    startDateTime = optional(string)
    status        = optional(any)
  }))
  default = null
}

variable "status" {
  description = "Status of the attack simulation automation. Supports $filter and $orderby. The possible values are: unknown, draft, notRunning, running, completed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "draft", "notRunning", "running", "completed", "unknownFutureValue"], var.status)
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
