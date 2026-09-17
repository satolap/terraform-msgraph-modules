variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "app_consent_request_id" {
  description = "The unique identifier of appConsentRequest"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.app_consent_request_id)) > 0
    error_message = "app_consent_request_id must not be empty."
  }
}

variable "approval" {
  description = "Approval decisions associated with a request."
  type        = any
  default     = null
}

variable "approval_id" {
  description = "The identifier of the approval of the request."
  type        = string
  default     = null
}

variable "completed_date_time" {
  description = "The request completion date time."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The principal that created the request."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The request creation date time."
  type        = string
  default     = null
}

variable "custom_data" {
  description = "Free text field to define any custom data for the request. Not used."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userConsentRequest"
  nullable    = false
}

variable "reason" {
  description = "The user's justification for requiring access to the app. Supports $filter (eq only) and $orderby."
  type        = string
  default     = null
}

variable "status" {
  description = "The status of the request. Not nullable. The possible values are: Canceled, Denied, Failed, Granted, PendingAdminDecision, PendingApproval, PendingProvisioning, PendingScheduleCreation, Provisioned, Revoked, and ScheduleCreated. Not nullable."
  type        = string
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
