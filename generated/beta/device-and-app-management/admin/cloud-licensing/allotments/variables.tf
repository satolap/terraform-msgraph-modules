variable "assignable_to" {
  description = "Microsoft Graph assignableTo property."
  type        = string
  default     = null

  validation {
    condition     = var.assignable_to == null ? true : contains(["none", "user", "group", "device", "unknownFutureValue"], var.assignable_to)
    error_message = "assignable_to must be one of the documented enum values."
  }
}

variable "assignments" {
  description = "The list of license assignments that consume licenses from this allotment. Not nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.cloudLicensing.assignment")
    allotment  = optional(any)
    assignedTo = optional(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    }))
    disabledServicePlanIds = optional(list(string))
  }))
  default = null
}

variable "external_service_identifier" {
  description = "Microsoft Graph externalServiceIdentifier property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudLicensing.allotment"
  nullable    = false
}

variable "subscriptions" {
  description = "Basic information about the subscriptions that supports this allotment."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.cloudLicensing.subscription")
    nextLifecycleDate = optional(string)
    startDate         = optional(string)
    state             = optional(string)
    subscriptionId    = optional(string)
    tags              = optional(string)
  }))
  default = null
}

variable "waiting_members" {
  description = "List of over-assigned users who are in the waiting room for an allotment due to license capacity limits."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.cloudLicensing.waitingMember")
    allotment = optional(object({
      odata_type   = optional(string, "#microsoft.graph.cloudLicensing.allotment")
      assignableTo = optional(string)
      assignments = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.cloudLicensing.assignment")
        allotment              = optional(any)
        assignedTo             = optional(any)
        disabledServicePlanIds = optional(any)
      })))
      externalServiceIdentifier = optional(string)
      subscriptions = optional(list(object({
        odata_type        = optional(string, "#microsoft.graph.cloudLicensing.subscription")
        nextLifecycleDate = optional(string)
        startDate         = optional(string)
        state             = optional(string)
        subscriptionId    = optional(string)
        tags              = optional(string)
      })))
      waitingMembers = optional(any)
    }))
    assignedTo = optional(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    }))
    waitingSinceDateTime = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["allottedUnits", "consumedUnits", "id", "services", "skuId", "skuPartNumber"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
