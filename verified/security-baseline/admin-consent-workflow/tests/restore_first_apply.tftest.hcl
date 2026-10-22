# Restoring before any snapshot exists captures the policy as read and sends it back, so the
# policy stays as it is. Fresh state, separate from the other files.

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
          isEnabled             = false
          notifyReviewers       = false
          remindersEnabled      = false
          requestDurationInDays = 7
          reviewers             = []
        }
      }
    }
  }
}

run "restore_on_first_apply_is_a_no_op" {
  command = apply

  variables {
    tier                   = "free"
    restore_previous_state = true
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.this.body) == jsonencode({ isEnabled = false, notifyReviewers = false, remindersEnabled = false, requestDurationInDays = 7, reviewers = [] })
    error_message = "A restore without an earlier snapshot must send the policy as just read, a disabled policy with no reviewers included."
  }
}
