locals {
  subject_id_field = {
    singleUser                   = "userId"
    groupMembers                 = "groupId"
    connectedOrganizationMembers = "connectedOrganizationId"
  }


  expiration_body = merge(
    { type = var.expiration.type },
    var.expiration.duration_days != null ? { duration = "P${var.expiration.duration_days}D" } : {},
    var.expiration.end_date_time != null ? { endDateTime = var.expiration.end_date_time } : {},
  )

  specific_allowed_targets_body = [
    for t in var.specific_allowed_targets : merge(
      { "@odata.type" = "#microsoft.graph.${t.type}" },
      t.description != null ? { description = t.description } : {},
      contains(keys(local.subject_id_field), t.type) && t.id != null ? { (local.subject_id_field[t.type]) = t.id } : {},
      t.type == "attributeRuleMembers" && t.membership_rule != null ? { membershipRule = t.membership_rule } : {},
    )
  ]

  on_behalf_requestors_body = [
    for s in var.requestor_settings.on_behalf_requestors : merge(
      { "@odata.type" = "#microsoft.graph.${s.type}" },
      s.description != null ? { description = s.description } : {},
      contains(keys(local.subject_id_field), s.type) && s.id != null ? { (local.subject_id_field[s.type]) = s.id } : {},
    )
  ]

  approval_stages_body = [
    for s in var.request_approval_settings.stages : {
      approverInformationVisibility   = s.approver_information_visibility
      durationBeforeAutomaticDenial   = s.approval_timeout_in_days != null ? "P${s.approval_timeout_in_days}D" : null
      durationBeforeEscalation        = s.escalation_timeout_in_days != null ? "P${s.escalation_timeout_in_days}D" : null
      isApproverJustificationRequired = s.is_approver_justification_required
      isEscalationEnabled             = s.is_escalation_enabled
      primaryApprovers = [
        for a in s.primary_approvers : merge(
          { "@odata.type" = "#microsoft.graph.${a.type}" },
          a.description != null ? { description = a.description } : {},
          contains(keys(local.subject_id_field), a.type) && a.id != null ? { (local.subject_id_field[a.type]) = a.id } : {},
        )
      ]
      escalationApprovers = [
        for a in s.escalation_approvers : merge(
          { "@odata.type" = "#microsoft.graph.${a.type}" },
          a.description != null ? { description = a.description } : {},
          contains(keys(local.subject_id_field), a.type) && a.id != null ? { (local.subject_id_field[a.type]) = a.id } : {},
        )
      ]
      fallbackPrimaryApprovers = [
        for a in s.fallback_primary_approvers : merge(
          { "@odata.type" = "#microsoft.graph.${a.type}" },
          a.description != null ? { description = a.description } : {},
          contains(keys(local.subject_id_field), a.type) && a.id != null ? { (local.subject_id_field[a.type]) = a.id } : {},
        )
      ]
      fallbackEscalationApprovers = [
        for a in s.fallback_escalation_approvers : merge(
          { "@odata.type" = "#microsoft.graph.${a.type}" },
          a.description != null ? { description = a.description } : {},
          contains(keys(local.subject_id_field), a.type) && a.id != null ? { (local.subject_id_field[a.type]) = a.id } : {},
        )
      ]
    }
  ]

  questions_body = [
    for q in var.questions : {
      "@odata.type"    = "#microsoft.graph.accessPackageTextInputQuestion"
      isRequired       = q.is_required
      isAnswerEditable = q.is_answer_editable
      sequence         = q.sequence
      text             = q.text
    }
  ]

  body = {
    displayName            = var.display_name
    description            = var.description
    allowedTargetScope     = var.allowed_target_scope
    specificAllowedTargets = local.specific_allowed_targets_body
    expiration             = local.expiration_body
    requestorSettings = {
      allowCustomAssignmentSchedule          = var.requestor_settings.allow_custom_assignment_schedule
      enableTargetsToSelfAddAccess           = var.requestor_settings.enable_targets_to_self_add_access
      enableTargetsToSelfUpdateAccess        = var.requestor_settings.enable_targets_to_self_update_access
      enableTargetsToSelfRemoveAccess        = var.requestor_settings.enable_targets_to_self_remove_access
      enableOnBehalfRequestorsToAddAccess    = var.requestor_settings.enable_on_behalf_requestors_to_add_access
      enableOnBehalfRequestorsToUpdateAccess = var.requestor_settings.enable_on_behalf_requestors_to_update_access
      enableOnBehalfRequestorsToRemoveAccess = var.requestor_settings.enable_on_behalf_requestors_to_remove_access
      onBehalfRequestors                     = local.on_behalf_requestors_body
    }
    requestApprovalSettings = {
      isApprovalRequiredForAdd         = var.request_approval_settings.is_approval_required_for_add
      isApprovalRequiredForUpdate      = var.request_approval_settings.is_approval_required_for_update
      isRequestorJustificationRequired = var.request_approval_settings.is_requestor_justification_required
      stages                           = local.approval_stages_body
    }
    questions = local.questions_body
    accessPackage = {
      id = var.access_package_id
    }
  }
}

resource "msgraph_resource" "assignment_policy" {
  url         = "identityGovernance/entitlementManagement/assignmentPolicies"
  api_version = var.api_version
  body        = local.body

  # Graph's assignmentPolicies endpoint only supports full-object PUT for
  # updates (PATCH is not implemented); without this every post-create
  # change to the policy fails.
  update_method = "PUT"

  response_export_values = {
    display_name = "displayName"
  }
}
