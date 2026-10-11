mock_provider "msgraph" {
  mock_resource "msgraph_resource_collection" {
    defaults = {
      id = "groups/11111111-1111-1111-1111-111111111111/members"
    }
  }
}

variables {
  group_id = "11111111-1111-1111-1111-111111111111"
  member_ids = [
    "aaaaaaaa-0000-0000-0000-000000000001",
    "aaaaaaaa-0000-0000-0000-000000000002",
  ]
}

# The runs below share one state in file order. A mock provider does not run
# the provider's plan modifiers, so it neither replaces the collection when the
# url changes nor ignores a change of order; the provider does both. These runs
# check the configuration the module hands to the provider.

run "manages_the_members_collection_of_the_group" {
  command = apply

  assert {
    condition     = msgraph_resource_collection.this.url == "groups/11111111-1111-1111-1111-111111111111/members/$ref"
    error_message = "The collection must be the group's members $ref collection."
  }

  assert {
    condition     = msgraph_resource_collection.this.api_version == "v1.0"
    error_message = "api_version must default to v1.0."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.this.reference_ids) == jsonencode(["aaaaaaaa-0000-0000-0000-000000000001", "aaaaaaaa-0000-0000-0000-000000000002"])
    error_message = "reference_ids must be the configured member IDs, in the given order."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.this.retry) == jsonencode({ error_message_regex = ["The source resource object or one of the objects being referenced"] })
    error_message = "The collection must retry the replication delay error that Microsoft Learn documents, and nothing else."
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.this.timeouts) == jsonencode({ create = null, delete = null, read = null, update = null })
    error_message = "With default inputs every timeout must stay unset, so the provider's defaults apply."
  }

  assert {
    condition     = output.id == "groups/11111111-1111-1111-1111-111111111111/members"
    error_message = "id must be the collection's id."
  }

  assert {
    condition     = output.group_id == "11111111-1111-1111-1111-111111111111"
    error_message = "group_id must be exposed."
  }

  assert {
    condition     = jsonencode(output.member_ids) == jsonencode(["aaaaaaaa-0000-0000-0000-000000000001", "aaaaaaaa-0000-0000-0000-000000000002"])
    error_message = "member_ids must expose the managed member IDs."
  }
}

# The retry expression must match the message Microsoft Learn documents for a
# group that has not replicated yet, also when the JSON body escapes the
# apostrophe, and must not match the 400 for a member that already exists or
# the 404 for an object that does not exist: retrying those cannot succeed.
# Learn documents those two status codes, not their messages; the bodies below
# are representative.
run "retries_only_the_replication_delay_error" {
  command = plan

  assert {
    condition     = can(regex(local.replication_delay_errors[0], "{\"error\":{\"code\":\"Request_BadRequest\",\"message\":\"The source resource object or one of the objects being referenced don't exist.\"}}"))
    error_message = "The expression must match the replication delay error."
  }

  assert {
    condition     = can(regex(local.replication_delay_errors[0], "{\"error\":{\"code\":\"Request_BadRequest\",\"message\":\"The source resource object or one of the objects being referenced don\\u0027t exist.\"}}"))
    error_message = "The expression must match the replication delay error when the apostrophe is escaped."
  }

  assert {
    condition     = !can(regex(local.replication_delay_errors[0], "{\"error\":{\"code\":\"Request_BadRequest\",\"message\":\"One or more added object references already exist for the following modified properties: 'members'.\"}}"))
    error_message = "The expression must not match the error for a member that already exists."
  }

  assert {
    condition     = !can(regex(local.replication_delay_errors[0], "{\"error\":{\"code\":\"Request_ResourceNotFound\",\"message\":\"Resource 'aaaaaaaa-0000-0000-0000-000000000009' does not exist or one of its queried reference-property objects are not present.\"}}"))
    error_message = "The expression must not match the error for an object that does not exist."
  }
}

# A GUID has no case. Upper case IDs give the same url and reference IDs, so a
# change of case alone plans no change.
run "upper_case_ids_give_the_same_url_and_reference_ids" {
  command = plan

  variables {
    group_id = "11111111-1111-1111-1111-111111111111"
    member_ids = [
      "AAAAAAAA-0000-0000-0000-000000000001",
      "aaaaaaaa-0000-0000-0000-000000000002",
    ]
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.this.reference_ids) == jsonencode(["aaaaaaaa-0000-0000-0000-000000000001", "aaaaaaaa-0000-0000-0000-000000000002"])
    error_message = "Member IDs must be used in lower case."
  }
}

run "upper_case_group_id_gives_the_same_url" {
  command = apply

  variables {
    group_id = "BBBBBBBB-1111-1111-1111-111111111111"
  }

  assert {
    condition     = msgraph_resource_collection.this.url == "groups/bbbbbbbb-1111-1111-1111-111111111111/members/$ref"
    error_message = "The group ID must be used in lower case in the url."
  }

  assert {
    condition     = output.group_id == "bbbbbbbb-1111-1111-1111-111111111111"
    error_message = "group_id must be exposed in lower case."
  }
}

run "lower_case_group_id_gives_the_same_url" {
  command = plan

  variables {
    group_id = "bbbbbbbb-1111-1111-1111-111111111111"
  }

  assert {
    condition     = msgraph_resource_collection.this.url == "groups/bbbbbbbb-1111-1111-1111-111111111111/members/$ref"
    error_message = "A change of case in group_id must not change the url, which the provider replaces the collection on."
  }
}

run "beta_is_passed_to_the_provider" {
  command = apply

  variables {
    api_version = "beta"
  }

  assert {
    condition     = msgraph_resource_collection.this.api_version == "beta"
    error_message = "api_version must be passed to the collection."
  }
}

# An empty list is the authoritative "no members": the provider removes every
# member it lists.
run "an_empty_list_keeps_no_member" {
  command = apply

  variables {
    member_ids = []
  }

  assert {
    condition     = msgraph_resource_collection.this.reference_ids != null && length(msgraph_resource_collection.this.reference_ids) == 0
    error_message = "An empty member_ids must be sent as an empty list, not left out."
  }

  assert {
    condition     = length(output.member_ids) == 0
    error_message = "member_ids must be empty."
  }
}

run "applies_custom_timeouts" {
  command = apply

  variables {
    timeouts = { create = "45m", read = "5m", update = "1h", delete = "20m" }
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.this.timeouts) == jsonencode({ create = "45m", delete = "20m", read = "5m", update = "1h" })
    error_message = "Each configured timeout must be planned as given."
  }
}

# A wrapper that forwards an unset variable passes null; the module must keep
# the provider's defaults, as it does when timeouts is unset.
run "null_timeouts_keep_the_provider_defaults" {
  command = apply

  variables {
    timeouts = null
  }

  assert {
    condition     = jsonencode(msgraph_resource_collection.this.timeouts) == jsonencode({ create = null, delete = null, read = null, update = null })
    error_message = "A null timeouts must leave every timeout unset."
  }
}

# Validation. Each run changes one input and expects its variable to fail.
run "rejects_a_group_id_that_is_not_a_guid" {
  command = plan

  variables {
    group_id = "engineering"
  }

  expect_failures = [var.group_id]
}

run "rejects_an_empty_group_id" {
  command = plan

  variables {
    group_id = ""
  }

  expect_failures = [var.group_id]
}

run "rejects_a_member_id_that_is_not_a_guid" {
  command = plan

  variables {
    member_ids = ["aaaaaaaa-0000-0000-0000-000000000001", "user@contoso.com"]
  }

  expect_failures = [var.member_ids]
}

run "rejects_an_empty_member_id" {
  command = plan

  variables {
    member_ids = [""]
  }

  expect_failures = [var.member_ids]
}

# A null element must reach the validation message, not a function error.
run "rejects_a_null_member_id" {
  command = plan

  variables {
    member_ids = ["aaaaaaaa-0000-0000-0000-000000000001", null]
  }

  expect_failures = [var.member_ids]
}

run "rejects_a_duplicate_member_id" {
  command = plan

  variables {
    member_ids = ["aaaaaaaa-0000-0000-0000-000000000001", "aaaaaaaa-0000-0000-0000-000000000001"]
  }

  expect_failures = [var.member_ids]
}

run "rejects_member_ids_that_differ_only_in_case" {
  command = plan

  variables {
    member_ids = ["aaaaaaaa-0000-0000-0000-000000000001", "AAAAAAAA-0000-0000-0000-000000000001"]
  }

  expect_failures = [var.member_ids]
}

run "rejects_an_unknown_api_version" {
  command = plan

  variables {
    api_version = "v2.0"
  }

  expect_failures = [var.api_version]
}

run "rejects_a_malformed_timeout" {
  command = plan

  variables {
    timeouts = { update = "10 minutes" }
  }

  expect_failures = [var.timeouts]
}

run "rejects_a_zero_timeout" {
  command = plan

  variables {
    timeouts = { delete = "0m" }
  }

  expect_failures = [var.timeouts]
}
