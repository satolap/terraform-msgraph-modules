# Fail closed on partial/malformed collection exports. All identities are synthetic.

mock_provider "msgraph" {

  mock_data "msgraph_resource" {

    defaults = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "breakglass2@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "displayName" : "Synthetic private group", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : true }], "members" : [], "skus" : [], "next_link" : null } }

  }

}

variables {
  tier                 = "free"
  break_glass_user_ids = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
}

run "rejects_missing_user_value" {

  command = plan

  override_data {

    target = data.msgraph_resource.users

    values = { output = { "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.users]

}

run "rejects_missing_user_paging_export" {

  command = plan

  override_data {

    target = data.msgraph_resource.users

    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "breakglass2@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }] } }

  }

  expect_failures = [data.msgraph_resource.users]

}

run "rejects_unresolved_user_page" {

  command = plan

  override_data {

    target = data.msgraph_resource.users

    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "breakglass2@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "next_link" : "https://graph.microsoft.com/v1.0/users?$skiptoken=synthetic" } }

  }

  expect_failures = [data.msgraph_resource.users]

}

run "rejects_string_sync_state" {

  command = plan

  override_data {

    target = data.msgraph_resource.users

    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : "false", "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "breakglass2@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.users]

}

run "rejects_missing_sync_projection" {

  command = plan

  override_data {

    target = data.msgraph_resource.users

    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "breakglass2@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.users]

}

run "rejects_duplicate_user_records" {

  command = plan

  override_data {

    target = data.msgraph_resource.users

    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.users]

}

run "rejects_unrequested_user" {

  command = plan

  override_data {

    target = data.msgraph_resource.users

    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000099", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "breakglass2@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.users]

}

run "rejects_missing_group_paging_export" {

  command = plan

  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {

    target = data.msgraph_resource.groups[0]

    values = { output = { "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "displayName" : "Synthetic private group", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : true }] } }

  }

  expect_failures = [data.msgraph_resource.groups[0]]

}

run "rejects_unresolved_group_page" {

  command = plan

  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {

    target = data.msgraph_resource.groups[0]

    values = { output = { "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "displayName" : "Synthetic private group", "securityEnabled" : true, "groupTypes" : [], "isAssignableToRole" : true }], "next_link" : "https://graph.microsoft.com/v1.0/groups?$skiptoken=synthetic" } }

  }

  expect_failures = [data.msgraph_resource.groups[0]]

}

run "rejects_missing_group_type_projection" {

  command = plan

  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {

    target = data.msgraph_resource.groups[0]

    values = { output = { "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "displayName" : "Synthetic private group", "securityEnabled" : true, "isAssignableToRole" : true }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.groups[0]]

}

run "rejects_missing_member_paging_export" {

  command = plan

  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {

    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]

    values = { output = { "members" : [] } }

  }

  expect_failures = [data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]]

}

run "rejects_unresolved_member_page" {

  command = plan

  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {

    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]

    values = { output = { "members" : [], "next_link" : "https://graph.microsoft.com/v1.0/groups/synthetic/members?$skiptoken=synthetic" } }

  }

  expect_failures = [data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]]

}

run "rejects_unknown_member_type" {

  command = plan

  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {

    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]

    values = { output = { "members" : [{ "id" : "00000000-0000-4000-8000-000000000010", "@odata.type" : "#microsoft.graph.unknown" }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]]

}

run "rejects_null_group_type" {
  command = plan
  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }
  override_data {
    target = data.msgraph_resource.groups[0]
    values = { output = { "users" : [{ "id" : "00000000-0000-4000-8000-000000000010", "userPrincipalName" : "breakglass1@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }, { "id" : "00000000-0000-4000-8000-000000000020", "userPrincipalName" : "breakglass2@contoso.onmicrosoft.com", "accountEnabled" : true, "onPremisesSyncEnabled" : null, "userType" : "Member" }], "groups" : [{ "id" : "00000000-0000-4000-8000-000000000002", "displayName" : "Synthetic private group", "securityEnabled" : true, "groupTypes" : [null], "isAssignableToRole" : true }], "members" : [], "skus" : [], "next_link" : null } }
  }
  expect_failures = [data.msgraph_resource.groups[0]]
}

run "supports_sensitive_existing_ids" {
  command = plan
  variables {
    break_glass_user_ids  = sensitive(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"])
    break_glass_group_ids = sensitive(["00000000-0000-4000-8000-000000000002"])
  }
  assert {
    condition     = output.checks.users == "passed" && output.checks.groups == "passed"
    error_message = "Sensitive caller inputs must retain usable hashed read addresses and gate-bound public statuses."
  }
}
