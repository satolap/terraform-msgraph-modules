variable "access_package_id" {
  description = "ID of the access package this policy applies to. The access package of a policy is read-only after creation, so a change replaces the policy: the new policy is created before the old one is deleted. A change of letter case alone keeps the policy."
  type        = string
}

variable "displayName" {
  description = "Display name of the assignment policy."
  type        = string

  validation {
    condition     = length(var.displayName) > 0 && length(var.displayName) <= 90
    error_message = "displayName must be between 1 and 90 characters."
  }
}

variable "description" {
  description = "Description of the assignment policy."
  type        = string
  default     = null
}

variable "allowedTargetScope" {
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
    ], var.allowedTargetScope)
    error_message = "allowedTargetScope must be a documented allowedTargetScope value (see accessPackageAssignmentPolicy resource type docs)."
  }
}

variable "specific_allowed_targets" {
  description = <<-EOT
    The principals that can be assigned access from an access package through this policy,
    used when allowedTargetScope is one of the "specific*" values. Each entry's "type" must
    be one of "singleUser" (set id to the user's object ID), "groupMembers" (set id to the
    group's object ID), "connectedOrganizationMembers" (set id to the connected organization's
    ID), or "attributeRuleMembers" (set membershipRule to a dynamic membership rule).
  EOT
  type = list(object({
    type            = string
    id              = optional(string)
    membershipRule  = optional(string)
    membership_rule = optional(any)
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

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(membership_rule)\":[^n]", jsonencode(var.specific_allowed_targets)))
    error_message = "specific_allowed_targets no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (membership_rule -> membershipRule). An old name that is silently dropped would fall back to its default."
  }
}

variable "expiration" {
  description = "The expiration pattern for assignments created through this policy."
  type = object({
    type          = string
    duration_days = optional(number)
    endDateTime   = optional(string)
    end_date_time = optional(any)
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
    condition     = var.expiration.type == "afterDateTime" ? var.expiration.endDateTime != null : true
    error_message = "expiration.endDateTime is required when expiration.type is \"afterDateTime\"."
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
    condition     = var.expiration.endDateTime == null ? true : (var.expiration.type == "afterDateTime" && can(formatdate("YYYY", var.expiration.endDateTime)))
    error_message = "expiration.endDateTime must be an RFC3339 timestamp used with afterDateTime."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(end_date_time)\":[^n]", jsonencode(var.expiration)))
    error_message = "expiration no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (end_date_time -> endDateTime). An old name that is silently dropped would fall back to its default."
  }
}

variable "requestor_settings" {
  description = "Settings controlling who can create a request for an access package assignment through this policy, and what they can include in their request."
  type = object({
    allowCustomAssignmentSchedule                = optional(bool, true)
    allow_custom_assignment_schedule             = optional(any)
    enableTargetsToSelfAddAccess                 = optional(bool, false)
    enable_targets_to_self_add_access            = optional(any)
    enableTargetsToSelfUpdateAccess              = optional(bool, false)
    enable_targets_to_self_update_access         = optional(any)
    enableTargetsToSelfRemoveAccess              = optional(bool, false)
    enable_targets_to_self_remove_access         = optional(any)
    enableOnBehalfRequestorsToAddAccess          = optional(bool, false)
    enable_on_behalf_requestors_to_add_access    = optional(any)
    enableOnBehalfRequestorsToUpdateAccess       = optional(bool, false)
    enable_on_behalf_requestors_to_update_access = optional(any)
    enableOnBehalfRequestorsToRemoveAccess       = optional(bool, false)
    enable_on_behalf_requestors_to_remove_access = optional(any)
    onBehalfRequestors = optional(list(object({
      type        = string
      id          = optional(string)
      description = optional(string)
    })), [])
    on_behalf_requestors = optional(any)
  })
  default = {}

  validation {
    condition = alltrue([
      for r in var.requestor_settings.onBehalfRequestors : contains(
        ["singleUser", "groupMembers", "requestorManager", "internalSponsors", "externalSponsors", "targetUserSponsors"],
        r.type
      )
    ])
    error_message = "requestor_settings.onBehalfRequestors[*].type must be a supported subjectSet type."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(allow_custom_assignment_schedule|enable_on_behalf_requestors_to_add_access|enable_on_behalf_requestors_to_remove_access|enable_on_behalf_requestors_to_update_access|enable_targets_to_self_add_access|enable_targets_to_self_remove_access|enable_targets_to_self_update_access|on_behalf_requestors)\":[^n]", jsonencode(var.requestor_settings)))
    error_message = "requestor_settings no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (allow_custom_assignment_schedule -> allowCustomAssignmentSchedule, enable_on_behalf_requestors_to_add_access -> enableOnBehalfRequestorsToAddAccess, enable_on_behalf_requestors_to_remove_access -> enableOnBehalfRequestorsToRemoveAccess, enable_on_behalf_requestors_to_update_access -> enableOnBehalfRequestorsToUpdateAccess, enable_targets_to_self_add_access -> enableTargetsToSelfAddAccess, enable_targets_to_self_remove_access -> enableTargetsToSelfRemoveAccess, enable_targets_to_self_update_access -> enableTargetsToSelfUpdateAccess, on_behalf_requestors -> onBehalfRequestors). An old name that is silently dropped would fall back to its default."
  }
}

variable "request_approval_settings" {
  description = "Settings for approval of requests for an access package assignment through this policy."
  type = object({
    isApprovalRequiredForAdd            = optional(bool, false)
    is_approval_required_for_add        = optional(any)
    isApprovalRequiredForUpdate         = optional(bool, false)
    is_approval_required_for_update     = optional(any)
    isRequestorJustificationRequired    = optional(bool, false)
    is_requestor_justification_required = optional(any)
    stages = optional(list(object({
      approverInformationVisibility      = optional(string, "default")
      approver_information_visibility    = optional(any)
      approval_timeout_in_days           = optional(number)
      escalation_timeout_in_days         = optional(number)
      isApproverJustificationRequired    = optional(bool, false)
      is_approver_justification_required = optional(any)
      isEscalationEnabled                = optional(bool, false)
      is_escalation_enabled              = optional(any)
      primaryApprovers = list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      }))
      escalationApprovers = optional(list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      })), [])
      escalation_approvers = optional(any)
      fallbackPrimaryApprovers = optional(list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      })), [])
      fallback_primary_approvers = optional(any)
      fallbackEscalationApprovers = optional(list(object({
        type        = string
        id          = optional(string)
        description = optional(string)
      })), [])
      fallback_escalation_approvers = optional(any)
    })), [])
  })
  default = {}

  validation {
    condition     = (var.request_approval_settings.isApprovalRequiredForAdd || var.request_approval_settings.isApprovalRequiredForUpdate) ? length(var.request_approval_settings.stages) > 0 : true
    error_message = "Approval for adding or updating access requires at least one approval stage."
  }

  validation {
    condition     = alltrue([for s in var.request_approval_settings.stages : length(s.primaryApprovers) > 0])
    error_message = "Every entry in request_approval_settings.stages must define at least one primaryApprovers entry."
  }

  validation {
    condition = alltrue(flatten([
      for s in var.request_approval_settings.stages : [
        for a in concat(s.primaryApprovers, s.escalationApprovers, s.fallbackPrimaryApprovers, s.fallbackEscalationApprovers) :
        contains(["singleUser", "groupMembers", "requestorManager", "internalSponsors", "externalSponsors", "targetUserSponsors"], a.type)
      ]
    ]))
    error_message = "All approver entries must use a supported subjectSet type (singleUser, groupMembers, requestorManager, internalSponsors, externalSponsors, targetUserSponsors)."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(approver_information_visibility|escalation_approvers|fallback_escalation_approvers|fallback_primary_approvers|is_approval_required_for_add|is_approval_required_for_update|is_approver_justification_required|is_escalation_enabled|is_requestor_justification_required)\":[^n]", jsonencode(var.request_approval_settings)))
    error_message = "request_approval_settings no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (approver_information_visibility -> approverInformationVisibility, escalation_approvers -> escalationApprovers, fallback_escalation_approvers -> fallbackEscalationApprovers, fallback_primary_approvers -> fallbackPrimaryApprovers, is_approval_required_for_add -> isApprovalRequiredForAdd, is_approval_required_for_update -> isApprovalRequiredForUpdate, is_approver_justification_required -> isApproverJustificationRequired, is_escalation_enabled -> isEscalationEnabled, is_requestor_justification_required -> isRequestorJustificationRequired). An old name that is silently dropped would fall back to its default."
  }
}

variable "questions" {
  description = <<-EOT
    Questions posed to the requestor when they request this access package through this
    policy, one object per question. type is "text_input" (the default, an
    accessPackageTextInputQuestion) or "multiple_choice" (an
    accessPackageMultipleChoiceQuestion). text is the default text of the question, and
    localizations gives its text per language as { text, languageCode }, with a language
    code such as "en-us" or "fr-CA".

    A text_input question can set isSingleLineQuestion and regexPattern, the
    regular expression that every answer must match. A multiple_choice question needs
    choices, each { text, actualValue, localizations }, where actualValue is the value
    an answer carries, and can set isMultipleSelectionAllowed, which is sent as false
    when it is null. Every other new attribute that is null is left out of the request
    body, so a question that sets none of them sends the same body as before they existed.
    The module sends no question IDs; see the README section "Requestor questions".
  EOT
  type = list(object({
    text               = string
    isRequired         = optional(bool, false)
    is_required        = optional(any)
    isAnswerEditable   = optional(bool, true)
    is_answer_editable = optional(any)
    sequence           = optional(number)
    type               = optional(string, "text_input")
    localizations = optional(list(object({
      text         = string
      languageCode = string
    })))
    isSingleLineQuestion          = optional(bool)
    is_single_line_question       = optional(any)
    regexPattern                  = optional(string)
    regex_pattern                 = optional(any)
    isMultipleSelectionAllowed    = optional(bool)
    is_multiple_selection_allowed = optional(any)
    choices = optional(list(object({
      text        = string
      actualValue = string
      localizations = optional(list(object({
        text         = string
        languageCode = string
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
    condition     = alltrue([for q in var.questions : q.type == "multiple_choice" || (q.choices == null && q.isMultipleSelectionAllowed == null)])
    error_message = "choices and isMultipleSelectionAllowed apply only to a multiple_choice question."
  }

  validation {
    condition     = alltrue([for q in var.questions : q.type == "text_input" || (q.isSingleLineQuestion == null && q.regexPattern == null)])
    error_message = "isSingleLineQuestion and regexPattern apply only to a text_input question."
  }

  validation {
    condition = alltrue([
      for q in var.questions : length(distinct([for c in coalesce(q.choices, []) : c.actualValue])) == length(coalesce(q.choices, []))
    ])
    error_message = "The choices of a question must have distinct actualValue entries; an answer carries the actualValue of the choice."
  }

  validation {
    condition = alltrue(flatten([
      for q in var.questions : concat(
        [for l in coalesce(q.localizations, []) : length(trimspace(l.text)) > 0],
        [for c in coalesce(q.choices, []) : length(trimspace(c.text)) > 0 && length(trimspace(c.actualValue)) > 0],
        flatten([for c in coalesce(q.choices, []) : [for l in coalesce(c.localizations, []) : length(trimspace(l.text)) > 0]]),
      )
    ]))
    error_message = "questions[*].localizations[*].text, questions[*].choices[*].text, questions[*].choices[*].actualValue and questions[*].choices[*].localizations[*].text must not be empty."
  }

  validation {
    condition = alltrue(flatten([
      for q in var.questions : [
        for l in concat(coalesce(q.localizations, []), flatten([for c in coalesce(q.choices, []) : coalesce(c.localizations, [])])) :
        can(regex("^[A-Za-z]{2}(-[A-Za-z]{2})?$", l.languageCode))
      ]
    ]))
    error_message = "questions[*].localizations[*].languageCode and questions[*].choices[*].localizations[*].languageCode must be a two-letter ISO 639-1 language code, optionally followed by a hyphen and a two-letter ISO 3166-1 country code, such as \"de\", \"en-us\" or \"fr-CA\"."
  }

  validation {
    condition = alltrue(flatten([
      for q in var.questions : [
        for entries in concat([coalesce(q.localizations, [])], [for c in coalesce(q.choices, []) : coalesce(c.localizations, [])]) :
        length(distinct([for l in entries : lower(l.languageCode)])) == length(entries)
      ]
    ]))
    error_message = "Each localizations list must name a languageCode at most once, ignoring case."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(is_answer_editable|is_multiple_selection_allowed|is_required|is_single_line_question|regex_pattern)\":[^n]", jsonencode(var.questions)))
    error_message = "questions no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (is_answer_editable -> isAnswerEditable, is_multiple_selection_allowed -> isMultipleSelectionAllowed, is_required -> isRequired, is_single_line_question -> isSingleLineQuestion, regex_pattern -> regexPattern). An old name that is silently dropped would fall back to its default."
  }
}

variable "review_settings" {
  description = <<-EOT
    Recurring access reviews of the assignments made through this policy, or null (the
    default) for no reviewSettings in the request body. See the README section "Access
    reviews" for what an update does to reviews that a body without reviewSettings leaves out.

    expirationBehavior is the decision applied when reviewers do not respond:
    "keepAccess", "removeAccess" or "acceptAccessRecommendation". primaryReviewers and
    fallbackReviewers are { type, id } with type "singleUser" (id is the user's object ID)
    or "groupMembers" (id is the group's object ID); at least one primary reviewer is needed
    unless isSelfReview is true or isEnabled is false.

    schedule.startDateTime is the start of the first review, an RFC 3339 timestamp in UTC
    such as "2026-01-01T00:00:00Z"; pass a fixed value, because a value from timestamp()
    changes on every plan. schedule.duration_in_days is how long each review stays open.
    schedule.recurrence is { type, interval, dayOfMonth, range_type,
    numberOfOccurrences }: type "weekly" or "absoluteMonthly" with interval the number of
    weeks or months between reviews (absoluteMonthly with interval 3 is quarterly),
    dayOfMonth (1 to 31) only for absoluteMonthly, where Graph requires a day: null sends the
    day of startDateTime. range_type is "noEnd" (the default) or "numbered" with
    numberOfOccurrences reviews.
  EOT
  type = object({
    isEnabled                          = optional(bool, true)
    is_enabled                         = optional(any)
    expirationBehavior                 = string
    isRecommendationEnabled            = optional(bool, true)
    is_recommendation_enabled          = optional(any)
    isReviewerJustificationRequired    = optional(bool, true)
    is_reviewer_justification_required = optional(any)
    isSelfReview                       = optional(bool, false)
    is_self_review                     = optional(any)
    primaryReviewers = optional(list(object({
      type = string
      id   = string
    })), [])
    primary_reviewers = optional(any)
    fallbackReviewers = optional(list(object({
      type = string
      id   = string
    })), [])
    fallback_reviewers = optional(any)
    schedule = object({
      startDateTime    = string
      duration_in_days = number
      recurrence = object({
        type                  = string
        interval              = number
        dayOfMonth            = optional(number)
        day_of_month          = optional(any)
        range_type            = optional(string, "noEnd")
        numberOfOccurrences   = optional(number)
        number_of_occurrences = optional(any)
      })
    })
  })
  default = null

  validation {
    condition     = var.review_settings == null ? true : contains(["keepAccess", "removeAccess", "acceptAccessRecommendation"], var.review_settings.expirationBehavior)
    error_message = "review_settings.expirationBehavior must be \"keepAccess\", \"removeAccess\" or \"acceptAccessRecommendation\"."
  }

  validation {
    condition = var.review_settings == null ? true : alltrue([
      for r in concat(var.review_settings.primaryReviewers, var.review_settings.fallbackReviewers) : contains(["singleUser", "groupMembers"], r.type)
    ])
    error_message = "review_settings.primaryReviewers[*].type and review_settings.fallbackReviewers[*].type must be \"singleUser\" or \"groupMembers\", the subject sets that Microsoft Graph documents for the reviewers of access package assignments."
  }

  validation {
    condition = var.review_settings == null ? true : alltrue([
      for r in concat(var.review_settings.primaryReviewers, var.review_settings.fallbackReviewers) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", r.id))
    ])
    error_message = "review_settings.primaryReviewers[*].id and review_settings.fallbackReviewers[*].id must be the object ID (a GUID) of the user (singleUser) or group (groupMembers)."
  }

  validation {
    condition     = var.review_settings == null ? true : (!var.review_settings.isEnabled || var.review_settings.isSelfReview || length(var.review_settings.primaryReviewers) > 0)
    error_message = "review_settings needs at least one primaryReviewers entry unless isSelfReview is true or isEnabled is false."
  }

  validation {
    condition     = var.review_settings == null ? true : (can(formatdate("YYYY", var.review_settings.schedule.startDateTime)) && endswith(var.review_settings.schedule.startDateTime, "Z"))
    error_message = "review_settings.schedule.startDateTime must be an RFC 3339 timestamp in UTC, such as \"2026-01-01T00:00:00Z\"."
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
    condition = var.review_settings == null ? true : (var.review_settings.schedule.recurrence.dayOfMonth == null ? true : (
      var.review_settings.schedule.recurrence.type == "absoluteMonthly" &&
      var.review_settings.schedule.recurrence.dayOfMonth >= 1 &&
      var.review_settings.schedule.recurrence.dayOfMonth <= 31 &&
      floor(var.review_settings.schedule.recurrence.dayOfMonth) == var.review_settings.schedule.recurrence.dayOfMonth
    ))
    error_message = "review_settings.schedule.recurrence.dayOfMonth must be a whole number from 1 to 31 and can only be used with type \"absoluteMonthly\"."
  }

  validation {
    condition     = var.review_settings == null ? true : contains(["noEnd", "numbered"], var.review_settings.schedule.recurrence.range_type)
    error_message = "review_settings.schedule.recurrence.range_type must be \"noEnd\" or \"numbered\"."
  }

  validation {
    condition = var.review_settings == null ? true : (var.review_settings.schedule.recurrence.range_type == "numbered" ? (
      var.review_settings.schedule.recurrence.numberOfOccurrences == null ? false : (
        var.review_settings.schedule.recurrence.numberOfOccurrences > 0 &&
        floor(var.review_settings.schedule.recurrence.numberOfOccurrences) == var.review_settings.schedule.recurrence.numberOfOccurrences
      )
    ) : var.review_settings.schedule.recurrence.numberOfOccurrences == null)
    error_message = "review_settings.schedule.recurrence.numberOfOccurrences is required with range_type \"numbered\", must be a positive whole number, and can only be used with \"numbered\"."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(day_of_month|fallback_reviewers|is_enabled|is_recommendation_enabled|is_reviewer_justification_required|is_self_review|number_of_occurrences|primary_reviewers)\":[^n]", jsonencode(var.review_settings)))
    error_message = "review_settings no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (day_of_month -> dayOfMonth, fallback_reviewers -> fallbackReviewers, is_enabled -> isEnabled, is_recommendation_enabled -> isRecommendationEnabled, is_reviewer_justification_required -> isReviewerJustificationRequired, is_self_review -> isSelfReview, number_of_occurrences -> numberOfOccurrences, primary_reviewers -> primaryReviewers). An old name that is silently dropped would fall back to its default."
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
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}
