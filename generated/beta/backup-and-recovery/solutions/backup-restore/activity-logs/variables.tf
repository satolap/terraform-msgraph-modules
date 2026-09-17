variable "activity_type" {
  description = "Microsoft Graph activityType property."
  type        = string
  default     = null

  validation {
    condition     = var.activity_type == null ? true : contains(["backupPolicyCreated", "backupPolicyActivated", "backupPolicyModified", "backupPolicyPaused", "backupPolicyRenamed", "dynamicRuleExecution", "dynamicRuleDeletion", "protectionUnitLevelOffboarding", "policyLevelOffboarding", "restoreTaskCreated", "restoreTaskCompleted", "unknownFutureValue"], var.activity_type)
    error_message = "activity_type must be one of the documented enum values."
  }
}

variable "error" {
  description = "Microsoft Graph error property."
  type        = any
  default     = null
}

variable "event_date_time" {
  description = "Microsoft Graph eventDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.activityLogBase"
  nullable    = false
}

variable "performed_by" {
  description = "Microsoft Graph performedBy property."
  type        = string
  default     = null
}

variable "result_status" {
  description = "Microsoft Graph resultStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.result_status == null ? true : contains(["succeeded", "failed", "partiallySucceeded", "unknownFutureValue"], var.result_status)
    error_message = "result_status must be one of the documented enum values."
  }
}

variable "service_type" {
  description = "Microsoft Graph serviceType property."
  type        = string
  default     = null

  validation {
    condition     = var.service_type == null ? true : contains(["unknown", "sharePoint", "exchange", "oneDriveForBusiness", "unknownFutureValue"], var.service_type)
    error_message = "service_type must be one of the documented enum values."
  }
}

variable "severity" {
  description = "Microsoft Graph severity property."
  type        = string
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["high", "medium", "low", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
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
