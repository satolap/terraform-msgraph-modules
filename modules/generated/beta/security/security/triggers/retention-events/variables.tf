variable "created_by" {
  description = "The user who created the retentionEvent."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date time when the retentionEvent was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional information about the event."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the event."
  type        = string
  default     = null
}

variable "event_propagation_results" {
  description = "Represents the success status of a created event and additional information."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.eventPropagationResult")
    location          = optional(string)
    serviceName       = optional(string)
    status            = optional(any)
    statusInformation = optional(string)
  }))
  default = null
}

variable "event_queries" {
  description = "Represents the workload (SharePoint Online, OneDrive for Business, Exchange Online) and identification information associated with a retention event."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.eventQuery")
    query      = optional(string)
    queryType  = optional(any)
  }))
  default = null
}

variable "event_status" {
  description = "Status of event propogation to the scoped locations after the event has been created."
  type        = any
  default     = null
}

variable "event_trigger_date_time" {
  description = "Optional time when the event should be triggered."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user who last modified the retentionEvent."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The latest date time when the retentionEvent was modified."
  type        = string
  default     = null
}

variable "last_status_update_date_time" {
  description = "Last time the status of the event was updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.retentionEvent"
  nullable    = false
}

variable "retention_event_type" {
  description = "Specifies the event that will start the retention period for labels that use this event type when an event is created."
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
