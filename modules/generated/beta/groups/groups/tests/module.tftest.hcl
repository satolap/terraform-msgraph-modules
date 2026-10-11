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
    condition     = alltrue([for key in ["acceptedSenders", "appRoleAssignments", "assignedLabels", "classification", "cloudLicensing", "conversations", "deletedDateTime", "description", "disableNesting", "events", "groupTypes", "hasMembersWithLicenseErrors", "infoCatalogs", "isAssignableToRole", "members", "membershipRule", "membershipRuleProcessingState", "onPremisesExtensionAttributes", "onPremisesProvisioningErrors", "onPremisesSyncBehavior", "onenote", "organizationId", "owners", "permissionGrants", "photo", "preferredDataLocation", "preferredLanguage", "rejectedSenders", "resourceBehaviorOptions", "resourceProvisioningOptions", "serviceProvisioningErrors", "settings", "sites", "team", "theme", "threads", "transitiveMemberOf", "transitiveMembers", "visibility", "welcomeMessageEnabled", "writebackConfiguration"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
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
