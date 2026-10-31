output "request_id" {
  description = "The ID of the adminAssign schedule request."
  value       = try(msgraph_resource_action.assign.output.request_id, null)
}

output "status" {
  description = "The status Graph returned for the adminAssign request, for example Provisioned or ScheduleCreated."
  value       = try(msgraph_resource_action.assign.output.status, null)
}

output "role_definition_id" {
  description = "The ID of the assigned role definition, as passed in or resolved from role_display_name."
  value       = local.role_definition_id
}

output "directory_scope_id" {
  description = "The scope of the assignment, as passed in."
  value       = var.directoryScopeId
}

output "schedule_id" {
  description = "The ID of the eligibility or assignment schedule found by the verification read. Null if verification did not find exactly one."
  value       = local.matched_schedule_id
}

output "verified" {
  description = "Whether the verification read found exactly one matching schedule. False for an assignment that has not started yet if Graph does not list it."
  value       = local.verified
}
