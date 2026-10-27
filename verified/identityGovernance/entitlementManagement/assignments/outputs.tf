output "request_id" {
  description = "The ID of the adminAdd request. Null when an existing assignment was adopted and no request was sent. It identifies the request only; it is not the assignment ID."
  value       = local.request_id
}

output "request_state" {
  description = "The state Graph reported for the adminAdd request on the last read, for example pendingApproval or delivered. Null when adopting or when the read returned none."
  value       = local.request_state
}

output "request_phase" {
  description = "The request state bucketed by this module: pending, delivered, denied, canceled, failed, partial or unknown, or \"adopted\" when no request was sent. An unrecognised state is \"unknown\" and never counts as delivered."
  value       = local.request_phase
}

output "assignment_id" {
  description = "The stable ID of the assignment resolved from the assignments listing. Null while the request is pending, when nothing matches and when more than one assignment matches."
  value       = local.assignment_id
}

output "assignment_state" {
  description = "The assignment state Graph reported: delivering, partiallyDelivered, delivered, deliveryFailed or expired. Null when no single assignment was resolved."
  value       = local.assignment_state
}

output "assignment_schedule_json" {
  description = "The schedule of the resolved assignment as Graph reported it, encoded as JSON, so the effect of schedule_update shows on the next read. Null when no assignment was resolved."
  value       = local.assignment_schedule_json
}

output "delivered" {
  description = "True when the request was delivered (or the assignment adopted) and exactly one matching assignment reports delivered. This is Graph's report about the assignment, not a measurement of the access the subject has to the package's resources."
  value       = local.delivered
}

output "ambiguous" {
  description = "True when more than one assignment matched the subject, policy and package, so no assignment ID was resolved."
  value       = local.ambiguous
}

output "access_package_id" {
  description = "The ID of the assigned access package, as passed in."
  value       = var.access_package_id
}

output "assignment_policy_id" {
  description = "The ID of the assignment policy, as passed in."
  value       = var.assignment_policy_id
}

output "update_request_id" {
  description = "The ID of the adminUpdate request sent for schedule_update. Null when schedule_update is null."
  value       = local.update_request_id
}

output "update_request_phase" {
  description = "The adminUpdate request state bucketed like request_phase. Null when schedule_update is null."
  value       = local.update_request_phase
}
