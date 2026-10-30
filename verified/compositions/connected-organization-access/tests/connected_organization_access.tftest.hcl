# The composite calls the verified modules with relative sources, so this suite runs
# all of them against mock providers. Every Graph object gets a fixed GUID through
# an override, because the child modules validate IDs as GUIDs and the assertions
# name them. An override replaces the mock defaults, so each one repeats the
# read-back keys that the child modules read. The data sources of the child modules
# share one default read, and each module reads only its own keys.
#
# Assertions can reach the root's locals and resources and the child modules'
# outputs, not the child modules' resources, so the inputs that the composite
# passes on are asserted through the locals that hold them.
#
# The runs share one state in file order and use command = apply, because the
# assignment-policies module reads the policy back in a check block, which is known
# only after apply.

mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      output = {
        display_name = "mock"
        state        = "published"
        catalog_type = "userManaged"
        mail         = null
        unmanaged_properties = {
          callback_configuration = false
          client_configuration   = false
          behavior_on_error      = false
          other_authentication   = false
        }
        custom_extension_stage_settings = []
      }
    }
  }

  mock_resource "msgraph_resource_action" {
    defaults = {
      output = {
        id         = "99999999-0000-0000-0000-000000000001"
        request_id = "99999999-0000-0000-0000-000000000002"
        state      = "delivered"
        user_id    = "99999999-0000-0000-0000-00000000000C"
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        # connected-organizations: the listing of existing organizations and the
        # tenant lookup of a "tenant_domain" source.
        organizations = []
        tenant_id     = "33333333-3333-3333-3333-333333333333"
        display_name  = "Fabrikam (tenant)"
        # catalogs/resources: the read that verifies the guests group in the catalog.
        resources = [{ id = "11111111-0000-0000-0000-00000000000b" }]
        # resource-role-scopes: the roles of the guests group in the catalog.
        roles = [{
          displayName = "Member"
          originId    = "Member_11111111-0000-0000-0000-000000000001"
          resource    = { originId = "11111111-0000-0000-0000-000000000001" }
        }]
        # custom-extensions: no other extension in the catalog.
        extensions = []
        # assignment-policies: the catalog of the access package, its extensions, and
        # the policy's bindings as the check reads them.
        catalog_id                      = "11111111-0000-0000-0000-000000000006"
        extension_ids                   = ["11111111-0000-0000-0000-00000000000a", "11111111-0000-0000-0000-00000000000d"]
        custom_extension_stage_settings = []
      }
    }
  }
}

mock_provider "null" {}
mock_provider "time" {}

override_resource {
  target = module.guests_group.msgraph_resource.group
  values = {
    id     = "11111111-0000-0000-0000-000000000001"
    output = { display_name = "mock", mail = null, mail_enabled = false, group_types = [] }
  }
}

override_resource {
  target = module.external_sponsors_group.msgraph_resource.group
  values = {
    id     = "11111111-0000-0000-0000-000000000002"
    output = { display_name = "mock", mail = null, mail_enabled = false, group_types = [] }
  }
}

override_resource {
  target = module.internal_sponsors_group.msgraph_resource.group
  values = {
    id     = "11111111-0000-0000-0000-000000000003"
    output = { display_name = "mock", mail = null, mail_enabled = false, group_types = [] }
  }
}

override_resource {
  target = module.administrative_unit[0].msgraph_resource.this
  values = {
    id     = "11111111-0000-0000-0000-000000000004"
    output = {}
  }
}

override_resource {
  target = module.connected_organization.msgraph_resource.this
  values = {
    id     = "11111111-0000-0000-0000-000000000005"
    output = {}
  }
}

override_resource {
  target = module.catalog.msgraph_resource.catalog
  values = {
    id     = "11111111-0000-0000-0000-000000000006"
    output = { display_name = "mock", state = "published", catalog_type = "userManaged" }
  }
}

override_resource {
  target = module.access_package.msgraph_resource.access_package
  values = {
    id     = "11111111-0000-0000-0000-000000000007"
    output = { display_name = "mock", is_hidden = false }
  }
}

override_resource {
  target = module.requests_policy.msgraph_resource.assignment_policy
  values = {
    id     = "11111111-0000-0000-0000-000000000008"
    output = { display_name = "mock", custom_extension_stage_settings = [] }
  }
}

override_resource {
  target = module.external_sponsor_policy[0].msgraph_resource.assignment_policy
  values = {
    id     = "11111111-0000-0000-0000-000000000009"
    output = { display_name = "mock", custom_extension_stage_settings = [] }
  }
}

override_resource {
  target = module.custom_extensions["grant"].msgraph_resource.this
  values = {
    id = "11111111-0000-0000-0000-00000000000a"
    output = {
      unmanaged_properties = {
        callback_configuration = false
        client_configuration   = false
        behavior_on_error      = false
        other_authentication   = false
      }
    }
  }
}

override_resource {
  target = module.custom_extensions["notify"].msgraph_resource.this
  values = {
    id = "11111111-0000-0000-0000-00000000000d"
    output = {
      unmanaged_properties = {
        callback_configuration = false
        client_configuration   = false
        behavior_on_error      = false
        other_authentication   = false
      }
    }
  }
}

variables {
  display_name           = "Fabrikam Café"
  identity_sources       = [{ type = "domain", domain_name = "fabrikam.example" }]
  internal_sponsor_ids   = ["22222222-0000-0000-0000-000000000001"]
  external_sponsor_ids   = ["22222222-0000-0000-0000-00000000000A"]
  enable_destroy_cleanup = false
}

run "defaults_build_the_whole_setup" {
  command = apply

  assert {
    condition = output.names == {
      connected_organization_description    = "Fabrikam Café connected organization"
      catalog                               = "Fabrikam Café"
      catalog_description                   = "Resources and access packages for the Fabrikam Café connected organization"
      access_package                        = "Fabrikam Café guest access"
      access_package_description            = "Guest access for users of the Fabrikam Café connected organization"
      administrative_unit                   = "Fabrikam Café connected organization"
      administrative_unit_description       = "Groups of the Fabrikam Café connected organization"
      guests_group                          = "FabrikamCafe-guests"
      guests_group_mail_nickname            = "fabrikam-cafe-guests"
      guests_group_description              = "Guests of the Fabrikam Café connected organization, assigned through its access package"
      external_sponsors_group               = "FabrikamCafe-external-sponsors"
      external_sponsors_group_mail_nickname = "fabrikam-cafe-external-sponsors"
      external_sponsors_group_description   = "External sponsors of the Fabrikam Café connected organization"
      internal_sponsors_group               = "FabrikamCafe-internal-sponsors"
      internal_sponsors_group_mail_nickname = "fabrikam-cafe-internal-sponsors"
      internal_sponsors_group_description   = "Internal sponsors of the Fabrikam Café connected organization"
      requests_policy                       = "Connected organization requests"
      requests_policy_description           = "Requests from users of the Fabrikam Café connected organization"
      external_sponsor_policy               = "External sponsor access"
      external_sponsor_policy_description   = "Access for the external sponsors of the Fabrikam Café connected organization"
    }
    error_message = "The default naming convention must name every object from display_name, with ASCII group names and mail nicknames."
  }

  assert {
    condition = (
      output.name_patterns.guests_group == "^[A-Za-z0-9]+-guests$" &&
      output.name_patterns.guests_group_mail_nickname == "^[a-z0-9]+(?:-[a-z0-9]+)*-guests$" &&
      output.name_patterns.catalog == "(?s)^.+$" &&
      output.name_patterns.requests_policy == "^Connected organization requests$"
    )
    error_message = "The composite must expose the patterns that the default convention derives."
  }

  assert {
    condition     = alltrue([for key, name in output.names : can(regex(output.name_patterns[key], name))])
    error_message = "Every name must match the pattern that the module taking it receives."
  }

  assert {
    condition = jsonencode(local.approval_stages) == jsonencode([
      {
        approval_timeout_in_days           = 14
        is_approver_justification_required = true
        primary_approvers                  = [{ type = "externalSponsors" }]
        fallback_primary_approvers         = [{ type = "groupMembers", id = "11111111-0000-0000-0000-000000000002" }]
      },
      {
        approval_timeout_in_days           = 14
        is_approver_justification_required = true
        primary_approvers                  = [{ type = "internalSponsors" }]
        fallback_primary_approvers         = [{ type = "groupMembers", id = "11111111-0000-0000-0000-000000000003" }]
      },
    ])
    error_message = "By default the external sponsors approve first and the internal sponsors second, each with their group as fallback approvers."
  }

  assert {
    condition = jsonencode(local.requests_policy_approval_settings) == jsonencode({
      is_approval_required_for_add        = true
      is_approval_required_for_update     = true
      is_requestor_justification_required = true
      stages                              = local.approval_stages
    })
    error_message = "Approval must be required for new and updated requests, with justification."
  }

  assert {
    condition     = jsonencode(local.requests_policy_expiration) == jsonencode({ type = "afterDuration", duration_days = 365 })
    error_message = "Assignments must expire after 365 days by default."
  }

  assert {
    condition = jsonencode(local.requests_policy_requestor_settings) == jsonencode({
      allow_custom_assignment_schedule     = true
      enable_targets_to_self_add_access    = true
      enable_targets_to_self_update_access = true
      enable_targets_to_self_remove_access = true
    })
    error_message = "Users of the organization must be able to request, extend and remove their own access."
  }

  assert {
    condition     = local.review_settings == null
    error_message = "Without access_review the requests policy must have no review settings."
  }

  assert {
    condition     = jsonencode(local.extension_bindings) == jsonencode({ external_sponsor = [], requests = [] })
    error_message = "Without custom extensions no policy must bind one."
  }

  assert {
    condition     = jsonencode(local.external_sponsor_member_ids) == jsonencode(["22222222-0000-0000-0000-00000000000a"]) && jsonencode(local.internal_sponsor_member_ids) == jsonencode(["22222222-0000-0000-0000-000000000001"])
    error_message = "The sponsor groups must hold the sponsor IDs in lower case."
  }

  assert {
    condition     = jsonencode(module.external_sponsors_members.member_ids) == jsonencode(["22222222-0000-0000-0000-00000000000a"]) && jsonencode(module.internal_sponsors_members.member_ids) == jsonencode(["22222222-0000-0000-0000-000000000001"])
    error_message = "The members modules must manage the sponsor groups' members."
  }

  assert {
    condition     = jsonencode(module.administrative_unit[0].member_ids) == jsonencode(["11111111-0000-0000-0000-000000000001", "11111111-0000-0000-0000-000000000002", "11111111-0000-0000-0000-000000000003"])
    error_message = "The administrative unit must hold the three groups."
  }

  assert {
    condition     = jsonencode(module.connected_organization.internal_sponsor_ids) == jsonencode(["11111111-0000-0000-0000-000000000003"]) && jsonencode(module.connected_organization.external_sponsor_ids) == jsonencode(["11111111-0000-0000-0000-000000000002"])
    error_message = "The sponsor groups must be the connected organization's only sponsors."
  }

  assert {
    condition     = module.catalog.is_externally_visible == true
    error_message = "The catalog must be enabled for external users."
  }

  assert {
    condition     = output.my_access_url == "https://myaccess.microsoft.com/#/access-packages/11111111-0000-0000-0000-000000000007"
    error_message = "Without my_access_tenant the My Access link must have no tenant hint."
  }

  assert {
    condition = output.group_ids == {
      guests            = "11111111-0000-0000-0000-000000000001"
      external_sponsors = "11111111-0000-0000-0000-000000000002"
      internal_sponsors = "11111111-0000-0000-0000-000000000003"
    }
    error_message = "group_ids must name the three groups."
  }

  assert {
    condition = (
      output.connected_organization_id == "11111111-0000-0000-0000-000000000005" &&
      output.catalog_id == "11111111-0000-0000-0000-000000000006" &&
      output.access_package_id == "11111111-0000-0000-0000-000000000007" &&
      output.administrative_unit_id == "11111111-0000-0000-0000-000000000004" &&
      output.requests_policy_id == "11111111-0000-0000-0000-000000000008" &&
      output.external_sponsor_policy_id == "11111111-0000-0000-0000-000000000009"
    )
    error_message = "The outputs must expose the IDs of the objects."
  }

  assert {
    condition     = output.custom_extension_ids == {} && output.invited_user_ids == {} && length(msgraph_resource_action.external_sponsor_invitation) == 0
    error_message = "Without custom extensions and invitations there must be none."
  }

  assert {
    condition     = jsonencode(output.identity_sources) == jsonencode([{ "@odata.type" = "#microsoft.graph.domainIdentitySource", domainName = "fabrikam.example", displayName = "fabrikam.example" }])
    error_message = "identity_sources must be passed to the connected-organizations module unchanged."
  }
}

run "naming_overrides_and_additional_description" {
  command = apply

  variables {
    additional_description = "Logistics partner"
    naming = {
      templates = {
        catalog        = "Partners/{organization}"
        access_package = "Partners/{organization}/{region|upper}"
        guests_group   = "{organization|ascii|alnum|upper}-G-Guests"
      }
      tokens      = { region = "emea" }
      constraints = { access_package = { max_length = 40 } }
      transliterations = {
        "é" = "ee"
      }
    }
  }

  assert {
    condition     = output.names.catalog == "Partners/Fabrikam Café" && output.names.access_package == "Partners/Fabrikam Café/EMEA"
    error_message = "naming.templates must replace the default templates and may use naming.tokens."
  }

  assert {
    condition     = output.names.guests_group == "FABRIKAMCAFEE-G-Guests" && output.names.guests_group_mail_nickname == "fabrikam-cafee-guests"
    error_message = "naming.transliterations must change the ascii filter for every template."
  }

  assert {
    condition     = output.names.connected_organization_description == "Fabrikam Café connected organization\nLogistics partner"
    error_message = "additional_description must go on a new line of the connected organization description."
  }

  assert {
    condition     = output.names.requests_policy == "Connected organization requests"
    error_message = "Templates that naming.templates does not name must keep their defaults."
  }

  assert {
    condition     = output.name_patterns.guests_group == "^[A-Z0-9]+-G-Guests$" && output.name_patterns.access_package == "(?s)^Partners/.+/[^a-z]+$"
    error_message = "The patterns must follow the replaced templates, so the child modules hold the names to the caller's convention."
  }

  assert {
    condition     = alltrue([for key, name in output.names : can(regex(output.name_patterns[key], name))])
    error_message = "Every name must match the pattern that the module taking it receives."
  }
}

run "access_review_internal_approval_only_and_no_expiration" {
  command = apply

  variables {
    my_access_tenant = "contoso.example"
    requests_policy = {
      approval_stages    = ["internal_sponsors"]
      assignments_expire = false
      access_review = {
        start_date_time = "2026-11-01T00:00:00Z"
      }
    }
  }

  assert {
    condition     = length(local.approval_stages) == 1 && jsonencode(local.approval_stages[0].primary_approvers) == jsonencode([{ type = "internalSponsors" }])
    error_message = "approval_stages must select and order the stages."
  }

  assert {
    condition     = jsonencode(local.requests_policy_expiration) == jsonencode({ type = "noExpiration", duration_days = null })
    error_message = "assignments_expire = false must make assignments permanent."
  }

  assert {
    condition = jsonencode(local.review_settings) == jsonencode({
      is_enabled                         = true
      expiration_behavior                = "removeAccess"
      is_recommendation_enabled          = true
      is_reviewer_justification_required = true
      is_self_review                     = false
      primary_reviewers                  = [{ type = "groupMembers", id = "11111111-0000-0000-0000-000000000003" }]
      fallback_reviewers                 = []
      schedule = {
        start_date_time  = "2026-11-01T00:00:00Z"
        duration_in_days = 25
        recurrence       = { type = "absoluteMonthly", interval = 3 }
      }
    })
    error_message = "access_review must become quarterly reviews by the internal sponsors group that remove unconfirmed access."
  }

  assert {
    condition     = output.my_access_url == "https://myaccess.microsoft.com/@contoso.example#/access-packages/11111111-0000-0000-0000-000000000007"
    error_message = "my_access_tenant must be the tenant hint of the My Access link."
  }
}

run "external_sponsor_access_expires_and_can_be_extended" {
  command = apply

  variables {
    external_sponsor_policy = { expiration_in_days = 180 }
  }

  assert {
    condition     = jsonencode(local.external_sponsor_policy_expiration) == jsonencode({ type = "afterDuration", duration_days = 180 })
    error_message = "A sponsor's assignment must expire after expiration_in_days, so that a removed sponsor loses access."
  }

  assert {
    condition     = local.external_sponsor_policy_requestor_settings.enable_targets_to_self_update_access && local.external_sponsor_policy_requestor_settings.enable_targets_to_self_remove_access
    error_message = "Current sponsors must be able to extend and remove their own access."
  }
}

run "external_sponsor_access_expires_after_a_year_by_default" {
  command = apply

  assert {
    condition     = local.external_sponsor_policy_expiration.duration_days == 365
    error_message = "A sponsor's assignment must expire after 365 days by default."
  }
}

run "external_sponsor_expiration_must_be_a_whole_number" {
  command = plan

  variables {
    external_sponsor_policy = { expiration_in_days = 0 }
  }

  expect_failures = [var.external_sponsor_policy]
}

run "access_review_can_be_turned_off" {
  command = apply

  variables {
    internal_sponsor_ids = []
    requests_policy = {
      approval_stages = ["external_sponsors"]
      access_review = {
        enabled         = false
        start_date_time = "2026-11-01T00:00:00Z"
      }
    }
  }

  assert {
    condition     = local.review_settings.is_enabled == false
    error_message = "access_review.enabled = false must send isEnabled = false, so that the reviews stop."
  }

  # Disabled reviews need no reviewers, so the sponsor check does not warn.
}

run "no_approval_stages_requires_no_approval" {
  command = apply

  variables {
    requests_policy = { approval_stages = [] }
  }

  assert {
    condition     = local.requests_policy_approval_settings.is_approval_required_for_add == false && local.requests_policy_approval_settings.is_approval_required_for_update == false && length(local.requests_policy_approval_settings.stages) == 0
    error_message = "An empty approval_stages must require no approval."
  }
}

# Both policies can include guests, so the assignment-policies module's
# guest_custom_extension_prerequisite check warns as soon as either binds an
# extension, and a test cannot expect a check inside a child module. The policy
# modules are therefore replaced in this run, and the bindings are asserted on the
# local that the composite passes to them.
run "custom_extensions_bind_the_chosen_policies" {
  command = apply

  override_module {
    target = module.requests_policy
    outputs = {
      id                              = "11111111-0000-0000-0000-000000000008"
      display_name                    = "mock"
      access_package_id               = "11111111-0000-0000-0000-000000000007"
      custom_extension_stage_settings = []
    }
  }

  override_module {
    target = module.external_sponsor_policy
    outputs = {
      id                              = "11111111-0000-0000-0000-000000000009"
      display_name                    = "mock"
      access_package_id               = "11111111-0000-0000-0000-000000000007"
      custom_extension_stage_settings = []
    }
  }

  variables {
    custom_extensions = {
      grant = {
        logic_app = {
          subscription_id     = "44444444-4444-4444-4444-444444444444"
          resource_group_name = "rg-access"
          workflow_name       = "partner-grant"
        }
        callback = { timeout = "PT1H" }
        stages   = ["assignmentRequestGranted", "assignmentRequestRemoved"]
      }
      notify = {
        display_name = "Notify sponsors"
        logic_app = {
          subscription_id     = "44444444-4444-4444-4444-444444444444"
          resource_group_name = "rg-access"
          workflow_name       = "partner-notify"
        }
        stages   = ["assignmentRequestCreated"]
        policies = ["requests"]
      }
    }
  }

  assert {
    condition = jsonencode(local.extension_bindings) == jsonencode({
      external_sponsor = [
        { extension_id = "11111111-0000-0000-0000-00000000000a", extension_type = "request_workflow", stage = "assignmentRequestGranted" },
        { extension_id = "11111111-0000-0000-0000-00000000000a", extension_type = "request_workflow", stage = "assignmentRequestRemoved" },
      ]
      requests = [
        { extension_id = "11111111-0000-0000-0000-00000000000a", extension_type = "request_workflow", stage = "assignmentRequestGranted" },
        { extension_id = "11111111-0000-0000-0000-00000000000a", extension_type = "request_workflow", stage = "assignmentRequestRemoved" },
        { extension_id = "11111111-0000-0000-0000-00000000000d", extension_type = "request_workflow", stage = "assignmentRequestCreated" },
      ]
    })
    error_message = "Each extension must be bound at each of its stages to each policy it names."
  }

  assert {
    condition     = module.custom_extensions["grant"].launch_and_wait == true && module.custom_extensions["notify"].launch_and_wait == false
    error_message = "callback must make the extension launch and wait."
  }

  assert {
    condition     = module.custom_extensions["grant"].display_name == "grant" && module.custom_extensions["notify"].display_name == "Notify sponsors"
    error_message = "An extension's display name must default to its key."
  }

  assert {
    condition     = output.custom_extension_ids == { grant = "11111111-0000-0000-0000-00000000000a", notify = "11111111-0000-0000-0000-00000000000d" }
    error_message = "custom_extension_ids must name the extensions by key."
  }
}

run "invitations_join_the_external_sponsors_group" {
  command = apply

  variables {
    my_access_tenant = "contoso.example"
    external_sponsor_invitations = {
      email_addresses         = ["Ana@Fabrikam.example"]
      message_language        = "de-DE"
      customized_message_body = "Welcome"
    }
  }

  assert {
    condition = jsonencode(msgraph_resource_action.external_sponsor_invitation["ana@fabrikam.example"].body) == jsonencode({
      invitedUserEmailAddress = "ana@fabrikam.example"
      inviteRedirectUrl       = "https://myaccess.microsoft.com/@contoso.example#/access-packages/11111111-0000-0000-0000-000000000007"
      invitedUserMessageInfo  = { customizedMessageBody = "Welcome", messageLanguage = "de-DE" }
      sendInvitationMessage   = true
    })
    error_message = "An invitation must send the address in lower case, redirect to the My Access link and carry the message settings."
  }

  assert {
    condition     = msgraph_resource_action.external_sponsor_invitation["ana@fabrikam.example"].resource_url == "invitations" && msgraph_resource_action.external_sponsor_invitation["ana@fabrikam.example"].method == "POST"
    error_message = "An invitation must be a POST to invitations."
  }

  assert {
    condition     = output.invited_user_ids == { "ana@fabrikam.example" = "99999999-0000-0000-0000-00000000000c" }
    error_message = "invited_user_ids must give the invited user's ID in lower case, keyed by address."
  }

  assert {
    condition     = jsonencode(local.external_sponsor_member_ids) == jsonencode(["22222222-0000-0000-0000-00000000000a", "99999999-0000-0000-0000-00000000000c"])
    error_message = "Invited users must join the external sponsors group next to external_sponsor_ids."
  }
}

# The previous run invited the address. Changing the invitation settings must not
# send the invitation again: the action ignores changes to its body, so the stored
# body is the one of the first invitation.
run "a_changed_invitation_is_not_sent_again" {
  command = apply

  variables {
    external_sponsor_invitations = {
      email_addresses         = ["ana@fabrikam.example"]
      redirect_url            = "https://partners.contoso.example/welcome"
      send_invitation_message = false
    }
  }

  assert {
    condition     = msgraph_resource_action.external_sponsor_invitation["ana@fabrikam.example"].body.inviteRedirectUrl == "https://myaccess.microsoft.com/@contoso.example#/access-packages/11111111-0000-0000-0000-000000000007" && msgraph_resource_action.external_sponsor_invitation["ana@fabrikam.example"].body.sendInvitationMessage == true
    error_message = "A change of the invitation settings must not update, and so resend, an existing invitation."
  }
}

# A new address is invited with the current settings, and the address that is no
# longer listed leaves the external sponsors group.
run "invitation_redirect_url_and_message_defaults" {
  command = apply

  variables {
    external_sponsor_invitations = {
      email_addresses         = ["ben@fabrikam.example"]
      redirect_url            = "https://partners.contoso.example/welcome"
      send_invitation_message = false
    }
  }

  assert {
    condition = jsonencode(msgraph_resource_action.external_sponsor_invitation["ben@fabrikam.example"].body) == jsonencode({
      invitedUserEmailAddress = "ben@fabrikam.example"
      inviteRedirectUrl       = "https://partners.contoso.example/welcome"
      sendInvitationMessage   = false
    })
    error_message = "redirect_url and send_invitation_message must be sent, and no message info without a language or body."
  }

  assert {
    condition     = jsonencode(keys(output.invited_user_ids)) == jsonencode(["ben@fabrikam.example"])
    error_message = "An address that is no longer listed must leave invited_user_ids."
  }
}

run "optional_parts_can_be_left_out" {
  command = apply

  variables {
    administrative_unit     = { enabled = false }
    external_sponsor_policy = { enabled = false }
  }

  assert {
    condition     = output.administrative_unit_id == null && output.external_sponsor_policy_id == null
    error_message = "Disabling the administrative unit and the external sponsor policy must leave them out."
  }
}

run "tenant_domain_sources_are_resolved" {
  command = apply

  variables {
    identity_sources = [{ type = "tenant_domain", domain_name = "fabrikam.example" }]
  }

  assert {
    condition     = jsonencode(output.identity_sources) == jsonencode([{ "@odata.type" = "#microsoft.graph.azureActiveDirectoryTenant", tenantId = "33333333-3333-3333-3333-333333333333", displayName = "Fabrikam (tenant)" }])
    error_message = "A tenant_domain source must reach the connected organization as the tenant the lookup found."
  }
}

run "missing_sponsors_warn" {
  command = apply

  variables {
    internal_sponsor_ids = []
    external_sponsor_ids = []
  }

  expect_failures = [check.sponsors_for_approvals]
}

# The connected-organizations module checks display_name against name_pattern; its
# own suite covers a name that does not match.
run "accepts_a_display_name_that_matches_name_pattern" {
  command = plan

  variables {
    name_pattern = "^[A-Z][^/]+$"
  }

  assert {
    condition     = output.names.catalog == "Fabrikam Café"
    error_message = "A display_name that matches name_pattern must plan."
  }
}

# Validations of the composite's own inputs.

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(["
  }

  expect_failures = [var.name_pattern]
}

run "empty_display_name_fails" {
  command = plan

  variables {
    display_name = " "
  }

  expect_failures = [var.display_name]
}

run "unknown_state_fails" {
  command = plan

  variables {
    connected_organization_state = "suggested"
  }

  expect_failures = [var.connected_organization_state]
}

run "sponsor_ids_must_be_guids" {
  command = plan

  variables {
    internal_sponsor_ids = ["alex@contoso.example"]
    external_sponsor_ids = ["not-a-guid"]
  }

  expect_failures = [var.internal_sponsor_ids, var.external_sponsor_ids]
}

run "invitation_addresses_must_be_email_addresses" {
  command = plan

  variables {
    external_sponsor_invitations = { email_addresses = ["ana"] }
  }

  expect_failures = [var.external_sponsor_invitations]
}

run "duplicate_invitation_addresses_fail" {
  command = plan

  variables {
    external_sponsor_invitations = { email_addresses = ["ana@fabrikam.example", "ANA@fabrikam.example"] }
  }

  expect_failures = [var.external_sponsor_invitations]
}

run "invitation_redirect_must_be_https" {
  command = plan

  variables {
    external_sponsor_invitations = { email_addresses = ["ana@fabrikam.example"], redirect_url = "http://contoso.example" }
  }

  expect_failures = [var.external_sponsor_invitations]
}

run "my_access_tenant_must_be_a_domain_or_id" {
  command = plan

  variables {
    my_access_tenant = "https://contoso.example"
  }

  expect_failures = [var.my_access_tenant]
}

run "my_access_tenant_rejects_a_hyphen" {
  command = plan

  variables {
    my_access_tenant = "-"
  }

  expect_failures = [var.my_access_tenant]
}

run "my_access_tenant_rejects_an_empty_label" {
  command = plan

  variables {
    my_access_tenant = "contoso..com"
  }

  expect_failures = [var.my_access_tenant]
}

run "my_access_tenant_rejects_a_single_label" {
  command = plan

  variables {
    my_access_tenant = "contoso"
  }

  expect_failures = [var.my_access_tenant]
}

run "my_access_tenant_accepts_a_tenant_id" {
  command = apply

  variables {
    my_access_tenant = "aaaaaaaa-0000-4000-8000-000000000001"
  }

  assert {
    condition     = output.my_access_url == "https://myaccess.microsoft.com/@aaaaaaaa-0000-4000-8000-000000000001#/access-packages/11111111-0000-0000-0000-000000000007"
    error_message = "A tenant ID must be accepted as the tenant hint."
  }
}

run "unknown_approval_stage_fails" {
  command = plan

  variables {
    requests_policy = { approval_stages = ["managers"] }
  }

  expect_failures = [var.requests_policy]
}

run "repeated_approval_stage_fails" {
  command = plan

  variables {
    requests_policy = { approval_stages = ["internal_sponsors", "internal_sponsors"] }
  }

  expect_failures = [var.requests_policy]
}

run "approval_timeout_must_be_whole_days" {
  command = plan

  variables {
    requests_policy = { approval_timeout_in_days = 0.5 }
  }

  expect_failures = [var.requests_policy]
}

run "expiration_must_be_whole_days" {
  command = plan

  variables {
    requests_policy = { expiration_in_days = 0 }
  }

  expect_failures = [var.requests_policy]
}

run "extension_needs_a_stage" {
  command = plan

  variables {
    custom_extensions = {
      grant = {
        logic_app = { subscription_id = "44444444-4444-4444-4444-444444444444", resource_group_name = "rg-access", workflow_name = "partner-grant" }
        stages    = []
      }
    }
  }

  expect_failures = [var.custom_extensions]
}

run "extension_policy_must_be_known" {
  command = plan

  variables {
    custom_extensions = {
      grant = {
        logic_app = { subscription_id = "44444444-4444-4444-4444-444444444444", resource_group_name = "rg-access", workflow_name = "partner-grant" }
        stages    = ["assignmentRequestGranted"]
        policies  = ["sponsors"]
      }
    }
  }

  expect_failures = [var.custom_extensions]
}

run "a_stage_bound_twice_fails" {
  command = plan

  variables {
    custom_extensions = {
      grant = {
        logic_app = { subscription_id = "44444444-4444-4444-4444-444444444444", resource_group_name = "rg-access", workflow_name = "partner-grant" }
        stages    = ["assignmentRequestGranted"]
      }
      notify = {
        logic_app = { subscription_id = "44444444-4444-4444-4444-444444444444", resource_group_name = "rg-access", workflow_name = "partner-notify" }
        stages    = ["assignmentRequestGranted"]
        policies  = ["requests"]
      }
    }
  }

  expect_failures = [var.custom_extensions]
}

run "reserved_naming_tokens_fail" {
  command = plan

  variables {
    naming = { tokens = { organization = "Contoso" } }
  }

  expect_failures = [var.naming]
}
