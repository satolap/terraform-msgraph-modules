output "id" {
  description = "The ID of the access review definition."
  value       = msgraph_resource.this.id
}

output "group_id" {
  description = "The object ID of the reviewed group, in lower case."
  value       = local.group_id
}

output "scope_query" {
  description = "The query of the review scope, built from group_id and membership_scope."
  value       = local.scope_query
}

output "reviewer_user_ids" {
  description = "The primary reviewer user IDs sent, in lower case."
  value       = local.reviewer_ids
}

output "status" {
  description = "The definition's status as read back, or null when Graph returned none."
  value       = try(msgraph_resource.this.output.status, null)
}
