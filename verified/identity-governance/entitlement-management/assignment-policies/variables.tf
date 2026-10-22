variable "access_package_id" {
  description = "ID of the access package this policy applies to. The access package of a policy is read-only after creation, so a change replaces the policy: the new policy is created before the old one is deleted. A change of letter case alone keeps the policy."
  type        = string
}

variable "display_name" {
  description = "Display name of the assignment policy."
  type        = string

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 90
    error_message = "display_name must be between 1 and 90 characters."
  }
}

variable "description" {
  description = "Description of the assignment policy."
  type        = string
  default     = null
}

variable "allowed_target_scope" {
  description = "Who is allowed to be assigned the access package through this policy."
  type        = string
  default     = "notSpecified"

  validation {
    condition = contains([
      "notSpecified",
      "specificDirectoryUsers",
      "specificConnectedOrganizationUsers",
      "specificDirectoryServicePrincipals",
      "allMemberUsers",
      "allDirectoryUsers",
      "allDirectoryServicePrincipals",
      "allConfiguredConnectedOrganizationUsers",
      "allExternalUsers",
      "allDirectoryAgentIdentities",
    ], var.allowed_target_scope)
    error_message = "allowed_target_scope must be a documented allowedTargetScope value (see accessPackageAssignmentPolicy resource type docs)."
  }
}

variable "specific_allowed_targets" {
  description = <<-EOT
    The principals that can be assigned access from an access package through this policy,
    used when allowed_target_scope is one of the "specific*" values. Each entry's "type" must
    be one of "singleUser" (set id to the user's object ID), "groupMembers" (set id to the
    group's object ID), "connectedOrganizationMembers" (set id to the connected organization's
    ID), or "attributeRuleMembers" (set membership_rule to a dynamic membership rule).
  EOT
  type = list(object({
    type            = string
    id              = optional(string)
    membership_rule = optional(string)
    description     = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for t in var.specific_allowed_targets : contains(
        ["singleUser", "groupMembers", "connectedOrganizationMembers", "attributeRuleMembers"],
        t.type
      )
    ])
    error_message = "specific_allowed_targets[*].type must be one of \"singleUser\", \"groupMembers\", \"connectedOrganizationMembers\", or \"attributeRuleMembers\"."
  }
}

variable "expiration" {
  description = "The expiration pattern for assignments created through this policy."
  type = object({
    type          = string
    duration_days = optional(number)
    end_date_time = optional(string)
  })
  default = { type = "noExpiration" }

  validation {
    condition     = contains(["noExpiration", "afterDateTime", "afterDuration"], var.expiration.type)
    error_message = "expiration.type must be one of \"noExpiration\", \"afterDateTime\", or \"afterDuration\"."
  }

  validation {
    condition     = var.expiration.type == "afterDuration" ? var.expiration.duration_days != null : true
    error_message = "expiration.duration_days is required when expiration.type is \"afterDuration\"."
  }

  validation {
    condition     = var.expiration.type == "afterDateTime" ? var.expiration.end_date_time != null : true
    error_message = "expiration.end_date_time is required when expiration.type is \"afterDateTime\"."
  }

  validation {
    condition     = var.expiration.duration_days == null ? true : (var.expiration.duration_days > 0 && floor(var.expiration.duration_days) == var.expiration.duration_days)
    error_message = "expiration.duration_days must be a positive whole number."
  }

  validation {
    condition     = var.expiration.type == "afterDuration" || var.expiration.duration_days == null
    error_message = "expiration.duration_days can only be used with afterDuration."
  }

  validation {
    condition     = var.expiration.end_date_time == null ? true : (var.expiration.type == "afterDateTime" && can(formatdate("YYYY", var.expiration.end_date_time)))
    error_message = "expiration.end_date_time must be an RFC3339 timestamp used with afterDateTime."
  }
}

variable "requestor_settings" {
  description = "Settings controlling who can create a request for an access package assignment through this policy, and what they can include in their request."
  type = object({
    allow_custom_assignment_schedule             = optional(bool, true)
    enable_targets_to_self_add_access            = optional(bool, false)
    enable_targets_to_self_update_access         = optional(bool, false)
    enable_targets_to_self_remove_access         = optional(bool, false)
    enable_on_behalf_requestors_to_add_access    = optional(bool, false)
    enable_on_behalf_requestors_to_update_access = optional(bool, false)
    enable_on_behalf_requestors_to_remove_access = optional(bool, false)
    on_behalf_requestors = optional(list(object({
      type        = string
      id          = optional(string)
      description = optional(string)
    })), [])
  })
  default = {}

  validation {
    condition = alltrue([
      for r in var.requestor_settings.on_behalf_requestors : contains(
        ["singleUser", "groupMembers", "requestorManager", "internalSponsors", "externalSponsors", "targetUserSponsors"],
        r.type
      )
    ])
    error_message = "requestor_settings.on_behalf_requestors[*].type must be a supported subjectSet type."
  }
}

variable "request_approval_settings" {
  description = "Settings for approval of requests for an access package assignment through this policy."
  type = object({
    is_approval_required_for_add        = optional(bool, false)
    is_approval_required_for_update     = optional(bool, false)
    is_requestor_justification_required = optional(bool, false)
    stages = optional(list(object({
      approver_information_visibility    = optional(string, "default")
      approval_timeout_in_days           = optional(number)
      escalation_timeout_in_days         = optional(number)
      is_approver_justification_required = optional(bool, false)
      is_escalation_enabled              = optional(bool, false)
      primary_approvers = list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      }))
      escalation_approvers = optional(list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      })), [])
      fallback_primary_approvers = optional(list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      })), [])
      fallback_escalation_approvers = optional(list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      })), [])
    })), [])
  })
  default = {}

  validation {
    condition     = (var.request_approval_settings.is_approval_required_for_add || var.request_approval_settings.is_approval_required_for_update) ? length(var.request_approval_settings.stages) > 0 : true
    error_message = "Approval for adding or updating access requires at least one approval stage."
  }

  validation {
    condition     = alltrue([for s in var.request_approval_settings.stages : length(s.primary_approvers) > 0])
    error_message = "Every entry in request_approval_settings.stages must define at least one primary_approvers entry."
  }

  validation {
    condition = alltrue(flatten([
      for s in var.request_approval_settings.stages : [
        for a in concat(s.primary_approvers, s.escalation_approvers, s.fallback_primary_approvers, s.fallback_escalation_approvers) :
        contains(["singleUser", "groupMembers", "requestorManager", "internalSponsors", "externalSponsors", "targetUserSponsors"], a.type)
      ]
    ]))
    error_message = "All approver entries must use a supported subjectSet type (singleUser, groupMembers, requestorManager, internalSponsors, externalSponsors, targetUserSponsors)."
  }
}

variable "questions" {
  description = <<-EOT
    Questions posed to the requestor when they request this access package through this
    policy, one object per question. type is "text_input" (the default, an
    accessPackageTextInputQuestion) or "multiple_choice" (an
    accessPackageMultipleChoiceQuestion). text is the default text of the question, and
    localizations gives its text per language as { text, language_code }, with a language
    code such as "en-us" or "fr-CA".

    A text_input question can set is_single_line_question and regex_pattern, the
    regular expression that every answer must match. A multiple_choice question needs
    choices, each { text, actual_value, localizations }, where actual_value is the value
    an answer carries, and can set is_multiple_selection_allowed, which is sent as false
    when it is null. Every other new attribute that is null is left out of the request
    body, so a question that sets none of them sends the same body as before they existed.
    The module sends no question IDs; see the README section "Requestor questions".
  EOT
  type = list(object({
    text               = string
    is_required        = optional(bool, false)
    is_answer_editable = optional(bool, true)
    sequence           = optional(number)
    type               = optional(string, "text_input")
    localizations = optional(list(object({
      text          = string
      language_code = string
    })))
    is_single_line_question       = optional(bool)
    regex_pattern                 = optional(string)
    is_multiple_selection_allowed = optional(bool)
    choices = optional(list(object({
      text         = string
      actual_value = string
      localizations = optional(list(object({
        text          = string
        language_code = string
      })))
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for q in var.questions : contains(["text_input", "multiple_choice"], q.type)])
    error_message = "questions[*].type must be \"text_input\" or \"multiple_choice\"."
  }

  validation {
    condition     = alltrue([for q in var.questions : q.type != "multiple_choice" || length(coalesce(q.choices, [])) > 0])
    error_message = "A multiple_choice question needs at least one entry in choices."
  }

  validation {
    condition     = alltrue([for q in var.questions : q.type == "multiple_choice" || (q.choices == null && q.is_multiple_selection_allowed == null)])
    error_message = "choices and is_multiple_selection_allowed apply only to a multiple_choice question."
  }

  validation {
    condition     = alltrue([for q in var.questions : q.type == "text_input" || (q.is_single_line_question == null && q.regex_pattern == null)])
    error_message = "is_single_line_question and regex_pattern apply only to a text_input question."
  }

  validation {
    condition = alltrue([
      for q in var.questions : length(distinct([for c in coalesce(q.choices, []) : c.actual_value])) == length(coalesce(q.choices, []))
    ])
    error_message = "The choices of a question must have distinct actual_value entries; an answer carries the actual_value of the choice."
  }

  validation {
    condition = alltrue(flatten([
      for q in var.questions : concat(
        [for l in coalesce(q.localizations, []) : length(trimspace(l.text)) > 0],
        [for c in coalesce(q.choices, []) : length(trimspace(c.text)) > 0 && length(trimspace(c.actual_value)) > 0],
        flatten([for c in coalesce(q.choices, []) : [for l in coalesce(c.localizations, []) : length(trimspace(l.text)) > 0]]),
      )
    ]))
    error_message = "questions[*].localizations[*].text, questions[*].choices[*].text, questions[*].choices[*].actual_value and questions[*].choices[*].localizations[*].text must not be empty."
  }

  validation {
    condition = alltrue(flatten([
      for q in var.questions : [
        for l in concat(coalesce(q.localizations, []), flatten([for c in coalesce(q.choices, []) : coalesce(c.localizations, [])])) :
        can(regex("^[A-Za-z]{2}(-[A-Za-z]{2})?$", l.language_code))
      ]
    ]))
    error_message = "questions[*].localizations[*].language_code and questions[*].choices[*].localizations[*].language_code must be a two-letter ISO 639-1 language code, optionally followed by a hyphen and a two-letter ISO 3166-1 country code, such as \"de\", \"en-us\" or \"fr-CA\"."
  }

  validation {
    condition = alltrue(flatten([
      for q in var.questions : [
        for entries in concat([coalesce(q.localizations, [])], [for c in coalesce(q.choices, []) : coalesce(c.localizations, [])]) :
        length(distinct([for l in entries : lower(l.language_code)])) == length(entries)
      ]
    ]))
    error_message = "Each localizations list must name a language_code at most once, ignoring case."
  }
}

variable "review_settings" {
  description = <<-EOT
    Recurring access reviews of the assignments made through this policy, or null (the
    default) for no reviewSettings in the request body. See the README section "Access
    reviews" for what an update does to reviews that a body without reviewSettings leaves out.

    expiration_behavior is the decision applied when reviewers do not respond:
    "keepAccess", "removeAccess" or "acceptAccessRecommendation". primary_reviewers and
    fallback_reviewers are { type, id } with type "singleUser" (id is the user's object ID)
    or "groupMembers" (id is the group's object ID); at least one primary reviewer is needed
    unless is_self_review is true or is_enabled is false.

    schedule.start_date_time is the start of the first review, an RFC 3339 timestamp in UTC
    such as "2026-01-01T00:00:00Z"; pass a fixed value, because a value from timestamp()
    changes on every plan. schedule.duration_in_days is how long each review stays open.
    schedule.recurrence is { type, interval, day_of_month, range_type,
    number_of_occurrences }: type "weekly" or "absoluteMonthly" with interval the number of
    weeks or months between reviews (absoluteMonthly with interval 3 is quarterly),
    day_of_month (1 to 31) only for absoluteMonthly, where Graph requires a day: null sends the
    day of start_date_time. range_type is "noEnd" (the default) or "numbered" with
    number_of_occurrences reviews.
  EOT
  type = object({
    is_enabled                         = optional(bool, true)
    expiration_behavior                = string
    is_recommendation_enabled          = optional(bool, true)
    is_reviewer_justification_required = optional(bool, true)
    is_self_review                     = optional(bool, false)
    primary_reviewers = optional(list(object({
      type = string
      id   = string
    })), [])
    fallback_reviewers = optional(list(object({
      type = string
      id   = string
    })), [])
    schedule = object({
      start_date_time  = string
      duration_in_days = number
      recurrence = object({
        type                  = string
        interval              = number
        day_of_month          = optional(number)
        range_type            = optional(string, "noEnd")
        number_of_occurrences = optional(number)
      })
    })
  })
  default = null

  validation {
    condition     = var.review_settings == null ? true : contains(["keepAccess", "removeAccess", "acceptAccessRecommendation"], var.review_settings.expiration_behavior)
    error_message = "review_settings.expiration_behavior must be \"keepAccess\", \"removeAccess\" or \"acceptAccessRecommendation\"."
  }

  validation {
    condition = var.review_settings == null ? true : alltrue([
      for r in concat(var.review_settings.primary_reviewers, var.review_settings.fallback_reviewers) : contains(["singleUser", "groupMembers"], r.type)
    ])
    error_message = "review_settings.primary_reviewers[*].type and review_settings.fallback_reviewers[*].type must be \"singleUser\" or \"groupMembers\", the subject sets that Microsoft Graph documents for the reviewers of access package assignments."
  }

  validation {
    condition = var.review_settings == null ? true : alltrue([
      for r in concat(var.review_settings.primary_reviewers, var.review_settings.fallback_reviewers) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", r.id))
    ])
    error_message = "review_settings.primary_reviewers[*].id and review_settings.fallback_reviewers[*].id must be the object ID (a GUID) of the user (singleUser) or group (groupMembers)."
  }

  validation {
    condition     = var.review_settings == null ? true : (!var.review_settings.is_enabled || var.review_settings.is_self_review || length(var.review_settings.primary_reviewers) > 0)
    error_message = "review_settings needs at least one primary_reviewers entry unless is_self_review is true or is_enabled is false."
  }

  validation {
    condition     = var.review_settings == null ? true : (can(formatdate("YYYY", var.review_settings.schedule.start_date_time)) && endswith(var.review_settings.schedule.start_date_time, "Z"))
    error_message = "review_settings.schedule.start_date_time must be an RFC 3339 timestamp in UTC, such as \"2026-01-01T00:00:00Z\"."
  }

  validation {
    condition     = var.review_settings == null ? true : (var.review_settings.schedule.duration_in_days > 0 && floor(var.review_settings.schedule.duration_in_days) == var.review_settings.schedule.duration_in_days)
    error_message = "review_settings.schedule.duration_in_days must be a positive whole number."
  }

  validation {
    condition     = var.review_settings == null ? true : contains(["weekly", "absoluteMonthly"], var.review_settings.schedule.recurrence.type)
    error_message = "review_settings.schedule.recurrence.type must be \"weekly\" or \"absoluteMonthly\", the recurrence patterns that Microsoft Graph supports for access reviews."
  }

  validation {
    condition     = var.review_settings == null ? true : (var.review_settings.schedule.recurrence.interval > 0 && floor(var.review_settings.schedule.recurrence.interval) == var.review_settings.schedule.recurrence.interval)
    error_message = "review_settings.schedule.recurrence.interval must be a positive whole number."
  }

  validation {
    condition = var.review_settings == null ? true : (var.review_settings.schedule.recurrence.day_of_month == null ? true : (
      var.review_settings.schedule.recurrence.type == "absoluteMonthly" &&
      var.review_settings.schedule.recurrence.day_of_month >= 1 &&
      var.review_settings.schedule.recurrence.day_of_month <= 31 &&
      floor(var.review_settings.schedule.recurrence.day_of_month) == var.review_settings.schedule.recurrence.day_of_month
    ))
    error_message = "review_settings.schedule.recurrence.day_of_month must be a whole number from 1 to 31 and can only be used with type \"absoluteMonthly\"."
  }

  validation {
    condition     = var.review_settings == null ? true : contains(["noEnd", "numbered"], var.review_settings.schedule.recurrence.range_type)
    error_message = "review_settings.schedule.recurrence.range_type must be \"noEnd\" or \"numbered\"."
  }

  validation {
    condition = var.review_settings == null ? true : (var.review_settings.schedule.recurrence.range_type == "numbered" ? (
      var.review_settings.schedule.recurrence.number_of_occurrences == null ? false : (
        var.review_settings.schedule.recurrence.number_of_occurrences > 0 &&
        floor(var.review_settings.schedule.recurrence.number_of_occurrences) == var.review_settings.schedule.recurrence.number_of_occurrences
      )
    ) : var.review_settings.schedule.recurrence.number_of_occurrences == null)
    error_message = "review_settings.schedule.recurrence.number_of_occurrences is required with range_type \"numbered\", must be a positive whole number, and can only be used with \"numbered\"."
  }
}

variable "custom_extension_stage_settings" {
  description = <<-EOT
    The catalog custom extensions that run at stages of this policy's requests and assignments,
    one entry per stage: { stage, extension_id, extension_type }. The module is authoritative
    over the bindings of every policy it manages: it sends the list on every apply, so an empty
    list removes the bindings that were configured outside Terraform.

    stage is one of "assignmentRequestCreated", "assignmentRequestApproved",
    "assignmentRequestGranted", "assignmentRequestRemoved" (request stages),
    "assignmentFourteenDaysBeforeExpiration" or "assignmentOneDayBeforeExpiration" (expiration
    stages, which run only for assignments that expire). extension_id is the ID of a custom
    extension in the catalog of the access package. extension_type is "request_workflow" for a
    request stage and "assignment_workflow" for an expiration stage. One extension can be
    bound to several stages of the same type, and each stage can be bound once.
  EOT
  type = list(object({
    stage          = string
    extension_id   = string
    extension_type = string
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for s in var.custom_extension_stage_settings : contains(concat(
        ["assignmentRequestCreated", "assignmentRequestApproved", "assignmentRequestGranted", "assignmentRequestRemoved"],
        ["assignmentFourteenDaysBeforeExpiration", "assignmentOneDayBeforeExpiration"],
      ), s.stage)
    ])
    error_message = "custom_extension_stage_settings[*].stage must be one of \"assignmentRequestCreated\", \"assignmentRequestApproved\", \"assignmentRequestGranted\", \"assignmentRequestRemoved\", \"assignmentFourteenDaysBeforeExpiration\" or \"assignmentOneDayBeforeExpiration\"."
  }

  validation {
    condition     = alltrue([for s in var.custom_extension_stage_settings : contains(["request_workflow", "assignment_workflow"], s.extension_type)])
    error_message = "custom_extension_stage_settings[*].extension_type must be \"request_workflow\" or \"assignment_workflow\"."
  }

  validation {
    condition = alltrue([
      for s in var.custom_extension_stage_settings :
      contains(["assignmentRequestCreated", "assignmentRequestApproved", "assignmentRequestGranted", "assignmentRequestRemoved"], s.stage) ? s.extension_type != "assignment_workflow" : (
        contains(["assignmentFourteenDaysBeforeExpiration", "assignmentOneDayBeforeExpiration"], s.stage) ? s.extension_type != "request_workflow" : true
      )
    ])
    error_message = "The four request stages (assignmentRequestCreated, assignmentRequestApproved, assignmentRequestGranted, assignmentRequestRemoved) take an extension_type of \"request_workflow\", and the two expiration stages (assignmentFourteenDaysBeforeExpiration, assignmentOneDayBeforeExpiration) take \"assignment_workflow\"."
  }

  validation {
    condition     = length(distinct([for s in var.custom_extension_stage_settings : s.stage])) == length(var.custom_extension_stage_settings)
    error_message = "custom_extension_stage_settings must name each stage at most once; bind one extension to several stages with one entry per stage."
  }

  validation {
    condition     = alltrue([for s in var.custom_extension_stage_settings : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s.extension_id))])
    error_message = "custom_extension_stage_settings[*].extension_id must be the GUID of a custom extension in the catalog of the access package."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version to target for the assignmentPolicies endpoint. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
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
