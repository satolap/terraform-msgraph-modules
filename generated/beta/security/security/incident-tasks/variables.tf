variable "action_status" {
  description = "Microsoft Graph actionStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.action_status == null ? true : contains(["notStarted", "inProgress", "partiallyCompleted", "completed", "failed", "unknownFutureValue"], var.action_status)
    error_message = "action_status must be one of the documented enum values."
  }
}

variable "action_type" {
  description = "Microsoft Graph actionType property."
  type        = string
  default     = null

  validation {
    condition     = var.action_type == null ? true : contains(["text", "isolateDevice", "stopAndQuarantineFile", "runAntiVirusScan", "collectInvestigationPackage", "restrictAppExecution", "submitIocRule", "forceUserPasswordReset", "disableUser", "markUserAsCompromised", "requireSignIn", "hardDeleteEmail", "softDeleteEmail", "unIsolateDevice", "unRestrictAppExecution", "enableUser", "unknownFutureValue"], var.action_type)
    error_message = "action_type must be one of the documented enum values."
  }
}

variable "description" {
  description = "Description of the remediation action."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Title of the task."
  type        = string
  default     = null
}

variable "graph_source" {
  description = "Microsoft Graph source property."
  type        = string
  default     = null

  validation {
    condition     = var.graph_source == null ? true : contains(["defenderExpertsGuidedResponse", "defenderExpertsManagedResponse", "unknownFutureValue"], var.graph_source)
    error_message = "graph_source must be one of the documented enum values."
  }
}

variable "incident" {
  description = "Required. The incident that contains this task. Must contain a valid incident ID."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.incidentTask"
  nullable    = false
}

variable "response_action" {
  description = "The reponse action."
  type        = any
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["open", "inProgress", "completed", "failed", "notRelevant", "unknownFutureValue"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdByDisplayName", "createdDateTime", "id", "lastModifiedByDisplayName", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
