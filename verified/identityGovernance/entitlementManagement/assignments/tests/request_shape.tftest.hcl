# Request shapes and read-back queries. Mocked providers: these runs prove what
# the module sends and asks for, not what Microsoft Graph does with it.
# Mocking providers does not suppress destroy provisioners. Disable that hook.
mock_provider "null" {}
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-00000000-0000-0000-0000-000000000001"
      output = {
        request_id = "req-00000000-0000-0000-0000-000000000001"
        state      = "delivered"
        status     = "Delivered"
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        state       = "delivered"
        status      = "Delivered"
        assignments = []
      }
    }
  }
}

variables {
  enable_destroy_cleanup     = false
  target_id                  = "11111111-1111-1111-1111-111111111111"
  access_package_id          = "22222222-2222-2222-2222-222222222222"
  assignment_policy_id       = "33333333-3333-3333-3333-333333333333"
  verification_delay_seconds = 0
  require_delivery           = false
}

run "sends_admin_add_to_the_assignment_requests_collection" {
  command = plan

  assert {
    condition     = msgraph_resource_action.add[0].resource_url == "identityGovernance/entitlementManagement/assignmentRequests" && msgraph_resource_action.add[0].method == "POST"
    error_message = "adminAdd must POST to identityGovernance/entitlementManagement/assignmentRequests."
  }

  assert {
    condition     = msgraph_resource_action.add[0].body.requestType == "adminAdd"
    error_message = "The request type must be adminAdd."
  }

  assert {
    condition = jsonencode(msgraph_resource_action.add[0].body.assignment) == jsonencode({
      accessPackageId    = "22222222-2222-2222-2222-222222222222"
      assignmentPolicyId = "33333333-3333-3333-3333-333333333333"
      targetId           = "11111111-1111-1111-1111-111111111111"
    })
    error_message = "The assignment must name the subject, the policy and the package explicitly."
  }

  assert {
    condition     = msgraph_resource_action.add[0].body.justification == "Managed by Terraform"
    error_message = "The justification must default to \"Managed by Terraform\"."
  }

  assert {
    condition     = !contains(keys(msgraph_resource_action.add[0].body), "schedule")
    error_message = "Without a schedule input the request must carry none, so the policy's expiration applies."
  }
}

run "targets_v1_0_on_every_request" {
  command = plan

  assert {
    condition = (
      msgraph_resource_action.add[0].api_version == "v1.0"
      && data.msgraph_resource.assignments.api_version == "v1.0"
    )
    error_message = "Every request and read must target v1.0."
  }
}

run "lists_assignments_filtered_by_package_and_subject_and_expanded" {
  command = plan

  assert {
    condition     = data.msgraph_resource.assignments.url == "identityGovernance/entitlementManagement/assignments"
    error_message = "The read-back must list identityGovernance/entitlementManagement/assignments."
  }

  assert {
    condition     = data.msgraph_resource.assignments.query_parameters["$filter"][0] == "accessPackage/id eq '22222222-2222-2222-2222-222222222222' and target/objectId eq '11111111-1111-1111-1111-111111111111'"
    error_message = "The listing must filter on the access package and on the subject's object ID."
  }

  assert {
    condition     = data.msgraph_resource.assignments.query_parameters["$expand"][0] == "target,assignmentPolicy,accessPackage"
    error_message = "The listing must expand the subject, the policy and the package so that the match can re-check them."
  }
}

run "sends_the_justification" {
  command = plan

  variables {
    justification = "Onboarding ticket 42"
  }

  assert {
    condition     = msgraph_resource_action.add[0].body.justification == "Onboarding ticket 42"
    error_message = "The justification must be sent as given."
  }
}

run "sends_a_start_time_and_an_end_date" {
  command = plan

  variables {
    schedule = {
      startDateTime = "2026-11-01T00:00:00Z"
      expiration = {
        type        = "afterDateTime"
        endDateTime = "2027-01-01T00:00:00Z"
      }
    }
  }

  assert {
    condition = jsonencode(msgraph_resource_action.add[0].body.schedule) == jsonencode({
      expiration    = { endDateTime = "2027-01-01T00:00:00Z", type = "afterDateTime" }
      startDateTime = "2026-11-01T00:00:00Z"
    })
    error_message = "The schedule must send startDateTime and an afterDateTime expiration with endDateTime and no duration."
  }
}

run "sends_a_duration_expiration" {
  command = plan

  variables {
    schedule = {
      expiration = {
        type     = "afterDuration"
        duration = "P30D"
      }
    }
  }

  assert {
    condition     = jsonencode(msgraph_resource_action.add[0].body.schedule) == jsonencode({ expiration = { duration = "P30D", type = "afterDuration" } })
    error_message = "An afterDuration expiration must send the duration and no start or end."
  }
}

run "sends_a_no_expiration_schedule" {
  command = plan

  variables {
    schedule = {
      expiration = { type = "noExpiration" }
    }
  }

  assert {
    condition     = jsonencode(msgraph_resource_action.add[0].body.schedule) == jsonencode({ expiration = { type = "noExpiration" } })
    error_message = "A noExpiration schedule must send only the type."
  }
}

run "sends_no_update_by_default" {
  command = plan

  assert {
    condition     = length(msgraph_resource_action.update) == 0 && length(terraform_data.update_gate) == 0
    error_message = "No adminUpdate may be sent unless schedule_update is set."
  }

  assert {
    condition     = output.update_request_id == null && output.update_request_phase == null
    error_message = "The update outputs must be null without schedule_update."
  }
}

# Applies last: once the request is in state its body is captured and later plans ignore body changes.
run "reads_the_request_it_sent_by_id" {
  command = apply

  assert {
    condition     = data.msgraph_resource.request[0].url == "identityGovernance/entitlementManagement/assignmentRequests/req-00000000-0000-0000-0000-000000000001"
    error_message = "The request must be read back by the ID Graph returned, never by listing the collection."
  }
}
