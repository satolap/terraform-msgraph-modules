variable "actionAfterRetentionPeriod" {
  description = "Specifies the action to take on the labeled document after the period specified by the retentionDuration property expires. The possible values are: none, delete, startDispositionReview, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.actionAfterRetentionPeriod == null ? true : contains(["none", "delete", "startDispositionReview", "relabel"], var.actionAfterRetentionPeriod)
    error_message = "actionAfterRetentionPeriod must be one of the documented enum values."
  }
}

variable "behaviorDuringRetentionPeriod" {
  description = "Specifies how the behavior of a document with this label should be during the retention period. The possible values are: doNotRetain, retain, retainAsRecord, retainAsRegulatoryRecord, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.behaviorDuringRetentionPeriod == null ? true : contains(["doNotRetain", "retain", "retainAsRecord", "retainAsRegulatoryRecord"], var.behaviorDuringRetentionPeriod)
    error_message = "behaviorDuringRetentionPeriod must be one of the documented enum values."
  }
}

variable "createdBy" {
  description = "Represents the user who created the retentionLabel."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "Represents the date and time in which the retentionLabel is created."
  type        = string
  default     = null
}

variable "defaultRecordBehavior" {
  description = "Specifies the locked or unlocked state of a record label when it is created.The possible values are: startLocked, startUnlocked, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.defaultRecordBehavior == null ? true : contains(["startLocked", "startUnlocked"], var.defaultRecordBehavior)
    error_message = "defaultRecordBehavior must be one of the documented enum values."
  }
}

variable "descriptionForAdmins" {
  description = "Provides label information for the admin. Optional."
  type        = string
  default     = null
}

variable "descriptionForUsers" {
  description = "Provides the label information for the user. Optional."
  type        = string
  default     = null
}

variable "descriptors" {
  description = "Represents out-of-the-box values that provide more options to improve the manageability and organization of the content you need to label."
  type        = any
  default     = null
}

variable "displayName" {
  description = "Unique string that defines a label name."
  type        = string
  default     = null
}

variable "dispositionReviewStages" {
  description = "When action at the end of retention is chosen as 'dispositionReview', dispositionReviewStages specifies a sequential set of stages with at least one reviewer in each stage."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.security.dispositionReviewStage")
    name                    = optional(string)
    reviewersEmailAddresses = optional(list(string))
    stageNumber             = optional(string)
  }))
  default = null
}

variable "isInUse" {
  description = "Specifies whether the label is currently being used."
  type        = bool
  default     = null
}

variable "labelToBeApplied" {
  description = "Specifies the replacement label to be applied automatically after the retention period of the current label ends."
  type        = string
  default     = null
}

variable "lastModifiedBy" {
  description = "The user who last modified the retentionLabel."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
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

variable "retentionDuration" {
  description = "Specifies the number of days to retain the content."
  type        = any
  default     = null
}

variable "retentionEventType" {
  description = "Represents the type associated with a retention event."
  type        = any
  default     = null
}

variable "retentionTrigger" {
  description = "Specifies whether the retention duration is calculated from the content creation date, labeled date, or last modification date. The possible values are: dateLabeled, dateCreated, dateModified, dateOfEvent, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.retentionTrigger == null ? true : contains(["dateLabeled", "dateCreated", "dateModified", "dateOfEvent"], var.retentionTrigger)
    error_message = "retentionTrigger must be one of the documented enum values."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
