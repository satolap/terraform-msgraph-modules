# The writer is terraform_data and policy reads are mocked: this sends no Graph writes.
mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        policies = [{
          id    = "00000000-0000-4000-8000-000000000003"
          state = "enabled"
          conditions = {
            users = {
              excludeUsers  = ["00000000-0000-4000-8000-000000000010"]
              excludeGroups = []
            }
          }
        }]
      }
    }
  }
}

run "seed_caller_with_known_policy_ids" {
  command = apply
  module { source = "./tests/caller-ordering" }
  assert {
    condition     = output.verified
    error_message = "The explicit writer dependency must allow read-back after the initial writer apply."
  }
}

run "writer_change_defers_known_id_read" {
  command = plan
  module { source = "./tests/caller-ordering" }
  variables { writer_revision = "updated" }
  override_data {
    target = module.verification.data.msgraph_resource.policies[0]
    values = { output = { policies = [], next_link = null } }
  }
  # If the read occurs before the writer update, this missing-policy response fails
  # the plan. A deferred read is unknown and cannot produce that stale failure.
  assert {
    condition     = terraform_data.policy_writer.input == "updated"
    error_message = "The simulated writer must actually have a planned input change."
  }
}

run "updated_writer_then_verification_passes" {
  command = apply
  module { source = "./tests/caller-ordering" }
  variables { writer_revision = "updated" }
  assert {
    condition     = output.verified && terraform_data.policy_writer.output == "updated"
    error_message = "Verification must complete after the updated writer, using the fresh mocked response."
  }
}
