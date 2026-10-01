variable "access_package_id" {
  description = "ID of the access package this policy applies to."
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
  description = "Text-input questions posed to the requestor when they request this access package through this policy."
  type = list(object({
    text               = string
    is_required        = optional(bool, false)
    is_answer_editable = optional(bool, true)
    sequence           = optional(number)
  }))
  default = []
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
