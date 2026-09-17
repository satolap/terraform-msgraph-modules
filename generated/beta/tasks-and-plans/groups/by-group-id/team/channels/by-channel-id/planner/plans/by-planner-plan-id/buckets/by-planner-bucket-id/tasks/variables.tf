variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "channel_id" {
  description = "The unique identifier of channel"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.channel_id)) > 0
    error_message = "channel_id must not be empty."
  }
}

variable "planner_plan_id" {
  description = "The unique identifier of plannerPlan"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_plan_id)) > 0
    error_message = "planner_plan_id must not be empty."
  }
}

variable "planner_bucket_id" {
  description = "The unique identifier of plannerBucket"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_bucket_id)) > 0
    error_message = "planner_bucket_id must not be empty."
  }
}

variable "active_checklist_item_count" {
  description = "The number of checklist items with value set to false, representing incomplete items."
  type        = number
  default     = null
}

variable "applied_categories" {
  description = "The categories to which the task is applied. See plannerAppliedCategories resource type for possible values."
  type        = any
  default     = null
}

variable "assignee_priority" {
  description = "A hint that is used to order items of this type in a list view. For more information, see Using order hints in planner."
  type        = string
  default     = null
}

variable "assignments" {
  description = "The set of assignees the task is assigned to."
  type        = any
  default     = null
}

variable "bucket_id" {
  description = "Bucket ID to which the task belongs. The bucket needs to be in the same plan as the task. The value of the bucketId property is 28 characters long and case-sensitive. Format validation is done on the service."
  type        = string
  default     = null
}

variable "checklist_item_count" {
  description = "The number of checklist items that are present on the task."
  type        = number
  default     = null
}

variable "completed_by" {
  description = "The identity of the user that completed the task."
  type        = any
  default     = null
}

variable "conversation_thread_id" {
  description = "The thread ID of the conversation on the task. This is the ID of the conversation thread object created in the group."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The identity of the user who created the task."
  type        = any
  default     = null
}

variable "creation_source" {
  description = "Information about the origin of the task."
  type        = any
  default     = null
}

variable "due_date_time" {
  description = "The date and time at which the task is due. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "is_on_my_day" {
  description = "Indicates whether to show this task in the MyDay view. If true, it shows the task."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerTask"
  nullable    = false
}

variable "order_hint" {
  description = "The hint used to order items of this type in a list view. For more information, see Using order hints in planner."
  type        = string
  default     = null
}

variable "percent_complete" {
  description = "The percentage of task completion. When set to 100, the task is completed."
  type        = number
  default     = null
}

variable "plan_id" {
  description = "Plan ID to which the task belongs."
  type        = string
  default     = null
}

variable "preview_type" {
  description = "The type of preview that shows up on the task. The possible values are: automatic, noPreview, checklist, description, reference."
  type        = any
  default     = null

  validation {
    condition     = var.preview_type == null ? true : contains(["automatic", "noPreview", "checklist", "description", "reference"], var.preview_type)
    error_message = "preview_type must be one of the documented enum values."
  }
}

variable "priority" {
  description = "The priority of the task. Valid values are between 0 and 10, inclusive. Larger values indicate lower priority. For example, 0 has the highest priority and 10 has the lowest priority. Currently, planner interprets values 0 and 1 as 'urgent', 2 and 3 and 4 as 'important', 5, 6, and 7 as 'medium', and 8, 9, and 10 as 'low'. Currently, planner sets the value 1 for 'urgent', 3 for 'important', 5 for 'medium', and 9 for 'low'."
  type        = number
  default     = null
}

variable "recurrence" {
  description = "Defines active or inactive recurrence for the task. null when the recurrence has never been defined for the task."
  type        = any
  default     = null
}

variable "reference_count" {
  description = "Number of external references that exist on the task."
  type        = number
  default     = null
}

variable "start_date_time" {
  description = "Date and time at which the task starts. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "title" {
  description = "Title of the task."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["archivalInfo", "assignedToTaskBoardFormat", "bucketTaskBoardFormat", "completedDateTime", "createdDateTime", "details", "goalIds", "hasChat", "hasDescription", "id", "isArchived", "isOnMyDayLastModifiedDate", "lastModifiedBy", "lastModifiedDateTime", "messages", "progressTaskBoardFormat", "specifiedCompletionRequirements"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
