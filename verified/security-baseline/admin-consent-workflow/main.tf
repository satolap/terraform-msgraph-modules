# Manages the tenant singleton adminConsentRequestPolicy: the admin consent workflow that lets
# users request apps they cannot consent to. The update is a PUT with all five writable
# properties, as Microsoft requires:
# https://learn.microsoft.com/graph/api/adminconsentrequestpolicy-update?view=graph-rest-1.0
# The policy has no report-only state and controls no sign-in, so there is no break-glass
# input. The module assigns no roles: a reviewer gains no privileges.

# For p1 and p2 the shared licence guard fails the plan unless a usable subscription lists
# the tier's service plan. The free tier reads no licences.
module "licence_guard" {
  source = "../licence-guard"

  tier = var.tier
}

locals {
  # Reviewer query strings: /users/{id} is the form of the Update example; the group form is
  # documented for access review reviewers (accessreviews-reviewers-concept) and unverified here.
  reviewers = concat(
    [for id in var.reviewer_user_ids : { query = "/users/${id}", queryType = "MicrosoftGraph" }],
    [for id in var.reviewer_group_ids : { query = "/groups/${id}/transitiveMembers", queryType = "MicrosoftGraph" }],
  )

  input_body = {
    isEnabled             = var.enabled
    notifyReviewers       = var.notify_reviewers
    remindersEnabled      = var.reminders_enabled
    requestDurationInDays = var.request_duration_in_days
    reviewers             = local.reviewers
  }

  # The policy as read before the module first wrote it, reduced to the five writable
  # properties: version and OData annotations are never sent back.
  current = try(data.msgraph_resource.policy.output.policy, null)
  snapshot_input = local.current == null ? null : {
    isEnabled             = local.current.isEnabled
    notifyReviewers       = local.current.notifyReviewers
    remindersEnabled      = local.current.remindersEnabled
    requestDurationInDays = local.current.requestDurationInDays
    # flatten([null]) is [null], so a null reviewers property yields no reviewer; the object
    # types are kept, and a malformed reviewer still fails instead of being skipped.
    reviewers = [
      for reviewer in flatten([local.current.reviewers]) :
      merge({ query = reviewer.query, queryType = reviewer.queryType }, try(reviewer.queryRoot, null) == null ? {} : { queryRoot = reviewer.queryRoot })
      if reviewer != null
    ]
  }

  snapshot = terraform_data.previous_state.output

  # Both branches are JSON text, so the restore snapshot and the inputs need no common type.
  body = jsondecode(var.restore_previous_state ? jsonencode(local.snapshot) : jsonencode(local.input_body))
}

# One read per plan. Only the first one is kept (see terraform_data.previous_state).
data "msgraph_resource" "policy" {
  url         = "policies/adminConsentRequestPolicy"
  api_version = "v1.0"

  response_export_values = {
    policy = "@"
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.policy != null &&
        contains([true, false], self.output.policy.isEnabled) &&
        contains([true, false], self.output.policy.notifyReviewers) &&
        contains([true, false], self.output.policy.remindersEnabled) &&
        self.output.policy.requestDurationInDays == floor(self.output.policy.requestDurationInDays) &&
        self.output.policy.requestDurationInDays >= 0 &&
        (self.output.policy.reviewers == null || can(concat(self.output.policy.reviewers, []))) &&
        alltrue([for reviewer in flatten([self.output.policy.reviewers]) :
          reviewer.query != null && reviewer.queryType != null &&
          reviewer.query == tostring(reviewer.query) && reviewer.queryType == tostring(reviewer.queryType)
          if reviewer != null
        ]), false
      )
      error_message = "The adminConsentRequestPolicy response is malformed; the policy cannot be snapshotted."
    }
  }
}

# The snapshot is taken once and never overwritten: ignore_changes keeps later reads out.
# Restoring it takes two steps, restore_previous_state = true and apply, then destroy. The
# snapshot is built from a response that the data source postcondition has validated, so a
# restore never sends a malformed body. On the very first apply it sends the policy as just
# read, which changes nothing.
resource "terraform_data" "previous_state" {
  input = local.snapshot_input

  lifecycle {
    ignore_changes = [input]
  }
}

# Destroying this resource sends no request, so the settings stay as last set.
resource "msgraph_update_resource" "this" {
  url                    = "policies/adminConsentRequestPolicy"
  api_version            = "v1.0"
  update_method          = "PUT"
  body                   = local.body
  response_export_values = { policy = "@" }

  # The snapshot must exist before the first write.
  depends_on = [terraform_data.previous_state]

  lifecycle {
    precondition {
      condition     = module.licence_guard.tier == var.tier
      error_message = "The licence guard did not pass the requested tier."
    }

    precondition {
      condition     = var.restore_previous_state || !var.enabled || length(local.reviewers) > 0
      error_message = "enabled = true needs at least one reviewer in reviewer_user_ids or reviewer_group_ids. There are no default reviewers."
    }

    precondition {
      condition     = !var.restore_previous_state || local.snapshot != null
      error_message = "restore_previous_state = true needs the snapshot captured by the first apply, and none is available."
    }
  }
}
