# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

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
    condition     = alltrue([for key in ["acceptedSenders", "appRoleAssignments", "assignedLabels", "classification", "conversations", "deletedDateTime", "description", "events", "groupTypes", "hasMembersWithLicenseErrors", "infoCatalogs", "isAssignableToRole", "members", "membershipRule", "membershipRuleProcessingState", "onPremisesExtensionAttributes", "onPremisesProvisioningErrors", "onPremisesSyncBehavior", "onenote", "organizationId", "owners", "permissionGrants", "photo", "planner", "preferredDataLocation", "preferredLanguage", "rejectedSenders", "resourceBehaviorOptions", "resourceProvisioningOptions", "serviceProvisioningErrors", "settings", "sites", "team", "theme", "threads", "transitiveMemberOf", "transitiveMembers", "visibility", "welcomeMessageEnabled"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    display_name                    = "example"
    mail_enabled                    = false
    mail_nickname                   = "example"
    security_enabled                = false
    classification                  = "example"
    has_members_with_license_errors = false
    accepted_senders                = [{}]
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
    condition     = jsonencode(msgraph_resource.this.body["acceptedSenders"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.directoryObject" }])
    error_message = "acceptedSenders must preserve typed values and omit nested nulls."
  }
}
