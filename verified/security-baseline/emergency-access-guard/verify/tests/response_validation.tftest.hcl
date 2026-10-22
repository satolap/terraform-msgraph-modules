# Fail closed on partial/malformed collection exports. All identities are synthetic.

mock_provider "msgraph" {

  mock_data "msgraph_resource" {

    defaults = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] } } }], "next_link" : null } }

  }

}

variables {
  tier                = "p1"
  exclusions          = { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] }
  baseline_policy_ids = []
}

run "seed_known_policy_inputs" {
  command = apply
  variables { scope = "tenant" }
}

run "rejects_missing_policy_paging_export" {

  command = plan

  variables {
    scope = "tenant"
  }

  override_data {

    target = data.msgraph_resource.policies[0]

    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] } } }] } }

  }

  expect_failures = [data.msgraph_resource.policies[0]]

}

run "rejects_unresolved_policy_page" {

  command = plan

  variables {
    scope = "tenant"
  }

  override_data {

    target = data.msgraph_resource.policies[0]

    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] } } }], "next_link" : "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies?$skiptoken=synthetic" } }

  }

  expect_failures = [data.msgraph_resource.policies[0]]

}

run "rejects_missing_policy_state" {

  command = plan

  variables {
    scope = "tenant"
  }

  override_data {

    target = data.msgraph_resource.policies[0]

    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] } } }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.policies[0]]

}

run "rejects_unknown_policy_state" {

  command = plan

  variables {
    scope = "tenant"
  }

  override_data {

    target = data.msgraph_resource.policies[0]

    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "unreviewedState", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] } } }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.policies[0]]

}

run "rejects_null_exclusions" {

  command = plan

  variables {
    scope = "tenant"
  }

  override_data {

    target = data.msgraph_resource.policies[0]

    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : null } } }], "next_link" : null } }

  }

  expect_failures = [data.msgraph_resource.policies[0]]

}

run "rejects_null_exclusion_element" {
  command = plan
  variables {
    scope = "tenant"
  }
  override_data {
    target = data.msgraph_resource.policies[0]
    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", null], "excludeGroups" : [] } } }], "next_link" : null } }
  }
  expect_failures = [data.msgraph_resource.policies[0]]
}

run "rejects_numeric_exclusion_element" {
  command = plan
  variables {
    scope = "tenant"
  }
  override_data {
    target = data.msgraph_resource.policies[0]
    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", 12], "excludeGroups" : [] } } }], "next_link" : null } }
  }
  expect_failures = [data.msgraph_resource.policies[0]]
}

run "allows_unrelated_workload_policy" {
  command = apply
  variables {
    scope               = "baseline"
    baseline_policy_ids = ["00000000-0000-4000-8000-000000000003"]
  }
  override_data {
    target = data.msgraph_resource.policies[0]
    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] } } }, { "id" : "00000000-0000-4000-8000-000000000099", "state" : "disabled", "conditions" : { "clientApplications" : { "includeServicePrincipals" : ["All"] } } }], "next_link" : null } }
  }
}

run "refuses_checked_workload_policy" {
  command = plan
  variables {
    scope               = "tenant"
    baseline_policy_ids = ["00000000-0000-4000-8000-000000000003"]
  }
  override_data {
    target = data.msgraph_resource.policies[0]
    values = { output = { "policies" : [{ "id" : "00000000-0000-4000-8000-000000000003", "displayName" : "Synthetic private policy", "state" : "enabled", "conditions" : { "users" : { "excludeUsers" : ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], "excludeGroups" : [] } } }, { "id" : "00000000-0000-4000-8000-000000000099", "state" : "enabled", "conditions" : { "clientApplications" : { "includeServicePrincipals" : ["All"] } } }], "next_link" : null } }
  }
  expect_failures = [terraform_data.verified]
}

run "rejects_empty_nonfree_baseline" {
  command         = plan
  expect_failures = [terraform_data.verified]
}

run "empty_tenant_population_is_not_verification" {
  command = apply
  variables { scope = "tenant" }
  override_data {
    target = data.msgraph_resource.policies[0]
    values = { output = { policies = [], next_link = null } }
  }
  assert {
    condition     = !output.verified && length(output.verified_policy_ids) == 0
    error_message = "An empty enabled tenant population must not report a successful policy verification."
  }
}
