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
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
  }

  assert {
    condition     = msgraph_resource.this.url == "groups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acceptedSenders", "appRoleAssignments", "assignedLabels", "classification", "conversations", "deletedDateTime", "description", "events", "groupTypes", "hasMembersWithLicenseErrors", "infoCatalogs", "isAssignableToRole", "members", "membershipRule", "membershipRuleProcessingState", "onPremisesExtensionAttributes", "onPremisesProvisioningErrors", "onPremisesSyncBehavior", "onenote", "organizationId", "owners", "permissionGrants", "photo", "planner", "preferredDataLocation", "preferredLanguage", "rejectedSenders", "resourceBehaviorOptions", "resourceProvisioningOptions", "serviceProvisioningErrors", "settings", "sites", "team", "theme", "threads", "transitiveMemberOf", "transitiveMembers", "visibility", "welcomeMessageEnabled"] : !contains(keys(msgraph_resource.this.body), key)])
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
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["acceptedSenders", "appRoleAssignments", "conversations", "events", "members", "onPremisesSyncBehavior", "onenote", "owners", "permissionGrants", "photo", "planner", "rejectedSenders", "settings", "sites", "team", "threads", "transitiveMemberOf", "transitiveMembers"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    displayName                   = "example"
    mailEnabled                   = false
    mailNickname                  = "example"
    securityEnabled               = false
    classification                = "example"
    hasMembersWithLicenseErrors   = false
    onPremisesExtensionAttributes = { "extensionAttribute1" = null }
    acceptedSenders               = [{}]
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
    condition     = jsonencode(msgraph_resource.this.body["hasMembersWithLicenseErrors"]) == jsonencode(false)
    error_message = "hasMembersWithLicenseErrors must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["onPremisesExtensionAttributes"]) == jsonencode({ "@odata.type" = "#microsoft.graph.onPremisesExtensionAttributes" })
    error_message = "onPremisesExtensionAttributes must preserve typed values and omit nested nulls."
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
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
  }

  assert {
    condition     = msgraph_resource.this.id != ""
    error_message = "The baseline must create the object."
  }
}

run "update_in_place_displayName" {
  command = apply

  variables {
    displayName     = "example-changed"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.replacement_baseline.id
    error_message = "Changing displayName must update the object in place."
  }
}

run "update_in_place_mailEnabled" {
  command = apply

  variables {
    displayName     = "example-changed"
    mailEnabled     = true
    mailNickname    = "example"
    securityEnabled = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_displayName.id
    error_message = "Changing mailEnabled must update the object in place."
  }
}

run "update_in_place_mailNickname" {
  command = apply

  variables {
    displayName     = "example-changed"
    mailEnabled     = true
    mailNickname    = "example-changed"
    securityEnabled = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_mailEnabled.id
    error_message = "Changing mailNickname must update the object in place."
  }
}

run "update_in_place_unlisted_additional_property" {
  command = apply

  variables {
    displayName           = "example-changed"
    mailEnabled           = true
    mailNickname          = "example-changed"
    securityEnabled       = false
    additional_properties = { "unlistedProperty" = "example" }
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_mailNickname.id
    error_message = "unlistedProperty in additional_properties must update the object in place."
  }
}

run "keep_object_for_null_additional_property" {
  command = apply

  variables {
    displayName           = "example-changed"
    mailEnabled           = true
    mailNickname          = "example-changed"
    securityEnabled       = false
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_unlisted_additional_property.id
    error_message = "nullProperty set to null is omitted from the request and must keep the object."
  }
}

run "keep_object_for_default_isAssignableToRole" {
  command = apply

  variables {
    displayName           = "example-changed"
    mailEnabled           = true
    mailNickname          = "example-changed"
    securityEnabled       = false
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
    isAssignableToRole    = false
  }

  assert {
    condition     = msgraph_resource.this.id == run.keep_object_for_null_additional_property.id
    error_message = "Setting isAssignableToRole to its default False must keep the object, as unset does."
  }
}

run "replace_on_isAssignableToRole" {
  command = apply

  variables {
    displayName           = "example-changed"
    mailEnabled           = true
    mailNickname          = "example-changed"
    securityEnabled       = true
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
    isAssignableToRole    = true
  }

  assert {
    condition     = msgraph_resource.this.id != run.keep_object_for_default_isAssignableToRole.id
    error_message = "Changing isAssignableToRole must replace the object."
  }
}

run "replace_when_unset_isAssignableToRole" {
  command = apply

  variables {
    displayName           = "example-changed"
    mailEnabled           = true
    mailNickname          = "example-changed"
    securityEnabled       = true
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id != run.replace_on_isAssignableToRole.id
    error_message = "Unsetting isAssignableToRole after a non-default value must replace the object."
  }
}

run "guard_2_securityEnabled" {
  command = plan

  variables {
    displayName        = "example"
    mailEnabled        = false
    mailNickname       = "example"
    securityEnabled    = false
    isAssignableToRole = true
  }

  expect_failures = [msgraph_resource.this]
}

run "guard_3_groupTypes" {
  command = plan

  variables {
    displayName        = "example"
    mailEnabled        = false
    mailNickname       = "example"
    securityEnabled    = false
    isAssignableToRole = true
    groupTypes         = ["DynamicMembership"]
  }

  expect_failures = [msgraph_resource.this]
}

run "typed_default_wins_isAssignableToRole" {
  command = plan

  variables {
    displayName           = "example"
    mailEnabled           = false
    mailNickname          = "example"
    securityEnabled       = false
    isAssignableToRole    = false
    additional_properties = { "isAssignableToRole" = true }
  }

  assert {
    condition     = !contains(keys(msgraph_resource.this.body), "isAssignableToRole")
    error_message = "isAssignableToRole set to its default must win over a different additional_properties value, so the key is not sent."
  }
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
    timeouts        = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
    timeouts        = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
    timeouts        = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    displayName     = "example"
    mailEnabled     = false
    mailNickname    = "example"
    securityEnabled = false
    timeouts        = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
