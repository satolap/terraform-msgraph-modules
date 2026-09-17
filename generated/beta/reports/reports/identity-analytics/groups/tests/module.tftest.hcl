# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/identityAnalytics/groups"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedRoleCount", "calculatedDateTime", "createdDateTime", "directGroupMemberCount", "displayName", "dynamicMembershipType", "groupExpirationDateTime", "groupType", "guestOwnerCount", "guestTransitiveUserCount", "isCloudDistributionListGroup", "isCloudM365Group", "isCloudMailEnabledSecurityGroup", "isCloudSecurityGroup", "isDynamicGroup", "isOnPremiseDistributionListGroup", "isOnPremiseMailEnabledSecurityGroup", "isOnPremiseSecurityGroup", "isValidGroup", "lastRestorationDateTime", "memberOwnerCount", "memberTransitiveUserCount", "membershipRuleContainsCount", "membershipRuleExpressionCount", "membershipRuleMatchCount", "membershipRuleMemberOfCount", "membershipRuleProcessingState", "preferredDataLocation", "sensitivityLabelCount", "servicePrincipalOwnerCount", "softDeletionDateTime", "tenantId", "transitiveServicePrincipalCount", "transitiveUserCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    calculated_date_time             = "2026-01-01T00:00:00Z"
    is_cloud_distribution_list_group = false
    assigned_role_count              = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["calculatedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "calculatedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCloudDistributionListGroup"]) == jsonencode(false)
    error_message = "isCloudDistributionListGroup must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedRoleCount"]) == jsonencode(0)
    error_message = "assignedRoleCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    group_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.group_type]
}
