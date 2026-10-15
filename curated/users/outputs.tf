output "id" {
  description = "The object ID of the user. Use this when referencing the user as a group member/owner or as an approver/requestor/target in an assignment policy."
  value       = msgraph_resource.user.id
}

output "user_principal_name" {
  description = "The user principal name of the user."
  value       = msgraph_resource.user.output.user_principal_name
}

output "display_name" {
  description = "The display name of the user."
  value       = msgraph_resource.user.output.display_name
}
