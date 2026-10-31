# The v4.0.0 module: the state-shape fixture for upgrade.tftest.hcl. Its destroy cleanup
# resource is left out (enable_destroy_cleanup stays false, so state never held it) because
# verified modules may not add another local-exec provisioner.
locals {
  # Only v1.0 is admitted: its request states and assignment states are the
  # vocabulary this module classifies. The beta pages spell and enumerate them
  # differently (PascalCase, "Canceled" without a lowercase form, no adminUpdate
  # in the requestType enum), so beta is not a supported target.
  api_version      = "v1.0"
  requests_path    = "identityGovernance/entitlementManagement/assignmentRequests"
  assignments_path = "identityGovernance/entitlementManagement/assignments"

  adopting = var.adopt_assignment_id != null

  # An assignment this module granted is always revoked on destroy. One it only
  # adopted is revoked only on request.
  revoke_on_destroy = !local.adopting || var.revoke_adopted_assignment_on_destroy

  # A request ID that Graph did not return must fail the read loudly instead of
  # turning the read into a listing of the whole collection.
  missing_request_id = "request-id-not-returned"

  # accessPackageAssignmentRequest.state (v1.0) bucketed into phases. The bucketing
  # is this module's, not Graph's. Anything outside the v1.0 enum, including the
  # beta spellings, is "unknown" and is never read as delivered.
  phase_by_state = {
    submitted          = "pending"
    pendingApproval    = "pending"
    scheduled          = "pending"
    delivering         = "pending"
    delivered          = "delivered"
    denied             = "denied"
    canceled           = "canceled"
    deliveryFailed     = "failed"
    partiallyDelivered = "partial"
  }
  failed_phases = ["denied", "canceled", "failed", "partial"]

  add_schedule = var.schedule == null ? {} : {
    schedule = merge(
      var.schedule.start_date_time != null ? { startDateTime = var.schedule.start_date_time } : {},
      var.schedule.expiration != null ? {
        expiration = merge(
          { type = var.schedule.expiration.type },
          var.schedule.expiration.end_date_time != null ? { endDateTime = var.schedule.expiration.end_date_time } : {},
          var.schedule.expiration.duration != null ? { duration = var.schedule.expiration.duration } : {},
        )
      } : {},
    )
  }

  add_body = merge(
    {
      requestType = "adminAdd"
      assignment = {
        targetId           = var.target_id
        assignmentPolicyId = var.assignment_policy_id
        accessPackageId    = var.access_package_id
      }
      justification = var.justification
    },
    local.add_schedule,
  )

  request_id = try(msgraph_resource_action.add[0].output.request_id, null)
}

# Every input that decides which assignment this module owns. A change replaces
# the request and the destroy hook, so the old assignment is revoked before the
# new one is requested. The schedule and the justification are deliberately not
# here: they are captured when the request is sent and never re-sent.
resource "terraform_data" "identity" {
  input = {
    target_id            = var.target_id
    access_package_id    = var.access_package_id
    assignment_policy_id = var.assignment_policy_id
    adopt_assignment_id  = var.adopt_assignment_id
    replacement_token    = var.replacement_token
    api_version          = local.api_version
  }
}

# Submits the adminAdd request. An accepted request is not a delivered assignment:
# it can wait for approval, be denied, canceled or fail, and Graph returns no
# assignment ID with it. The request object supports no PATCH, and this action is
# forgotten on destroy, so the hook below revokes the assignment instead.
#
# The action runs once. Plans and applies that follow never send it again, so a
# request that was accepted but is not delivered yet is recovered by a later apply
# that re-reads it, not by a second adminAdd. Never add create_before_destroy: the
# new adminAdd would meet the old assignment, and the destroy-time revoke would
# then remove the new one. With adopt_assignment_id set, no request is sent.
resource "msgraph_resource_action" "add" {
  count = local.adopting ? 0 : 1

  resource_url = local.requests_path
  method       = "POST"
  api_version  = local.api_version
  body         = local.add_body

  response_export_values = {
    request_id = "id"
    state      = "state"
    status     = "status"
  }

  lifecycle {
    # The body is captured at creation; see terraform_data.identity.
    ignore_changes       = all
    replace_triggered_by = [terraform_data.identity]
  }
}

# One bounded wait for approval-free delivery and for Graph to list the assignment.
resource "time_sleep" "wait_for_delivery" {
  depends_on      = [msgraph_resource_action.add, null_resource.remove_on_destroy]
  create_duration = "${var.verification_delay_seconds}s"

  lifecycle {
    replace_triggered_by = [terraform_data.identity]
  }
}

# Reads the request back. The state decides whether the access was delivered, is
# still pending (for example, waiting for an approver), or was refused.
data "msgraph_resource" "request" {
  count = local.adopting ? 0 : 1

  url         = "${local.requests_path}/${coalesce(local.request_id, local.missing_request_id)}"
  api_version = local.api_version

  response_export_values = {
    state  = "state"
    status = "status"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

# Lists the assignments for the package and the subject, expanded so that the
# match below can re-check the subject, the policy and the package. The filter
# only narrows the list; the match decides. The first page is read: an
# unexpected number of matches is refused, never guessed.
data "msgraph_resource" "assignments" {
  url         = local.assignments_path
  api_version = local.api_version

  query_parameters = {
    "$filter" = ["accessPackage/id eq '${var.access_package_id}' and target/objectId eq '${var.target_id}'"]
    "$expand" = ["target,assignmentPolicy,accessPackage"]
  }

  response_export_values = {
    assignments = "value"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

locals {
  request_state = local.adopting ? null : try(data.msgraph_resource.request[0].output.state, null)
  request_phase = local.adopting ? "adopted" : lookup(local.phase_by_state, local.request_state_text, "unknown")

  # Assignments of exactly this subject, policy and package. When adopting, also
  # exactly the adopted ID.
  matched = [
    for a in try(data.msgraph_resource.assignments.output.assignments, []) : a
    if lower(try(a.target.objectId, "")) == lower(var.target_id)
    && lower(try(a.assignmentPolicy.id, "")) == lower(var.assignment_policy_id)
    && lower(try(a.accessPackage.id, "")) == lower(var.access_package_id)
    && (!local.adopting || lower(try(a.id, "")) == lower(coalesce(var.adopt_assignment_id, "x")))
  ]

  # An expired assignment is history: a new grant for the same subject creates a
  # new assignment. A live one (any other state) is the candidate. One live match
  # is the assignment; none live and one expired reports the expired one; any
  # other count is ambiguous and resolves to nothing.
  live    = [for a in local.matched : a if try(a.state, "") != "expired"]
  expired = [for a in local.matched : a if try(a.state, "") == "expired"]

  ambiguous = length(local.live) > 1 || (length(local.live) == 0 && length(local.expired) > 1)

  assignment_id = (
    length(local.live) == 1 ? try(local.live[0].id, null) :
    length(local.live) == 0 && length(local.expired) == 1 ? try(local.expired[0].id, null) :
    null
  )
  assignment_state = (
    length(local.live) == 1 ? try(local.live[0].state, null) :
    length(local.live) == 0 && length(local.expired) == 1 ? "expired" :
    null
  )
  assignment_schedule_json = local.assignment_id == null ? null : try(jsonencode([for a in local.matched : a.schedule if a.id == local.assignment_id][0]), null)

  # Delivered means the request was delivered (or the assignment adopted) and the
  # one matching assignment reports delivered. It is Graph's report about the
  # assignment, not a measurement of what the subject can reach.
  delivered = (
    contains(["delivered", "adopted"], local.request_phase)
    && !local.ambiguous
    && local.assignment_id != null
    && local.assignment_state == "delivered"
  )

  request_id_text    = local.request_id != null ? local.request_id : "none"
  request_state_text = local.request_state != null ? local.request_state : ""
  assignment_id_text = local.assignment_id != null ? local.assignment_id : ""
}

# Fails apply, with a message that separates a refused request, a pending one,
# an ambiguous match and an expired assignment from a delivered one. Applies
# that fail here leave the request in state; the next apply re-reads it.
resource "terraform_data" "verification_gate" {
  input = local.delivered

  lifecycle {
    precondition {
      condition     = !contains(local.failed_phases, local.request_phase)
      error_message = "The adminAdd request ${local.request_id_text} ended as ${local.request_state_text} (status: ${coalesce(try(data.msgraph_resource.request[0].output.status, null), "unknown")}), so no access was delivered. A denied or canceled request is a decision, not a fault: a new request needs a new replacement_token. A failed or partially delivered one needs the cause fixed first; see the request in the My Access portal or in Graph."
    }

    precondition {
      condition     = local.request_phase != "unknown" || !var.require_delivery
      error_message = "The adminAdd request ${local.request_id_text} reports state '${local.request_state_text}', which is not in the v1.0 state list this module classifies (submitted, pendingApproval, scheduled, delivering, delivered, denied, canceled, deliveryFailed, partiallyDelivered). It is not treated as delivered. Set require_delivery = false to track it."
    }

    precondition {
      condition     = local.request_phase != "pending" || !var.require_delivery
      error_message = "The adminAdd request ${local.request_id_text} is still ${local.request_state_text} after ${var.verification_delay_seconds}s. This module never approves a request: wait for the approver or the policy, then apply again to re-read it without sending a second request, or set require_delivery = false to track a pending request."
    }

    precondition {
      condition     = !local.ambiguous
      error_message = "Found ${length(local.live)} live and ${length(local.expired)} expired assignments for subject '${var.target_id}', policy '${var.assignment_policy_id}' and package '${var.access_package_id}'; expected exactly one. The module refuses to guess which one it owns. Remove the extra assignments, or name the one to keep with adopt_assignment_id."
    }

    precondition {
      condition     = !(contains(["delivered", "adopted"], local.request_phase) && local.assignment_state == "expired")
      error_message = "The assignment ${local.assignment_id_text} for subject '${var.target_id}' has expired. Change replacement_token to revoke it and request access again, or remove this module."
    }

    precondition {
      condition     = local.delivered || !var.require_delivery || local.request_phase == "pending" || local.request_phase == "unknown"
      error_message = "The request ${local.request_id_text} is ${local.request_phase == "adopted" ? "an adoption" : "delivered"}, but ${length(local.live)} live assignments match subject '${var.target_id}', policy '${var.assignment_policy_id}' and package '${var.access_package_id}' (assignment state: ${coalesce(local.assignment_state, "none")}); expected exactly one in state delivered. Graph may not have listed it yet: apply again, or raise verification_delay_seconds. With adopt_assignment_id, check that the ID belongs to those three identities."
    }
  }

  depends_on = [data.msgraph_resource.request, data.msgraph_resource.assignments]
}

locals {
  update_schedule = var.schedule_update == null ? {} : {
    schedule = merge(
      var.schedule_update.start_date_time != null ? { startDateTime = var.schedule_update.start_date_time } : {},
      var.schedule_update.expiration != null ? {
        expiration = merge(
          { type = var.schedule_update.expiration.type },
          var.schedule_update.expiration.end_date_time != null ? { endDateTime = var.schedule_update.expiration.end_date_time } : {},
          var.schedule_update.expiration.duration != null ? { duration = var.schedule_update.expiration.duration } : {},
        )
      } : {},
    )
  }

  update_body = merge(
    {
      requestType   = "adminUpdate"
      assignment    = { id = local.assignment_id }
      justification = var.justification
    },
    local.update_schedule,
  )

  update_request_id         = try(msgraph_resource_action.update[0].output.request_id, null)
  update_request_state      = var.schedule_update == null ? null : try(data.msgraph_resource.update_request[0].output.state, null)
  update_request_state_text = local.update_request_state != null ? local.update_request_state : ""
  update_request_phase      = var.schedule_update == null ? null : lookup(local.phase_by_state, local.update_request_state_text, "unknown")
}

# Changing schedule_update sends a new adminUpdate; the old one is not undone.
resource "terraform_data" "update_input" {
  input = var.schedule_update
}

# Sends adminUpdate for the resolved assignment, after the gate confirmed it.
# The assignment ID comes from the read-back, never from a request ID.
resource "msgraph_resource_action" "update" {
  count = var.schedule_update != null ? 1 : 0

  resource_url = local.requests_path
  method       = "POST"
  api_version  = local.api_version
  body         = local.update_body

  response_export_values = {
    request_id = "id"
    state      = "state"
  }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.update_input, terraform_data.identity]

    precondition {
      condition     = local.delivered
      error_message = "adminUpdate needs a delivered assignment resolved from the read-back (request phase ${local.request_phase}, assignment state ${coalesce(local.assignment_state, "none")}); it never targets an unresolved or pending one."
    }
  }

  depends_on = [terraform_data.verification_gate]
}

resource "time_sleep" "wait_for_update" {
  count = var.schedule_update != null ? 1 : 0

  depends_on      = [msgraph_resource_action.update]
  create_duration = "${var.verification_delay_seconds}s"

  lifecycle {
    replace_triggered_by = [terraform_data.update_input, terraform_data.identity]
  }
}

data "msgraph_resource" "update_request" {
  count = var.schedule_update != null ? 1 : 0

  url         = "${local.requests_path}/${coalesce(local.update_request_id, local.missing_request_id)}"
  api_version = local.api_version

  response_export_values = {
    state  = "state"
    status = "status"
  }

  depends_on = [time_sleep.wait_for_update]
}

resource "terraform_data" "update_gate" {
  count = var.schedule_update != null ? 1 : 0

  input = local.update_request_phase

  lifecycle {
    precondition {
      condition     = !contains(local.failed_phases, coalesce(local.update_request_phase, "unknown"))
      error_message = "The adminUpdate request ${coalesce(local.update_request_id, "none")} ended as ${local.update_request_state_text}; the schedule was not changed."
    }

    precondition {
      condition     = !var.require_delivery || coalesce(local.update_request_phase, "unknown") == "delivered"
      error_message = "The adminUpdate request ${coalesce(local.update_request_id, "none")} is ${coalesce(local.update_request_phase, "unknown")} (state '${local.update_request_state_text}'), not delivered. This module never approves a request: apply again after the approval, or set require_delivery = false to track it."
    }
  }

  depends_on = [data.msgraph_resource.update_request]
}

# Removal on destroy. The request object cannot be deleted, so this hook cancels a
# request that still waits, or submits adminRemove for the delivered assignment,
# with the ambient Azure CLI session. Before requesting a token it requires
# ARM_TENANT_ID (the tenant variable the msgraph provider reads) to match
# `az account show`, so nothing can go to another tenant. curl reads the
# Authorization header from a config on stdin, so the token never appears in a
# process argv. Values are passed as environment variables, never interpolated
# into shell code.
#
# It removes only an assignment this module created or explicitly adopted. A request
# that is waiting (submitted, pendingApproval or scheduled, with a status v1.0 lists
# as cancelable) is canceled. A request that is delivering stops the destroy. A
# denied or canceled one needs nothing. A request that failed, was partially
# delivered, no longer exists or reports an unknown state is NOT tied to any
# assignment, so the hook refuses and prints the evidence instead of removing
# whichever assignment happens to match. Only a delivered request leads on: the
# assignment is then taken from a listing of the exact subject, policy and package
# (or from the adopted ID), parsed strictly from the top-level value array, and
# only when exactly one non-expired assignment matches. Before any adminRemove the
# hook reads that assignment itself, expanded, and requires its subject, policy and
# package to equal the module's inputs; a wrong adopted ID is never revoked. The hook
# then polls until the assignment reports expired or is gone, and fails when it
# does not, so a revoked grant is confirmed, not assumed. Every stop prints the
# non-secret ownership evidence (subject, package, policy, request) and keeps the
# hook in state, so a later destroy retries. Learn documents no error code for an
# assignment that is already gone; 404 and the words "not found" and "does not
# exist" count as removed. 409, 429 and 5xx answers are retried for about two minutes.
#
# The hook can only revoke the assignment of the identity captured when the
# resource was created; deleting the module block from the configuration does not
# run it. Run a targeted destroy of the module while its block is still present.
# Keep `triggers` complete: a change to any identity input replaces this resource,

resource "null_resource" "remove_on_destroy" {
  count = var.enable_destroy_cleanup ? 1 : 0
}
