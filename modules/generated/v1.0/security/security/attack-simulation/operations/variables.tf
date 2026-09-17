variable "created_date_time" {
  description = "The start time of the operation. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_action_date_time" {
  description = "The time of the last action in the operation. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.attackSimulationOperation"
  nullable    = false
}

variable "percentage_completed" {
  description = "Percentage of completion of the respective operation."
  type        = number
  default     = null
}

variable "resource_location" {
  description = "URI of the resource that the operation is performed on."
  type        = string
  default     = null
}

variable "status" {
  description = "The status of the operation. The possible values are: notStarted, running, succeeded, failed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "running", "succeeded", "failed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "status_detail" {
  description = "Details about the status of the operation."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Tenant identifier."
  type        = string
  default     = null
}

variable "type" {
  description = "The attack simulation operation type. The possible values are: createSimulation, updateSimulation, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["createSimualation", "updateSimulation", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
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
