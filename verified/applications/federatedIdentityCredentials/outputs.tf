output "id" {
  description = "Object ID of this federated identity credential. Replacement changes it."
  value       = msgraph_resource.credential.id
}

output "application_id" {
  description = "Application object ID, normalized to lower case."
  value       = local.application_id
}

output "name" {
  description = "Immutable credential name, as configured."
  value       = var.name
}
