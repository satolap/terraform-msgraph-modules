variable "activity" {
  description = "Friendly name of the activity. Optional."
  type        = string
  default     = null
}

variable "activity_operation_type" {
  description = "Microsoft Graph activityOperationType property."
  type        = string
  default     = null

  validation {
    condition     = var.activity_operation_type == null ? true : contains(["create", "delete", "patch", "unknownFutureValue"], var.activity_operation_type)
    error_message = "activity_operation_type must be one of the documented enum values."
  }
}

variable "activity_result" {
  description = "Microsoft Graph activityResult property."
  type        = string
  default     = null

  validation {
    condition     = var.activity_result == null ? true : contains(["success", "clientError", "failure", "timeout", "unknownFutureValue"], var.activity_result)
    error_message = "activity_result must be one of the documented enum values."
  }
}

variable "actor" {
  description = "Microsoft Graph actor property."
  type = object({
    odata_type             = optional(string, "#microsoft.graph.cloudPcAuditActor")
    applicationDisplayName = optional(string)
    applicationId          = optional(string)
    ipAddress              = optional(string)
    remoteTenantId         = optional(string)
    remoteUserId           = optional(string)
    servicePrincipalName   = optional(string)
    type                   = optional(string)
    userId                 = optional(string)
    userPermissions        = optional(list(string))
    userPrincipalName      = optional(string)
    userRoleScopeTags = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.cloudPcUserRoleScopeTagInfo")
      displayName    = optional(string)
      roleScopeTagId = optional(string)
    })))
  })
  default = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["cloudPC", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcAuditEvent"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activityDateTime", "activityType", "componentName", "correlationId", "displayName", "id", "resources"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
