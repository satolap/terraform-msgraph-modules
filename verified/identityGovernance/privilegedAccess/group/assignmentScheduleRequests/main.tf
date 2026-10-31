locals {
  requests_path  = "identityGovernance/privilegedAccess/group/assignmentScheduleRequests"
  schedules_path = "identityGovernance/privilegedAccess/group/assignmentSchedules"
  instances_path = "identityGovernance/privilegedAccess/group/assignmentScheduleInstances"

  # The contract admits one explicit administrative grant with a single bounded
  # window. Recurrence, other expiration types and every other action are not
  # offered, even though the resource metadata lists them.
  request_body = {
    action        = "adminAssign"
    principalId   = var.principalId
    groupId       = var.groupId
    accessId      = var.accessId
    justification = var.justification
    scheduleInfo = {
      startDateTime = var.start_date_time
      expiration = {
        type        = "afterDateTime"
        endDateTime = var.end_date_time
      }
    }
  }

  grant_identity = {
    principal_id    = var.principalId
    group_id        = var.groupId
    access_id       = var.accessId
    start_date_time = var.start_date_time
    end_date_time   = var.end_date_time
  }

  filter = "principalId eq '${var.principalId}' and groupId eq '${var.groupId}' and accessId eq '${var.accessId}'"
}

# Records the identity and window that were submitted, once. ignore_changes keeps
# the recorded value, so a later change to the configuration is detected by the
# gate below instead of being applied. Nothing replaces the request on its own:
# a second adminAssign for a grant that still exists is expected to be refused by
# PIM (as in the directory-role module), and replacing the request would drop the
# running grant from state. To change a grant, wait for it to expire or remove it
# in PIM, then replace both this record and the request deliberately (see README).
resource "terraform_data" "grant" {
  input = local.grant_identity

  lifecycle {
    ignore_changes = [input]
  }
}

# Submits the administrative request once. A schedule request supports neither
# PATCH nor DELETE, so it is a one-shot action that is forgotten on destroy:
# destroying or removing this module sends nothing to Graph and never touches
# the group, the principal, any other membership or ownership, or a role
# management policy. PIM policy rules (maximum duration, approval, MFA,
# justification) can reject the request; the error from Graph is surfaced unchanged.
# Never add create_before_destroy or an adminRemove provisioner here.
resource "msgraph_resource_action" "request" {
  resource_url = local.requests_path
  method       = "POST"
  api_version  = "v1.0"
  body         = local.request_body

  response_export_values = {
    request_id         = "id"
    status             = "status"
    target_schedule_id = "targetScheduleId"
  }

  # ignore_changes = all: the POST runs only when the action is created. No
  # in-place update (a new export value, a reworded justification) may ever send
  # the stored adminAssign again, which could re-grant access an owner removed.
  lifecycle {
    replace_triggered_by = [terraform_data.grant]
    ignore_changes       = all
  }
}

# PIM provisions the schedule asynchronously. Wait before reading it back; a new
# request waits again.
resource "time_sleep" "wait_for_delivery" {
  depends_on      = [msgraph_resource_action.request]
  create_duration = "${var.verification_delay_seconds}s"

  lifecycle {
    replace_triggered_by = [terraform_data.grant]
  }
}

# Read-only discovery of the result surfaces. Both filters use properties that
# Learn lists as $filter-capable (eq); the matching below re-checks them.
data "msgraph_resource" "schedule" {
  url         = local.schedules_path
  api_version = "v1.0"

  query_parameters = {
    "$filter" = [local.filter]
  }

  response_export_values = {
    schedules = "value"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

data "msgraph_resource" "instance" {
  url         = local.instances_path
  api_version = "v1.0"

  query_parameters = {
    "$filter" = [local.filter]
  }

  response_export_values = {
    instances = "value"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

# The POST response keeps the status the request had at creation, and
# msgraph_resource_action never refreshes it. PIM may still be provisioning or
# awaiting approval then and deny, cancel or fail the request later, so the
# request is read back after the delay and its status classified from that. The read
# goes through the collection filtered by id, not a GET by id: a request that is not
# listed yet, or no longer, gives an empty result instead of a 404, which the data
# source does not retry and which would fail every later plan and destroy.
data "msgraph_resource" "request" {
  url         = local.requests_path
  api_version = "v1.0"

  query_parameters = {
    "$filter" = ["id eq '${local.request_id == null ? "none" : local.request_id}'"]
  }

  response_export_values = {
    requests = "value"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

locals {
  request_id         = try(msgraph_resource_action.request.output.request_id, null)
  created_status     = try(msgraph_resource_action.request.output.status, null)
  read_requests      = [for r in try(data.msgraph_resource.request.output.requests, []) : r if try(r.id, null) == local.request_id && local.request_id != null]
  read_status        = try(local.read_requests[0].status, null)
  request_readable   = local.read_status != null
  request_status     = try(coalesce(local.read_status, local.created_status), null)
  target_schedule_id = try(msgraph_resource_action.request.output.target_schedule_id, null)

  rejected_statuses = ["Canceled", "Denied", "Failed", "Revoked"]
  rejected          = local.request_status == null ? false : contains(local.rejected_statuses, local.request_status)

  # Terraform keeps no record that can only grow, so a status that was seen once cannot
  # be remembered reliably. Instead the gate fails only on the status seen when the
  # request was submitted (terraform_data.first_outcome, recorded once). A later
  # Canceled, Denied, Failed or Revoked, which may follow a successful grant that ended
  # or was removed, is reported in the state as withdrawn and never fails a plan.
  first_readable = try(terraform_data.first_outcome.output.readable, false)
  first_rejected = try(terraform_data.first_outcome.output.rejected, false)

  # A schedule belongs to this grant only when it names this identity, is a direct
  # (not group-derived) schedule, was created by this request or is the schedule
  # the request reports (and agrees with both when both are present), has a
  # non-recurring window equal to the requested one, and has not ended in
  # failure. No identifier is parsed or synthesized, and an identity-only match
  # never counts.
  matched_schedules = [
    for s in try(data.msgraph_resource.schedule.output.schedules, []) : s
    if lower(try(s.principalId, "")) == var.principalId
    && lower(try(s.groupId, "")) == var.groupId
    && lower(try(s.accessId, "")) == var.accessId
    && lower(try(s.memberType, "")) == "direct"
    && local.request_id != null
    && (
      try(s.createdUsing, null) == local.request_id
      || (local.target_schedule_id != null && try(s.id, null) == local.target_schedule_id)
    )
    && (try(s.createdUsing, null) == null || try(s.createdUsing, null) == local.request_id)
    && (local.target_schedule_id == null || try(s.id, null) == local.target_schedule_id)
    && try(s.scheduleInfo.recurrence, null) == null
    && try(timecmp(s.scheduleInfo.startDateTime, timeadd(var.start_date_time, "-60s")) >= 0 && timecmp(s.scheduleInfo.startDateTime, timeadd(var.start_date_time, "60s")) <= 0, false)
    && try(s.scheduleInfo.expiration.type, "") == "afterDateTime"
    && try(timecmp(s.scheduleInfo.expiration.endDateTime, timeadd(var.end_date_time, "-60s")) >= 0 && timecmp(s.scheduleInfo.expiration.endDateTime, timeadd(var.end_date_time, "60s")) <= 0, false)
    && !contains(local.rejected_statuses, try(s.status, ""))
    && lower(try(s.assignmentType, "")) == "assigned"
  ]

  schedule_correlated = length(local.matched_schedules) == 1
  schedule_id         = local.schedule_correlated ? try(local.matched_schedules[0].id, null) : null

  # An instance counts only when it links to that single correlated schedule.
  matched_instances = local.schedule_id == null ? [] : [
    for i in try(data.msgraph_resource.instance.output.instances, []) : i
    if try(i.assignmentScheduleId, null) == local.schedule_id
    && lower(try(i.principalId, "")) == var.principalId
    && lower(try(i.groupId, "")) == var.groupId
    && lower(try(i.accessId, "")) == var.accessId
    && lower(try(i.memberType, "")) == "direct"
    && lower(try(i.assignmentType, "")) == "assigned"
  ]

  instance_correlated = length(local.matched_instances) == 1
  instance_id         = local.instance_correlated ? try(local.matched_instances[0].id, null) : null

  # Timestamps are read only by the state and the gate and are never stored.
  # Before the window starts there may be no instance yet; after it ends the
  # schedule may no longer be listed, and later plans must not fail for a grant
  # that has expired.
  started = timecmp(timestamp(), var.start_date_time) >= 0
  ended   = timecmp(timestamp(), var.end_date_time) >= 0

  # Evidence ladder, weakest first. Only an instance linked to the correlated
  # schedule is evidence of the access, and it is still Graph's schedule data, not
  # a check of the group's actual membership or ownership. After the window the
  # state is expired, whatever was or is still listed.
  state = (
    local.first_rejected ? "rejected" :
    local.ended ? "expired" :
    local.rejected ? "withdrawn" :
    local.first_readable && !local.request_readable ? "request_unreadable" :
    local.instance_correlated ? "instance_observed" :
    local.schedule_correlated ? "schedule_only" :
    "request_accepted_only"
  )

  # The identity and window that were submitted, as recorded by terraform_data.grant.
  recorded_matches = jsonencode(terraform_data.grant.output) == jsonencode(local.grant_identity)
}

# What was seen when the request was submitted, once: whether it was already rejected and
# whether it could be read back. It lets the gate fail on a rejection at that point only,
# and lets the state report a request that could be read before and is no longer listed.
# A new grant replaces it with the request.
resource "terraform_data" "first_outcome" {
  input = { readable = local.request_readable, rejected = local.rejected }

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [terraform_data.grant]
  }
}

# Fails apply when Graph rejected the request and, unless disabled, when the
# window is open and no correlated schedule and instance are visible.
resource "terraform_data" "verification_gate" {
  input = local.state

  lifecycle {
    precondition {
      condition     = local.recorded_matches
      error_message = "The principal, group, access or window changed after the request was submitted. The module never replaces a running grant on its own: a second adminAssign for an existing grant is expected to be refused, and replacing the request would drop the running grant from state. Restore the submitted values, or, once the grant has expired or been removed in PIM, replace both records deliberately with: terraform apply -replace=terraform_data.grant (this submits a new adminAssign)."
    }

    precondition {
      condition     = !local.first_rejected
      error_message = "Graph reports the request as ${coalesce(local.request_status, "unknown")}; no access was granted."
    }

    precondition {
      condition     = !var.fail_on_verification_mismatch || !local.started || local.ended || (local.schedule_correlated && local.instance_correlated)
      error_message = "Found ${length(local.matched_schedules)} correlated assignment schedules and ${length(local.matched_instances)} correlated instances for principal '${var.principalId}' in group '${var.groupId}' (${var.accessId}) after ${var.verification_delay_seconds}s (request status: ${coalesce(local.request_status, "unknown")}); expected exactly one of each. The request may be awaiting approval or still provisioning: increase verification_delay_seconds and re-apply, or set fail_on_verification_mismatch = false and inspect the state output. An accepted request is not effective access."
    }
  }

  depends_on = [data.msgraph_resource.schedule, data.msgraph_resource.instance, data.msgraph_resource.request]
}
