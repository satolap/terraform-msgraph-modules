variable "createdBy" {
  description = "The user who created the retentionEvent."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "The date time when the retentionEvent was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional information about the event."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Name of the event."
  type        = string
  default     = null
}

variable "eventPropagationResults" {
  description = "Represents the success status of a created event and additional information."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.security.eventPropagationResult")
    location          = optional(string)
    serviceName       = optional(string)
    status            = optional(string)
    statusInformation = optional(string)
  }))
  default = null

  validation {
    condition     = (var.eventPropagationResults == null ? true : alltrue([alltrue([for input0 in var.eventPropagationResults : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["none", "inProcessing", "failed", "success"], input0["status"]))]))]))])]))
    error_message = "eventPropagationResults: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "eventQueries" {
  description = "Represents the workload (SharePoint Online, OneDrive for Business, Exchange Online) and identification information associated with a retention event."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.eventQuery")
    query      = optional(string)
    queryType  = optional(string)
  }))
  default = null

  validation {
    condition     = (var.eventQueries == null ? true : alltrue([alltrue([for input0 in var.eventQueries : (input0 == null ? true : alltrue([(input0["queryType"] == null ? true : alltrue([(input0["queryType"] == null ? true : contains(["files", "messages"], input0["queryType"]))]))]))])]))
    error_message = "eventQueries: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "eventStatus" {
  description = "Status of event propogation to the scoped locations after the event has been created."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.retentionEventStatus")
    error = optional(object({
      odata_type = optional(string, "#microsoft.graph.publicError")
      code       = optional(string)
      details = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
        code       = optional(string)
        message    = optional(string)
        target     = optional(string)
      })))
      innerError = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicInnerError")
        code       = optional(string)
        details = optional(list(object({
          odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
          code       = optional(string)
          message    = optional(string)
          target     = optional(string)
        })))
        message = optional(string)
        target  = optional(string)
      }))
      message = optional(string)
      target  = optional(string)
    }))
    status = optional(string)
  })
  default = null

  validation {
    condition     = (var.eventStatus == null ? true : alltrue([(var.eventStatus["status"] == null ? true : alltrue([(var.eventStatus["status"] == null ? true : contains(["pending", "error", "success", "notAvaliable"], var.eventStatus["status"]))]))]))
    error_message = "eventStatus: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "eventTriggerDateTime" {
  description = "Optional time when the event should be triggered."
  type        = string
  default     = null
}

variable "lastModifiedBy" {
  description = "The user who last modified the retentionEvent."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The latest date time when the retentionEvent was modified."
  type        = string
  default     = null
}

variable "lastStatusUpdateDateTime" {
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

variable "retentionEventType" {
  description = "Specifies the event that will start the retention period for labels that use this event type when an event is created."
  type        = any
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
