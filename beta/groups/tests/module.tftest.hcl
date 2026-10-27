# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      output = { response = {} }
    }
  }
}

run "minimal_request" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
  }

  assert {
    condition     = msgraph_resource.this.url == "groups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acceptedSenders", "appRoleAssignments", "assignedLabels", "classification", "cloudLicensing", "conversations", "deletedDateTime", "description", "disableNesting", "events", "groupTypes", "hasMembersWithLicenseErrors", "infoCatalogs", "isAssignableToRole", "members", "membershipRule", "membershipRuleProcessingState", "onPremisesExtensionAttributes", "onPremisesProvisioningErrors", "onPremisesSyncBehavior", "onenote", "organizationId", "owners", "permissionGrants", "photo", "preferredDataLocation", "preferredLanguage", "rejectedSenders", "resourceBehaviorOptions", "resourceProvisioningOptions", "serviceProvisioningErrors", "settings", "sites", "team", "theme", "threads", "transitiveMemberOf", "transitiveMembers", "visibility", "welcomeMessageEnabled", "writebackConfiguration"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
    select_response  = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["acceptedSenders", "appRoleAssignments", "conversations", "events", "members", "onPremisesSyncBehavior", "onenote", "owners", "permissionGrants", "photo", "rejectedSenders", "settings", "sites", "team", "threads", "transitiveMemberOf", "transitiveMembers"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
    classification   = "example"
    disable_nesting  = false
    cloud_licensing  = { "assignments" = null }
    accepted_senders = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["mailEnabled"]) == jsonencode(false)
    error_message = "mailEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["mailNickname"]) == jsonencode("example")
    error_message = "mailNickname must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["securityEnabled"]) == jsonencode(false)
    error_message = "securityEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["classification"]) == jsonencode("example")
    error_message = "classification must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["disableNesting"]) == jsonencode(false)
    error_message = "disableNesting must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["cloudLicensing"]) == jsonencode({ "@odata.type" = "#microsoft.graph.cloudLicensing.groupCloudLicensing" })
    error_message = "cloudLicensing must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acceptedSenders"]) == jsonencode([{}])
    error_message = "acceptedSenders must preserve typed values and omit nested nulls."
  }
}

# Offline replacement tests: each apply changes one input. An unchanged id is an in-place
# update and a new id is a replacement.

run "replacement_baseline" {
  command = apply

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
  }

  assert {
    condition     = msgraph_resource.this.id != ""
    error_message = "The baseline must create the object."
  }
}

run "update_in_place_display_name" {
  command = apply

  variables {
    display_name     = "example-changed"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.replacement_baseline.id
    error_message = "Changing display_name must update the object in place."
  }
}

run "update_in_place_mail_enabled" {
  command = apply

  variables {
    display_name     = "example-changed"
    mail_enabled     = true
    mail_nickname    = "example"
    security_enabled = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_display_name.id
    error_message = "Changing mail_enabled must update the object in place."
  }
}

run "update_in_place_mail_nickname" {
  command = apply

  variables {
    display_name     = "example-changed"
    mail_enabled     = true
    mail_nickname    = "example-changed"
    security_enabled = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_mail_enabled.id
    error_message = "Changing mail_nickname must update the object in place."
  }
}

run "update_in_place_unlisted_additional_property" {
  command = apply

  variables {
    display_name          = "example-changed"
    mail_enabled          = true
    mail_nickname         = "example-changed"
    security_enabled      = false
    additional_properties = { "unlistedProperty" = "example" }
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_mail_nickname.id
    error_message = "unlistedProperty in additional_properties must update the object in place."
  }
}

run "keep_object_for_null_additional_property" {
  command = apply

  variables {
    display_name          = "example-changed"
    mail_enabled          = true
    mail_nickname         = "example-changed"
    security_enabled      = false
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_unlisted_additional_property.id
    error_message = "nullProperty set to null is omitted from the request and must keep the object."
  }
}

run "keep_object_for_default_is_assignable_to_role" {
  command = apply

  variables {
    display_name          = "example-changed"
    mail_enabled          = true
    mail_nickname         = "example-changed"
    security_enabled      = false
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
    is_assignable_to_role = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.keep_object_for_null_additional_property.id
    error_message = "Setting is_assignable_to_role to its default False must keep the object, as unset does."
  }
}

run "replace_on_is_assignable_to_role" {
  command = apply

  variables {
    display_name          = "example-changed"
    mail_enabled          = true
    mail_nickname         = "example-changed"
    security_enabled      = true
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
    is_assignable_to_role = true
  }

  assert {
    condition     = msgraph_resource.this.id != run.keep_object_for_default_is_assignable_to_role.id
    error_message = "Changing is_assignable_to_role must replace the object."
  }
}

run "replace_when_unset_is_assignable_to_role" {
  command = apply

  variables {
    display_name          = "example-changed"
    mail_enabled          = true
    mail_nickname         = "example-changed"
    security_enabled      = true
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_is_assignable_to_role.id
    error_message = "Unsetting is_assignable_to_role after a non-default value must replace the object."
  }
}

run "guard_2_security_enabled" {
  command = plan

  variables {
    display_name          = "example"
    mail_enabled          = false
    mail_nickname         = "example"
    security_enabled      = false
    is_assignable_to_role = true
  }

  expect_failures = [msgraph_resource.this]
}

run "guard_3_group_types" {
  command = plan

  variables {
    display_name          = "example"
    mail_enabled          = false
    mail_nickname         = "example"
    security_enabled      = false
    is_assignable_to_role = true
    group_types           = ["DynamicMembership"]
  }

  expect_failures = [msgraph_resource.this]
}

run "typed_default_wins_is_assignable_to_role" {
  command = plan

  variables {
    display_name          = "example"
    mail_enabled          = false
    mail_nickname         = "example"
    security_enabled      = false
    is_assignable_to_role = false
    additional_properties = { "isAssignableToRole" = true }
  }

  assert {
    condition     = !contains(keys(msgraph_resource.this.body), "isAssignableToRole")
    error_message = "is_assignable_to_role set to its default must win over a different additional_properties value, so the key is not sent."
  }
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
    timeouts         = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
    timeouts         = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
    timeouts         = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    display_name     = "example"
    mail_enabled     = false
    mail_nickname    = "example"
    security_enabled = false
    timeouts         = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
