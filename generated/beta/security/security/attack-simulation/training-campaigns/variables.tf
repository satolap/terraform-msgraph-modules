variable "campaign_schedule" {
  description = "Details about the schedule and current status for a training campaign"
  type        = any
  default     = null
}

variable "created_by" {
  description = "Identity of the user who created the training campaign"
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time of creation of the training campaign."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the training campaign."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "end_user_notification_setting" {
  description = "Details about the end user notification setting."
  type        = any
  default     = null
}

variable "excluded_account_target" {
  description = "Users excluded from the training campaign."
  type        = any
  default     = null
}

variable "included_account_target" {
  description = "Users targeted in the training campaign."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the user who most recently modified the training campaign."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Date and time of the most recent modification of the training campaign."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.trainingCampaign"
  nullable    = false
}

variable "report" {
  description = "Report of the training campaign."
  type        = any
  default     = null
}

variable "training_setting" {
  description = "Details about the training settings for a training campaign."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
