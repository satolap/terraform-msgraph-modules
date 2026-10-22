# Snapshot exclusions contain no mutable group identity, even when group discovery is used.
mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "synthetic10@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "synthetic20@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000030", "userPrincipalName" : "synthetic30@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : false }], "members" : [{ "id" : "00000000-0000-4000-8000-000000000030", "@odata.type" : "#microsoft.graph.user" }], "next_link" : null } }
  }
}
variables {
  tier                      = "free"
  break_glass_user_ids      = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
  break_glass_group_ids     = ["00000000-0000-4000-8000-000000000002"]
  expected_group_member_ids = ["00000000-0000-4000-8000-000000000030"]
}

run "non_role_assignable_snapshot" {
  command = plan
  assert {
    condition     = output.exclude_users == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000030"]) && length(output.exclude_groups) == 0 && output.conditional_access_users_exclusions.excludeUsers == output.exclude_users && length(output.conditional_access_users_exclusions.excludeGroups) == 0
    error_message = "Both exclusion interfaces must snapshot validated users and omit every discovery-group ID."
  }
}

run "role_assignable_snapshot" {
  command = plan
  override_data {
    target = data.msgraph_resource.groups[0]
    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "synthetic10@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "synthetic20@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000030", "userPrincipalName" : "synthetic30@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : true }], "members" : [{ "id" : "00000000-0000-4000-8000-000000000030", "@odata.type" : "#microsoft.graph.user" }], "next_link" : null } }
  }
  assert {
    condition     = output.exclude_users == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000030"]) && length(output.exclude_groups) == 0 && output.conditional_access_users_exclusions.excludeUsers == output.exclude_users && length(output.conditional_access_users_exclusions.excludeGroups) == 0
    error_message = "Both exclusion interfaces must snapshot validated users and omit every discovery-group ID."
  }
}

run "later_membership_addition_cannot_change_prior_snapshot" {
  command = plan
  variables { expected_group_member_ids = null }
  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "synthetic10@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "synthetic20@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000030", "userPrincipalName" : "synthetic30@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000040", "userPrincipalName" : "synthetic40@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : false }], "members" : [{ "id" : "00000000-0000-4000-8000-000000000030", "@odata.type" : "#microsoft.graph.user" }, { "id" : "00000000-0000-4000-8000-000000000040", "@odata.type" : "#microsoft.graph.user" }], "next_link" : null } }
  }
  override_data {
    target = data.msgraph_resource.users
    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "synthetic10@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "synthetic20@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000030", "userPrincipalName" : "synthetic30@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000040", "userPrincipalName" : "synthetic40@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : false }], "members" : [{ "id" : "00000000-0000-4000-8000-000000000030", "@odata.type" : "#microsoft.graph.user" }, { "id" : "00000000-0000-4000-8000-000000000040", "@odata.type" : "#microsoft.graph.user" }], "next_link" : null } }
  }
  assert {
    condition     = !contains(run.non_role_assignable_snapshot.exclude_users, "00000000-0000-4000-8000-000000000040") && length(run.non_role_assignable_snapshot.exclude_groups) == 0 && contains(output.exclude_users, "00000000-0000-4000-8000-000000000040") && length(output.exclude_groups) == 0
    error_message = "A later group member must be absent from the prior user-only snapshot; including it requires an explicit new snapshot update."
  }
}

run "reviewed_member_expectation_rejects_addition" {
  command = plan
  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "synthetic10@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "synthetic20@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000030", "userPrincipalName" : "synthetic30@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000040", "userPrincipalName" : "synthetic40@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : false }], "members" : [{ "id" : "00000000-0000-4000-8000-000000000030", "@odata.type" : "#microsoft.graph.user" }, { "id" : "00000000-0000-4000-8000-000000000040", "@odata.type" : "#microsoft.graph.user" }], "next_link" : null } }
  }
  override_data {
    target = data.msgraph_resource.users
    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "synthetic10@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "synthetic20@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000030", "userPrincipalName" : "synthetic30@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000040", "userPrincipalName" : "synthetic40@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : false }], "members" : [{ "id" : "00000000-0000-4000-8000-000000000030", "@odata.type" : "#microsoft.graph.user" }, { "id" : "00000000-0000-4000-8000-000000000040", "@odata.type" : "#microsoft.graph.user" }], "next_link" : null } }
  }
  expect_failures = [terraform_data.emergency_access]
}
