mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "11111111-1111-1111-1111-111111111111"
      output = {
        isBuiltIn  = false
        templateId = "22222222-2222-2222-2222-222222222222"
      }
    }
  }
}

variables {
  displayName = "Application metadata reader"
  rolePermissions = [{
    allowedResourceActions = ["microsoft.directory/applications/basic/read"]
  }]
}

run "creates_custom_definition_with_graph_case" {
  command = apply

  assert {
    condition     = msgraph_resource.roleDefinition.url == "roleManagement/directory/roleDefinitions" && msgraph_resource.roleDefinition.api_version == "v1.0"
    error_message = "Use the directory roleDefinitions v1.0 endpoint with original Graph case."
  }
  assert {
    condition     = jsonencode(msgraph_resource.roleDefinition.body) == jsonencode({ displayName = "Application metadata reader", isEnabled = true, rolePermissions = [{ allowedResourceActions = ["microsoft.directory/applications/basic/read"] }] })
    error_message = "The default body must contain exactly the reviewed Graph properties, no built-in flag, scope, or assignment."
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-111111111111" && output.templateId == "22222222-2222-2222-2222-222222222222"
    error_message = "Outputs must expose the managed definition ID and Graph's returned templateId."
  }
}

run "setting_template_identifier_replaces_definition" {
  command = apply
  variables {
    templateId = "AAAAAAAA-3333-3333-3333-333333333333"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000001"
      output = { isBuiltIn = false, templateId = "aaaaaaaa-3333-3333-3333-333333333333" }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000001" && msgraph_resource.roleDefinition.body.templateId == "AAAAAAAA-3333-3333-3333-333333333333"
    error_message = "Adding templateId must replace the definition and send the identifier on its create."
  }
  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ templateId = "aaaaaaaa-3333-3333-3333-333333333333" })
    error_message = "Only the stable template identity belongs in the replacement trigger."
  }
}

run "template_identifier_letter_case_keeps_definition" {
  command = apply
  variables {
    templateId = "aaaaaaaa-3333-3333-3333-333333333333"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000008"
      output = { isBuiltIn = false, templateId = "aaaaaaaa-3333-3333-3333-333333333333" }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000001"
    error_message = "A change of only templateId hexadecimal letter case must keep the definition."
  }
  assert {
    condition     = msgraph_resource.roleDefinition.body.templateId == "AAAAAAAA-3333-3333-3333-333333333333"
    error_message = "A case-only change must retain the original templateId body rather than patching it."
  }
}

run "mutable_role_changes_keep_definition" {
  command = apply
  variables {
    templateId  = "aaaaaaaa-3333-3333-3333-333333333333"
    displayName = "Application registration support"
    description = "Reviewed basic read and update"
    isEnabled   = false
    rolePermissions = [{
      allowedResourceActions = [
        "microsoft.directory/applications/basic/read",
        "microsoft.directory/applications.myOrganization/basic/update",
        "microsoft.directory/applications/createAsOwner",
        "microsoft.directory/groups.security.assignedMembership/members/update",
      ]
    }]
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000002"
      output = { isBuiltIn = false, templateId = "aaaaaaaa-3333-3333-3333-333333333333" }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000001"
    error_message = "Display name, description, enablement and permission changes must update in place."
  }
  assert {
    condition     = msgraph_resource.roleDefinition.body.isEnabled == false && msgraph_resource.roleDefinition.body.description == "Reviewed basic read and update" && msgraph_resource.roleDefinition.body.displayName == "Application registration support" && length(msgraph_resource.roleDefinition.body.rolePermissions[0].allowedResourceActions) == 4
    error_message = "All mutable inputs must reach the request body, including optional-property-set action syntax and entity subtypes."
  }
}

run "changed_template_identifier_replaces_definition" {
  command = apply
  variables {
    templateId = "44444444-4444-4444-4444-444444444444"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000003"
      output = { isBuiltIn = false, templateId = "44444444-4444-4444-4444-444444444444" }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000003" && msgraph_resource.roleDefinition.body.templateId == "44444444-4444-4444-4444-444444444444"
    error_message = "Changing the template identifier must create a replacement with the new identity."
  }
}

run "removing_template_identifier_replaces_definition" {
  command = apply
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000004"
      output = { isBuiltIn = false, templateId = "55555555-5555-5555-5555-555555555555" }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000004" && !contains(keys(msgraph_resource.roleDefinition.body), "templateId")
    error_message = "Removing templateId must replace and omit the old identifier on create."
  }
}

run "returned_template_identifier_matching_exactly_is_accepted" {
  command = apply
  variables {
    templateId = "77777777-7777-7777-7777-777777777777"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000005"
      output = { isBuiltIn = false, templateId = "77777777-7777-7777-7777-777777777777" }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000005" && output.templateId == "77777777-7777-7777-7777-777777777777"
    error_message = "A returned templateId equal to the configured one must be accepted."
  }
}

run "returned_template_identifier_in_other_letter_case_is_accepted" {
  command = apply
  variables {
    templateId = "88888888-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000006"
      output = { isBuiltIn = false, templateId = "88888888-AAAA-AAAA-AAAA-AAAAAAAAAAAA" }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000006"
    error_message = "A returned templateId that differs only in letter case must be accepted."
  }
}

run "omitted_template_identifier_accepts_a_null_server_assigned_readback" {
  command = apply
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000007"
      output = { isBuiltIn = false, templateId = null }
    }
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-000000000007" && output.templateId == null
    error_message = "An omitted templateId is server-assigned and unmanaged, so even a null readback must be accepted."
  }
}

run "broad_named_permissions_are_explicit_not_classified_safe" {
  command = plan
  variables {
    rolePermissions = [{
      allowedResourceActions = [
        "microsoft.directory/applications/allProperties/update",
        "microsoft.directory/applications/allTasks",
        "microsoft.directory/applications/credentials/update",
        "microsoft.directory/applications/owners/update",
      ]
    }]
  }
  assert {
    condition     = length(msgraph_resource.roleDefinition.body.rolePermissions[0].allowedResourceActions) == 4
    error_message = "Syntax validation must not silently remove explicit high-impact named permissions or imply a least-privilege policy."
  }
}

run "explicit_null_template_identifier_is_omitted" {
  command = plan
  variables { templateId = null }
  assert {
    condition     = !contains(keys(msgraph_resource.roleDefinition.body), "templateId") && terraform_data.immutable.input.templateId == null
    error_message = "An explicit null templateId must be omitted from the body and remain null in the identity trigger."
  }
}

run "accepts_documented_policy_qualified_consent_actions" {
  command = plan
  variables {
    rolePermissions = [{
      allowedResourceActions = [
        "microsoft.directory/servicePrincipals/managePermissionGrantsForSelf.microsoft-user-default-low",
        "microsoft.directory/servicePrincipals/managePermissionGrantsForAll.low-risk-any-app",
        "microsoft.directory/servicePrincipals/managePermissionGrantsForAll.11111111-1111-1111-1111-111111111111",
        "microsoft.directory/servicePrincipals/managePermissionGrantsForSelf.2026_low-risk_policy",
      ]
    }]
  }
  assert {
    condition     = jsonencode(msgraph_resource.roleDefinition.body.rolePermissions) == jsonencode(var.rolePermissions)
    error_message = "Documented user/admin consent actions must retain policy-qualified IDs, including hyphens, GUIDs and underscores."
  }
}

run "rejects_consent_policy_wildcards" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/servicePrincipals/managePermissionGrantsForAll.*"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_unqualified_user_consent_action" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/servicePrincipals/managePermissionGrantsForSelf"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_unqualified_admin_consent_action" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/servicePrincipals/managePermissionGrantsForAll"] }] }
  expect_failures = [var.rolePermissions]
}

run "retains_documented_consent_policy_administration_actions" {
  command = plan
  variables {
    rolePermissions = [{
      allowedResourceActions = [
        "microsoft.directory/permissionGrantPolicies/create",
        "microsoft.directory/permissionGrantPolicies/standard/read",
        "microsoft.directory/permissionGrantPolicies/basic/update",
        "microsoft.directory/permissionGrantPolicies/delete",
      ]
    }]
  }
  assert {
    condition     = jsonencode(msgraph_resource.roleDefinition.body.rolePermissions) == jsonencode(var.rolePermissions)
    error_message = "Refusing bare consent-grant actions must preserve documented ordinary consent-policy administration actions."
  }
}

run "rejects_empty_consent_policy_identifier" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/servicePrincipals/managePermissionGrantsForAll."] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_consent_policy_identifier_with_dot" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/servicePrincipals/managePermissionGrantsForSelf.low.risk"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_consent_action_extra_path_segment" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/servicePrincipals/managePermissionGrantsForAll.lowrisk/read"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_consent_action_other_namespace" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.azure/servicePrincipals/managePermissionGrantsForSelf.microsoft-user-default-low"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_empty_display_name" {
  command = plan
  variables { displayName = "   " }
  expect_failures = [var.displayName]
}

run "rejects_empty_template_identifier" {
  command = plan
  variables { templateId = " " }
  expect_failures = [var.templateId]
}

run "rejects_non_guid_template_identifier" {
  command = plan
  variables { templateId = "shared-role-v1" }
  expect_failures = [var.templateId]
}

run "rejects_non_hexadecimal_template_identifier" {
  command = plan
  variables { templateId = "gggggggg-3333-3333-3333-333333333333" }
  expect_failures = [var.templateId]
}

run "rejects_empty_permissions" {
  command = plan
  variables { rolePermissions = [] }
  expect_failures = [var.rolePermissions]
}

run "rejects_empty_permission_item" {
  command = plan
  variables { rolePermissions = [{}] }
  expect_failures = [var.rolePermissions]
}

run "rejects_null_permission_item" {
  command = plan
  variables { rolePermissions = [null] }
  expect_failures = [var.rolePermissions]
}

run "rejects_empty_actions" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = [] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_malformed_action" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["applications/read"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_trailing_dot_in_entity" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/applications./read"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_empty_entity_subtype" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/groups..security/members/read"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_trailing_dot_in_property_set" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/applications/basic./read"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_empty_property_set_segment" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/applications/basic..properties/read"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_other_resource_provider_namespace" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["Microsoft.Authorization/roleDefinitions/read"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_literal_wildcards" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = ["microsoft.directory/applications/*"] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_null_action" {
  command = plan
  variables { rolePermissions = [{ allowedResourceActions = [null] }] }
  expect_failures = [var.rolePermissions]
}

run "rejects_unsupported_permission_properties" {
  command = plan
  variables {
    rolePermissions = [{
      allowedResourceActions  = ["microsoft.directory/applications/basic/read"]
      excludedResourceActions = ["microsoft.directory/applications/delete"]
    }]
  }
  expect_failures = [var.rolePermissions]
}

run "rejects_unsupported_conditions" {
  command = plan
  variables {
    rolePermissions = [{
      allowedResourceActions = ["microsoft.directory/applications/basic/read"]
      condition              = []
    }]
  }
  expect_failures = [var.rolePermissions]
}

# A configured templateId must equal the one Graph returns; ignore_changes would
# otherwise hide a remote change. Each run below is a custom definition (isBuiltIn
# is false) and uses a GUID of its own, so it creates a replacement and only the
# template guard can fail. Like the built-in guard, this detects a response after
# the provider operation and is not a pre-write barrier.
run "rejects_returned_template_identifier_that_differs" {
  command = apply
  variables {
    templateId = "99999999-9999-9999-9999-999999999999"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000009"
      output = { isBuiltIn = false, templateId = "99999999-9999-9999-9999-aaaaaaaaaaaa" }
    }
  }
  expect_failures = [msgraph_resource.roleDefinition]
}

run "rejects_null_returned_template_identifier_when_configured" {
  command = apply
  variables {
    templateId = "99999999-9999-9999-9999-bbbbbbbbbbbb"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000010"
      output = { isBuiltIn = false, templateId = null }
    }
  }
  expect_failures = [msgraph_resource.roleDefinition]
}

run "rejects_missing_returned_template_identifier_when_configured" {
  command = apply
  variables {
    templateId = "99999999-9999-9999-9999-cccccccccccc"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      id     = "11111111-1111-1111-1111-000000000011"
      output = { isBuiltIn = false }
    }
  }
  expect_failures = [msgraph_resource.roleDefinition]
}

# This detects a provider RESPONSE, not a pre-write barrier for imported state.
run "detects_builtin_response_after_provider_operation" {
  command = apply
  variables {
    templateId = "66666666-6666-6666-6666-666666666666"
  }
  override_resource {
    target = msgraph_resource.roleDefinition
    values = {
      # The returned template matches the configured one, so only the built-in guard fails.
      output = { isBuiltIn = true, templateId = "66666666-6666-6666-6666-666666666666" }
    }
  }
  expect_failures = [msgraph_resource.roleDefinition]
}
