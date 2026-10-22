# Fixtures follow the Get and Update adminConsentRequestPolicy references of Microsoft Graph
# v1.0: the singleton is read with GET and written with a full-body PUT.
# https://learn.microsoft.com/graph/api/adminconsentrequestpolicy-get?view=graph-rest-1.0
# https://learn.microsoft.com/graph/api/adminconsentrequestpolicy-update?view=graph-rest-1.0
# The default output also serves the subscribedSkus read of the licence guard.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        # A P1 SKU makes the p2 case below a real mismatch rather than an empty tenant.
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
        policy = {
          "@odata.context"      = "https://graph.microsoft.com/v1.0/$metadata#policies/adminConsentRequestPolicy/$entity"
          id                    = "00000000-0000-4000-8000-0000000000aa"
          version               = 3
          isEnabled             = false
          notifyReviewers       = false
          remindersEnabled      = false
          requestDurationInDays = 7
          reviewers             = []
        }
      }
    }
  }

  mock_resource "msgraph_update_resource" {
    defaults = {
      output = {
        policy = {
          version               = 4
          isEnabled             = true
          notifyReviewers       = true
          remindersEnabled      = true
          requestDurationInDays = 30
          reviewers             = []
        }
      }
    }
  }
}

variables {
  tier              = "free"
  reviewer_user_ids = ["00000000-0000-4000-8000-000000000010"]
}

run "reads_the_singleton" {
  command = plan

  assert {
    condition     = data.msgraph_resource.policy.url == "policies/adminConsentRequestPolicy" && data.msgraph_resource.policy.api_version == "v1.0"
    error_message = "The module must read the adminConsentRequestPolicy singleton from v1.0."
  }
}

run "default_plan_puts_the_full_body" {
  command = plan

  assert {
    condition     = msgraph_update_resource.this.url == "policies/adminConsentRequestPolicy" && msgraph_update_resource.this.api_version == "v1.0"
    error_message = "The module must write the adminConsentRequestPolicy singleton at v1.0."
  }

  assert {
    condition     = msgraph_update_resource.this.update_method == "PUT"
    error_message = "The update must be a PUT, never a partial PATCH."
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ isEnabled = true, notifyReviewers = true, remindersEnabled = true, requestDurationInDays = 30, reviewers = [{ query = "/users/00000000-0000-4000-8000-000000000010", queryType = "MicrosoftGraph" }] })
    error_message = "The body must hold all five writable properties with the documented defaults."
  }

  assert {
    condition     = length(keys(msgraph_update_resource.this.body)) == 5 && !contains(keys(msgraph_update_resource.this.body), "version")
    error_message = "The body must never send the read-only version."
  }
}

run "reviewers_render_for_users_and_groups" {
  command = plan

  variables {
    reviewer_user_ids  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
    reviewer_group_ids = ["00000000-0000-4000-8000-000000000030"]
  }

  assert {
    condition = jsonencode(output.reviewers) == jsonencode([
      { query = "/users/00000000-0000-4000-8000-000000000010", queryType = "MicrosoftGraph" },
      { query = "/users/00000000-0000-4000-8000-000000000020", queryType = "MicrosoftGraph" },
      { query = "/groups/00000000-0000-4000-8000-000000000030/transitiveMembers", queryType = "MicrosoftGraph" },
    ])
    error_message = "Users render as /users/{id} and groups as /groups/{id}/transitiveMembers, both with queryType MicrosoftGraph."
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body.reviewers) == jsonencode(output.reviewers)
    error_message = "The body must carry the rendered reviewers."
  }
}

run "groups_alone_are_enough" {
  command = plan

  variables {
    reviewer_user_ids  = []
    reviewer_group_ids = ["00000000-0000-4000-8000-000000000030"]
  }

  assert {
    condition     = length(msgraph_update_resource.this.body.reviewers) == 1
    error_message = "A group is a sufficient reviewer."
  }
}

run "every_setting_passes_through" {
  command = plan

  variables {
    enabled                  = false
    reviewer_user_ids        = []
    notify_reviewers         = false
    reminders_enabled        = false
    request_duration_in_days = 5
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ isEnabled = false, notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 5, reviewers = [] })
    error_message = "Each setting must reach the body; a disabled workflow needs no reviewer."
  }
}

run "duration_bounds_are_accepted" {
  command = plan

  variables {
    request_duration_in_days = 1
  }

  assert {
    condition     = msgraph_update_resource.this.body.requestDurationInDays == 1
    error_message = "1 day is the lower bound."
  }
}

run "disabled_with_reviewers_keeps_them" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = msgraph_update_resource.this.body.isEnabled == false && length(msgraph_update_resource.this.body.reviewers) == 1
    error_message = "Turning the workflow off keeps the configured reviewers."
  }
}

run "free_reads_no_licences" {
  command = plan

  assert {
    condition     = length(module.licence_guard.licensed_skus) == 0
    error_message = "The free tier lists no licensed SKUs. That it reads no subscribedSkus is asserted in the licence-guard tests."
  }

  assert {
    condition     = output.tier == "free"
    error_message = "The tier output must pass the validated tier through."
  }
}

run "p1_with_licence_passes" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus[0]
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = length(module.licence_guard.licensed_skus) == 1 && output.tier == "p1"
    error_message = "p1 must run the shared licence guard and pass with a licensed SKU."
  }

  assert {
    condition     = msgraph_update_resource.this.body.isEnabled == true
    error_message = "The tier changes no setting."
  }
}

# A failing module output cannot be named in expect_failures from this module, so the
# unlicensed case runs against the shared guard that this module calls, as the other
# baseline modules do. The default mock lists only a P1 SKU, so p2 is unlicensed.
run "p2_without_licence_fails" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier = "p2"
  }

  expect_failures = [output.tier]
}
