variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The start time of the operation."
  type        = string
  default     = null
}

variable "error" {
  description = "The error returned by the operation."
  type        = any
  default     = null
}

variable "last_action_date_time" {
  description = "The time of the last action of the operation."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onenoteOperation"
  nullable    = false
}

variable "percent_complete" {
  description = "The operation percent complete if the operation is still in running status."
  type        = string
  default     = null
}

variable "resource_id" {
  description = "The resource id."
  type        = string
  default     = null
}

variable "resource_location" {
  description = "The resource URI for the object. For example, the resource URI for a copied page or section."
  type        = string
  default     = null
}

variable "status" {
  description = "The current status of the operation: notStarted, running, completed, failed"
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["NotStarted", "Running", "Completed", "Failed"], var.status)
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
