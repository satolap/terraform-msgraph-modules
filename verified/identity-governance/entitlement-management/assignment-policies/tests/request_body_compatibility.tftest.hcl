# The request bodies of callers that use none of the inputs and question attributes
# added after the custom extension release. Each expected string is the jsonencode()
# of the body that release's module built for the same variables, captured from it and
# pasted unchanged, so an equal string proves a byte-identical request. This file uses
# only that release's interface: it passes against that module as well.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        custom_extension_stage_settings = []
      }
    }
  }
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"
}

run "keeps_the_default_body" {
  command = apply

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body) == trimspace(<<-EOT
      {"accessPackage":{"id":"77777777-7777-7777-7777-777777777777"},"allowedTargetScope":"notSpecified","customExtensionStageSettings":[],"description":null,"displayName":"Standard request policy","expiration":{"type":"noExpiration"},"questions":[],"requestApprovalSettings":{"isApprovalRequiredForAdd":false,"isApprovalRequiredForUpdate":false,"isRequestorJustificationRequired":false,"stages":[]},"requestorSettings":{"allowCustomAssignmentSchedule":true,"enableOnBehalfRequestorsToAddAccess":false,"enableOnBehalfRequestorsToRemoveAccess":false,"enableOnBehalfRequestorsToUpdateAccess":false,"enableTargetsToSelfAddAccess":false,"enableTargetsToSelfRemoveAccess":false,"enableTargetsToSelfUpdateAccess":false,"onBehalfRequestors":[]},"specificAllowedTargets":[]}
    EOT
    )
    error_message = "A caller that uses no new input must send the body of the previous release, without reviewSettings."
  }
}

# Two approval stages with sponsors and group fallbacks, a connected organization
# target and text questions that set only the four original attributes.
run "keeps_a_full_body_with_text_questions" {
  command = apply

  variables {
    description          = "Partner users request with sponsor approval"
    allowed_target_scope = "specificConnectedOrganizationUsers"
    specific_allowed_targets = [
      { type = "connectedOrganizationMembers", id = "55555555-5555-5555-5555-555555555555" },
    ]
    expiration = { type = "afterDuration", duration_days = 365 }
    requestor_settings = {
      enable_targets_to_self_add_access    = true
      enable_targets_to_self_remove_access = true
    }
    request_approval_settings = {
      is_approval_required_for_add        = true
      is_requestor_justification_required = true
      stages = [
        {
          approval_timeout_in_days   = 14
          primary_approvers          = [{ type = "externalSponsors" }]
          fallback_primary_approvers = [{ type = "groupMembers", id = "33333333-3333-3333-3333-333333333333" }]
        },
        {
          approval_timeout_in_days           = 14
          is_approver_justification_required = true
          primary_approvers                  = [{ type = "internalSponsors" }]
          fallback_primary_approvers         = [{ type = "groupMembers", id = "44444444-4444-4444-4444-444444444444" }]
        },
      ]
    }
    questions = [
      { text = "Why do you need this access?", is_required = true, sequence = 1 },
      { text = "Which project is this for?", is_answer_editable = false },
    ]
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body) == trimspace(<<-EOT
      {"accessPackage":{"id":"77777777-7777-7777-7777-777777777777"},"allowedTargetScope":"specificConnectedOrganizationUsers","customExtensionStageSettings":[],"description":"Partner users request with sponsor approval","displayName":"Standard request policy","expiration":{"duration":"P365D","type":"afterDuration"},"questions":[{"@odata.type":"#microsoft.graph.accessPackageTextInputQuestion","isAnswerEditable":true,"isRequired":true,"sequence":1,"text":"Why do you need this access?"},{"@odata.type":"#microsoft.graph.accessPackageTextInputQuestion","isAnswerEditable":false,"isRequired":false,"sequence":null,"text":"Which project is this for?"}],"requestApprovalSettings":{"isApprovalRequiredForAdd":true,"isApprovalRequiredForUpdate":false,"isRequestorJustificationRequired":true,"stages":[{"approverInformationVisibility":"default","durationBeforeAutomaticDenial":"P14D","durationBeforeEscalation":null,"escalationApprovers":[],"fallbackEscalationApprovers":[],"fallbackPrimaryApprovers":[{"@odata.type":"#microsoft.graph.groupMembers","groupId":"33333333-3333-3333-3333-333333333333"}],"isApproverJustificationRequired":false,"isEscalationEnabled":false,"primaryApprovers":[{"@odata.type":"#microsoft.graph.externalSponsors"}]},{"approverInformationVisibility":"default","durationBeforeAutomaticDenial":"P14D","durationBeforeEscalation":null,"escalationApprovers":[],"fallbackEscalationApprovers":[],"fallbackPrimaryApprovers":[{"@odata.type":"#microsoft.graph.groupMembers","groupId":"44444444-4444-4444-4444-444444444444"}],"isApproverJustificationRequired":true,"isEscalationEnabled":false,"primaryApprovers":[{"@odata.type":"#microsoft.graph.internalSponsors"}]}]},"requestorSettings":{"allowCustomAssignmentSchedule":true,"enableOnBehalfRequestorsToAddAccess":false,"enableOnBehalfRequestorsToRemoveAccess":false,"enableOnBehalfRequestorsToUpdateAccess":false,"enableTargetsToSelfAddAccess":true,"enableTargetsToSelfRemoveAccess":true,"enableTargetsToSelfUpdateAccess":false,"onBehalfRequestors":[]},"specificAllowedTargets":[{"@odata.type":"#microsoft.graph.connectedOrganizationMembers","connectedOrganizationId":"55555555-5555-5555-5555-555555555555"}]}
    EOT
    )
    error_message = "Text questions that set only text, is_required, is_answer_editable and sequence must send the body of the previous release."
  }
}
