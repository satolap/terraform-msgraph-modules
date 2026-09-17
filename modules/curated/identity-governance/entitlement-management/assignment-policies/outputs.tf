output "id" {
  description = "The ID of the assignment policy."
  value       = msgraph_resource.assignment_policy.id
}

output "display_name" {
  description = "The display name of the assignment policy."
  value       = msgraph_resource.assignment_policy.output.display_name
}

output "access_package_id" {
  description = "The ID of the access package this policy is attached to."
  value       = var.access_package_id
}
