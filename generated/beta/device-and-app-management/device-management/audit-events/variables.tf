variable "activity" {
  description = "Friendly name of the activity."
  type        = string
  default     = null
}

variable "activity_date_time" {
  description = "The date time in UTC when the activity was performed."
  type        = string
  default     = null
}

variable "activity_operation_type" {
  description = "The HTTP operation type of the activity."
  type        = string
  default     = null
}

variable "activity_result" {
  description = "The result of the activity."
  type        = string
  default     = null
}

variable "activity_type" {
  description = "The type of activity that was being performed."
  type        = string
  default     = null
}

variable "actor" {
  description = "AAD user and application that are associated with the audit event."
  type        = any
  default     = null
}

variable "category" {
  description = "Audit category."
  type        = string
  default     = null
}

variable "component_name" {
  description = "Component name."
  type        = string
  default     = null
}

variable "correlation_id" {
  description = "The client request Id that is used to correlate activity within the system."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Event display name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.auditEvent"
  nullable    = false
}

variable "resources" {
  description = "Resources being modified."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.auditResource")
    auditResourceType = optional(string)
    displayName       = optional(string)
    modifiedProperties = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.auditProperty")
      displayName = optional(string)
      newValue    = optional(string)
      oldValue    = optional(string)
    })))
    resourceId = optional(string)
    type       = optional(string)
  }))
  default = null
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
