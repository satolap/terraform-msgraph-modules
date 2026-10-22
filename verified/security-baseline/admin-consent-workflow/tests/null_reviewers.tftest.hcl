# A policy response whose reviewers are null is snapshotted as an empty list, and a null
# reviewers property passes the response validation.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        skus      = []
        policy = {
          id                    = "00000000-0000-4000-8000-0000000000aa"
          version               = 3
          isEnabled             = false
          notifyReviewers       = false
          remindersEnabled      = false
          requestDurationInDays = 7
          reviewers             = null
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

run "null_reviewers_snapshot_as_empty_list" {
  command = apply

  variables {
    tier              = "free"
    reviewer_user_ids = ["00000000-0000-4000-8000-000000000010"]
  }

  assert {
    condition     = jsonencode(output.previous_state) == jsonencode({ isEnabled = false, notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 7, reviewers = [] })
    error_message = "A null reviewers response must be snapshotted as an empty list."
  }
}
