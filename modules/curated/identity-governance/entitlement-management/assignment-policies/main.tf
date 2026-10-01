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

  # The stages that run only for assignments that expire, and the concrete type of
  # each extension type. The variable validations list the stages.
  expiration_stages = ["assignmentFourteenDaysBeforeExpiration", "assignmentOneDayBeforeExpiration"]

  extension_odata_types = {
    request_workflow    = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension"
    assignment_workflow = "#microsoft.graph.accessPackageAssignmentWorkflowExtension"
  }

  # Always part of the body: the PUT replaces the bindings of the policy, so an
  # empty list removes the ones that were configured outside Terraform.
  custom_extension_stage_settings_body = [
    for s in var.custom_extension_stage_settings : {
      stage = s.stage
      customExtension = {
        "@odata.type" = local.extension_odata_types[s.extension_type]
        id            = lower(s.extension_id)
      }
    }
  ]

  # A plain GET does not return the bindings; they need this expand.
  stage_settings_expand    = "customExtensionStageSettings($expand=customExtension)"
  stage_settings_read_back = "customExtensionStageSettings[].{stage: stage, extension_id: customExtension.id}"

  declared_extension_ids = [for s in var.custom_extension_stage_settings : s.extension_id]
  has_expiration_stage   = anytrue([for s in var.custom_extension_stage_settings : contains(local.expiration_stages, s.stage)])

  # The catalog of the access package and the extensions in it. Both reads exist
  # only when a binding is declared. A guard that cannot read them fails the plan:
  # an access package read without a catalog is rejected by the precondition of the
  # list read, and a missing or empty list reports every declared extension.
  catalog_id_read       = try(data.msgraph_resource.access_package[0].output.catalog_id, null)
  catalog_id            = local.catalog_id_read == null ? "" : local.catalog_id_read
  catalog_extension_ids = try([for id in data.msgraph_resource.catalog_extensions[0].output.extension_ids : lower(id)], [])
  missing_extension_ids = [for id in local.declared_extension_ids : id if !contains(local.catalog_extension_ids, lower(id))]

  # Empty, and known, only while every declared extension id is known. While one
  # is not, because the same apply creates the extension, it is unknown, which
  # defers the list of the catalog's extensions until after that apply step; a list
  # read earlier does not contain the new extension.
  after_declared_extensions = substr(join(",", local.declared_extension_ids), 0, 0)

  # null when Graph returned no customExtensionStageSettings key, as it does for a
  # read that does not expand them; an empty list is a read that found no binding.
  server_stage_settings = try(msgraph_resource.assignment_policy.output.custom_extension_stage_settings, null)
  read_back_stage_settings = local.server_stage_settings == null ? null : [
    for s in local.server_stage_settings : {
      stage        = s.stage
      extension_id = s.extension_id
    }
  ]

  # Scopes whose targets can be guests or external users. A user, a group or a
  # membership rule that specificDirectoryUsers names can be or contain a guest,
  # so that scope counts as soon as it names a target.
  guest_scopes       = ["specificConnectedOrganizationUsers", "allConfiguredConnectedOrganizationUsers", "allExternalUsers", "allDirectoryUsers"]
  can_include_guests = contains(local.guest_scopes, var.allowed_target_scope) || (var.allowed_target_scope == "specificDirectoryUsers" && length(var.specific_allowed_targets) > 0)
  declared_bindings  = [for s in var.custom_extension_stage_settings : "${s.stage}/${lower(s.extension_id)}"]

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
    questions                    = local.questions_body
    customExtensionStageSettings = local.custom_extension_stage_settings_body
    accessPackage = {
      id = var.access_package_id
    }
  }
}

# The access package's catalog, and the extensions in that catalog, are read only
# when a binding is declared, so a caller without bindings makes no extra request.
# Both are top-level data sources: a 401 or 403 fails the plan instead of being
# read as "no extensions".
data "msgraph_resource" "access_package" {
  count = length(var.custom_extension_stage_settings) > 0 ? 1 : 0

  url         = "identityGovernance/entitlementManagement/accessPackages/${var.access_package_id}"
  api_version = var.api_version

  query_parameters = {
    "$expand" = ["catalog"]
  }

  response_export_values = {
    catalog_id = "catalog.id"
  }
}

data "msgraph_resource" "catalog_extensions" {
  count = length(var.custom_extension_stage_settings) > 0 ? 1 : 0

  url         = "identityGovernance/entitlementManagement/catalogs/${local.catalog_id}/customWorkflowExtensions${local.after_declared_extensions}"
  api_version = var.api_version

  response_export_values = {
    extension_ids = "value[].id"
  }

  lifecycle {
    precondition {
      condition     = local.catalog_id != ""
      error_message = "The read of access package ${var.access_package_id} returned no catalog, so the custom extensions of its catalog cannot be listed and custom_extension_stage_settings cannot be checked against them."
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

  # The bindings come back only when the read expands them.
  read_query_parameters = {
    "$expand" = [local.stage_settings_expand]
  }

  response_export_values = {
    display_name                    = "displayName"
    custom_extension_stage_settings = local.stage_settings_read_back
  }

  lifecycle {
    precondition {
      condition     = !local.has_expiration_stage || var.expiration.type != "noExpiration"
      error_message = "custom_extension_stage_settings binds an expiration stage (assignmentFourteenDaysBeforeExpiration or assignmentOneDayBeforeExpiration), but expiration.type is \"noExpiration\". These stages run only for assignments that expire; set expiration.type to \"afterDuration\" or \"afterDateTime\", or remove the binding."
    }

    precondition {
      condition     = length(local.missing_extension_ids) == 0
      error_message = "custom_extension_stage_settings names custom extensions that are not in the catalog of access package ${var.access_package_id} (catalog ${local.catalog_id}): ${join(", ", local.missing_extension_ids)}. A policy can use only the custom extensions of its own catalog."
    }
  }
}

# Warns, without failing the plan or apply, about the custom extension bindings
# that the server has and custom_extension_stage_settings does not declare. This
# module sends customExtensionStageSettings on every apply, so the next apply
# removes them, and their Logic Apps are no longer called. It reads the policy
# again, so it also sees them on a plan that updates the policy, where the
# resource's own read-back is not known yet. It cannot warn before the policy
# exists, and on a plan that creates the policy Terraform reports that the result
# is known after apply.
#
# The provider writes the exported key with a null value when Graph omits it or
# returns null, and try() does not replace a null, so the null is replaced by an
# empty list explicitly. A template rejects null as well, so a binding whose stage
# comes back null is still named.
check "undeclared_custom_extension_bindings" {
  data "msgraph_resource" "server_bindings" {
    url         = "identityGovernance/entitlementManagement/assignmentPolicies/${msgraph_resource.assignment_policy.id}"
    api_version = var.api_version

    query_parameters = {
      "$expand" = [local.stage_settings_expand]
    }

    response_export_values = {
      custom_extension_stage_settings = local.stage_settings_read_back
    }
  }

  assert {
    condition = length([
      for b in(try(data.msgraph_resource.server_bindings.output.custom_extension_stage_settings, null) == null ? [] : data.msgraph_resource.server_bindings.output.custom_extension_stage_settings) :
      b if !contains(local.declared_bindings, "${b.stage == null ? "" : b.stage}/${try(lower(b.extension_id), "")}")
    ]) == 0
    error_message = "Policy ${msgraph_resource.assignment_policy.id} has custom extension bindings on the server that custom_extension_stage_settings does not declare: ${join(", ", [for b in(try(data.msgraph_resource.server_bindings.output.custom_extension_stage_settings, null) == null ? [] : data.msgraph_resource.server_bindings.output.custom_extension_stage_settings) : "${b.stage == null ? "unknown stage" : b.stage} (extension ${try(lower(b.extension_id), "unknown")})" if !contains(local.declared_bindings, "${b.stage == null ? "" : b.stage}/${try(lower(b.extension_id), "")}")])}. This module sends customExtensionStageSettings on every apply, so the next apply removes them and their Logic Apps are no longer called. Declare them in custom_extension_stage_settings to keep them."
  }
}

# Warns when bindings are declared for a policy that can include guests or
# external users. Such a policy needs the tenant linked to an Azure subscription
# for Microsoft Entra ID Governance for guests, and each successful request is billed.
check "guest_custom_extension_prerequisite" {
  assert {
    condition     = length(var.custom_extension_stage_settings) == 0 || !local.can_include_guests
    error_message = "custom_extension_stage_settings is declared for a policy whose allowed_target_scope (${var.allowed_target_scope}) can include guests or external users. A guest policy that uses a custom extension needs the tenant linked to an Azure subscription for Microsoft Entra ID Governance for guests, Graph rejects the policy without it, and each successful request is billed to that subscription. See https://learn.microsoft.com/en-us/entra/id-governance/microsoft-entra-id-governance-licensing-for-guest-users."
  }
}
