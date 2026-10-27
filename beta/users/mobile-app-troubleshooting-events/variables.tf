variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "additional_information" {
  description = "A set of string key and string value pairs which provides additional information on the Troubleshooting event"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "app_log_collection_requests" {
  description = "Indicates collection of App Log Upload Request."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.appLogCollectionRequest")
    completedDateTime = optional(string)
    customLogFolders  = optional(list(string))
    errorMessage      = optional(string)
    status            = optional(string)
  }))
  default = null

  validation {
    condition     = (var.app_log_collection_requests == null ? true : alltrue([alltrue([for input0 in var.app_log_collection_requests : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["pending", "completed", "failed"], input0["status"]))]))]))])]))
    error_message = "app_log_collection_requests: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "application_id" {
  description = "Intune application identifier."
  type        = string
  default     = null
}

variable "correlation_id" {
  description = "Id used for tracing the failure in the service."
  type        = string
  default     = null
}

variable "device_id" {
  description = "Device identifier created or collected by Intune."
  type        = string
  default     = null
}

variable "event_date_time" {
  description = "Time when the event occurred ."
  type        = string
  default     = null
}

variable "event_name" {
  description = "Event Name corresponding to the Troubleshooting Event. It is an Optional field"
  type        = string
  default     = null
}

variable "history" {
  description = "Intune Mobile Application Troubleshooting History Item"
  type        = any
  default     = null
}

variable "managed_device_identifier" {
  description = "Device identifier created or collected by Intune."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileAppTroubleshootingEvent"
  nullable    = false
}

variable "troubleshooting_error_details" {
  description = "Object containing detailed information about the error and its remediation."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.deviceManagementTroubleshootingErrorDetails")
    context        = optional(string)
    failure        = optional(string)
    failureDetails = optional(string)
    remediation    = optional(string)
    resources = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.deviceManagementTroubleshootingErrorResource")
      link       = optional(string)
      text       = optional(string)
    })))
  })
  default = null
}

variable "user_id_2" {
  description = "Identifier for the user that tried to enroll the device."
  type        = string
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
