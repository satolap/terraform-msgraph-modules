variable "planner_plan_id" {
  description = "The unique identifier of plannerPlan"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.planner_plan_id)) > 0
    error_message = "planner_plan_id must not be empty."
  }
}

variable "active_checklist_item_count" {
  description = "Number of checklist items with value set to false, representing incomplete items."
  type        = number
  default     = null
}

variable "applied_categories" {
  description = "The categories to which the task has been applied. See applied Categories for possible values."
  type        = any
  default     = null
}

variable "assignee_priority" {
  description = "Hint used to order items of this type in a list view. The format is defined as outlined here."
  type        = string
  default     = null
}

variable "assignments" {
  description = "The set of assignees the task is assigned to."
  type        = any
  default     = null
}

variable "bucket_id" {
  description = "Bucket ID to which the task belongs. The bucket needs to be in the plan that the task is in. It's 28 characters long and case-sensitive. Format validation is done on the service."
  type        = string
  default     = null
}

variable "checklist_item_count" {
  description = "Number of checklist items that are present on the task."
  type        = number
  default     = null
}

variable "completed_by" {
  description = "Identity of the user that completed the task."
  type        = any
  default     = null
}

variable "conversation_thread_id" {
  description = "Thread ID of the conversation on the task. This is the ID of the conversation thread object created in the group."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Identity of the user that created the task."
  type        = any
  default     = null
}

variable "due_date_time" {
  description = "Date and time at which the task is due. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerTask"
  nullable    = false
}

variable "order_hint" {
  description = "Hint used to order items of this type in a list view. The format is defined as outlined here."
  type        = string
  default     = null
}

variable "percent_complete" {
  description = "Percentage of task completion. When set to 100, the task is considered completed."
  type        = number
  default     = null
}

variable "plan_id" {
  description = "Plan ID to which the task belongs."
  type        = string
  default     = null
}

variable "preview_type" {
  description = "This sets the type of preview that shows up on the task. The possible values are: automatic, noPreview, checklist, description, reference."
  type        = any
  default     = null

  validation {
    condition     = var.preview_type == null ? true : contains(["automatic", "noPreview", "checklist", "description", "reference"], var.preview_type)
    error_message = "preview_type must be one of the documented enum values."
  }
}

variable "priority" {
  description = "Priority of the task. The valid range of values is between 0 and 10, with the increasing value being lower priority (0 has the highest priority and 10 has the lowest priority).  Currently, Planner interprets values 0 and 1 as 'urgent', 2, 3 and 4 as 'important', 5, 6, and 7 as 'medium', and 8, 9, and 10 as 'low'.  Additionally, Planner sets the value 1 for 'urgent', 3 for 'important', 5 for 'medium', and 9 for 'low'."
  type        = number
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignedToTaskBoardFormat", "bucketTaskBoardFormat", "completedDateTime", "createdDateTime", "details", "hasDescription", "id", "progressTaskBoardFormat"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
