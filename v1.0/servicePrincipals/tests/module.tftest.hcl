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
    appId = "example"
  }

  assert {
    condition     = msgraph_resource.this.url == "servicePrincipals"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountEnabled", "addIns", "alternativeNames", "appDescription", "appDisplayName", "appManagementPolicies", "appOwnerOrganizationId", "appRoleAssignedTo", "appRoleAssignmentRequired", "appRoleAssignments", "appRoles", "claimsMappingPolicies", "customSecurityAttributes", "delegatedPermissionClassifications", "deletedDateTime", "description", "disabledByMicrosoftStatus", "displayName", "endpoints", "federatedIdentityCredentials", "homeRealmDiscoveryPolicies", "homepage", "info", "isDisabled", "keyCredentials", "loginUrl", "logoutUrl", "notes", "notificationEmailAddresses", "oauth2PermissionScopes", "owners", "passwordCredentials", "preferredSingleSignOnMode", "preferredTokenSigningKeyThumbprint", "remoteDesktopSecurityConfiguration", "replyUrls", "samlSingleSignOnSettings", "servicePrincipalNames", "servicePrincipalType", "synchronization", "tags", "tokenEncryptionKeyId", "tokenIssuancePolicies", "tokenLifetimePolicies", "transitiveMemberOf", "verifiedPublisher"] : !contains(keys(msgraph_resource.this.body), key)])
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
    appId           = "example"
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id", "appId"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["appManagementPolicies", "appRoleAssignedTo", "appRoleAssignments", "claimsMappingPolicies", "delegatedPermissionClassifications", "endpoints", "federatedIdentityCredentials", "homeRealmDiscoveryPolicies", "owners", "remoteDesktopSecurityConfiguration", "synchronization", "tokenIssuancePolicies", "tokenLifetimePolicies", "transitiveMemberOf"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    appId          = "example"
    appDescription = "example"
    accountEnabled = false
    info           = { "marketingUrl" = null }
    addIns         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appId"]) == jsonencode("example")
    error_message = "appId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDescription"]) == jsonencode("example")
    error_message = "appDescription must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountEnabled"]) == jsonencode(false)
    error_message = "accountEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["info"]) == jsonencode({ "@odata.type" = "#microsoft.graph.informationalUrl" })
    error_message = "info must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["addIns"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.addIn" }])
    error_message = "addIns must preserve typed values and omit nested nulls."
  }
}

# Offline replacement tests: each apply changes one input. An unchanged id is an in-place
# update and a new id is a replacement.

run "replacement_baseline" {
  command = apply

  variables {
    appId = "example"
  }

  assert {
    condition     = msgraph_resource.this.id != ""
    error_message = "The baseline must create the object."
  }
}

run "update_in_place_accountEnabled" {
  command = apply

  variables {
    appId          = "example"
    accountEnabled = true
  }

  assert {
    condition     = msgraph_resource.this.id == run.replacement_baseline.id
    error_message = "Changing accountEnabled must update the object in place."
  }
}

run "update_in_place_appDescription" {
  command = apply

  variables {
    appId          = "example"
    accountEnabled = true
    appDescription = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_accountEnabled.id
    error_message = "Changing appDescription must update the object in place."
  }
}

run "update_in_place_appDisplayName" {
  command = apply

  variables {
    appId          = "example"
    accountEnabled = true
    appDescription = "example-changed"
    appDisplayName = "example-changed"
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_appDescription.id
    error_message = "Changing appDisplayName must update the object in place."
  }
}

run "update_in_place_unlisted_additional_property" {
  command = apply

  variables {
    appId                 = "example"
    accountEnabled        = true
    appDescription        = "example-changed"
    appDisplayName        = "example-changed"
    additional_properties = { "unlistedProperty" = "example" }
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_appDisplayName.id
    error_message = "unlistedProperty in additional_properties must update the object in place."
  }
}

run "keep_object_for_null_additional_property" {
  command = apply

  variables {
    appId                 = "example"
    accountEnabled        = true
    appDescription        = "example-changed"
    appDisplayName        = "example-changed"
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id == run.update_in_place_unlisted_additional_property.id
    error_message = "nullProperty set to null is omitted from the request and must keep the object."
  }
}

run "replace_on_appId" {
  command = apply

  variables {
    appId                 = "example-changed"
    accountEnabled        = true
    appDescription        = "example-changed"
    appDisplayName        = "example-changed"
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id != run.keep_object_for_null_additional_property.id
    error_message = "Changing appId must replace the object."
  }
}

run "keep_object_for_case_change_appId" {
  command = apply

  variables {
    appId                 = "EXAMPLE-CHANGED"
    accountEnabled        = true
    appDescription        = "example-changed"
    appDisplayName        = "example-changed"
    additional_properties = { "unlistedProperty" = "example", "nullProperty" = null }
  }

  assert {
    condition     = msgraph_resource.this.id == run.replace_on_appId.id
    error_message = "A change of only the letter case of appId must keep the object."
  }
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    appId = "example"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    appId    = "example"
    timeouts = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    appId    = "example"
    timeouts = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    appId    = "example"
    timeouts = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    appId    = "example"
    timeouts = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
