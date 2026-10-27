output "keyId" {
  description = "The keyId returned by addPassword and independently verified before removal registration."
  value       = try(msgraph_resource_action.add.output.keyId, null)
  depends_on  = [msgraph_resource_action.remove]
}

output "secretText" {
  description = "The one-time Graph-generated password. Stored in Terraform state; protect state, saved plans and downstream secret stores. Graph cannot return it again."
  value       = try(msgraph_resource_action.add.output.secretText, null)
  sensitive   = true
  depends_on  = [msgraph_resource_action.remove]
}

output "startDateTime" {
  description = "The validity start returned by addPassword."
  value       = try(msgraph_resource_action.add.output.startDateTime, null)
  depends_on  = [msgraph_resource_action.remove]
}

output "endDateTime" {
  description = "The expiration returned by addPassword."
  value       = try(msgraph_resource_action.add.output.endDateTime, null)
  depends_on  = [msgraph_resource_action.remove]
}
