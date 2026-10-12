variable "assigned_to" {
  description = "The name or email of the admin this task is assigned to."
  type        = string
  default     = null
}

variable "category" {
  description = "Device app management task category."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["unknown", "advancedThreatProtection"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "created_date_time" {
  description = "The created date."
  type        = string
  default     = null
}

variable "creator" {
  description = "The email address of the creator."
  type        = string
  default     = null
}

variable "creator_notes" {
  description = "Notes from the creator."
  type        = string
  default     = null
}

variable "description" {
  description = "The description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name."
  type        = string
  default     = null
}

variable "due_date_time" {
  description = "The due date."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceAppManagementTask"
  nullable    = false
}

variable "priority" {
  description = "Device app management task priority."
  type        = string
  default     = null

  validation {
    condition     = var.priority == null ? true : contains(["none", "high", "low"], var.priority)
    error_message = "priority must be one of the documented enum values."
  }
}

variable "status" {
  description = "Device app management task status."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "pending", "active", "completed", "rejected"], var.status)
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
