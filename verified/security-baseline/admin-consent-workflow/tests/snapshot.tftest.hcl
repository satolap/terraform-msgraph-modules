# The snapshot is taken from the first read, cleaned, and kept; restore_previous_state PUTs it.
# The runs share one state, so they run in this order.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        skus      = []
        policy = {
          "@odata.context"      = "https://graph.microsoft.com/v1.0/$metadata#policies/adminConsentRequestPolicy/$entity"
          id                    = "00000000-0000-4000-8000-0000000000aa"
          version               = 3
          isEnabled             = false
          notifyReviewers       = false
          remindersEnabled      = true
          requestDurationInDays = 7
          reviewers = [
            { "@odata.type" = "#microsoft.graph.accessReviewReviewerScope", query = "/users/00000000-0000-4000-8000-000000000099", queryType = "MicrosoftGraph", queryRoot = null },
            { "@odata.type" = "#microsoft.graph.accessReviewReviewerScope", query = "./manager", queryType = "MicrosoftGraph", queryRoot = "decisions" },
          ]
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

run "first_apply_captures_a_cleaned_snapshot" {
  command = apply

  assert {
    condition = jsonencode(output.previous_state) == jsonencode({
      isEnabled             = false
      notifyReviewers       = false
      remindersEnabled      = true
      requestDurationInDays = 7
      reviewers = [
        { query = "/users/00000000-0000-4000-8000-000000000099", queryType = "MicrosoftGraph" },
        { query = "./manager", queryType = "MicrosoftGraph", queryRoot = "decisions" },
      ]
    })
    error_message = "The snapshot must hold the five writable properties only, without version, id, OData annotations or null reviewer fields."
  }

  assert {
    condition     = msgraph_update_resource.this.body.isEnabled == true && output.policy.version == 4
    error_message = "The first apply writes the inputs and reads the policy back."
  }
}

run "a_later_read_never_overwrites_the_snapshot" {
  command = apply

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        policy = {
          version               = 9
          isEnabled             = true
          notifyReviewers       = true
          remindersEnabled      = true
          requestDurationInDays = 30
          reviewers             = [{ query = "/users/00000000-0000-4000-8000-000000000010", queryType = "MicrosoftGraph" }]
        }
      }
    }
  }

  assert {
    condition     = output.previous_state.isEnabled == false && output.previous_state.requestDurationInDays == 7 && length(output.previous_state.reviewers) == 2
    error_message = "The snapshot must stay the state captured before the module first wrote."
  }
}

# Restoring needs no reviewer input: the snapshot supplies the reviewers, and a disabled
# snapshot is a valid target.
run "restore_sends_the_snapshot" {
  command = apply

  variables {
    restore_previous_state = true
    reviewer_user_ids      = []
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode(output.previous_state)
    error_message = "restore_previous_state = true must PUT the snapshot body unchanged."
  }

  assert {
    condition     = msgraph_update_resource.this.update_method == "PUT" && !contains(keys(msgraph_update_resource.this.body), "version")
    error_message = "The restore must be a full PUT without version."
  }
}

run "leaving_restore_returns_to_the_inputs" {
  command = apply

  assert {
    condition     = msgraph_update_resource.this.body.isEnabled == true && length(msgraph_update_resource.this.body.reviewers) == 1
    error_message = "With restore_previous_state back to false the inputs apply again."
  }

  assert {
    condition     = output.previous_state.isEnabled == false
    error_message = "The snapshot survives the restore."
  }
}
