variable "action_after_retention_period" {
  description = "Specifies the action to take on the labeled document after the period specified by the retentionDuration property expires. The possible values are: none, delete, startDispositionReview, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.action_after_retention_period == null ? true : contains(["none", "delete", "startDispositionReview", "relabel", "unknownFutureValue"], var.action_after_retention_period)
    error_message = "action_after_retention_period must be one of the documented enum values."
  }
}

variable "behavior_during_retention_period" {
  description = "Specifies how the behavior of a document with this label should be during the retention period. The possible values are: doNotRetain, retain, retainAsRecord, retainAsRegulatoryRecord, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.behavior_during_retention_period == null ? true : contains(["doNotRetain", "retain", "retainAsRecord", "retainAsRegulatoryRecord", "unknownFutureValue"], var.behavior_during_retention_period)
    error_message = "behavior_during_retention_period must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "Represents the user who created the retentionLabel."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Represents the date and time in which the retentionLabel is created."
  type        = string
  default     = null
}

variable "default_record_behavior" {
  description = "Specifies the locked or unlocked state of a record label when it is created.The possible values are: startLocked, startUnlocked, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.default_record_behavior == null ? true : contains(["startLocked", "startUnlocked", "unknownFutureValue"], var.default_record_behavior)
    error_message = "default_record_behavior must be one of the documented enum values."
  }
}

variable "description_for_admins" {
  description = "Provides label information for the admin. Optional."
  type        = string
  default     = null
}

variable "description_for_users" {
  description = "Provides the label information for the user. Optional."
  type        = string
  default     = null
}

variable "descriptors" {
  description = "Represents out-of-the-box values that provide more options to improve the manageability and organization of the content you need to label."
  type        = any
  default     = null
}

variable "display_name" {
  description = "Unique string that defines a label name."
  type        = string
  default     = null
}

variable "disposition_review_stages" {
  description = "When action at the end of retention is chosen as 'dispositionReview', dispositionReviewStages specifies a sequential set of stages with at least one reviewer in each stage."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.security.dispositionReviewStage")
    name                    = optional(string)
    reviewersEmailAddresses = optional(list(string))
    stageNumber             = optional(string)
  }))
  default = null
}

variable "is_in_use" {
  description = "Specifies whether the label is currently being used."
  type        = bool
  default     = null
}

variable "label_to_be_applied" {
  description = "Specifies the replacement label to be applied automatically after the retention period of the current label ends."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user who last modified the retentionLabel."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The latest date time when the retentionLabel was modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.retentionLabel"
  nullable    = false
}

variable "retention_duration" {
  description = "Specifies the number of days to retain the content."
  type        = any
  default     = null
}

variable "retention_event_type" {
  description = "Represents the type associated with a retention event."
  type        = any
  default     = null
}

variable "retention_trigger" {
  description = "Specifies whether the retention duration is calculated from the content creation date, labeled date, or last modification date. The possible values are: dateLabeled, dateCreated, dateModified, dateOfEvent, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.retention_trigger == null ? true : contains(["dateLabeled", "dateCreated", "dateModified", "dateOfEvent", "unknownFutureValue"], var.retention_trigger)
    error_message = "retention_trigger must be one of the documented enum values."
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
