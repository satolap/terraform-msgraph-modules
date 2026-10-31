variable "accessPackageAssignment" {
  description = "For a requestType of UserAdd or AdminAdd, an access package assignment requested to be created. For a requestType of UserRemove, AdminRemove, ApproverRemove, or SystemRemove, this property has the id property of an existing assignment to be removed. Supports $expand."
  type        = any
  default     = null
}

variable "answers" {
  description = "Answers provided by the requestor to accessPackageQuestions asked of them at the time of request."
  type        = any
  default     = null
}

variable "customExtensionCalloutInstances" {
  description = "Information about all the custom extension calls that were made during the access package assignment request workflow."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionCalloutInstance")
    customExtensionId     = optional(string)
    detail                = optional(string)
    externalCorrelationId = optional(string)
    status                = optional(string)
  }))
  default = null

  validation {
    condition     = (var.customExtensionCalloutInstances == null ? true : alltrue([alltrue([for input0 in var.customExtensionCalloutInstances : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["calloutSent", "callbackReceived", "calloutFailed", "callbackTimedOut", "waitingForCallback"], input0["status"]))]))]))])]))
    error_message = "customExtensionCalloutInstances: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "expirationDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "history" {
  description = "Microsoft Graph history property."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.requestActivity")
    action            = optional(string)
    actionDateTime    = optional(string)
    detail            = optional(string)
    scheduledDateTime = optional(string)
    userDisplayName   = optional(string)
    userPrincipalName = optional(string)
  }))
  default = null
}

variable "isValidationOnly" {
  description = "True if the request isn't to be processed for assignment."
  type        = bool
  default     = null
}

variable "justification" {
  description = "The requestor's supplied justification."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageAssignmentRequest"
  nullable    = false
}

variable "parameters" {
  description = "Additional parameters that control how the request is processed, such as bypassing the approval requirement configured on the access package policy."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.accessPackageAssignmentRequestParameters")
    bypassApproval = optional(bool)
  })
  default = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "completedDate", "createdDateTime", "customExtensionHandlerInstances", "id", "requestState", "requestStatus", "requestType", "requestor", "schedule", "verifiedCredentialsData"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
