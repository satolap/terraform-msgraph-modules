variable "add_to_calendar_action" {
  description = "Optional field to control the assignment behavior  for adding assignments to students' and teachers' calendars when the assignment is published. The possible values are: none, studentsAndPublisher, studentsAndTeamOwners, unknownFutureValue, and studentsOnly. Use the Prefer: include-unknown-enum-members request header to get the following members in this evolvable enum: studentsOnly. The default value is none."
  type        = any
  default     = null

  validation {
    condition     = var.add_to_calendar_action == null ? true : contains(["none", "studentsAndPublisher", "studentsAndTeamOwners", "unknownFutureValue", "studentsOnly"], var.add_to_calendar_action)
    error_message = "add_to_calendar_action must be one of the documented enum values."
  }
}

variable "added_student_action" {
  description = "Optional field to control the assignment behavior for students who are added after the assignment is published. If not specified, defaults to none. Supported values are: none, assignIfOpen. For example, a teacher can use assignIfOpen to indicate that an assignment should be assigned to any new student who joins the class while the assignment is still open, and none to indicate that an assignment shouldn't be assigned to new students."
  type        = any
  default     = null

  validation {
    condition     = var.added_student_action == null ? true : contains(["none", "assignIfOpen", "unknownFutureValue"], var.added_student_action)
    error_message = "added_student_action must be one of the documented enum values."
  }
}

variable "allow_late_submissions" {
  description = "Identifies whether students can submit after the due date. If this property isn't specified during create, it defaults to true."
  type        = bool
  default     = null
}

variable "allow_students_to_add_resources_to_submission" {
  description = "Identifies whether students can add their own resources to a submission or if they can only modify resources added by the teacher."
  type        = bool
  default     = null
}

variable "assign_to" {
  description = "Which users, or whole class should receive a submission object once the assignment is published."
  type        = any
  default     = null
}

variable "class_id" {
  description = "Class to which this assignment belongs."
  type        = string
  default     = null
}

variable "close_date_time" {
  description = "Date when the assignment will be closed for submissions. This is an optional field that can be null if the assignment doesn't allowLateSubmissions or when the closeDateTime is the same as the dueDateTime. But if specified, then the closeDateTime must be greater than or equal to the dueDateTime. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the assignment."
  type        = string
  default     = null
}

variable "due_date_time" {
  description = "Date when the students assignment is due.  The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "grading" {
  description = "How the assignment will be graded."
  type        = any
  default     = null
}

variable "grading_category" {
  description = "When set, enables users to weight assignments differently when computing a class average grade."
  type        = any
  default     = null
}

variable "grading_scheme" {
  description = "When set, enables users to configure custom string grades based on the percentage of total points earned on this assignment."
  type        = any
  default     = null
}

variable "instructions" {
  description = "Instructions for the assignment. This property and the display name tell the student what to do."
  type        = any
  default     = null
}

variable "language_tag" {
  description = "Specifies the language in which UI notifications for the assignment are displayed. If languageTag isn't provided, the default language is en-US. Optional."
  type        = string
  default     = null
}

variable "module_url" {
  description = "The URL of the module from which to access the assignment."
  type        = string
  default     = null
}

variable "notification_channel_url" {
  description = "Optional field to specify the URL of the channel to post the assignment publish notification. If not specified or null, defaults to the General channel. This field only applies to assignments where the assignTo value is educationAssignmentClassRecipient. Updating the notificationChannelUrl isn't allowed after the assignment has been published."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationAssignment"
  nullable    = false
}

variable "resources" {
  description = "Learning objects that are associated with this assignment.  Only teachers can modify this list. Nullable."
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.educationAssignmentResource")
    dependentResources       = optional(any)
    distributeForStudentWork = optional(bool)
    resource                 = optional(any)
  }))
  default = null
}

variable "rubric" {
  description = "When set, the grading rubric attached to this assignment."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignDateTime", "assignedDateTime", "categories", "createdBy", "createdDateTime", "feedbackResourcesFolderUrl", "id", "lastModifiedBy", "lastModifiedDateTime", "resourcesFolderUrl", "status", "submissions", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
