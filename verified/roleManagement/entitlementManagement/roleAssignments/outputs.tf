output "id" {
  description = "The ID of the role assignment. It changes when any input changes, because that replaces the assignment."
  value       = msgraph_resource.assignment.id
}

output "role_definition_id" {
  description = "The role definition ID assigned: the ID of the named role, or roleDefinitionId in lower case."
  value       = local.role_definition_id
}

output "app_scope_id" {
  description = "The app scope of the assignment, /AccessPackageCatalog/{catalog-id} for a catalog role; null for a tenant-wide role."
  value       = local.app_scope_id
}

output "directory_scope_id" {
  description = "The directory scope of the assignment, / for a tenant-wide role; null for a catalog role."
  value       = local.directory_scope_id
}

output "principal_id" {
  description = "The object ID of the principal that holds the role, in lower case."
  value       = local.principal_id
}
