output "request_id" {
  description = "The ID of the adminAssign schedule request. An accepted request is not effective access."
  value       = local.request_id
}

output "request_status" {
  description = "The status Graph returned for the request, for example PendingApproval, PendingProvisioning or Provisioned."
  value       = local.request_status
}

output "target_schedule_id" {
  description = "The schedule ID the request response reported, or null."
  value       = local.target_schedule_id
}

output "schedule_id" {
  description = "The ID of the assignment schedule correlated with this request. Null unless exactly one schedule matched identity, window and request."
  value       = local.schedule_id
}

output "instance_id" {
  description = "The ID of the assignment schedule instance linked to the correlated schedule. Null unless exactly one matched."
  value       = local.instance_id
}

output "state" {
  description = "Evidence level: rejected, withdrawn (the request became Canceled, Denied, Failed or Revoked after it was submitted), request_unreadable (it could be read before and no longer can), request_accepted_only, schedule_only or instance_observed. Only instance_observed rests on a schedule instance; none of them checks the group's actual membership or ownership."
  value       = local.state
}

output "expires_at" {
  description = "The end of the requested window. The grant ends then; destroying this module does not end it earlier."
  value       = var.end_date_time
}
