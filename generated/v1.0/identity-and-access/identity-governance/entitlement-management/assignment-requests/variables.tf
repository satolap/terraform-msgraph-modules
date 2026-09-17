variable "answers" {
  description = "Answers provided by the requestor to accessPackageQuestions asked of them at the time of request."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.accessPackageAnswer")
    answeredQuestion = optional(any)
    displayValue     = optional(string)
  }))
  default = null
}

variable "assignment" {
  description = "For a requestType of userAdd or adminAdd, this is an access package assignment requested to be created. For a requestType of userRemove, adminRemove, approverRemove, or systemRemove, this has the id property of an existing assignment to be removed.   Supports $expand."
  type        = any
  default     = null
}

variable "custom_extension_callout_instances" {
  description = "Information about all the custom extension calls that were made during the access package assignment workflow."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionCalloutInstance")
    customExtensionId     = optional(string)
    detail                = optional(string)
    externalCorrelationId = optional(string)
    status                = optional(any)
  }))
  default = null
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
  description = "Microsoft Graph parameters property."
  type        = any
  default     = null
}

variable "request_type" {
  description = "The type of the request. The possible values are: notSpecified, userAdd, userUpdate, userRemove, adminAdd, adminUpdate, adminRemove, systemAdd, systemUpdate, systemRemove, onBehalfAdd (not supported), unknownFutureValue. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: approverRemove. Requests from the user have a requestType of userAdd, userUpdate, or userRemove. This property can't be changed once set."
  type        = any
  default     = null

  validation {
    condition     = var.request_type == null ? true : contains(["notSpecified", "userAdd", "userUpdate", "userRemove", "adminAdd", "adminUpdate", "adminRemove", "systemAdd", "systemUpdate", "systemRemove", "onBehalfAdd", "unknownFutureValue", "approverRemove"], var.request_type)
    error_message = "request_type must be one of the documented enum values."
  }
}

variable "schedule" {
  description = "The range of dates that access is to be assigned to the requestor. This property can't be changed once set, but a new schedule for an assignment can be included in another userUpdate or adminUpdate assignment request."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "completedDateTime", "createdDateTime", "id", "requestor", "state", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
