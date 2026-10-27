variable "display_name" {
  description = "Name of the access review series (displayName). Reviewers see it."
  type        = string
  nullable    = false

  validation {
    condition     = trimspace(var.display_name) != ""
    error_message = "display_name must not be empty."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that display_name must match, such as the pattern of a naming convention. When it is set and display_name does not match, the plan fails. Null, the default, accepts any display_name."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "description_for_admins" {
  description = "Context of the review for administrators (descriptionForAdmins). Required by the create request."
  type        = string
  nullable    = false

  validation {
    condition     = trimspace(var.description_for_admins) != ""
    error_message = "description_for_admins must not be empty; Microsoft Graph requires it on create."
  }
}

variable "description_for_reviewers" {
  description = "Context of the review for reviewers (descriptionForReviewers). Required by the create request, at most 256 characters (the limit Microsoft Learn gives for reviewer email notifications)."
  type        = string
  nullable    = false

  validation {
    condition     = trimspace(var.description_for_reviewers) != ""
    error_message = "description_for_reviewers must not be empty; Microsoft Graph requires it on create."
  }

  validation {
    condition     = length(var.description_for_reviewers) <= 256
    error_message = "description_for_reviewers must be at most 256 characters, the limit Microsoft Learn gives for reviewer email notifications."
  }
}

variable "group_id" {
  description = "Object ID of the existing static group whose members are reviewed. The module does not create or read the group. The scope query is built from it. Microsoft Learn's update table does not list scope, so a change replaces the definition: the old series is deleted and a new one created."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.group_id))
    error_message = "group_id must be the object ID of a group, a GUID."
  }
}

variable "membership_scope" {
  description = "\"transitive\" reviews /groups/{id}/transitiveMembers, so users of nested groups appear as individual users; \"direct\" reviews /groups/{id}/members. Both are query scopes of type MicrosoftGraph. A change replaces the definition, as for group_id."
  type        = string
  default     = "transitive"
  nullable    = false

  validation {
    condition     = contains(["transitive", "direct"], var.membership_scope)
    error_message = "membership_scope must be one of \"transitive\" or \"direct\"."
  }
}

variable "reviewer_user_ids" {
  description = "Object IDs of the individual users who review. At least one is required: an empty reviewers list means self-review in Microsoft Graph and the module refuses that mode. Only individually named users are accepted because Graph documents reviewers as updatable only then."
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(var.reviewer_user_ids) > 0
    error_message = "reviewer_user_ids needs at least one user; an empty list would mean self-review, which this module does not support."
  }

  validation {
    condition     = alltrue([for id in var.reviewer_user_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))])
    error_message = "reviewer_user_ids must contain only user object IDs, each a GUID."
  }

  validation {
    condition     = try(length(distinct([for id in var.reviewer_user_ids : lower(id)])) == length(var.reviewer_user_ids), true)
    error_message = "reviewer_user_ids must name each user once; IDs that differ only in letter case name the same user."
  }
}

variable "fallback_reviewer_user_ids" {
  description = "Object IDs of individual fallback reviewers, sent as fallbackReviewers. Defaults to none. Microsoft Learn says fallback reviewers added in the portal are not removable by design, and removal through Graph is unproven, so treat a shrinking list as unverified."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.fallback_reviewer_user_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))])
    error_message = "fallback_reviewer_user_ids must contain only user object IDs, each a GUID."
  }

  validation {
    condition     = try(length(distinct([for id in var.fallback_reviewer_user_ids : lower(id)])) == length(var.fallback_reviewer_user_ids), true)
    error_message = "fallback_reviewer_user_ids must name each user once."
  }
}

variable "start_date" {
  description = "Explicit first day of the series, YYYY-MM-DD (recurrence range startDate). The module never derives it from the current time, so a plan never changes the schedule by itself; choose a future date and move it deliberately. Updates apply only to future instances."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$", var.start_date)) && can(formatdate("YYYY-MM-DD", "${var.start_date}T00:00:00Z"))
    error_message = "start_date must be a calendar date in the form YYYY-MM-DD."
  }
}

variable "recurrence" {
  description = "How the series repeats. type is \"weekly\" or \"absoluteMonthly\", the only types Microsoft Learn lists as supported; interval is the number of weeks or months between instances. day_of_month (1 to 28) is required for absoluteMonthly and must be null for weekly. number_of_occurrences null means the series never ends (range type noEnd); a number of at least 1 ends it after that many instances (range type numbered)."
  type = object({
    type                  = string
    interval              = number
    day_of_month          = optional(number)
    number_of_occurrences = optional(number)
  })
  nullable = false

  validation {
    condition     = contains(["weekly", "absoluteMonthly"], var.recurrence.type)
    error_message = "recurrence.type must be one of \"weekly\" or \"absoluteMonthly\"."
  }

  validation {
    condition     = var.recurrence.interval == floor(var.recurrence.interval) && var.recurrence.interval >= 1
    error_message = "recurrence.interval must be a whole number of at least 1."
  }

  validation {
    condition = var.recurrence.type == "absoluteMonthly" ? (
      var.recurrence.day_of_month != null && try(var.recurrence.day_of_month == floor(var.recurrence.day_of_month) && var.recurrence.day_of_month >= 1 && var.recurrence.day_of_month <= 28, false)
    ) : var.recurrence.day_of_month == null
    error_message = "recurrence.day_of_month is required for absoluteMonthly, a whole number from 1 to 28, and must be null for weekly."
  }

  validation {
    condition     = var.recurrence.number_of_occurrences == null || try(var.recurrence.number_of_occurrences == floor(var.recurrence.number_of_occurrences) && var.recurrence.number_of_occurrences >= 1, false)
    error_message = "recurrence.number_of_occurrences must be null or a whole number of at least 1."
  }
}

variable "instance_duration_in_days" {
  description = "How many days each review instance stays open (settings.instanceDurationInDays), a whole number of at least 1. It must not exceed the length of one recurrence (7 days per weekly interval, 28 days per monthly interval)."
  type        = number
  nullable    = false

  validation {
    condition     = var.instance_duration_in_days == floor(var.instance_duration_in_days) && var.instance_duration_in_days >= 1
    error_message = "instance_duration_in_days must be a whole number of at least 1."
  }

  # Microsoft Learn says the recurrence must be at least as long as the instance duration.
  # The module applies that conservatively: 7 days per week of a weekly interval and 28
  # days per month of an absoluteMonthly interval.
  validation {
    condition     = var.instance_duration_in_days <= var.recurrence.interval * (var.recurrence.type == "weekly" ? 7 : 28)
    error_message = "instance_duration_in_days must not exceed the length of one recurrence: 7 days per week of a weekly interval, 28 days per month of an absoluteMonthly interval."
  }
}

variable "recommendations_enabled" {
  description = "Whether decision recommendations are shown to reviewers (settings.recommendationsEnabled)."
  type        = bool
  default     = false
  nullable    = false
}

variable "justification_required_on_approval" {
  description = "Whether reviewers must give a justification with a decision (settings.justificationRequiredOnApproval)."
  type        = bool
  default     = false
  nullable    = false
}

variable "timeouts" {
  description = "Timeouts for creating, reading, updating and deleting the definition, each a duration in whole hours, minutes or seconds greater than zero, such as \"10m\". Null keeps the provider's default."
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
      t == null || (can(regex("^([0-9]+[hms])+$", t)) && !can(regex("^(0+[hms])+$", t)))
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }
}
