variable "activity_date_time" {
  description = "Indicates the date and time the activity was performed. The Timestamp type is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq, ge, le) and $orderby."
  type        = string
  default     = null
}

variable "activity_display_name" {
  description = "Indicates the activity name or the operation name (examples: 'Create User' and 'Add member to group'). For a list of activities logged, refer to Microsoft Entra audit log categories and activities. Supports $filter (eq, startswith)."
  type        = string
  default     = null
}

variable "additional_details" {
  description = "Indicates additional details on the activity."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValue")
    key        = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "category" {
  description = "Indicates which resource category that's targeted by the activity. For example: UserManagement, GroupManagement, ApplicationManagement, RoleManagement. For a list of categories for activities logged, refer to Microsoft Entra audit log categories and activities."
  type        = string
  default     = null
}

variable "correlation_id" {
  description = "Indicates a unique ID that helps correlate activities that span across various services. Can be used to trace logs across services. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "initiated_by" {
  description = "Microsoft Graph initiatedBy property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.auditActivityInitiator")
    app        = optional(any)
    user       = optional(any)
  })
  default = null
}

variable "logged_by_service" {
  description = "Indicates information on which service initiated the activity (For example: Self-service Password Management, Core Directory, B2C, Invited Users, Microsoft Identity Manager, Privileged Identity Management. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.directoryAudit"
  nullable    = false
}

variable "operation_type" {
  description = "Indicates the type of operation that was performed. The possible values include but are not limited to the following: Add, Assign, Update, Unassign, and Delete."
  type        = string
  default     = null
}

variable "result" {
  description = "Indicates the result of the activity. The possible values are: success, failure, timeout, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.result == null ? true : contains(["success", "failure", "timeout", "unknownFutureValue"], var.result)
    error_message = "result must be one of the documented enum values."
  }
}

variable "result_reason" {
  description = "Indicates the reason for failure if the result is failure or timeout."
  type        = string
  default     = null
}

variable "target_resources" {
  description = "Indicates information on which resource was changed due to the activity. Target Resource Type can be User, Device, Directory, App, Role, Group, Policy or Other. Supports $filter (eq) for id and displayName; and $filter (startswith) for displayName."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.targetResource")
    displayName = optional(string)
    groupType   = optional(any)
    id          = optional(string)
    modifiedProperties = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.modifiedProperty")
      displayName = optional(string)
      newValue    = optional(string)
      oldValue    = optional(string)
    })))
    type              = optional(string)
    userPrincipalName = optional(string)
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
